Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH] blk-mq-debugfs: Add names for recently added flags
Date: Fri, 18 Aug 2017 16:52:51 +0000
Message-ID: <1503075169.2622.7.camel@wdc.com>
References: <20170818154711.11906-1-bart.vanassche@wdc.com>
In-Reply-To: <20170818154711.11906-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTA4LTE4IGF0IDA4OjQ3IC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstbXEtZGVidWdmcy5jIGIvYmxvY2svYmxrLW1xLWRl
YnVnZnMuYw0KPiBpbmRleCBlNTNiNjEyOWNhNWEuLjlmYWMyOTE1ZDg5NyAxMDA2NDQNCj4gLS0t
IGEvYmxvY2svYmxrLW1xLWRlYnVnZnMuYw0KPiArKysgYi9ibG9jay9ibGstbXEtZGVidWdmcy5j
DQo+IEBAIC03Myw2ICs3Myw4IEBAIHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBibGtfcXVldWVf
ZmxhZ19uYW1lW10gPSB7DQo+ICAJUVVFVUVfRkxBR19OQU1FKFNUQVRTKSwNCj4gIAlRVUVVRV9G
TEFHX05BTUUoUE9MTF9TVEFUUyksDQo+ICAJUVVFVUVfRkxBR19OQU1FKFJFR0lTVEVSRUQpLA0K
PiArCVFVRVVFX0ZMQUdfTkFNRShQQVNTVEhST1VHSCksDQo+ICsJUVVFVUVfRkxBR19OQU1FKFFV
SUVTQ0VEKSwNCj4gIH07DQo+ICAjdW5kZWYgUVVFVUVfRkxBR19OQU1FDQo+ICANCj4gQEAgLTI2
Myw2ICsyNjUsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqY29uc3QgY21kX2ZsYWdfbmFtZVtdID0g
ew0KPiAgCUNNRF9GTEFHX05BTUUoUkFIRUFEKSwNCj4gIAlDTURfRkxBR19OQU1FKEJBQ0tHUk9V
TkQpLA0KPiAgCUNNRF9GTEFHX05BTUUoTk9VTk1BUCksDQo+ICsJQ01EX0ZMQUdfTkFNRShOT1dB
SVQpLA0KPiAgfTsNCj4gICN1bmRlZiBDTURfRkxBR19OQU1FDQoNClBsZWFzZSBpZ25vcmUgdGhp
cyBwYXRjaCAtIGl0IGRvZXNuJ3QgYnVpbGQuIEkgd2lsbCBzZW5kIGEgdjIuDQoNCkJhcnQu
