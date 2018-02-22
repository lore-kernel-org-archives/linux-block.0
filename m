Return-Path: <prvs=5846e59cf=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jack@suse.com" <jack@suse.com>
Subject: Re: [PATCH v3 3/3] block: Fix a race between request queue removal
 and the block cgroup controller
Date: Thu, 22 Feb 2018 16:59:05 +0000
Message-ID: <1519318744.2861.3.camel@wdc.com>
References: <20180209184405.25835-1-bart.vanassche@wdc.com>
	 <20180209184405.25835-4-bart.vanassche@wdc.com>
	 <4be27fbf-35a3-034a-f60e-1694393b90e3@linux.alibaba.com>
In-Reply-To: <4be27fbf-35a3-034a-f60e-1694393b90e3@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTAyLTIyIGF0IDEwOjI1ICswODAwLCBKb3NlcGggUWkgd3JvdGU6DQo+IEkg
bm90aWNlIHRoYXQgc2V2ZXJhbCBkZXZpY2VzIHN1Y2ggYXMgbG9vcCBhbmQgenJhbSB3aWxsIGNh
bGwNCj4gYmxrX2NsZWFudXBfcXVldWUgYmVmb3JlIGRlbF9nZW5kaXNrLCBzbyBpdCB3aWxsIGhp
dCB0aGlzIHdhcm5pbmcuIElzDQo+IHRoaXMgbm9ybWFsPw0KDQpIZWxsbyBKb3NlcGgsDQoNClNp
bmNlIHRoZSBkaXNrIG9iamVjdCBoYXMgYSByZWZlcmVuY2UgdG8gdGhlIHF1ZXVlIEkgYWdyZWUg
d2l0aCBNaW5nIHRoYXQgaXQncw0Kd3JvbmcgdG8gY2FsbCBibGtfY2xlYW51cF9xdWV1ZSgpIGJl
Zm9yZSBkZWxfZ2VuZGlzaygpLiBBbnl3YXksIEkgd2lsbCB2ZXJpZnkNCndoZXRoZXIgdGhlcmUg
YXJlIGFueSBibG9jayBkcml2ZXJzIGluIHdoaWNoIHRoZXNlIGNhbGxzIGhhdmUgdG8gYmUgc3dh
cHBlZC4NCg0KQmFydC4=
