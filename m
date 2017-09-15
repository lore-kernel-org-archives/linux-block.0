Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le Moal
	<Damien.LeMoal@wdc.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V3 10/12] scsi: sd_zbc: Limit zone write locking to
 sequential zones
Date: Fri, 15 Sep 2017 16:23:49 +0000
Message-ID: <1505492627.3420.5.camel@wdc.com>
References: <20170915100645.17999-1-damien.lemoal@wdc.com>
	 <20170915100645.17999-11-damien.lemoal@wdc.com>
In-Reply-To: <20170915100645.17999-11-damien.lemoal@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTA5LTE1IGF0IDE5OjA2ICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gKwkgKiBUaGVyZSBpcyBubyB3cml0ZSBjb25zdHJhaW50cyBvbiBjb252ZW50aW9uYWwgem9u
ZXMuIFNvIGFueSB3cml0ZQ0KICAgICAgICAgICBeXl5eXl5eXl5eXg0KU2hvdWxkIHRoaXMgaGF2
ZSBiZWVuICJUaGVyZSBhcmUgbm8iPw0KDQo+IC0JaWYgKHNka3AtPnpvbmVzX3dsb2NrICYmDQo+
IC0JICAgIHRlc3RfYW5kX3NldF9iaXQoem5vLCBzZGtwLT56b25lc193bG9jaykpDQo+ICsJaWYg
KHEtPnpvbmVkLnNlcV96b25lcyAmJiB0ZXN0X2JpdCh6bm8sIHEtPnpvbmVkLnNlcV96b25lcykp
DQo+ICsJCXJldHVybiBCTEtQUkVQX09LOw0KPiArCWlmIChzZGtwLT56b25lc193bG9jayAmJiB0
ZXN0X2FuZF9zZXRfYml0KHpubywgc2RrcC0+em9uZXNfd2xvY2spKQ0KPiAgCQlyZXR1cm4gQkxL
UFJFUF9ERUZFUjsNCg0KUGxlYXNlIGludHJvZHVjZSBoZWxwZXIgZnVuY3Rpb25zIGluIGluY2x1
ZGUvbGludXgvYmxrZGV2Lmggb3IgaW4gYSBuZXcNCmhlYWRlciBmaWxlIGZvciB2ZXJpZnlpbmcg
d2hldGhlciBvciBub3QgYSB6b25lIGlzIGEgc2VxdWVudGlhbCB6b25lIGFuZCBhbHNvDQpmb3Ig
bG9ja2luZyBhIHpvbmUgZm9yIHdyaXRlcy4gSSBleHBlY3QgdGhhdCB0aGF0IHdpbGwgbWFrZSB0
aGUgYWJvdmUgY29kZQ0Kc2lnbmlmaWNhbnRseSBlYXNpZXIgdG8gcmVhZC4NCg0KVGhhbmtzLA0K
DQpCYXJ0Lg==
