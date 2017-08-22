Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23856 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbdHVUKU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 16:10:20 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 06/20] blk-mq-sched: don't dequeue request until all in
 ->dispatch are flushed
Date: Tue, 22 Aug 2017 20:09:32 +0000
Message-ID: <1503432571.2508.15.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-7-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-7-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDE0OjU2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gKwkv
Kg0KPiArCSAqIFdoZXJldmVyIERJU1BBVENIX0JVU1kgaXMgc2V0LCBibGtfbXFfcnVuX2h3X3F1
ZXVlKCkNCj4gKwkgKiB3aWxsIGJlIHJ1biB0byB0cnkgdG8gbWFrZSBwcm9ncmVzcywgc28gaXQg
aXMgYWx3YXlzDQo+ICsJICogc2FmZSB0byBjaGVjayB0aGUgc3RhdGUgaGVyZS4NCj4gKwkgKi8N
Cj4gKwlpZiAodGVzdF9iaXQoQkxLX01RX1NfRElTUEFUQ0hfQlVTWSwgJmhjdHgtPnN0YXRlKSkN
Cj4gKwkJcmV0dXJuOw0KDQpUaGUgY29tbWVudCBhYm92ZSB0ZXN0X2JpdCgpIGlzIHVzZWZ1bCBi
dXQgZG9lcyBub3QgZXhwbGFpbiB0aGUgcHVycG9zZSBvZg0KdGhlIGVhcmx5IHJldHVybi4gSXMg
dGhlIHB1cnBvc2Ugb2YgdGhlIGVhcmx5IHJldHVybiBwZXJoYXBzIHRvIHNlcmlhbGl6ZQ0KYmxr
X21xX3NjaGVkX2Rpc3BhdGNoX3JlcXVlc3RzKCkgY2FsbHM/IElmIHNvLCBwbGVhc2UgbWVudGlv
biB0aGlzLg0KDQpUaGFua3MsDQoNCkJhcnQu
