Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [PATCH v5] blk-mq: Avoid that a completion can be ignored for
 BLK_EH_RESET_TIMER
Date: Wed, 11 Apr 2018 14:34:26 +0000
Message-ID: <67bd29b94662391ead77526ee45722b9f5712a98.camel@wdc.com>
References: <20180410210157.30477-1-bart.vanassche@wdc.com>
	 <255b84ff-3fe5-1269-70a8-3ab5cc89c1ef@grimberg.me>
	 <6684d4b3049397cbbabbee3008f96d80b48c0a17.camel@wdc.com>
	 <34fcf710-5e0a-9830-bc60-71c4086a0df5@grimberg.me>
In-Reply-To: <34fcf710-5e0a-9830-bc60-71c4086a0df5@grimberg.me>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDE3OjMyICswMzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0K
PiA+ID4gPiAgICBzdGF0aWMgdm9pZCBfX2Jsa19tcV9yZXF1ZXVlX3JlcXVlc3Qoc3RydWN0IHJl
cXVlc3QgKnJxKQ0KPiA+ID4gPiAgICB7DQo+ID4gPiA+ICAgIAlzdHJ1Y3QgcmVxdWVzdF9xdWV1
ZSAqcSA9IHJxLT5xOw0KPiA+ID4gPiArCWVudW0gbXFfcnFfc3RhdGUgb2xkX3N0YXRlID0gYmxr
X21xX3JxX3N0YXRlKHJxKTsNCj4gPiA+ID4gICAgDQo+ID4gPiA+ICAgIAlibGtfbXFfcHV0X2Ry
aXZlcl90YWcocnEpOw0KPiA+ID4gPiAgICANCj4gPiA+ID4gICAgCXRyYWNlX2Jsb2NrX3JxX3Jl
cXVldWUocSwgcnEpOw0KPiA+ID4gPiAgICAJd2J0X3JlcXVldWUocS0+cnFfd2IsICZycS0+aXNz
dWVfc3RhdCk7DQo+ID4gPiA+ICAgIA0KPiA+ID4gPiAtCWlmIChibGtfbXFfcnFfc3RhdGUocnEp
ICE9IE1RX1JRX0lETEUpIHsNCj4gPiA+ID4gLQkJYmxrX21xX3JxX3VwZGF0ZV9zdGF0ZShycSwg
TVFfUlFfSURMRSk7DQo+ID4gPiA+ICsJaWYgKG9sZF9zdGF0ZSAhPSBNUV9SUV9JRExFKSB7DQo+
ID4gPiA+ICsJCWlmICghYmxrX21xX2NoYW5nZV9ycV9zdGF0ZShycSwgb2xkX3N0YXRlLCBNUV9S
UV9JRExFKSkNCj4gPiA+ID4gKwkJCVdBUk5fT05fT05DRSh0cnVlKTsNCj4gPiA+ID4gICAgCQlp
ZiAocS0+ZG1hX2RyYWluX3NpemUgJiYgYmxrX3JxX2J5dGVzKHJxKSkNCj4gPiA+ID4gICAgCQkJ
cnEtPm5yX3BoeXNfc2VnbWVudHMtLTsNCj4gPiA+ID4gICAgCX0NCj4gPiA+IA0KPiA+ID4gQ2Fu
IHlvdSBleHBsYWluIHdoeSB3YXMgb2xkX3N0YXRlIGtlcHQgYXMgYSBsb2NhbCB2YXJpYWJsZT8N
Cj4gPiANCj4gPiBIZWxsbyBTYWdpLA0KPiA+IA0KPiA+IFNpbmNlIGJsa19tcV9yZXF1ZXVlX3Jl
cXVlc3QoKSBtdXN0IGJlIGNhbGxlZCBhZnRlciBhIHJlcXVlc3QgaGFzIGNvbXBsZXRlZA0KPiA+
IHRoZSB0aW1lb3V0IGhhbmRsZXIgd2lsbCBpZ25vcmUgcmVxdWVzdHMgdGhhdCBhcmUgYmVpbmcg
cmVxdWV1ZWQuIEhlbmNlIGl0DQo+ID4gaXMgc2FmZSBpbiB0aGlzIGZ1bmN0aW9uIHRvIGNhY2hl
IHRoZSByZXF1ZXN0IHN0YXRlIGluIGEgbG9jYWwgdmFyaWFibGUuDQo+IA0KPiBJIHVuZGVyc3Rh
bmQgd2h5IGl0IGlzIHNhZmUsIEkganVzdCBkaWRuJ3QgdW5kZXJzdGFuZCB3aHkgaXQgaXMgbmVl
ZGVkLg0KDQpUaGUgb25seSByZWFzb24gaXMgdGhhdCBpdCBrZWVwcyB0aGUgbGluZSB3aXRoIHRo
ZSBibGtfbXFfY2hhbmdlX3JxX3N0YXRlKCkgY2FsbA0KYmVsb3cgdGhlIDgwIGNoYXJhY3RlciBs
aW1pdCA6LSkNCg0KQmFydC4NCg0KDQoNCg==
