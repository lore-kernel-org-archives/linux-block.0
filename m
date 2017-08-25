Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53457 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933777AbdHYWX5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 18:23:57 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 09/20] blk-mq: introduce BLK_MQ_F_SHARED_DEPTH
Date: Fri, 25 Aug 2017 22:23:09 +0000
Message-ID: <1503699788.2680.52.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-10-ming.lei@redhat.com>
         <1503438955.2508.30.camel@wdc.com> <20170824065215.GJ12966@ming.t460p>
In-Reply-To: <20170824065215.GJ12966@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE3LTA4LTI0IGF0IDE0OjUyICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VHVlLCBBdWcgMjIsIDIwMTcgYXQgMDk6NTU6NTdQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIFNhdCwgMjAxNy0wOC0wNSBhdCAxNDo1NiArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiArCS8qDQo+ID4gPiArCSAqIGlmIHRoZXJlIGlzIHEtPnF1ZXVlX2RlcHRoLCBh
bGwgaHcgcXVldWVzIHNoYXJlDQo+ID4gPiArCSAqIHRoaXMgcXVldWUgZGVwdGggbGltaXQNCj4g
PiA+ICsJICovDQo+ID4gPiArCWlmIChxLT5xdWV1ZV9kZXB0aCkgew0KPiA+ID4gKwkJcXVldWVf
Zm9yX2VhY2hfaHdfY3R4KHEsIGhjdHgsIGkpDQo+ID4gPiArCQkJaGN0eC0+ZmxhZ3MgfD0gQkxL
X01RX0ZfU0hBUkVEX0RFUFRIOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCWlmICghcS0+
ZWxldmF0b3IpDQo+ID4gPiArCQlnb3RvIGV4aXQ7DQo+ID4gDQo+ID4gSGVsbG8gTWluZywNCj4g
PiANCj4gPiBJdCBzZWVtcyB2ZXJ5IGZyYWdpbGUgdG8gbWUgdG8gc2V0IEJMS19NUV9GX1NIQVJF
RF9ERVBUSCBpZiBhbmQgb25seSBpZg0KPiA+IHEtPnF1ZXVlX2RlcHRoICE9IDAuIFdvdWxkbid0
IGl0IGJlIGJldHRlciB0byBsZXQgdGhlIGJsb2NrIGRyaXZlciB0ZWxsIHRoZQ0KPiA+IGJsb2Nr
IGxheWVyIHdoZXRoZXIgb3Igbm90IHRoZXJlIGlzIGEgcXVldWUgZGVwdGggbGltaXQgYWNyb3Nz
IGhhcmR3YXJlDQo+ID4gcXVldWVzLCBlLmcuIHRocm91Z2ggYSB0YWcgc2V0IGZsYWc/DQo+IA0K
PiBPbmUgcmVhc29uIGZvciBub3QgZG9pbmcgaW4gdGhhdCB3YXkgaXMgYmVjYXVzZSBxLT5xdWV1
ZV9kZXB0aCBjYW4gYmUNCj4gY2hhbmdlZCB2aWEgc3lzZnMgaW50ZXJmYWNlLg0KDQpPbmx5IHRo
ZSBTQ1NJIGNvcmUgYWxsb3dzIHRoZSBxdWV1ZSBkZXB0aCB0byBiZSBjaGFuZ2VkIHRocm91Z2gg
c3lzZnMuIFRoZQ0Kb3RoZXIgYmxvY2sgZHJpdmVycyBJIGFtIGZhbWlsaWFyIHdpdGggc2V0IHRo
ZSBxdWV1ZSBkZXB0aCB3aGVuIHRoZSBibG9jaw0KbGF5ZXIgcXVldWUgaXMgY3JlYXRlZCBhbmQg
ZG8gbm90IGFsbG93IHRoZSBxdWV1ZSBkZXB0aCB0byBiZSBjaGFuZ2VkIGxhdGVyDQpvbi4NCg0K
PiBBbm90aGVyIHJlYXNvbiBpcyB0aGF0IGJldHRlciB0byBub3QgZXhwb3NpbmcgdGhpcyBmbGFn
IHRvIGRyaXZlcnMgc2luY2UNCj4gaXQgaXNuJ3QgbmVjZXNzYXJ5LCB0aGF0IHNhaWQgaXQgaXMg
YW4gaW50ZXJuYWwgZmxhZyBhY3R1YWxseS4NCg0KQXMgZmFyIGFzIEkga25vdyBvbmx5IHRoZSBT
Q1NJIGNvcmUgY2FuIGNyZWF0ZSByZXF1ZXN0IHF1ZXVlcyB0aGF0IGhhdmUgYQ0KcXVldWUgZGVw
dGggdGhhdCBpcyBsb3dlciB0aGFuIHRoZSBudW1iZXIgb2YgdGFncyBpbiB0aGUgdGFnIHNldC4g
U28gZm9yIGFsbA0KYmxvY2sgZHJpdmVycyBleGNlcHQgdGhlIFNDU0kgY29yZSBpdCBpcyBPSyB0
byBkaXNwYXRjaCBhbGwgcmVxdWVzdHMgYXQgb25jZQ0KdG8gd2hpY2ggYSBoYXJkd2FyZSB0YWcg
aGFzIGJlZW4gYXNzaWduZWQuIE15IHByb3Bvc2FsIGlzIGVpdGhlciB0byBsZXQNCmRyaXZlcnMg
bGlrZSB0aGUgU0NTSSBjb3JlIHNldCBCTEtfTVFfRl9TSEFSRURfREVQVEggb3IgdG8gbW9kaWZ5
DQpibGtfbXFfc2NoZWRfZGlzcGF0Y2hfcmVxdWVzdHMoKSBzdWNoIHRoYXQgaXQgZmx1c2hlcyBh
bGwgcmVxdWVzdHMgaWYgdGhlDQpyZXF1ZXN0IHF1ZXVlIGRlcHRoIGlzIG5vdCBsb3dlciB0aGFu
IHRoZSBoYXJkd2FyZSB0YWcgc2V0IHNpemUgaW5zdGVhZCBvZiBpZg0KcS0+cXVldWVfZGVwdGgg
PT0gMC4NCg0KQmFydC4=
