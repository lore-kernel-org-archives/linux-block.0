Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0078.outbound.protection.outlook.com ([104.47.34.78]:32530
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751353AbdABNQ1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Jan 2017 08:16:27 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@fb.com" <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [PATCH 2/2] block: Avoid that sparse complains about context
 imbalance in __wbt_wait()
Date: Mon, 2 Jan 2017 13:16:22 +0000
Message-ID: <1483362874.3592.60.camel@sandisk.com>
References: <1483362698.3592.58.camel@sandisk.com>
In-Reply-To: <1483362698.3592.58.camel@sandisk.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

VGhpcyBwYXRjaCBkb2VzIG5vdCBjaGFuZ2UgYW55IGZ1bmN0aW9uYWxpdHkuDQoNCkZpeGVzOiBl
MzRjYmQzMDc0NzcgKCJibGstd2J0OiBhZGQgZ2VuZXJhbCB0aHJvdHRsaW5nIG1lY2hhbmlzbSIp
DQpTaWduZWQtb2ZmLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHNhbmRpc2su
Y29tPg0KLS0tDQrCoGJsb2NrL2Jsay13YnQuYyB8IDEyICsrKysrKystLS0tLQ0KwqAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
YmxvY2svYmxrLXdidC5jIGIvYmxvY2svYmxrLXdidC5jDQppbmRleCBmZDI4YzI4MDY0MDYuLmFh
N2I5Y2NjNmZjNSAxMDA2NDQNCi0tLSBhL2Jsb2NrL2Jsay13YnQuYw0KKysrIGIvYmxvY2svYmxr
LXdidC5jDQpAQCAtNTQ0LDYgKzU0NCw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBtYXlfcXVldWUo
c3RydWN0IHJxX3diICpyd2IsIHN0cnVjdCBycV93YWl0ICpycXcsDQrCoCAqIHRoZSB0aW1lciB0
byBraWNrIG9mZiBxdWV1aW5nIGFnYWluLg0KwqAgKi8NCsKgc3RhdGljIHZvaWQgX193YnRfd2Fp
dChzdHJ1Y3QgcnFfd2IgKnJ3YiwgdW5zaWduZWQgbG9uZyBydywgc3BpbmxvY2tfdCAqbG9jaykN
CisJX19yZWxlYXNlcyhsb2NrKQ0KKwlfX2FjcXVpcmVzKGxvY2spDQrCoHsNCsKgCXN0cnVjdCBy
cV93YWl0ICpycXcgPSBnZXRfcnFfd2FpdChyd2IsIGN1cnJlbnRfaXNfa3N3YXBkKCkpOw0KwqAJ
REVGSU5FX1dBSVQod2FpdCk7DQpAQCAtNTU4LDEzICs1NjAsMTMgQEAgc3RhdGljIHZvaWQgX193
YnRfd2FpdChzdHJ1Y3QgcnFfd2IgKnJ3YiwgdW5zaWduZWQgbG9uZyBydywgc3BpbmxvY2tfdCAq
bG9jaykNCsKgCQlpZiAobWF5X3F1ZXVlKHJ3YiwgcnF3LCAmd2FpdCwgcncpKQ0KwqAJCQlicmVh
azsNCsKgDQotCQlpZiAobG9jaykNCisJCWlmIChsb2NrKSB7DQrCoAkJCXNwaW5fdW5sb2NrX2ly
cShsb2NrKTsNCi0NCi0JCWlvX3NjaGVkdWxlKCk7DQotDQotCQlpZiAobG9jaykNCisJCQlpb19z
Y2hlZHVsZSgpOw0KwqAJCQlzcGluX2xvY2tfaXJxKGxvY2spOw0KKwkJfSBlbHNlIHsNCisJCQlp
b19zY2hlZHVsZSgpOw0KKwkJfQ0KwqAJfSB3aGlsZSAoMSk7DQrCoA0KwqAJZmluaXNoX3dhaXQo
JnJxdy0+d2FpdCwgJndhaXQpOw0KLS3CoA0KMi4xMS4wDQo=
