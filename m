Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@fb.com" <shli@fb.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "tj@kernel.org" <tj@kernel.org>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>, "arnd@arndb.de"
	<arnd@arndb.de>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Date: Wed, 11 Apr 2018 21:28:30 +0000
Message-ID: <b34103c58fec2ff45be27cd90925f7655ff38da8.camel@wdc.com>
References: <20180407102148.GA9729@gmail.com>
	 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
	 <20180411101242.GA2322@gmail.com>
	 <20180411142019.GG793541@devbig577.frc2.facebook.com>
	 <20180411142859.GB2322@gmail.com>
	 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
	 <20180411190027.GA21274@gmail.com>
	 <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
	 <20180411212320.GA26747@gmail.com>
In-Reply-To: <20180411212320.GA26747@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDIzOjIzICswMjAwLCBBbGV4YW5kcnUgTW9pc2Ugd3JvdGU6
DQo+IEhpLCBJIHRlc3RlZCBpdCwgaXQgZG9lc24ndCBzb2x2ZSB0aGUgcHJvYmxlbS4NCj4gQnkg
dGhlIHRpbWUgeW91IGdldCBoZXJlIGl0J3MgYWxyZWFkeSB0b28gbGF0ZSwgbXkgcGF0Y2gNCj4g
cHJldmVudHMgdGhpcyBmcm9tIGZhaWxpbmcgaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQpIZWxsbyBB
bGV4LA0KDQpJZiB5b3UgY2FuIHNoYXJlIHRoZSBzdGVwcyB0byBmb2xsb3cgdG8gdHJpZ2dlciB0
aGUgYnVnIHlvdSByZXBvcnRlZCB0aGVuDQpJIHdpbGwgaGF2ZSBhIGNsb3NlciBsb29rIGF0IHRo
aXMuDQoNClRoYW5rcywNCg0KQmFydC4NCg0KDQoNCg==
