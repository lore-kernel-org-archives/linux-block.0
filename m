Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55741 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755173AbdHYVlz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 17:41:55 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 03/20] blk-mq: introduce blk_mq_dispatch_rq_from_ctx()
Date: Fri, 25 Aug 2017 21:41:08 +0000
Message-ID: <1503697267.2680.36.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-4-ming.lei@redhat.com>
         <1503427542.2508.10.camel@wdc.com> <20170824045226.GC12966@ming.t460p>
In-Reply-To: <20170824045226.GC12966@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE3LTA4LTI0IGF0IDEyOjUyICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VHVlLCBBdWcgMjIsIDIwMTcgYXQgMDY6NDU6NDZQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIFNhdCwgMjAxNy0wOC0wNSBhdCAxNDo1NiArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBNb3JlIGltcG9ydGFudGx5LCBmb3Igc29tZSBTQ1NJIGRldmljZXMsIGRyaXZl
cg0KPiA+ID4gdGFncyBhcmUgaG9zdCB3aWRlLCBhbmQgdGhlIG51bWJlciBpcyBxdWl0ZSBiaWcs
DQo+ID4gPiBidXQgZWFjaCBsdW4gaGFzIHZlcnkgbGltaXRlZCBxdWV1ZSBkZXB0aC4NCj4gPiAN
Cj4gPiBUaGlzIG1heSBiZSB0aGUgY2FzZSBidXQgaXMgbm90IGFsd2F5cyB0aGUgY2FzZS4gQW5v
dGhlciBpbXBvcnRhbnQgdXNlLWNhc2UNCj4gPiBpcyBvbmUgTFVOIHBlciBob3N0IGFuZCB3aGVy
ZSB0aGUgcXVldWUgZGVwdGggcGVyIExVTiBpcyBpZGVudGljYWwgdG8gdGhlDQo+ID4gbnVtYmVy
IG9mIGhvc3QgdGFncy4NCj4gDQo+IFRoaXMgcGF0Y2hzZXQgd29uJ3QgaHVydCB0aGlzIGNhc2Ug
YmVjYXVzZSB0aGUgQlVTWSBpbmZvIGlzIHJldHVybmVkDQo+IGZyb20gZHJpdmVyLiAgSW4gdGhp
cyBjYXNlLCBCTEtfU1RTX1JFU09VUkNFIHNob3VsZCBzZWxkb20gYmUgcmV0dXJuZWQNCj4gZnJv
bSAucXVldWVfcnEgZ2VuZXJhbGx5Lg0KPiANCj4gQWxzbyBvbmUgaW1wb3J0YW50IGZhY3QgaXMg
dGhhdCBvbmNlIHEtPnF1ZXVlX2RlcHRoIGlzIHNldCwgdGhhdA0KPiBtZWFucyB0aGVyZSBpcyBw
ZXItcmVxdWVzdF9xdWV1ZSBsaW1pdCBvbiBwZW5kaW5nIEkvT3MsIGFuZCB0aGUNCj4gc2luZ2xl
IExVTiBpcyBqdXN0IHRoZSBzcGVjaWFsIGNhc2Ugd2hpY2ggaXMgY292ZXJlZCBieSB0aGlzIHdo
b2xlDQo+IHBhdGNoc2V0LiBXZSBkb24ndCBuZWVkIHRvIHBheSBzcGVjaWFsIGF0dGVudGlvbiBp
biB0aGlzIHNwZWNpYWwgY2FzZQ0KPiBhdCBhbGwuDQoNClRoZSBwdXJwb3NlIG9mIG15IGNvbW1l
bnQgd2FzIG5vdCB0byBhc2sgZm9yIGZ1cnRoZXIgY2xhcmlmaWNhdGlvbiBidXQgdG8NCnJlcG9y
dCB0aGF0IHRoZSBkZXNjcmlwdGlvbiBvZiB0aGlzIHBhdGNoIGlzIG5vdCBjb3JyZWN0Lg0KDQo+
ID4gDQo+ID4gPiArc3RydWN0IHJlcXVlc3QgKmJsa19tcV9kaXNwYXRjaF9ycV9mcm9tX2N0eChz
dHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCwNCj4gPiA+ICsJCQkJCSAgICBzdHJ1Y3QgYmxrX21x
X2N0eCAqc3RhcnQpDQo+ID4gPiArew0KPiA+ID4gKwl1bnNpZ25lZCBvZmYgPSBzdGFydCA/IHN0
YXJ0LT5pbmRleF9odyA6IDA7DQo+ID4gDQo+ID4gUGxlYXNlIGNvbnNpZGVyIHRvIHJlbmFtZSB0
aGlzIGZ1bmN0aW9uIGludG8gYmxrX21xX2Rpc3BhdGNoX3JxX2Zyb21fbmV4dF9jdHgoKQ0KPiA+
IGFuZCB0byBzdGFydCBmcm9tIHN0YXJ0LT5pbmRleF9odyArIDEgaW5zdGVhZCBvZiBzdGFydC0+
aW5kZXhfaHcuIEkgdGhpbmsgdGhhdA0KPiA+IHdpbGwgbm90IG9ubHkgcmVzdWx0IGluIHNpbXBs
ZXIgYnV0IGFsc28gaW4gZmFzdGVyIGNvZGUuDQo+IA0KPiBJIGJlbGlldmUgdGhpcyBoZWxwZXIg
d2l0aCBibGtfbXFfbmV4dF9jdHgoaGN0eCwgcnEtPm1xX2N0eCkgdG9nZXRoZXINCj4gd2lsbCBi
ZSBtdWNoIHNpbXBsZXIgYW5kIGVhc2llciB0byBpbXBsZW1lbnQsIGFuZCBjb2RlIGNhbiBiZSBt
dWNoDQo+IHJlYWRhYmxlIHRvby4NCj4gDQo+IGJsa19tcV9kaXNwYXRjaF9ycV9mcm9tX25leHRf
Y3R4KCkgaXMgdWdseSBhbmQgbWl4aW5nIHR3byB0aGluZ3MNCj4gdG9nZXRoZXIuDQoNClNvcnJ5
IGJ1dCBJIGRpc2FncmVlIHdpdGggYm90aCBvZiB0aGUgYWJvdmUgc3RhdGVtZW50cy4NCg0KQmFy
dC4=
