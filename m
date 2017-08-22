Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26987 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbdHVShv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 14:37:51 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "osandov@fb.com" <osandov@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 02/20] sbitmap: introduce __sbitmap_for_each_set()
Date: Tue, 22 Aug 2017 18:37:02 +0000
Message-ID: <1503427020.2508.8.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-3-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDE0OjU2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gLXN0
YXRpYyBpbmxpbmUgdm9pZCBzYml0bWFwX2Zvcl9lYWNoX3NldChzdHJ1Y3Qgc2JpdG1hcCAqc2Is
IHNiX2Zvcl9lYWNoX2ZuIGZuLA0KPiAtCQkJCQl2b2lkICpkYXRhKQ0KPiArc3RhdGljIGlubGlu
ZSB2b2lkIF9fc2JpdG1hcF9mb3JfZWFjaF9zZXQoc3RydWN0IHNiaXRtYXAgKnNiLA0KPiArCQkJ
CQkgIHVuc2lnbmVkIGludCBvZmYsDQo+ICsJCQkJCSAgc2JfZm9yX2VhY2hfZm4gZm4sIHZvaWQg
KmRhdGEpDQo+ICB7DQoNCkFuIGFkZGl0aW9uYWwgY29tbWVudDogaWYgYSBmdW5jdGlvbiBuYW1l
IHN0YXJ0cyB3aXRoIGEgZG91YmxlIHVuZGVyc2NvcmUNCnVzdWFsbHkgdGhhdCBlaXRoZXIgbWVh
bnMgdGhhdCBpdCBzaG91bGQgYmUgY2FsbGVkIHdpdGggYSBzcGVjaWZpYyBsb2NrDQpoZWxkIG9y
IHRoYXQgaXQgaXMgYW4gaW1wbGVtZW50YXRpb24gZnVuY3Rpb24gdGhhdCBzaG91bGQgbm90IGJl
IGNhbGxlZCBieQ0Kb3RoZXIgbW9kdWxlcy4gU2luY2UgbmVpdGhlciBpcyB0aGUgY2FzZSBmb3Ig
X19zYml0bWFwX2Zvcl9lYWNoX3NldCgpLA0KcGxlYXNlIGNvbnNpZGVyIHRvIHVzZSBhbm90aGVy
IG5hbWUgZm9yIHRoaXMgZnVuY3Rpb24uDQoNClRoYW5rcywNCg0KQmFydC4=
