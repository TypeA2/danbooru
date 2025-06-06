import Rails from '@rails/ujs';
import { delegate, hideAll } from 'tippy.js';
import words from "lodash/words";
import Notice from './notice';

let Utility = {};

export function clamp(value, low, high) {
  return Math.max(low, Math.min(value, high));
}

Utility.delay = function(milliseconds) {
  return new Promise(resolve => setTimeout(resolve, milliseconds));
}

Utility.meta = function(key) {
  return $("meta[name=" + key + "]").attr("content");
}

Utility.test_max_width = function(width) {
  if (!window.matchMedia) {
    return false;
  }
  var mq = window.matchMedia('(max-width: ' + width + 'px)');
  return mq.matches;
}

Utility.dialog = function(title, html) {
  const $dialog = $(html).dialog({
    title: title,
    width: 700,
    modal: true,
    close: function() {
      // Defer removing the dialog to avoid detaching the <form> tag before the
      // form is submitted (which would prevent the submission from going through).
      $(() => $dialog.dialog("destroy"));
    },
    buttons: {
      "Submit": function() {
        let form = $dialog.find("form").get(0);

        if (form.requestSubmit) {
          form.requestSubmit();
        } else {
          form.submit();
          Rails.fire(form, "submit");
        }
      },
      "Cancel": function() {
        $dialog.dialog("close");
      }
    }
  });

  $dialog.find("form").on("submit.danbooru", function() {
    $dialog.dialog("close");
  });

  // XXX hides the popup menu when the Report comment button is clicked.
  hideAll({ duration: 0 });
}

Utility.keydown = function(keys, namespace, handler, selector = document) {
  $(selector).on("keydown.danbooru." + namespace, null, keys, handler);
};

Utility.is_subset = function(array, subarray) {
  var all = true;

  $.each(subarray, function(i, val) {
    if ($.inArray(val, array) === -1) {
      all = false;
    }
  });

  return all;
}

Utility.intersect = function(a, b) {
  a = a.slice(0).sort();
  b = b.slice(0).sort();
  var result = [];
  while (a.length > 0 && b.length > 0) {
    if (a[0] < b[0]) {
      a.shift();
    } else if (a[0] > b[0]) {
      b.shift();
    } else {
      result.push(a.shift());
      b.shift();
    }
  }
  return result;
}

Utility.regexp_escape = function(string) {
  return string.replace(/([.?*+^$[\]\\(){}|-])/g, "\\$1");
}

Utility.splitWords = function(string) {
  return words(string, /\S+/g);
}

Utility.copyToClipboard = async function(text, message = "Copied!") {
  try {
    await navigator.clipboard.writeText(text);
    Notice.info(message);
  } catch (error) {
    Notice.error("Couldn't copy to clipboard");
  }
}

export function printPage(url) {
  let iframe = document.createElement("iframe");
  iframe.style.display = "none";
  iframe.src = url;
  iframe.onload = () => iframe.contentWindow.print();
  document.body.appendChild(iframe);
}

export function createTooltip(name, options = {}) {
  return delegate("body", {
    allowHTML: true,
    interactive: true,
    maxWidth: "none",
    theme: `common-tooltip ${name}`,
    appendTo: document.querySelector("#tooltips"),
    popperOptions: {
      modifiers: [
        {
          name: "eventListeners",
          enabled: false,
        },
      ],
    },
    ...options
  });
}

$.fn.selectEnd = function() {
  return this.each(function() {
    this.focus();
    this.setSelectionRange(this.value.length, this.value.length);
  })
}

Utility.printPage = printPage;

export default Utility
