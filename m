Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@intel.com" <keith.busch@intel.com>, "tom.leiming@gmail.com"
	<tom.leiming@gmail.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH] blk-mq: Fix lost request during timeout
Date: Tue, 19 Sep 2017 15:18:45 +0000
Message-ID: <1505834324.2671.13.camel@wdc.com>
References: <1505772186-4601-1-git-send-email-keith.busch@intel.com>
	 <1505772477.12701.6.camel@wdc.com>
	 <20170918223900.GA4671@localhost.localdomain>
	 <1505775191.12701.20.camel@wdc.com>
	 <20170918230803.GB4671@localhost.localdomain>
	 <CACVXFVO4joG1zzipABWK4bc5Rwo9bDa4by4_mFOTx10nQPAUpQ@mail.gmail.com>
	 <20170919150721.GA6180@localhost.localdomain>
In-Reply-To: <20170919150721.GA6180@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE3LTA5LTE5IGF0IDExOjA3IC0wNDAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
VGhlIHByb2JsZW0gaXMgd2hlbiBibGstbXEncyB0aW1lb3V0IGhhbmRsZXIgcHJldmVudHMgdGhl
IHJlcXVlc3QgZnJvbQ0KPiBjb21wbGV0aW5nLCBhbmQgZG9lc24ndCBsZWF2ZSBhbnkgaW5kaWNh
dGlvbiB0aGUgZHJpdmVyIHJlcXVlc3RlZCB0bw0KPiBjb21wbGV0ZSBpdC4gV2hvIGlzIHJlc3Bv
bnNpYmxlIGZvciBjb21wbGV0aW5nIHRoYXQgcmVxdWVzdCBub3c/DQoNCkhlbGxvIEtlaXRoLA0K
DQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgYmxvY2sgZHJpdmVycyBhcmUgcmVzcG9uc2libGUg
Zm9yIGNvbXBsZXRpbmcgdGltZWQNCm91dCByZXF1ZXN0cyBieSB1c2luZyBvbmUgb2YgdGhlIGZv
bGxvd2luZyBhcHByb2FjaGVzOg0KKiBCeSByZXR1cm5pbmcgQkxLX0VIX0hBTkRMRUQgb3IgQkxL
X0VIX1JFU0VUX1RJTUVSIGZyb20gaW5zaWRlIHRoZSB0aW1lb3V0DQogIGhhbmRsZXIuDQoqIEJ5
IHJldHVybmluZyBCTEtfRUhfTk9UX0hBTkRMRUQgYW5kIGJ5IGNhbGxpbmcgYmxrX21xX2VuZF9y
ZXF1ZXN0KCkgb3INCiAgX19ibGtfbXFfZW5kX3JlcXVlc3QoKSBmb3IgdGhlIHJlcXVlc3QgdGhh
dCB0aW1lZCBvdXQuDQoNCkJhcnQuIA==
