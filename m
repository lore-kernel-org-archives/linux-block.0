Return-Path: <prvs=473169c3e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v2] blk-mq: Make blk_mq_get_request() error path less
 confusing
Date: Fri, 3 Nov 2017 18:31:37 +0000
Message-ID: <1509733895.2473.30.camel@wdc.com>
References: <20171016233226.5488-1-bart.vanassche@wdc.com>
In-Reply-To: <20171016233226.5488-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE3LTEwLTE2IGF0IDE2OjMyIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IGJsa19tcV9nZXRfdGFnKCkgY2FuIG1vZGlmeSBkYXRhLT5jdHguIFRoaXMgbWVhbnMgdGhh
dCBpbiB0aGUNCj4gZXJyb3IgcGF0aCBvZiBibGtfbXFfZ2V0X3JlcXVlc3QoKSBkYXRhLT5jdHgg
c2hvdWxkIGJlIHBhc3NlZCB0bw0KPiBibGtfbXFfcHV0X2N0eCgpIGluc3RlYWQgb2YgbG9jYWxf
Y3R4LiBOb3RlOiBzaW5jZSBibGtfbXFfcHV0X2N0eCgpDQo+IGlnbm9yZXMgaXRzIGFyZ3VtZW50
LCB0aGlzIHBhdGNoIGRvZXMgbm90IGNoYW5nZSBhbnkgZnVuY3Rpb25hbGl0eS4NCg0KSGVsbG8g
SmVucywNCg0KV291bGQgaXQgYmUgcG9zc2libGUgdG8gc2hhcmUgeW91ciBvcGluaW9uIGFib3V0
IHRoaXMgcGF0Y2g/DQoNClRoYW5rcywNCg0KQmFydC4=
