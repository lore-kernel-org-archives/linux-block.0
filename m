Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le Moal
	<Damien.LeMoal@wdc.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V5 07/14] scsi: sd_zbc: Initialize device request queue
 zoned data
Date: Mon, 25 Sep 2017 21:17:22 +0000
Message-ID: <1506374241.2641.20.camel@wdc.com>
References: <20170925061454.5533-1-damien.lemoal@wdc.com>
	 <20170925061454.5533-8-damien.lemoal@wdc.com>
In-Reply-To: <20170925061454.5533-8-damien.lemoal@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE3LTA5LTI1IGF0IDE1OjE0ICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gKwlyZXR1cm4ga3phbGxvY19ub2RlKEJJVFNfVE9fTE9OR1Moc2RrcC0+bnJfem9uZXMpDQo+
ICsJCQkgICAgKiBzaXplb2YodW5zaWduZWQgbG9uZyksDQoNCkRvZXMgdGhpcyBwZXJoYXBzIGZp
dCBvbiBvbmUgbGluZT8NCg0KPiArLyoqDQo+ICsgKiBzZF96YmNfZ2V0X3NlcV96b25lcyAtIFBh
cnNlIHJlcG9ydCB6b25lcyByZXBseSB0byBpZGVudGlmeSBzZXF1ZW50aWFsIHpvbmVzDQo+ICsg
KiBAc2RrcDogZGlzayB1c2VkDQo+ICsgKiBAYnVmOiByZXBvcnQgcmVwbHkgYnVmZmVyDQo+ICsg
KiBAc2VxX3pvbmVfYml0YW1wOiBiaXRtYXAgb2Ygc2VxdWVudGlhbCB6b25lcyB0byBzZXQNCj4g
KyAqIEB6bm86IFpvbmUgbnVtYmVyIG9mIHRoZSBmaXJzdCB6b25lIGluIHRoZSByZXBvcnQNCg0K
J3pubycgaXMgYW4gaW5wdXQgYW5kIG91dHB1dCBwYXJhbWV0ZXIgYnV0IHRoZSBhYm92ZSBsaW5l
IG9ubHkgZGVzY3JpYmVzIHdoYXQNCmhhcHBlbnMgd2l0aCB0aGUgdmFsdWUgcGFzc2VkIHRvIHNk
X3piY19nZXRfc2VxX3pvbmVzKCkuIEkgdGhpbmsgd2UgYWxzbyBuZWVkIGENCmRlc2NyaXB0aW9u
IGZvciB0aGUgdmFsdWUgb2YgJ3pubycgdXBvbiByZXR1cm4uDQoNCj4gKyAqIFBhcnNlIHJlcG9y
dGVkIHpvbmUgZGVzY3JpcHRvcnMgdG8gZmluZCBzZXF1aWVudGlhbCB6b25lcy4NCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXg0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlcXVlbnRpYWw/DQoNCk90
aGVyd2lzZSB0aGlzIHBhdGNoIGxvb2tzIGZpbmUgdG8gbWUuDQoNCkJhcnQu
