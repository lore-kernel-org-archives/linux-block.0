Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hare@suse.com" <hare@suse.com>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 4/4] scsi-mq: Reduce suspend latency
Date: Thu, 21 Sep 2017 23:32:33 +0000
Message-ID: <1506036752.2521.32.camel@wdc.com>
References: <20170921212255.12788-1-bart.vanassche@wdc.com>
	 <20170921212255.12788-5-bart.vanassche@wdc.com>
	 <20170921220652.GD6854@ming.t460p> <1506033805.2521.27.camel@wdc.com>
	 <20170921232543.GG6854@ming.t460p>
In-Reply-To: <20170921232543.GG6854@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTA5LTIyIGF0IDA3OjI1ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VGh1LCBTZXAgMjEsIDIwMTcgYXQgMTA6NDM6MjZQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIEZyaSwgMjAxNy0wOS0yMiBhdCAwNjowNiArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBPbiBUaHUsIFNlcCAyMSwgMjAxNyBhdCAwMjoyMjo1NVBNIC0wNzAwLCBCYXJ0
IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gPiA+ICsJfSBlbHNlIHsNCj4gPiA+ID4gIAkJc2NzaV9y
dW5fcXVldWUocSk7DQo+ID4gPiA+ICsJCXdoaWxlIChhdG9taWNfcmVhZCgmc2Rldi0+ZGV2aWNl
X2J1c3kpKSB7DQo+ID4gPiA+ICsJCQltc2xlZXBfaW50ZXJydXB0aWJsZSgyMDApOw0KPiA+ID4g
PiArCQkJc2NzaV9ydW5fcXVldWUocSk7DQo+ID4gPiA+ICsJCX0NCj4gPiA+IA0KPiA+ID4gQXJl
IHlvdSBzdXJlIG9ubHkgYmxrLW1xIG5lZWQgdG8gZHJhaW4gcXVldWU/IFdlIG5lZWQNCj4gPiA+
IHRvIGRvIHRoYXQgZm9yIGJsb2NrIGxlZ2FjeSB0b28uDQo+ID4gDQo+ID4gVGhlIGNvZGUgYWJv
dmUgeW91ciBjb21tZW50IGRyYWlucyB0aGUgcXVldWUgZm9yIHRoZSBsZWdhY3kgYmxvY2sgbGF5
ZXIuDQo+IA0KPiBUaGF0IGlzIGp1c3QgZHJhaW5pbmcgdGhlIHJlcXVlc3RzIGRpc3BhdGNoZWQg
dG8gU0NTSSBsYXllciwgYW5kIHRoZXJlDQo+IG1pZ2h0IGJlIGxvdHMgb2YgcmVxdWVzdHMgaW4g
YmxvY2sgSS9PIHNjaGVkdWxlciBxdWV1ZSBvciByZXF1ZXVlIG9yDQo+IHdoYXRldmVyLg0KDQpU
aGVyZSBpcyBubyByZXF1ZXVlIGxpc3QgZm9yIHRoZSBsZWdhY3kgYmxvY2sgbGF5ZXIuIFRoZXJl
IGlzIG9ubHkgYSByZXF1ZXVlDQpsaXN0IGZvciBibGstbXEuDQoNCldhaXRpbmcgZm9yIEkvTyBy
ZXF1ZXN0cyB0aGF0IGFyZSBpbiBzY2hlZHVsZXIgcXVldWVzIGlzIG5vdCB0aGUgcHVycG9zZSBv
Zg0Kc2NzaV9xdWllc2NlX2RldmljZSgpLiBUaGUgcHVycG9zZSBvZiB0aGF0IGZ1bmN0aW9uIGlz
IHRvIHdhaXQgZm9yIHJlcXVlc3RzDQp0aGF0IGhhdmUgYWxyZWFkeSBiZWVuIHN0YXJ0ZWQuIFRo
ZSBzZGV2LT5kZXZpY2VfYnVzeSBjb3VudGVyIHJlcHJlc2VudHMgdGhlDQpudW1iZXIgb2Ygc3Rh
cnRlZCByZXF1ZXN0cyBzbyB3YWl0aW5nIHVudGlsIHRoYXQgY291bnRlciBoYXMgcmVhY2hlZCB6
ZXJvIGlzDQpzdWZmaWNpZW50Lg0KDQpCYXJ0Lg==
