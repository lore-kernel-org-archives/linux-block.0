Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:56877 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbdKGPyi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Nov 2017 10:54:38 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/1] [RFC] blk-mq: fix queue stalling on shared hctx
 restart
Date: Tue, 7 Nov 2017 15:54:35 +0000
Message-ID: <1510070074.2656.2.camel@wdc.com>
References: <20171018102206.26020-1-roman.penyaev@profitbricks.com>
In-Reply-To: <20171018102206.26020-1-roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE3LTEwLTE4IGF0IDEyOjIyICswMjAwLCBSb21hbiBQZW4gd3JvdGU6DQo+IHRo
ZSBwYXRjaCBiZWxvdyBmaXhlcyBxdWV1ZSBzdGFsbGluZyB3aGVuIHNoYXJlZCBoY3R4IG1hcmtl
ZCBmb3IgcmVzdGFydA0KPiAoQkxLX01RX1NfU0NIRURfUkVTVEFSVCBiaXQpIGJ1dCBxLT5zaGFy
ZWRfaGN0eF9yZXN0YXJ0IHN0YXlzIHplcm8uDQoNClNpbmNlIEkgaGF2ZSBiZWVuIGFibGUgdG8g
cmVwcm9kdWNlIHRoaXMgcXVldWUgc3RhbGwgd2l0aCBhbiB1cHN0cmVhbSBkcml2ZXINCihpYl9z
cnApIGFuZCBzaW5jZSBJIGFsc28gaGF2ZSBiZWVuIGFibGUgdG8gdmVyaWZ5IHRoYXQgdGhpcyBw
YXRjaCBmaXhlcyB0aGF0DQpzdGFsbDoNCg0KUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZSA8
YmFydC52YW5hc3NjaGVAd2RjLmNvbT4NClRlc3RlZC1ieTogQmFydCBWYW4gQXNzY2hlIDxiYXJ0
LnZhbmFzc2NoZUB3ZGMuY29tPg==
