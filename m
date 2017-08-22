Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:10373 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdHVU5w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 16:57:52 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 05/20] blk-mq-sched: improve dispatching from sw queue
Date: Tue, 22 Aug 2017 20:57:03 +0000
Message-ID: <1503435422.2508.24.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-6-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDE0OjU2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gK3N0
YXRpYyBpbmxpbmUgdm9pZCBibGtfbXFfZG9fZGlzcGF0Y2hfY3R4KHN0cnVjdCByZXF1ZXN0X3F1
ZXVlICpxLA0KPiArCQkJCQkgIHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4KQ0KPiArew0KPiAr
CUxJU1RfSEVBRChycV9saXN0KTsNCj4gKwlzdHJ1Y3QgYmxrX21xX2N0eCAqY3R4ID0gTlVMTDsN
Cj4gKw0KPiArCWRvIHsNCj4gKwkJc3RydWN0IHJlcXVlc3QgKnJxOw0KPiArDQo+ICsJCXJxID0g
YmxrX21xX2Rpc3BhdGNoX3JxX2Zyb21fY3R4KGhjdHgsIGN0eCk7DQo+ICsJCWlmICghcnEpDQo+
ICsJCQlicmVhazsNCj4gKwkJbGlzdF9hZGQoJnJxLT5xdWV1ZWxpc3QsICZycV9saXN0KTsNCj4g
Kw0KPiArCQkvKiByb3VuZCByb2JpbiBmb3IgZmFpciBkaXNwYXRjaCAqLw0KPiArCQljdHggPSBi
bGtfbXFfbmV4dF9jdHgoaGN0eCwgcnEtPm1xX2N0eCk7DQo+ICsJfSB3aGlsZSAoYmxrX21xX2Rp
c3BhdGNoX3JxX2xpc3QocSwgJnJxX2xpc3QpKTsNCj4gK30NCg0KQW4gYWRkaXRpb25hbCBxdWVz
dGlvbiBhYm91dCB0aGlzIHBhdGNoOiBzaG91bGRuJ3QgcmVxdWVzdCBkZXF1ZXVpbmcgc3RhcnQN
CmF0IHRoZSBzb2Z0d2FyZSBxdWV1ZSBuZXh0IHRvIHRoZSBsYXN0IG9uZSBmcm9tIHdoaWNoIGEg
cmVxdWVzdCBnb3QgZGVxdWV1ZWQNCmluc3RlYWQgb2YgYWx3YXlzIHN0YXJ0aW5nIGF0IHRoZSBm
aXJzdCBzb2Z0d2FyZSBxdWV1ZSAoc3RydWN0IGJsa19tcV9jdHgNCipjdHggPSBOVUxMKSB0byBi
ZSB0cnVseSByb3VuZCByb2Jpbj8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg==
