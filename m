Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "neilb@suse.com" <neilb@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "cl@linux.com"
	<cl@linux.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] percpu-refcount: Introduce
 percpu_ref_switch_to_atomic_nowait()
Date: Mon, 11 Sep 2017 17:29:23 +0000
Message-ID: <1505150962.2802.54.camel@wdc.com>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
	 <20170908235226.26622-2-bart.vanassche@wdc.com>
	 <20170911131331.GE1774378@devbig577.frc2.facebook.com>
	 <1505146151.2802.21.camel@wdc.com>
	 <20170911163756.GF1774378@devbig577.frc2.facebook.com>
	 <1505148959.2802.47.camel@wdc.com>
	 <20170911172056.GG1774378@devbig577.frc2.facebook.com>
In-Reply-To: <20170911172056.GG1774378@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE3LTA5LTExIGF0IDEwOjIwIC0wNzAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IEht
bS4uLiBzbyBpZiB5b3Uga25vdyB0aGF0IHlvdSB3b24ndCB0cnkgdG8gc3dpdGNoIGFnYWluIHdo
aWxlDQo+IHN3aXRjaGluZyBpcyBpbiBwcm9ncmVzcywgaXQgc2hvdWxkIGJlIGZpbmUuICBUaGF0
IGNhbid0IGJlDQo+IGd1YXJhbnRlZWQ/DQoNCkhlbGxvIFRlanVuLA0KDQpBZnRlciBoYXZpbmcg
aGFkIGFub3RoZXIgbG9vayBhdCB0aGUgcG93ZXIgbWFuYWdlbWVudCBkb2N1bWVudGF0aW9uIEkg
c2VlDQpub3cgdGhhdCBwb3dlciBtYW5hZ2VtZW50IGNhbGxiYWNrcyBhcmUgb25seSBjYWxsZWQg
ZnJvbSBhdG9taWMgY29udGV4dCBpZg0KcG1fcnVudGltZV9pcnFfc2FmZShkZXYpIGlzIGNhbGxl
ZCBmaXJzdC4gTmVpdGhlciB0aGUgYmxvY2sgbGF5ZXIgY29yZSBub3INCnRoZSBTQ1NJIGNvcmUg
Y2FsbCB0aGlzIGZ1bmN0aW9uIHNvIEkgd2lsbCB0cnkgdG8gcmV3b3JrIHRoaXMgcGF0Y2ggc2Vy
aWVzDQp3aXRob3V0IG1vZGlmeWluZyB0aGUgcGVyY3B1LXJlZmNvdW50IGltcGxlbWVudGF0aW9u
Lg0KDQpUaGFua3MsDQoNCkJhcnQu
