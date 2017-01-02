Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0041.outbound.protection.outlook.com ([104.47.36.41]:22240
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932653AbdABNPG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Jan 2017 08:15:06 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@fb.com" <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [PATCH 1/2] block: Make wbt_wait() definition consistent with
 declaration
Date: Mon, 2 Jan 2017 13:14:59 +0000
Message-ID: <1483362841.3592.59.camel@sandisk.com>
References: <1483362698.3592.58.camel@sandisk.com>
In-Reply-To: <1483362698.3592.58.camel@sandisk.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Rml4ZXM6IGUzNGNiZDMwNzQ3NyAoImJsay13YnQ6IGFkZCBnZW5lcmFsIHRocm90dGxpbmcgbWVj
aGFuaXNtIikNClNpZ25lZC1vZmYtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3NjaGVA
c2FuZGlzay5jb20+DQotLS0NCsKgYmxvY2svYmxrLXdidC5jIHwgMiArLQ0KwqAxIGZpbGUgY2hh
bmdlZCwNCjEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9ibG9j
ay9ibGstd2J0LmMgYi9ibG9jay9ibGstd2J0LmMNCmluZGV4IDZlODI3NjlmNDA0Mi4uZmQyOGMy
ODA2NDA2IDEwMDY0NA0KLS0tIGEvYmxvY2svYmxrLXdidC5jDQorKysgYi9ibG9jay9ibGstd2J0
LmMNCkBAIC01OTUsNyArNTk1LDcgQEAgc3RhdGljIGlubGluZSBib29sIHdidF9zaG91bGRfdGhy
b3R0bGUoc3RydWN0IHJxX3diICpyd2IsIHN0cnVjdCBiaW8gKmJpbykNCsKgICogaW4gYW4gaXJx
IGhlbGQgc3BpbmxvY2ssIGlmIGl0IGhvbGRzIG9uZSB3aGVuIGNhbGxpbmcgdGhpcyBmdW5jdGlv
bi4NCsKgICogSWYgd2UgZG8gc2xlZXAsIHdlJ2xsIHJlbGVhc2UgYW5kIHJlLWdyYWIgaXQuDQrC
oCAqLw0KLXVuc2lnbmVkIGludCB3YnRfd2FpdChzdHJ1Y3QgcnFfd2IgKnJ3Yiwgc3RydWN0IGJp
byAqYmlvLCBzcGlubG9ja190ICpsb2NrKQ0KK2VudW0gd2J0X2ZsYWdzIHdidF93YWl0KHN0cnVj
dCBycV93YiAqcndiLCBzdHJ1Y3QgYmlvICpiaW8sIHNwaW5sb2NrX3QgKmxvY2spDQrCoHsNCsKg
CXVuc2lnbmVkIGludCByZXQgPSAwOw0KwqANCi0twqANCjIuMTEuMA0K
