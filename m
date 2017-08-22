Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9489 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbdHVSqs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 14:46:48 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 03/20] blk-mq: introduce blk_mq_dispatch_rq_from_ctx()
Date: Tue, 22 Aug 2017 18:45:46 +0000
Message-ID: <1503427542.2508.10.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-4-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDE0OjU2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gTW9y
ZSBpbXBvcnRhbnRseSwgZm9yIHNvbWUgU0NTSSBkZXZpY2VzLCBkcml2ZXINCj4gdGFncyBhcmUg
aG9zdCB3aWRlLCBhbmQgdGhlIG51bWJlciBpcyBxdWl0ZSBiaWcsDQo+IGJ1dCBlYWNoIGx1biBo
YXMgdmVyeSBsaW1pdGVkIHF1ZXVlIGRlcHRoLg0KDQpUaGlzIG1heSBiZSB0aGUgY2FzZSBidXQg
aXMgbm90IGFsd2F5cyB0aGUgY2FzZS4gQW5vdGhlciBpbXBvcnRhbnQgdXNlLWNhc2UNCmlzIG9u
ZSBMVU4gcGVyIGhvc3QgYW5kIHdoZXJlIHRoZSBxdWV1ZSBkZXB0aCBwZXIgTFVOIGlzIGlkZW50
aWNhbCB0byB0aGUNCm51bWJlciBvZiBob3N0IHRhZ3MuDQoNCj4gK3N0cnVjdCByZXF1ZXN0ICpi
bGtfbXFfZGlzcGF0Y2hfcnFfZnJvbV9jdHgoc3RydWN0IGJsa19tcV9od19jdHggKmhjdHgsDQo+
ICsJCQkJCSAgICBzdHJ1Y3QgYmxrX21xX2N0eCAqc3RhcnQpDQo+ICt7DQo+ICsJdW5zaWduZWQg
b2ZmID0gc3RhcnQgPyBzdGFydC0+aW5kZXhfaHcgOiAwOw0KDQpQbGVhc2UgY29uc2lkZXIgdG8g
cmVuYW1lIHRoaXMgZnVuY3Rpb24gaW50byBibGtfbXFfZGlzcGF0Y2hfcnFfZnJvbV9uZXh0X2N0
eCgpDQphbmQgdG8gc3RhcnQgZnJvbSBzdGFydC0+aW5kZXhfaHcgKyAxIGluc3RlYWQgb2Ygc3Rh
cnQtPmluZGV4X2h3LiBJIHRoaW5rIHRoYXQNCndpbGwgbm90IG9ubHkgcmVzdWx0IGluIHNpbXBs
ZXIgYnV0IGFsc28gaW4gZmFzdGVyIGNvZGUuDQoNClRoYW5rcywNCg0KQmFydC4=
