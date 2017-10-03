Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 2/2] block: fix peeking requests during PM
Date: Tue, 3 Oct 2017 15:13:43 +0000
Message-ID: <1507043621.2702.4.camel@wdc.com>
References: <20171003084701.19346-1-hch@lst.de>
	 <20171003084701.19346-3-hch@lst.de>
In-Reply-To: <20171003084701.19346-3-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE3LTEwLTAzIGF0IDEwOjQ3ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gLXN0YXRpYyBzdHJ1Y3QgcmVxdWVzdCAqYmxrX3BtX3BlZWtfcmVxdWVzdChzdHJ1Y3Qg
cmVxdWVzdF9xdWV1ZSAqcSwNCj4gLQkJCQkJICAgc3RydWN0IHJlcXVlc3QgKnJxKQ0KPiArc3Rh
dGljIGJvb2wgYmxrX3BtX2FsbG93X3JlcXVlc3Qoc3RydWN0IHJlcXVlc3QgKnJxKQ0KPiAgew0K
PiAtCWlmIChxLT5kZXYgJiYgKHEtPnJwbV9zdGF0dXMgPT0gUlBNX1NVU1BFTkRFRCB8fA0KPiAt
CSAgICAocS0+cnBtX3N0YXR1cyAhPSBSUE1fQUNUSVZFICYmICEocnEtPnJxX2ZsYWdzICYgUlFG
X1BNKSkpKQ0KPiAtCQlyZXR1cm4gTlVMTDsNCj4gLQllbHNlDQo+IC0JCXJldHVybiBycTsNCj4g
KwlpZiAoIXJxLT5xLT5kZXYpDQo+ICsJCXJldHVybiB0cnVlOw0KPiArDQo+ICsJc3dpdGNoIChy
cS0+cS0+cnBtX3N0YXR1cykgew0KPiArCWNhc2UgUlBNX1NVU1BFTkRFRDoNCj4gKwkJcmV0dXJu
IGZhbHNlOw0KPiArCWNhc2UgUlBNX0FDVElWRToNCj4gKwkJcmV0dXJuIHJxLT5ycV9mbGFncyAm
IFJRRl9QTTsNCj4gKwlkZWZhdWx0Og0KPiArCQlyZXR1cm4gdHJ1ZTsNCj4gKwl9DQo+ICB9DQoN
CkhlbGxvIENocmlzdG9waCwNCg0KVGhlIG9sZCBjb2RlIGRvZXMgbm90IHByb2Nlc3Mgbm9uLVBN
IHJlcXVlc3RzIGluIHRoZSBSUE1fU1VTUEVORElORyBtb2RlIG5vcg0KaW4gdGhlIFJQTV9SRVNV
TUlORyBjb2RlLiBJIHRoaW5rIHRoZSBuZXcgY29kZSBwcm9jZXNzZXMgYWxsIHJlcXVlc3RzIGlu
DQp0aGVzZSB0d28gbW9kZXMuIFdhcyB0aGF0IGJlaGF2aW9yIGNoYW5nZSBpbnRlbmRlZD8NCg0K
VGhhbmtzLA0KDQpCYXJ0Lg==
