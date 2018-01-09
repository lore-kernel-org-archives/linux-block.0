Return-Path: <prvs=540be3476=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 3/4] block: convert REQ_ATOM_COMPLETE to stealing
 rq->__deadline bit
Date: Tue, 9 Jan 2018 18:43:05 +0000
Message-ID: <1515523384.2721.18.camel@wdc.com>
References: <1515522422-21596-1-git-send-email-axboe@kernel.dk>
	 <1515522422-21596-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1515522422-21596-4-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTAxLTA5IGF0IDExOjI3IC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiAg
c3RhdGljIGlubGluZSBpbnQgYmxrX21hcmtfcnFfY29tcGxldGUoc3RydWN0IHJlcXVlc3QgKnJx
KQ0KPiAgew0KPiAtCXJldHVybiB0ZXN0X2FuZF9zZXRfYml0KFJFUV9BVE9NX0NPTVBMRVRFLCAm
cnEtPmF0b21pY19mbGFncyk7DQo+ICsJcmV0dXJuIHRlc3RfYW5kX3NldF9iaXQoMCwgJnJxLT5f
X2RlYWRsaW5lKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGlubGluZSB2b2lkIGJsa19jbGVhcl9y
cV9jb21wbGV0ZShzdHJ1Y3QgcmVxdWVzdCAqcnEpDQo+ICB7DQo+IC0JY2xlYXJfYml0KFJFUV9B
VE9NX0NPTVBMRVRFLCAmcnEtPmF0b21pY19mbGFncyk7DQo+ICsJY2xlYXJfYml0KDAsICZycS0+
X19kZWFkbGluZSk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBibGtfcnFfaXNf
Y29tcGxldGUoc3RydWN0IHJlcXVlc3QgKnJxKQ0KPiArew0KPiArCXJldHVybiB0ZXN0X2JpdCgw
LCAmcnEtPl9fZGVhZGxpbmUpOw0KPiAgfQ0KDQpIZWxsbyBKZW5zLA0KDQpXaXRoIHRoaXMgY2hh
bmdlIHNldHRpbmcgb3IgY2hhbmdpbmcgdGhlIGRlYWRsaW5lIGNsZWFycyB0aGUgQ09NUExFVEUg
ZmxhZy4NCklzIHRoYXQgdGhlIGludGVuZGVkIGJlaGF2aW9yPyBJZiBzbywgc2hvdWxkIHBlcmhh
cHMgYSBjb21tZW50IGJlIGFkZGVkIGFib3ZlDQpibGtfcnFfc2V0X2RlYWRsaW5lKCk/DQoNClRo
YW5rcywNCg0KQmFydC4=
