Return-Path: <prvs=6660f83ed=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "deller@gmx.de" <deller@gmx.de>,
	"heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "hch@lst.de"
	<hch@lst.de>, "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "chris@zankel.net"
	<chris@zankel.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"arnd@arndb.de" <arnd@arndb.de>, "geert@linux-m68k.org"
	<geert@linux-m68k.org>, "benh@kernel.crashing.org"
	<benh@kernel.crashing.org>, "schwidefsky@de.ibm.com"
	<schwidefsky@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>
Subject: Re: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Date: Tue, 15 May 2018 15:14:14 +0000
Message-ID: <7b1813846c2ad915f5432394ccbf7966065b5e45.camel@wdc.com>
References: <20180514184634.2160-1-bart.vanassche@wdc.com>
	 <20180514184634.2160-2-bart.vanassche@wdc.com>
	 <87lgclpr1y.fsf@concordia.ellerman.id.au>
In-Reply-To: <87lgclpr1y.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA1LTE1IGF0IDEyOjU0ICsxMDAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3Rl
Og0KPiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+IHdyaXRlczoNCj4g
PiANCj4gPiArICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gKyAgICB8ICAgICAgICAg
YXJjaCB8c3RhdHVzfA0KPiA+ICsgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArICAg
IHwgICAgICAgYWxwaGE6IHwgIG9rICB8DQo+ID4gKyAgICB8ICAgICAgICAgYXJjOiB8IFRPRE8g
fA0KPiA+ICsgICAgfCAgICAgICAgIGFybTogfCF0aHVtYnwNCj4gPiArICAgIHwgICAgICAgYXJt
NjQ6IHwgIG9rICB8DQo+ID4gKyAgICB8ICAgICAgICAgYzZ4OiB8IFRPRE8gfA0KPiA+ICsgICAg
fCAgICAgICBoODMwMDogfCBUT0RPIHwNCj4gPiArICAgIHwgICAgIGhleGFnb246IHwgVE9ETyB8
DQo+ID4gKyAgICB8ICAgICAgICBpYTY0OiB8ICBvayAgfA0KPiA+ICsgICAgfCAgICAgICAgbTY4
azogfCAgb2sgIHwNCj4gPiArICAgIHwgIG1pY3JvYmxhemU6IHwgVE9ETyB8DQo+ID4gKyAgICB8
ICAgICAgICBtaXBzOiB8NjQtYml0fA0KPiA+ICsgICAgfCAgICAgICBuaW9zMjogfCBUT0RPIHwN
Cj4gPiArICAgIHwgICAgb3BlbnJpc2M6IHwgVE9ETyB8DQo+ID4gKyAgICB8ICAgICAgcGFyaXNj
OiB8ICBvayAgfA0KPiA+ICsgICAgfCAgICAgcG93ZXJwYzogfDY0LWJpdHwNCj4gDQo+IEkgdGhp
bmsgdGhhdCBpcyBjb3JyZWN0IGZvciBwb3dlcnBjLCB3ZSBkb24ndCBoYXZlIGEgMzItYml0DQo+
IGltcGxlbWVudGF0aW9uIGFuZCB0aGVyZSdzIG5vIGZhbGxiYWNrIGl0IHNlZW1zLg0KPiANCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL0tjb25maWcgYi9hcmNoL3Bvd2VycGMvS2NvbmZp
Zw0KPiA+IC0tLSBhL2FyY2gvcG93ZXJwYy9LY29uZmlnDQo+ID4gKysrIGIvYXJjaC9wb3dlcnBj
L0tjb25maWcNCj4gPiBAQCAtMTUwLDYgKzE1MCw3IEBAIGNvbmZpZyBQUEMNCj4gPiAgCXNlbGVj
dCBBUkNIX0hBU19VQlNBTl9TQU5JVElaRV9BTEwNCj4gPiAgCXNlbGVjdCBBUkNIX0hBU19aT05F
X0RFVklDRQkJaWYgUFBDX0JPT0szU182NA0KPiA+ICAJc2VsZWN0IEFSQ0hfSEFWRV9OTUlfU0FG
RV9DTVBYQ0hHDQo+ID4gKwlzZWxlY3QgQVJDSF9IQVZFX0NNUFhDSEc2NA0KPiANCj4gU28gc2hv
dWxkbid0IHRoaXMgc2hvdWxkIGJlOg0KPiANCj4gKwlzZWxlY3QgQVJDSF9IQVZFX0NNUFhDSEc2
NAkJaWYgUFBDNjQNCj4gDQo+IEFuZCBpdCBzaG91bGQgYmUgc29ydGVkIGFscGhhYmV0aWNhbGx5
LCBpZS4gYWJvdmUgdGhlIHByZXZpb3VzIE5NSSBlbnRyeS4NCg0KSGVsbG8gTWljaGFlbCwNCg0K
VGhhbmtzLCBJIHdpbGwgbWFrZSB0aGVzZSBjaGFuZ2VzLg0KDQpCYXJ0Lg0KDQoNCg0KDQo=
