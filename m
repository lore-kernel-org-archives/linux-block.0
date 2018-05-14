Return-Path: <prvs=6650905ae=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>
CC: "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "deller@gmx.de" <deller@gmx.de>,
	"heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "hch@lst.de"
	<hch@lst.de>, "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hpa@zytor.com" <hpa@zytor.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
	<will.deacon@arm.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"jejb@parisc-linux.org" <jejb@parisc-linux.org>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "chris@zankel.net" <chris@zankel.net>,
	"davem@davemloft.net" <davem@davemloft.net>, "arnd@arndb.de" <arnd@arndb.de>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "benh@kernel.crashing.org"
	<benh@kernel.crashing.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"paulus@samba.org" <paulus@samba.org>
Subject: Re: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Date: Mon, 14 May 2018 20:42:13 +0000
Message-ID: <cb51c6f8eb93452d405180d9da0f1e203b469d2a.camel@wdc.com>
References: <20180514184634.2160-1-bart.vanassche@wdc.com>
	 <20180514184634.2160-2-bart.vanassche@wdc.com>
	 <CAMo8Bf+Wgm2VrZiY+CfjN=CM=ysYBpRyTMdozV+6A8Brk4DKDQ@mail.gmail.com>
In-Reply-To: <CAMo8Bf+Wgm2VrZiY+CfjN=CM=ysYBpRyTMdozV+6A8Brk4DKDQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTA1LTE0IGF0IDExOjUwIC0wNzAwLCBNYXggRmlsaXBwb3Ygd3JvdGU6DQo+
IE9uIE1vbiwgTWF5IDE0LCAyMDE4IGF0IDExOjQ2IEFNLCBCYXJ0IFZhbiBBc3NjaGUNCj4gPGJh
cnQudmFuYXNzY2hlQHdkYy5jb20+IHdyb3RlOg0KPiA+IFRoZSBuZXh0IHBhdGNoIGluIHRoaXMg
c2VyaWVzIGludHJvZHVjZXMgYSBjYWxsIHRvIGNtcHhjaGc2NCgpDQo+ID4gaW4gdGhlIGJsb2Nr
IGxheWVyIGNvcmUgZm9yIHRob3NlIGFyY2hpdGVjdHVyZXMgb24gd2hpY2ggdGhpcw0KPiA+IGZ1
bmN0aW9uYWxpdHkgaXMgYXZhaWxhYmxlLiBNYWtlIGl0IHBvc3NpYmxlIHRvIHRlc3Qgd2hldGhl
cg0KPiA+IGNtcHhjaGc2NCgpIGlzIGF2YWlsYWJsZSBieSBpbnRyb2R1Y2luZyBDT05GSUdfQVJD
SF9IQVZFX0NNUFhDSEc2NC4NCj4gPiANCj4gPiAtLS0NCj4gDQo+IFsuLi5dDQo+IA0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL3h0ZW5zYS9LY29uZmlnIGIvYXJjaC94dGVuc2EvS2NvbmZpZw0KPiA+
IGluZGV4IGM5MjFlOGJjY2RjOC4uODIzNDI3OGE4MjFkIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
eHRlbnNhL0tjb25maWcNCj4gPiArKysgYi9hcmNoL3h0ZW5zYS9LY29uZmlnDQo+ID4gQEAgLTIz
LDYgKzIzLDcgQEAgY29uZmlnIFhURU5TQQ0KPiA+ICAgICAgICAgc2VsZWN0IEhBVkVfRE1BX0NP
TlRJR1VPVVMNCj4gPiAgICAgICAgIHNlbGVjdCBIQVZFX0VYSVRfVEhSRUFEDQo+ID4gICAgICAg
ICBzZWxlY3QgSEFWRV9GVU5DVElPTl9UUkFDRVINCj4gPiArICAgICAgIHNlbGVjdCBBUkNIX0hB
VkVfQ01QWENIRzY0DQo+IA0KPiBUaGlzIGJyZWFrcyBhbHBoYWJldGljYWwgc29ydGluZyBvZiBL
Y29uZmlnIGVudHJpZXMuDQoNCkhlbGxvIE1heCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2su
IERvIHlvdSBwZXJoYXBzIGtub3cgd2hldGhlciBrZWVwaW5nIG5hbWVzIGluDQphbHBoYWJldGlj
YWwgb3JkZXIgaXMgYSByZXF1aXJlbWVudCBmb3IgYXJjaC94dGVuc2EvS2NvbmZpZyBvbmx5IG9y
DQp3aGV0aGVyIHRoaXMgaXMgcmVxdWlyZWQgZm9yIGFsbCBhcmNoLyovS2NvbmZpZyBmaWxlcz8N
Cg0KQmFydC4=
