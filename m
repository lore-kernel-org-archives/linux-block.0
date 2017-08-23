Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41951 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932216AbdHWRbs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 13:31:48 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [PATCH v2 1/2] fault-inject: Restore support for task-independent
 fault injection
Date: Wed, 23 Aug 2017 17:31:00 +0000
Message-ID: <1503509459.2484.13.camel@wdc.com>
References: <20170822230043.9968-1-bart.vanassche@wdc.com>
         <20170822230043.9968-2-bart.vanassche@wdc.com>
         <CAC5umyh5r-nmKisg7bavbm320Gd1puZmPOv7q+q0yonYbzr+ZA@mail.gmail.com>
In-Reply-To: <CAC5umyh5r-nmKisg7bavbm320Gd1puZmPOv7q+q0yonYbzr+ZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE3LTA4LTIzIGF0IDA5OjEwICswOTAwLCBBa2lub2J1IE1pdGEgd3JvdGU6DQo+
IDIwMTctMDgtMjMgODowMCBHTVQrMDk6MDAgQmFydCBWYW4gQXNzY2hlIDxiYXJ0LnZhbmFzc2No
ZUB3ZGMuY29tPjoNCj4gPiBDZXJ0YWluIGZhdWx0cyBzaG91bGQgYmUgaW5qZWN0ZWQgaW5kZXBl
bmRlbnQgb2YgdGhlIGNvbnRleHQNCj4gPiBpbiB3aGljaCB0aGVzZSBvY2N1ci4gQ29tbWl0IGU0
MWQ1ODE4NWYxNCBtYWRlIGl0IGltcG9zc2libGUgdG8NCj4gPiBpbmplY3QgZmF1bHRzIGluZGVw
ZW5kZW50IG9mIHRoZWlyIGNvbnRleHQuIFJlc3RvcmUgc3VwcG9ydCBmb3INCj4gPiB0YXNrLWlu
ZGVwZW5kZW50IGZhdWx0IGluamVjdGlvbiBieSBhZGRpbmcgdGhlIGF0dHJpYnV0ZSAnZ2xvYmFs
Jy4NCj4gDQo+IFRoZXJlIHdhcyBhIHRoZSBwcm9ibGVtIHJlcG9ydGVkIGJ5IGZhaWwtbWFrZS1y
ZXF1ZXN0IHVzZXIgYW5kIHRoZQ0KPiBwcm9ibGVtIGlzIGludHJvZHVjZWQgYnkgdGhlIGZvbGxv
dy11cCBwYXRjaGVzIGZvciBzeXN0ZW1hdGljDQo+IGZhdWx0IGluamVjdGlvbi4NCj4gDQo+IFBs
ZWFzZSBjaGVjayB0aGUgY29tbWl0IDllZWI1MmFlNzEyZSAoImZhdWx0LWluamVjdDogZml4IHdy
b25nDQo+IHNob3VsZF9mYWlsKCkgZGVjaXNpb24gaW4gdGFzayBjb250ZXh0IikgYW5kIHNlZSBp
ZiB0aGUgcHJvYmxlbQ0KPiB5b3UgcmVwb3J0ZWQgaXMgaWRlbnRpY2FsIHRvIHRoZSBjb21taXQu
DQoNCkhlbGxvIEFraW5vYnUsDQoNClNpbmNlIEkgd2FzIHVzaW5nIHRoZSBibG9jayBsYXllciBm
b3ItbmV4dCBicmFuY2ggYXMgdGhlIGJhc2lzIG9mIG15IHRlc3RzLA0KY29tbWl0IDllZWI1MmFl
NzEyZSB3YXMgbm90IHByZXNlbnQgaW4gdGhlIGtlcm5lbCB0cmVlIHVzZWQgaW4gbXkgdGVzdHMu
DQpIb3dldmVyLCB3aXRoIHRoYXQgY29tbWl0IDllZWI1MmFlNzEyZSBhcHBsaWVkIEkgZG9uJ3Qg
bmVlZCBteSB0d28gcGF0Y2hlcw0KYW55bW9yZSB0byBpbmplY3QgYmxvY2sgbGF5ZXIgdGltZW91
dCBmYXVsdHMgc3VjY2Vzc2Z1bGx5LiBTbyBJJ20gZmluZSB3aXRoDQpkcm9wcGluZyBteSB0d28g
cGF0Y2hlcy4NCg0KU29ycnkgZm9yIHRoZSBub2lzZS4NCg0KQmFydC4=
