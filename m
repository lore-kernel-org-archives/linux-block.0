Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15464 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752202AbdIASUN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Sep 2017 14:20:13 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>
Subject: Re: [PATCH V3 06/14] blk-mq-sched: don't dequeue request until all in
 ->dispatch are flushed
Date: Fri, 1 Sep 2017 18:19:24 +0000
Message-ID: <1504289962.14386.56.camel@wdc.com>
References: <20170826163332.28971-1-ming.lei@redhat.com>
         <20170826163332.28971-7-ming.lei@redhat.com>
         <1504113058.2526.54.camel@wdc.com> <20170831040123.GE12246@ming.t460p>
         <1504213218.31872.55.camel@wdc.com> <20170901030236.GC16525@ming.t460p>
In-Reply-To: <20170901030236.GC16525@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE3LTA5LTAxIGF0IDExOjAyICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVGhh
dCBpcyBhIGdvb2QgcXVlc3Rpb24sIGJ1dCBpdCBoYXMgYmVlbiBhbnN3ZXJlZCBieSB0aGUgY29t
bWVudA0KPiBiZWZvcmUgY2hlY2tpbmcgdGhlIERJU1BBVENIX0JVU1kgc3RhdGUgaW4gYmxrX21x
X3NjaGVkX2Rpc3BhdGNoX3JlcXVlc3RzKCk6DQo+IA0KPiAJLyoNCj4gCSAqIElmIERJU1BBVENI
X0JVU1kgaXMgc2V0LCB0aGF0IG1lYW5zIGh3IHF1ZXVlIGlzIGJ1c3kNCj4gCSAqIGFuZCByZXF1
ZXN0cyBpbiB0aGUgbGlzdCBvZiBoY3R4LT5kaXNwYXRjaCBuZWVkIHRvDQo+IAkgKiBiZSBmbHVz
aGVkIGZpcnN0LCBzbyByZXR1cm4gZWFybHkuDQo+IAkgKg0KPiAJICogV2hlcmV2ZXIgRElTUEFU
Q0hfQlVTWSBpcyBzZXQsIGJsa19tcV9ydW5faHdfcXVldWUoKQ0KPiAJICogd2lsbCBiZSBydW4g
dG8gdHJ5IHRvIG1ha2UgcHJvZ3Jlc3MsIHNvIGl0IGlzIGFsd2F5cw0KPiAJICogc2FmZSB0byBj
aGVjayB0aGUgc3RhdGUgaGVyZS4NCj4gCSAqLw0KPiANCj4gU3VwcG9zZSB0aGUgdHdvIHdyaXRl
cyBhcmUgcmVvcmRlcmVkLCBzb29uZXIgb3IgbGF0dGVyLCB0aGUNCj4gbGlzdF9lbXB0eV9jYXJl
ZnVsKCZoY3R4LT5kaXNwYXRjaCkgd2lsbCBiZSBvYnNlcnZlZCwgYW5kDQo+IHdpbGwgZGlzcGF0
Y2ggcmVxdWVzdCBmcm9tIHRoaXMgaHcgcXVldWUgYWZ0ZXIgJy0+ZGlzcGF0Y2gnDQo+IGlzIGZs
dXNoZWQuDQo+IA0KPiBTaW5jZSBub3cgdGhlIHNldHRpbmcgb2YgRElTUEFUQ0hfQlVTWSByZXF1
aXJlcyB0byBob2xkDQo+IGhjdHgtPmxvY2ssIHdlIHNob3VsZCBhdm9pZCB0byBhZGQgYmFycmll
ciB0aGVyZS4NCg0KQWx0aG91Z2ggaXQgaXMgbm90IGNsZWFyIHRvIG1lIGhvdyBhbnlvbmUgd2hv
IGhhcyBub3QgZm9sbG93ZWQgdGhpcyBkaXNjdXNzaW9uDQppcyBhc3N1bWVkIHRvIGZpZ3VyZSBv
dXQgYWxsIHRoZXNlIHN1YnRsZXRpZXMsIGlmIHRoZSBvdGhlciBjb21tZW50cyBnZXQNCmFkZHJl
c3NlZDoNCg0KUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3NjaGVAd2Rj
LmNvbT4NCg0K
