Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28383 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbdJ3Udx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2017 16:33:53 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Date: Mon, 30 Oct 2017 20:33:49 +0000
Message-ID: <1509395628.27259.19.camel@wdc.com>
References: <20171027044330.11921-1-ming.lei@redhat.com>
         <1509079996.3244.3.camel@wdc.com> <20171027053834.GA12858@ming.t460p>
         <CAJrWOzD0LoFhKhFf-BrCtWipVEteT3uUqUc30_qr8E8wNeESGg@mail.gmail.com>
In-Reply-To: <CAJrWOzD0LoFhKhFf-BrCtWipVEteT3uUqUc30_qr8E8wNeESGg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE3LTEwLTI3IGF0IDE5OjU1ICswMjAwLCBSb21hbiBQZW55YWV2IHdyb3RlOg0K
PiBUaGF0J3MganVzdCBhIGJ1ZyBpbiBjb2RlLCBub3QgYSBpbiBpc3N1ZSB3aXRoIHJlc3RhcnRz
LCB3aGljaCBjYW4gYmUgZml4ZWQNCj4gaWYgd2UgcHV0IGhjdHggd2hpY2ggYXJlIG5lZWRlZCB0
byBiZSByZXN0YXJ0ZWQgaW4gcGVyY3B1IGxpc3RzIGFuZCBhdm9pZA0KPiBsb25nIGxvb3BzIGFu
ZCBjb250ZW50aW9ucy4NCg0KSGVsbG8gUm9tYW4sDQoNCkhhdmUgeW91IG5vdGljZWQgdGhhdCBy
ZWNlbnRseSAuZ2V0X2J1ZGdldCgpIGFuZCAucHV0X2J1ZGdldCgpIGNhbGxiYWNrcyBoYXZlDQpi
ZWVuIGFkZGVkIGludG8gc3RydWN0IGJsa19tcV9vcHM/IElmIGJsb2NrIGRyaXZlcnMgdGhhdCBz
dXBwb3J0IHNoYXJlZCB0YWdzDQppbXBsZW1lbnQgdGhlc2UgY2FsbGJhY2sgZnVuY3Rpb25zIHBy
b3Blcmx5IHRoZW4gbWF5YmUgYnVzeSBjb25kaXRpb25zIGJlY29tZQ0KaW5mcmVxdWVudCBlbm91
Z2ggdG8gdXNlIGEgc2luZ2xlICJoY3R4IGJ1c3kiIGxpc3QgcGVyIHRhZyBzZXQgaW5zdGVhZCBv
Zg0KcGVyLWNwdSAiaGN0eCBidXN5IiBsaXN0cy4NCg0KQmFydC4=
