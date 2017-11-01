Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55515 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755024AbdKAQut (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Nov 2017 12:50:49 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH 1/1] [RFC] blk-mq: fix queue stalling on shared hctx
 restart
Date: Wed, 1 Nov 2017 16:50:45 +0000
Message-ID: <1509555044.2530.35.camel@wdc.com>
References: <20171018102206.26020-1-roman.penyaev@profitbricks.com>
         <1508435243.2429.42.camel@wdc.com>
         <CAJrWOzCyLSNYAmEY6afoVjPYK8KaoH1HSs63iGpDuCwesjwBLQ@mail.gmail.com>
         <1508529929.3029.20.camel@wdc.com>
         <CAJrWOzAmPT_0jrYRi_U-fHHjOitk2XE461ZhL=aKFiY3iQjGMQ@mail.gmail.com>
In-Reply-To: <CAJrWOzAmPT_0jrYRi_U-fHHjOitk2XE461ZhL=aKFiY3iQjGMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gTW9uLCAyMDE3LTEwLTIzIGF0IDE3OjEyICswMjAwLCBSb21hbiBQZW55YWV2IHdyb3RlOg0K
PiBPbiBGcmksIE9jdCAyMCwgMjAxNyBhdCAxMDowNSBQTSwgQmFydCBWYW4gQXNzY2hlIHdyb3Rl
Og0KPiA+IENvbW1pdCA2ZDhjNmMwZjk3YWQgaXMgc29tZXRoaW5nIEkgY2FtZSB1cCB3aXRoIHRv
IGZpeCBxdWV1ZSBsb2NrdXBzIGluIHRoZQ0KPiA+IFNDU0kgYW5kIGRtLW1xIGRyaXZlcnMuDQo+
IA0KPiBZb3UgbWVhbiBmYWlybmVzcz8gKHNvbWUgaGN0eCBnZXQgbGVzcyBhbW91bnQgb2YgY2hh
bmNlcyB0byBiZSByZXN0YXJ0ZWQpLg0KPiBUaGF0J3Mgd2h5IHlvdSBuZWVkIHRvIHJlc3RhcnQg
dGhlbSBpbiBSUiBmYXNoaW9uLCByaWdodD8NCg0KQ29tbWl0IDZkOGM2YzBmOTdhZCBub3Qgb25s
eSBpbXByb3ZlZCBmYWlybmVzcyBidXQgYWxzbyBmaXhlZCBhIGxvY2t1cCBzY2VuYXJpby4NCkFm
dGVyIGEgZHJpdmVyIHRhZyBoYXMgYmVlbiBmcmVlZCBub3Qgb25seSB0aGUgaHcgcXVldWVzIG9m
IHRoZSByZXF1ZXN0IHF1ZXVlIGZvcg0Kd2hpY2ggYSByZXF1ZXN0IGNvbXBsZXRlZCBtdXN0IGJl
IHJlZXhhbWluZWQgYnV0IGFsc28gdGhlIGh3IHF1ZXVlcyBhc3NvY2lhdGVkDQp3aXRoIHRoZSBv
dGhlciByZXF1ZXN0IHF1ZXVlcyB0aGF0IHNoYXJlIHRoZSBzYW1lIHRhZyBzZXQuDQoNCkJhcnQu
