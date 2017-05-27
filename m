Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43328 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdE0VcG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 May 2017 17:32:06 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v2 0/8] blk-mq: fix & improve queue quiescing
Date: Sat, 27 May 2017 21:32:02 +0000
Message-ID: <1495920721.13651.0.camel@sandisk.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
In-Reply-To: <20170527142126.26079-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA1LTI3IGF0IDIyOjIxICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVGhl
cmUgYXJlIHNvbWUgaXNzdWVzIGluIGN1cnJlbnQgYmxrX21xX3F1aWVzY2VfcXVldWUoKToNCj4g
DQo+ICAgICAtIGluIGNhc2Ugb2YgZGlyZWN0IGlzc3VlIG9yIEJMS19NUV9TX1NUQVJUX09OX1JV
TiwgZGlzcGF0Y2ggd29uJ3QNCj4gICAgIGJlIHByZXZlbnRlZCBhZnRlciBibGtfbXFfcXVpZXNj
ZV9xdWV1ZSgpIGlzIHJldHVybmVkLg0KPiAgICAgLSBpbiB0aGVvcnksIG5ldyBSQ1UgcmVhZC1z
aWRlIGNyaXRpY2FsIHNlY3Rpb25zIG1heSBiZWdpbiB3aGlsZQ0KPiAgICAgc3luY2hyb25pemVf
cmN1KCkgd2FzIHdhaXRpbmcsIGFuZCBlbmQgYWZ0ZXIgcmV0dXJuaW5nIGZyb20gDQo+ICAgICBz
eW5jaHJvbml6ZV9yY3UoKSwgdGhlbiBkaXNwYXRjaCBzdGlsbCBtYXkgYmUgcnVuIGFmdGVyDQo+
ICAgICBzeW5jaHJvbml6ZV9yY3UoKSByZXR1cm5zDQoNCkhlbGxvIE1pbmcsDQoNCkkgZGlzYWdy
ZWUgd2l0aCB0aGUgc2Vjb25kIHBhcnQgb2YgeW91ciBzdGF0ZW1lbnQuIGJsa19tcV9xdWllc2Nl
X3F1ZXVlKCkNCnN0b3BzIGFsbCBoYXJkd2FyZSBxdWV1ZXMgYmVmb3JlIGNhbGxpbmcgc3luY2hy
b25pemVfKnJjdSgpLg0KYmxrX21xX3NjaGVkX2Rpc3BhdGNoX3JlcXVlc3RzKCkgaXMgY2FsbGVk
IHdpdGggYW4gUkNVIGxvY2sgaGVsZCBhbmQgY2hlY2tzDQp3aGV0aGVyIGEgaGN0eCBoYXMgYmVl
biBzdG9wcGVkIGJlZm9yZSBjYWxsaW5nIC5xdWV1ZV9ycSgpLiBUaGF0IGlzDQpzdWZmaWNpZW50
IHRvIHByZXZlbnQgYmxrX21xX3RyeV9pc3N1ZV9kaXJlY3RseSgpIHRvIHRyaWdnZXIgYSAucXVl
dWVfcnEoKQ0KY2FsbC4NCg0KQmFydC4=
