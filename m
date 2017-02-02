Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0087.outbound.protection.outlook.com ([104.47.33.87]:58368
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751570AbdBBXlF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 18:41:05 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@fb.com" <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: block for-next: zram build error
Date: Thu, 2 Feb 2017 23:40:54 +0000
Message-ID: <1486078839.2816.24.camel@sandisk.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

SGVsbG8gSmVucywNCg0KSSBub3RpY2VkIGFjY2lkZW50YWxseSB0aGF0IHdpdGggdGhlIGZvci1u
ZXh0IGJyYW5jaCBvZiB0aGUgYmxvY2sNCmdpdCByZXBvc2l0b3J5IHRoYXQgdGhlIHpyYW0gZHJp
dmVyIGRvZXNuJ3QgYnVpbGQgYW55bW9yZToNCg0KDQokIG1ha2UgTT1kcml2ZXJzL2Jsb2NrL3py
YW0NCsKgIExEwqDCoMKgwqDCoMKgZHJpdmVycy9ibG9jay96cmFtL2J1aWx0LWluLm8NCsKgIEND
IFtNXcKgwqBkcml2ZXJzL2Jsb2NrL3pyYW0vemNvbXAubw0KwqAgQ0MgW01dwqDCoGRyaXZlcnMv
YmxvY2svenJhbS96cmFtX2Rydi5vDQpkcml2ZXJzL2Jsb2NrL3pyYW0venJhbV9kcnYuYzogSW4g
ZnVuY3Rpb24g4oCYenJhbV9yZXZhbGlkYXRlX2Rpc2vigJk6DQpkcml2ZXJzL2Jsb2NrL3pyYW0v
enJhbV9kcnYuYzoxMjA6Mzc6IGVycm9yOiDigJh6cmFtLT5kaXNrLT5xdWV1ZS0+YmFja2luZ19k
ZXZfaW5mb+KAmSBpcyBhIHBvaW50ZXI7IGRpZCB5b3UgbWVhbiB0byB1c2Ug4oCYLT7igJk/DQrC
oCB6cmFtLT5kaXNrLT5xdWV1ZS0+YmFja2luZ19kZXZfaW5mby5jYXBhYmlsaXRpZXMgfD0NCsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgXg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAtPg0KbWFrZVsxXTogKioqIFtzY3Jp
cHRzL01ha2VmaWxlLmJ1aWxkOjI5NDogZHJpdmVycy9ibG9jay96cmFtL3pyYW1fZHJ2Lm9dIEVy
cm9yIDENCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTQ5MDogX21vZHVsZV9kcml2ZXJzL2Jsb2NrL3py
YW1dIEVycm9yIDINCg0KQ29tcGlsYXRpb24gZXhpdGVkIGFibm9ybWFsbHkgd2l0aCBjb2RlIDIg
YXQgVGh1IEZlYsKgwqAyIDE1OjM3OjE5DQoNCg0KSSBoYXZlIG5vdCB5ZXQgdHJpZWQgdG8gZmln
dXJlIG91dCB3aGljaCBjb21taXQgYnJva2UgdGhlIGJ1aWxkLg0KDQpCYXJ0Lg==
