Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54031 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdIORal (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 13:30:41 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH 2/5] dm-mpath: return DM_MAPIO_REQUEUE in case of rq
 allocation failure
Date: Fri, 15 Sep 2017 17:29:53 +0000
Message-ID: <1505496592.3420.10.camel@wdc.com>
References: <20170915164456.9803-1-ming.lei@redhat.com>
         <20170915164456.9803-3-ming.lei@redhat.com>
In-Reply-To: <20170915164456.9803-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA5LTE2IGF0IDAwOjQ0ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gYmxr
LW1xIHdpbGwgcmVydW4gcXVldWUgdmlhIFJFU1RBUlQgYWZ0ZXIgb25lIHJlcXVlc3QgaXMgY29t
cGxldGlvbiwNCj4gc28gbm90IG5lY2Vzc2FyeSB0byB3YWl0IHJhbmRvbSB0aW1lIGZvciByZXF1
ZXVpbmcsIGl0IHNob3VsZCB0cnVzdA0KPiBibGstbXEgdG8gZG8gaXQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L21kL2RtLW1wYXRoLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21kL2RtLW1wYXRoLmMg
Yi9kcml2ZXJzL21kL2RtLW1wYXRoLmMNCj4gaW5kZXggOTZhZWRhYWMyYzY0Li5mNWExMDg4YTZl
NzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWQvZG0tbXBhdGguYw0KPiArKysgYi9kcml2ZXJz
L21kL2RtLW1wYXRoLmMNCj4gQEAgLTUwNSw3ICs1MDUsNyBAQCBzdGF0aWMgaW50IG11bHRpcGF0
aF9jbG9uZV9hbmRfbWFwKHN0cnVjdCBkbV90YXJnZXQgKnRpLCBzdHJ1Y3QgcmVxdWVzdCAqcnEs
DQo+ICAJCQlhdG9taWNfaW5jKCZtLT5wZ19pbml0X2luX3Byb2dyZXNzKTsNCj4gIAkJCWFjdGl2
YXRlX29yX29mZmxpbmVfcGF0aChwZ3BhdGgpOw0KPiAgCQl9DQo+IC0JCXJldHVybiBETV9NQVBJ
T19ERUxBWV9SRVFVRVVFOw0KPiArCQlyZXR1cm4gRE1fTUFQSU9fUkVRVUVVRTsNCj4gIAl9DQo+
ICAJY2xvbmUtPmJpbyA9IGNsb25lLT5iaW90YWlsID0gTlVMTDsNCj4gIAljbG9uZS0+cnFfZGlz
ayA9IGJkZXYtPmJkX2Rpc2s7DQoNClNvIHlvdSBhcmUgcmV2ZXJ0aW5nIHRoZSBwYXRjaCBiZWxv
dz8gVGhhbmsgeW91IHZlcnkgbXVjaC4NCg0KY29tbWl0IDFjMjM0ODRjMzU1ZWMzNjBjYTJmMzc5
MTRmOGE0ODAyYzZiYWVlYWQNCkF1dGhvcjogQmFydCBWYW4gQXNzY2hlIDxiYXJ0LnZhbmFzc2No
ZUB3ZGMuY29tPg0KRGF0ZTogICBXZWQgQXVnIDkgMTE6MzI6MTIgMjAxNyAtMDcwMA0KDQogICAg
ZG0gbXBhdGg6IGRvIG5vdCBsb2NrIHVwIGEgQ1BVIHdpdGggcmVxdWV1aW5nIGFjdGl2aXR5DQog
ICAgDQogICAgV2hlbiB1c2luZyB0aGUgYmxvY2sgbGF5ZXIgaW4gc2luZ2xlIHF1ZXVlIG1vZGUs
IGdldF9yZXF1ZXN0KCkNCiAgICByZXR1cm5zIEVSUl9QVFIoLUVBR0FJTikgaWYgdGhlIHF1ZXVl
IGlzIGR5aW5nIGFuZCB0aGUgUkVRX05PV0FJVA0KICAgIGZsYWcgaGFzIGJlZW4gcGFzc2VkIHRv
IGdldF9yZXF1ZXN0KCkuIEF2b2lkIHRoYXQgdGhlIGtlcm5lbA0KICAgIHJlcG9ydHMgc29mdCBs
b2NrdXAgY29tcGxhaW50cyBpbiB0aGlzIGNhc2UgZHVlIHRvIGNvbnRpbnVvdXMNCiAgICByZXF1
ZXVpbmcgYWN0aXZpdHkuDQogICAgDQogICAgRml4ZXM6IDcwODNhYmJiZiAoImRtIG1wYXRoOiBh
dm9pZCB0aGF0IHBhdGggcmVtb3ZhbCBjYW4gdHJpZ2dlciBhbiBpbmZpbml0ZSBsb29wIikNCiAg
ICBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KICAgIFNpZ25lZC1vZmYtYnk6IEJhcnQgVmFu
IEFzc2NoZSA8YmFydC52YW5hc3NjaGVAd2RjLmNvbT4NCiAgICBUZXN0ZWQtYnk6IExhdXJlbmNl
IE9iZXJtYW4gPGxvYmVybWFuQHJlZGhhdC5jb20+DQogICAgUmV2aWV3ZWQtYnk6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KICAgIFNpZ25lZC1vZmYtYnk6IE1pa2UgU25pdHplciA8
c25pdHplckByZWRoYXQuY29tPg==
