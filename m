Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26669 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbdHGWa3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Aug 2017 18:30:29 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V2 00/20] blk-mq-sched: improve SCSI-MQ performance
Date: Mon, 7 Aug 2017 22:29:40 +0000
Message-ID: <1502144980.27230.0.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <df64b15d-a443-553c-a3c6-d834320648fd@redhat.com>
         <CAFfF4qv3W6D-j8BSSZbwPLqhd_mmwk8CZQe7dSqud8cMMd2yPg@mail.gmail.com>
In-Reply-To: <CAFfF4qv3W6D-j8BSSZbwPLqhd_mmwk8CZQe7dSqud8cMMd2yPg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gTW9uLCAyMDE3LTA4LTA3IGF0IDE4OjA2IC0wNDAwLCBMYXVyZW5jZSBPYmVybWFuIHdyb3Rl
Og0KPiBXaXRoIFttcS1kZWFkbGluZV0gZW5hYmxlZCBvbiBzdG9jayBJIGRvbnQgc2VlIHRoZW0g
YXQgYWxsIGFuZCBpdCBiZWhhdmVzLg0KPiANCj4gTm93IHdpdGggTWluZydzIHBhdGNoZXMgaWYg
d2UgZW5hYmxlIFttcS1kZWFkbGluZV0gd2UgRE8gc2VlIHRoZSBjbG9uZQ0KPiBmYWlsdXJlcyBh
bmQgdGhlIGhhcmQgbG9ja3VwIHNvIHdlIGhhdmUgb3Bwb3NpdCBiZWhhdmlvdXIgd2l0aCB0aGUN
Cj4gc2NoZWR1bGVyIGNob2ljZSBhbmQgd2UgaGF2ZSB0aGUgaGFyZCBsb2NrdXAuDQo+IA0KPiBP
biBNaW5nJ3Mga2VybmVsIHdpdGggW25vbmVdIHdlIGFyZSB3ZWxsIGJlaGF2ZWQgYW5kIHRoYXQg
d2FzIG15IG9yaWdpbmFsDQo+IGZvY3VzLCB0ZXN0aW5nIG9uIFtub25lXSBhbmQgaGVuY2UgbXkg
VGVzdGVkLWJ5OiBwYXNzLg0KPiANCj4gU28gbW9yZSBpbnZlc3RpZ2F0aW9uIGlzIG5lZWRlZCBo
ZXJlLg0KDQpIZWxsbyBMYXVyZW5jZSwNCg0KV2FzIGRlYnVnZnMgZW5hYmxlZCBvbiB5b3VyIHRl
c3Qgc2V0dXA/IEhhZCB5b3UgcGVyaGFwcyBjb2xsZWN0ZWQgdGhlDQpjb250ZW50cyBvZiB0aGUg
YmxvY2sgbGF5ZXIgZGVidWdmcyBmaWxlcyBhZnRlciB0aGUgbG9ja3VwIG9jY3VycmVkLCBlLmcu
IGFzDQpmb2xsb3dzOiAoY2QgL3N5cy9rZXJuZWwvZGVidWcvYmxvY2sgJiYgZmluZCAtdHlwZSBm
IHwgeGFyZ3MgZ3JlcCAtYUggJycpPw0KDQpUaGFua3MsDQoNCkJhcnQu
