Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:57466 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932192AbdJWVIi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Oct 2017 17:08:38 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dann.frazier@canonical.com" <dann.frazier@canonical.com>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report] regression bisected to "block: Make most
 scsi_req_init() calls implicit"
Date: Mon, 23 Oct 2017 21:08:36 +0000
Message-ID: <1508792914.2634.6.camel@wdc.com>
References: <20171020225420.utvoqmtwit2isalc@xps13.dannf>
         <1508542254.3029.24.camel@wdc.com>
         <20171023154129.iik3ic36i5fi7sqs@xps13.dannf>
In-Reply-To: <20171023154129.iik3ic36i5fi7sqs@xps13.dannf>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gTW9uLCAyMDE3LTEwLTIzIGF0IDA5OjQxIC0wNjAwLCBkYW5uIGZyYXppZXIgd3JvdGU6DQo+
IChnZGIpIGxpc3QgKihzZ19pbysweDEyMCkNCj4gMHhmZmZmMDAwMDA4NGU3MWE4IGlzIGluIHNn
X2lvICguL2luY2x1ZGUvbGludXgvdWFjY2Vzcy5oOjExMykuDQo+IDEwOAlzdGF0aWMgaW5saW5l
IHVuc2lnbmVkIGxvbmcNCj4gMTA5CV9jb3B5X2Zyb21fdXNlcih2b2lkICp0bywgY29uc3Qgdm9p
ZCBfX3VzZXIgKmZyb20sIHVuc2lnbmVkIGxvbmcgbikNCj4gMTEwCXsNCj4gMTExCQl1bnNpZ25l
ZCBsb25nIHJlcyA9IG47DQo+IDExMgkJbWlnaHRfZmF1bHQoKTsNCj4gMTEzCQlpZiAobGlrZWx5
KGFjY2Vzc19vayhWRVJJRllfUkVBRCwgZnJvbSwgbikpKSB7DQo+IDExNAkJCWthc2FuX2NoZWNr
X3dyaXRlKHRvLCBuKTsNCj4gMTE1CQkJcmVzID0gcmF3X2NvcHlfZnJvbV91c2VyKHRvLCBmcm9t
LCBuKTsNCj4gMTE2CQl9DQo+IDExNwkJaWYgKHVubGlrZWx5KHJlcykpDQoNCkhlbGxvIERhbm4s
DQoNCldvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGNoZWNrIHdoZXRoZXIgdGhlIHBhdGNoIGJlbG93
IGlzIHN1ZmZpY2llbnQgdG8gZml4IHRoaXM/DQoNClRoYW5rcywNCg0KQmFydC4NCg0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRp
b19ibGsuYw0KaW5kZXggMzRlMTdlZTc5OWJlLi4xNWUxMWE1MTk4MDEgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYw0KKysrIGIvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxr
LmMNCkBAIC01OTcsNiArNTk3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBibGtfbXFfb3BzIHZp
cnRpb19tcV9vcHMgPSB7DQogCS5xdWV1ZV9ycQk9IHZpcnRpb19xdWV1ZV9ycSwNCiAJLmNvbXBs
ZXRlCT0gdmlydGJsa19yZXF1ZXN0X2RvbmUsDQogCS5pbml0X3JlcXVlc3QJPSB2aXJ0YmxrX2lu
aXRfcmVxdWVzdCwNCisJLmluaXRpYWxpemVfcnFfZm4gPSBzY3NpX2luaXRpYWxpemVfcnEsDQog
CS5tYXBfcXVldWVzCT0gdmlydGJsa19tYXBfcXVldWVzLA0KIH07DQogDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zY3NpL3NnLmMgYi9kcml2ZXJzL3Njc2kvc2cuYw0KaW5kZXggMDQxOWMyMjk4ZWFi
Li4xNDA5NmY2N2VlYmIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Njc2kvc2cuYw0KKysrIGIvZHJp
dmVycy9zY3NpL3NnLmMNCkBAIC0xNzIyLDYgKzE3MjIsOCBAQCBzZ19zdGFydF9yZXEoU2dfcmVx
dWVzdCAqc3JwLCB1bnNpZ25lZCBjaGFyICpjbWQpDQogCX0NCiAJcmVxID0gc2NzaV9yZXEocnEp
Ow0KIA0KKwlXQVJOX09OX09OQ0UoIXJlcS0+Y21kKTsNCisNCiAJaWYgKGhwLT5jbWRfbGVuID4g
QkxLX01BWF9DREIpDQogCQlyZXEtPmNtZCA9IGxvbmdfY21kcDsNCiAJbWVtY3B5KHJlcS0+Y21k
LCBjbWQsIGhwLT5jbWRfbGVuKTsNCg==
