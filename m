Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19076 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752072AbdIAPwd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Sep 2017 11:52:33 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "surajschoudhari@gmail.com" <surajschoudhari@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blk_get_request sleeps in schedule
Date: Fri, 1 Sep 2017 15:51:45 +0000
Message-ID: <1504281104.14386.20.camel@wdc.com>
References: <CAGvB2rNiyP58+TTgc-D9RzesvQWx1RgjjepQBujhZQa5Cx-f9A@mail.gmail.com>
In-Reply-To: <CAGvB2rNiyP58+TTgc-D9RzesvQWx1RgjjepQBujhZQa5Cx-f9A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE3LTA5LTAxIGF0IDA4OjA3ICswNTMwLCBTdXJhaiBDaG91ZGhhcmkgd3JvdGU6
DQo+IE9uIG15IHRlc3Qgc3lzdGVtLCBibGtfZ2V0X3JlcXVlc3QoKSBjb250aW51b3VzbHkgaGFu
Z3MgaW4gc2NoZWR1bGUoKS4NCj4gDQo+IHNjaGVkdWxlKzB4MzUvMHg4MA0KPiBzY2hlZHVsZV90
aW1lb3V0KzB4MjM3LzB4MmQwDQo+IGlvX3NjaGVkdWxlX3RpbWVvdXQrMHhhNi8weDExMA0KPiBn
ZXRfcmVxdWVzdCsweDI1OC8weDc2MA0KPiBibGtfZ2V0X3JlcXVlc3QrMHg3Zi8weDEwMA0KPiAN
Cj4gSSBzdXNwZWN0IHRoZSBwcm9ibGVtIG1pZ2h0IGJlIGR1ZSB0byBfX2dldF9yZXF1ZXN0IHJl
dHVybmluZyBFTk9NRU0sDQo+IGxlYWRpbmcgdG8gc2xlZXAgaW4gc2NoZWR1bGUoKS4NCg0KSGVs
bG8gU3VyYWosDQoNCkluIGFkZGl0aW9uIHRvIHdoYXQgSmVucyB3cm90ZTogcGxlYXNlIGNvbnNp
ZGVyIHN3aXRjaGluZyB0byBibGstbXEgc3VjaA0KdGhhdCB5b3UgY2FuIHVzZSB0aGUgaW5mb3Jt
YXRpb24gaW4gL3N5cy9rZXJuZWwvZGVidWcvYmxvY2sgdG8gYW5hbHl6ZQ0KdGhpcyBmdXJ0aGVy
Lg0KDQpCYXJ0Lg==
