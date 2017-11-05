Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12911 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdKEPix (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Nov 2017 10:38:53 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH] blk-mq: respect queue dead via blk_mq_quiesce_queue
Date: Sun, 5 Nov 2017 15:38:49 +0000
Message-ID: <1509896328.2697.4.camel@wdc.com>
References: <20171105121008.28180-1-ming.lei@redhat.com>
In-Reply-To: <20171105121008.28180-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE3LTExLTA1IGF0IDIwOjEwICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gZGlm
ZiAtLWdpdCBhL2Jsb2NrL2Jsay1jb3JlLmMgYi9ibG9jay9ibGstY29yZS5jDQo+IGluZGV4IDA0
OGJlNGFhNjAyNC4uMGIxMjFmMjllM2IxIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibGstY29yZS5j
DQo+ICsrKyBiL2Jsb2NrL2Jsay1jb3JlLmMNCj4gQEAgLTY1OCw2ICs2NTgsMTAgQEAgdm9pZCBi
bGtfY2xlYW51cF9xdWV1ZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkNCj4gIAlxdWV1ZV9mbGFn
X3NldChRVUVVRV9GTEFHX0RFQUQsIHEpOw0KPiAgCXNwaW5fdW5sb2NrX2lycShsb2NrKTsNCj4g
IA0KPiArCS8qIHJlc3BlY3QgcXVldWUgREVBRCB2aWEgcXVpZXNjZSBmb3IgYmxrLW1xICovDQo+
ICsJaWYgKHEtPm1xX29wcykNCj4gKwkJYmxrX21xX3F1aWVzY2VfcXVldWUocSk7DQo+ICsNCj4g
IAkvKiBmb3Igc3luY2hyb25vdXMgYmlvLWJhc2VkIGRyaXZlciBmaW5pc2ggaW4tZmxpZ2h0IGlu
dGVncml0eSBpL28gKi8NCj4gIAlibGtfZmx1c2hfaW50ZWdyaXR5KCk7DQoNCkhhdmUgeW91IGNv
bnNpZGVyZWQgdG8gY2hhbmdlIHRoZSBibGtfZnJlZXplX3F1ZXVlX3N0YXJ0KCkgY2FsbCBpbg0K
YmxrX3NldF9xdWV1ZV9keWluZygpIGludG8gYSBibGtfZnJlZXplX3F1ZXVlKCkgY2FsbD8gVGhh
dCBhcHByb2FjaCBoYXMgdGhlDQphZHZhbnRhZ2UgdGhhdCBubyBuZXcgaWYgKHEtPm1xX29wcykg
dGVzdCBoYXMgdG8gYmUgaW50cm9kdWNlZC4NCg0KQWRkaXRpb25hbGx5LCB0aGUgY2FsbCB0cmFj
ZSBpbiB0aGUgZGVzY3JpcHRpb24gb2YgdGhpcyBwYXRjaCBzaG93cyB0aGF0IHRoZQ0KY29tbWVu
dCBpbiBibGtfZXhlY3V0ZV9ycV9ub3dhaXQoKSBpcyB3cm9uZy4gSG93IGFib3V0IGNoYW5naW5n
IHRoYXQgY29tbWVudA0KYXMgZm9sbG93cz8NCg0KQEAgLTU3LDEwICs1NywxMiBAQCB2b2lkIGJs
a19leGVjdXRlX3JxX25vd2FpdChzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgc3RydWN0IGdlbmRp
c2sgKmJkX2Rpc2ssDQogCXJxLT5lbmRfaW8gPSBkb25lOw0KIA0KIAkvKg0KLQkgKiBkb24ndCBj
aGVjayBkeWluZyBmbGFnIGZvciBNUSBiZWNhdXNlIHRoZSByZXF1ZXN0IHdvbid0DQotCSAqIGJl
IHJldXNlZCBhZnRlciBkeWluZyBmbGFnIGlzIHNldA0KKwkgKiBibGtfZnJlZXplX3F1ZXVlKCkg
bXVzdCBiZSBjYWxsZWQgYmVmb3JlIHRyYW5zaXRpb25pbmcgYSBxdWV1ZQ0KKwkgKiBpbnRvIHRo
ZSAiZGVhZCIgc3RhdGUgdG8gZ3VhcmFudGVlIHRoYXQgYmxrX2V4ZWN1dGVfcnFfbm93YWl0KCkN
CisJICogd29uJ3QgYXR0ZW1wdCB0byBxdWV1ZSBhIHJlcXVlc3Qgb24gYSAiZGVhZCIgYmxrLW1x
IHF1ZXVlLg0KIAkgKi8NCiAJaWYgKHEtPm1xX29wcykgew0KKwkJV0FSTl9PTl9PTkNFKGJsa19x
dWV1ZV9kZWFkKHEpKTsNCiAJCWJsa19tcV9zY2hlZF9pbnNlcnRfcmVxdWVzdChycSwgYXRfaGVh
ZCwgdHJ1ZSwgZmFsc2UsIGZhbHNlKTsNCiAJCXJldHVybjsNCiAJfQ0KDQpCYXJ0Lg==
