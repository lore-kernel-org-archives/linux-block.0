Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4200 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756416AbdHYUY0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 16:24:26 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report] skd: Avoid that module unloading triggers a
 use-after-free
Date: Fri, 25 Aug 2017 20:23:40 +0000
Message-ID: <1503692619.2680.18.camel@wdc.com>
References: <20170824110412.uh27qkhutnrid7ji@mwanda>
         <1503587051.2702.1.camel@wdc.com> <20170824183654.o4glfufhi243io4c@mwanda>
In-Reply-To: <20170824183654.o4glfufhi243io4c@mwanda>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE3LTA4LTI0IGF0IDIxOjM2ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBPbiBUaHUsIEF1ZyAyNCwgMjAxNyBhdCAwMzowNDoxMlBNICswMDAwLCBCYXJ0IFZhbiBBc3Nj
aGUgd3JvdGU6DQo+ID4gSWYgeW91IGhhdmUgYSBsb29rIGF0IHNrZF9jb25zX2Rpc2soKSB5b3Ug
d2lsbCBzZWUgdGhhdCBza2Rldi0+cXVldWUgIT0gTlVMTA0KPiA+IGltcGxpZXMgdGhhdCBza2Rl
di0+ZGlzayAhPSBOVUxMLiBTbyBJIHRoaW5rIHRoZSBhYm92ZSByZXBvcnQgaXMgYSBmYWxzZQ0K
PiA+IHBvc2l0aXZlLg0KPiANCj4gT2gsIHllYWguICBZb3UncmUgcmlnaHQuICBUaGFua3MgZm9y
IHRha2luZyBhIGxvb2sgYXQgdGhpcy4NCg0KVGhhbmsgeW91IGZvciBhbGwgdGhlIHdvcmsgeW91
IGhhdmUgZG9uZSBhbmQgYXJlIHN0aWxsIGRvaW5nIG9uIHNtYXRjaCBhbmQgb24NCnZlcmlmeWlu
ZyBhbGwgbmV3IGNvZGUhDQoNCkJhcnQu
