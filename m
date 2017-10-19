Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41962 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdJSRrc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2017 13:47:32 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/1] [RFC] blk-mq: fix queue stalling on shared hctx
 restart
Date: Thu, 19 Oct 2017 17:47:24 +0000
Message-ID: <1508435243.2429.42.camel@wdc.com>
References: <20171018102206.26020-1-roman.penyaev@profitbricks.com>
In-Reply-To: <20171018102206.26020-1-roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE3LTEwLTE4IGF0IDEyOjIyICswMjAwLCBSb21hbiBQZW4gd3JvdGU6DQo+IHRo
ZSBwYXRjaCBiZWxvdyBmaXhlcyBxdWV1ZSBzdGFsbGluZyB3aGVuIHNoYXJlZCBoY3R4IG1hcmtl
ZCBmb3IgcmVzdGFydA0KPiAoQkxLX01RX1NfU0NIRURfUkVTVEFSVCBiaXQpIGJ1dCBxLT5zaGFy
ZWRfaGN0eF9yZXN0YXJ0IHN0YXlzIHplcm8uICBUaGUNCj4gcm9vdCBjYXVzZSBpcyB0aGF0IGhj
dHhzIGFyZSBzaGFyZWQgYmV0d2VlbiBxdWV1ZXMsIGJ1dCAnc2hhcmVkX2hjdHhfcmVzdGFydCcN
Cj4gYmVsb25ncyB0byB0aGUgcGFydGljdWxhciBxdWV1ZSwgd2hpY2ggaW4gZmFjdCBtYXkgbm90
IG5lZWQgdG8gYmUgcmVzdGFydGVkLA0KPiB0aHVzIHdlIHJldHVybiBmcm9tIGJsa19tcV9zY2hl
ZF9yZXN0YXJ0KCkgYW5kIGxlYXZlIHNoYXJlZCBoY3R4IG9mIGFub3RoZXINCj4gcXVldWUgbmV2
ZXIgcmVzdGFydGVkLg0KPiANCj4gVGhlIGZpeCBpcyB0byBtYWtlIHNoYXJlZF9oY3R4X3Jlc3Rh
cnQgY291bnRlciBiZWxvbmcgbm90IHRvIHRoZSBxdWV1ZSwgYnV0DQo+IHRvIHRhZ3MsIHRoZXJl
YnkgY291bnRlciB3aWxsIHJlZmxlY3QgcmVhbCBudW1iZXIgb2Ygc2hhcmVkIGhjdHggbmVlZGVk
IHRvDQo+IGJlIHJlc3RhcnRlZC4NCg0KSGVsbG8gUm9tYW4sDQoNClRoZSBwYXRjaCB5b3UgcG9z
dGVkIGxvb2tzIGZpbmUgdG8gbWUgYnV0IHNlZWluZyB0aGlzIHBhdGNoIGFuZCB0aGUgcGF0Y2gN
CmRlc2NyaXB0aW9uIG1ha2VzIG1lIHdvbmRlciB3aHkgdGhpcyBoYWQgbm90IGJlZW4gbm90aWNl
ZCBiZWZvcmUuIEFyZSB5b3UNCnBlcmhhcHMgdXNpbmcgYSBibG9jayBkcml2ZXIgdGhhdCByZXR1
cm5zIEJMS19TVFNfUkVTT1VSQ0UgbW9yZSBvZnRlbiB0aGFuDQpvdGhlciBibG9jayBkcml2ZXJz
PyBEaWQgeW91IHBlcmhhcHMgcnVuIGludG8gdGhpcyB3aXRoIHRoZSBJbmZpbmliYW5kDQpuZXR3
b3JrIGJsb2NrIGRldmljZSAoSUJOQkQpIGRyaXZlcj8gTm8gbWF0dGVyIHdoYXQgZHJpdmVyIHRy
aWdnZXJlZCB0aGlzLA0KSSB0aGluayB0aGlzIGJ1ZyBzaG91bGQgYmUgZml4ZWQuDQoNCkJhcnQu
