Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60602 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdHaUhl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 16:37:41 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>
Subject: Re: [PATCH V3 05/14] blk-mq-sched: improve dispatching from sw queue
Date: Thu, 31 Aug 2017 20:36:53 +0000
Message-ID: <1504211812.31872.41.camel@wdc.com>
References: <20170826163332.28971-1-ming.lei@redhat.com>
         <20170826163332.28971-6-ming.lei@redhat.com>
         <1504110886.2526.36.camel@wdc.com> <20170831034333.GD12246@ming.t460p>
In-Reply-To: <20170831034333.GD12246@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE3LTA4LTMxIGF0IDExOjQzICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
V2VkLCBBdWcgMzAsIDIwMTcgYXQgMDQ6MzQ6NDdQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIFN1biwgMjAxNy0wOC0yNyBhdCAwMDozMyArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGstbXEuaCBiL2luY2x1ZGUv
bGludXgvYmxrLW1xLmgNCj4gPiA+IGluZGV4IDUwYzY0ODVjYjA0Zi4uN2I3YTM2NmE5N2YzIDEw
MDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9ibGstbXEuaA0KPiA+ID4gKysrIGIvaW5j
bHVkZS9saW51eC9ibGstbXEuaA0KPiA+ID4gQEAgLTMwLDYgKzMwLDggQEAgc3RydWN0IGJsa19t
cV9od19jdHggew0KPiA+ID4gIA0KPiA+ID4gIAlzdHJ1Y3Qgc2JpdG1hcAkJY3R4X21hcDsNCj4g
PiA+ICANCj4gPiA+ICsJc3RydWN0IGJsa19tcV9jdHgJKmRpc3BhdGNoX2Zyb207DQo+ID4gPiAr
DQo+ID4gPiAgCXN0cnVjdCBibGtfbXFfY3R4CSoqY3R4czsNCj4gPiA+ICAJdW5zaWduZWQgaW50
CQlucl9jdHg7DQo+ID4gDQo+ID4gSGVsbG8gTWluZywNCj4gPiANCj4gPiBBcmUgeW91IHJlbHlp
bmcgaGVyZSBvbiB0aGUgZmFjdCB0aGF0IHRoZSBwZXItQ1BVIHF1ZXVlcyBhcmUgbmV2ZXINCj4g
PiByZWFsbG9jYXRlZCwgZXZlbiBpZiBDUFUgaG90LXBsdWdnaW5nIG9jY3Vycz8gU29ycnkgYnV0
IHRoYXQgc2VlbXMgZnJhZ2lsZQ0KPiA+IHRvIG1lLiBJIHdvdWxkIGxpa2UgdG8gc2VlICdkaXNw
YXRjaF9mcm9tJyBiZSBjb252ZXJ0ZWQgaW50byBhbiBpbnRlZ2VyLiBJdA0KPiA+IGlzIGVhc3kg
dG8gY2hlY2sgd2hldGhlciBhbiBpbnRlZ2VyIHNvZnR3YXJlIHF1ZXVlIGluZGV4IGlzIG91dCBv
ZiByYW5nZQ0KPiA+IGJ1dCBpdCdzIG5vdCB0aGF0IGVhc3kgdG8gY2hlY2sgd2hldGhlciBhIHBv
aW50ZXIgYmVjYW1lIGludmFsaWQuDQo+IA0KPiBJZiBDUFUgaG90cGx1ZyBoYXBwZW5zLCB0aGUg
aW5zdGFuY2Ugb2YgJ3N0cnVjdCBibGtfbXFfY3R4JyBmb3IgdGhhdA0KPiBDUFUgaXMgc3RpbGwg
dGhlcmUgYW5kIGl0cyBpbmRleCB3b24ndCBjaGFuZ2UgZnJvbSBiZWluZyBzZXR1cCBiZWNhdXNl
DQo+IGl0cyBsaWZldGltZSBpcyBzYW1lIHdpdGggJ3N0cnVjdCByZXF1ZXN0X3F1ZXVlJywgYmxr
X21xX2hjdHhfbm90aWZ5X2RlYWQoKQ0KPiBqdXN0IGZsdXNoZXMgdGhlIHN3IHF1ZXVlIHdoZW4g
dGhlIENQVSBpcyBnb2luZyBhd2F5Lg0KPiANCj4gU28gd2UgZG9uJ3QgbmVlZCB0byBwYXkgc3Bl
Y2lhbCBhdHRlbnRpb24gdG8gQ1BVIGhvdHBsdWcgaGVyZSwgcGxlYXNlIGxldA0KPiBtZSBrbm93
IGlmIHlvdSBhcmUgZmluZSBub3cuDQoNCkhlbGxvIE1pbmcsDQoNClRoYXQncyBhbHNvIGhvdyBJ
IGludGVycHJldCB0aGUgYmxrLW1xIHNvdXJjZSBjb2RlLiBCdXQgaXQncyBwcm9iYWJseSBhIGdv
b2QNCmlkZWEgdG8gYWRkIGEgc2hvcnQgY29tbWVudCB0aGF0IHRoZSBkaXNwYXRjaF9mcm9tIHBv
aW50ZXIgaXMgbm90IGFmZmVjdGVkIGJ5DQpDUFUgaG90LXBsdWdnaW5nLiBBbnl3YXksIHdpdGgg
b3Igd2l0aG91dCBzdWNoIGEgY29tbWVudDoNCg0KUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2No
ZSA8YmFydC52YW5hc3NjaGVAd2RjLmNvbT4NCg0K
