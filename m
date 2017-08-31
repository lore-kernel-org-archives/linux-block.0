Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22401 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdHaVBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 17:01:07 -0400
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
Date: Thu, 31 Aug 2017 21:00:19 +0000
Message-ID: <1504213218.31872.55.camel@wdc.com>
References: <20170826163332.28971-1-ming.lei@redhat.com>
         <20170826163332.28971-7-ming.lei@redhat.com>
         <1504113058.2526.54.camel@wdc.com> <20170831040123.GE12246@ming.t460p>
In-Reply-To: <20170831040123.GE12246@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE3LTA4LTMxIGF0IDEyOjAxICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
V2VkLCBBdWcgMzAsIDIwMTcgYXQgMDU6MTE6MDBQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIFN1biwgMjAxNy0wOC0yNyBhdCAwMDozMyArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gWyAuLi4gXQ0KPiA+IFNob3VsZG4ndCBibGtfbXFfc2NoZWRfZGlzcGF0Y2hfcmVx
dWVzdHMoKSBzZXQgQkxLX01RX1NfRElTUEFUQ0hfQlVTWSBqdXN0IGFmdGVyDQo+ID4gdGhlIGZv
bGxvd2luZyBzdGF0ZW1lbnQgYmVjYXVzZSB0aGlzIHN0YXRlbWVudCBtYWtlcyB0aGUgZGlzcGF0
Y2ggbGlzdCBlbXB0eT8NCj4gDQo+IEFjdHVhbGx5IHRoYXQgaXMgd2hhdCBJIGRpZCBpbiBWMS4N
Cj4gDQo+IEkgY2hhbmdlZCB0byB0aGlzIHdheSBiZWNhdXNlIHNldHRpbmcgdGhlIEJVU1kgZmxh
ZyBoZXJlIHdpbGwgaW5jcmVhc2UNCj4gdGhlIHJhY2Ugd2luZG93IGEgYml0LCBmb3IgZXhhbXBs
ZSwgaWYgb25lIHJlcXVlc3QgaXMgYWRkZWQgdG8gLT5kaXNwYXRjaA0KPiBqdXN0IGFmdGVyIGl0
IGlzIGZsdXNoZWQoKSwgdGhlIGNoZWNrIG9uIHRoZSBCVVNZIGJpdCB3b24ndCBjYXRjaCB0aGlz
DQo+IGNhc2UuIFRoZW4gd2UgY2FuIGF2b2lkIHRvIGNoZWNrIGJvdGggdGhlIGJpdCBhbmQgbGlz
dF9lbXB0eV9jYXJlZnVsKCZoY3R4LT5kaXNwYXRjaCkNCj4gaW4gYmxrX21xX3NjaGVkX2Rpc3Bh
dGNoX3JlcXVlc3RzKCksIHNvIGNvZGUgYmVjb21lcyBzaW1wbGVyIGFuZCBtb3JlDQo+IHJlYWRh
YmxlIGlmIHdlIHNldCB0aGUgZmxhZyBzaW1wbHkgZnJvbSB0aGUgYmVnaW5uaW5nLg0KDQpIZWxs
byBNaW5nLA0KDQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgYmxrX21xX3NjaGVkX2Rpc3BhdGNo
X3JlcXVlc3RzKCkgd2lsbCBvbmx5IHdvcmsNCmNvcnJlY3RseSBpZiB0aGUgY29kZSB0aGF0IHNl
dHMgdGhlIERJU1BBVENIX0JVU1kgZmxhZyBkb2VzIHRoYXQgYWZ0ZXIgaGF2aW5nDQppbnNlcnRl
ZCBvbmUgb3IgbW9yZSBlbGVtZW50cyBpbiB0aGUgZGlzcGF0Y2ggbGlzdC4gQWx0aG91Z2ggeDg2
IENQVXMgZG8gbm90DQpyZW9yZGVyIHN0b3JlIG9wZXJhdGlvbnMgSSB0aGluayB0aGF0IHRoZSBm
dW5jdGlvbnMgdGhhdCBzZXQgdGhlIERJU1BBVENIX0JVU1kNCmZsYWcgbmVlZCBhIG1lbW9yeSBi
YXJyaWVyIHRoZXNlIHR3byBzdG9yZSBvcGVyYXRpb25zLiBJJ20gcmVmZXJyaW5nIHRvIHRoZQ0K
YmxrX21xX3NjaGVkX2J5cGFzc19pbnNlcnQoKSwgYmxrX21xX2Rpc3BhdGNoX3dhaXRfYWRkKCkg
YW5kDQpibGtfbXFfaGN0eF9ub3RpZnlfZGVhZCgpIGZ1bmN0aW9ucy4NCg0KPiA+ID4gKwkJICog
dG9vIHNtYWxsLCBubyBuZWVkIHRvIHdvcnJ5IGFib3V0IHBlcmZvcm1hbmNlDQo+ID4gDQo+ID4g
ICAgICAgICAgICAgICAgICAgIF5eXg0KPiA+IFRoZSB3b3JkICJ0b28iIHNlZW1zIGV4dHJhbmVv
dXMgdG8gbWUgaW4gdGhpcyBzZW50ZW5jZS4NCj4gDQo+IE1heWJlICdleHRyZW1lbHknIGlzIGJl
dHRlciwgb3IganVzdCByZW1vdmUgaXQ/DQoNCklmIHRoZSB3b3JkICJ0b28iIHdvdWxkIGJlIHJl
bW92ZWQgSSB0aGluayB0aGUgY29tbWVudCBpcyBzdGlsbCBjbGVhci4NCg0KVGhhbmtzLA0KDQpC
YXJ0Lg==
