Return-Path: <Avri.Altman@sandisk.com>
From: Avri Altman <Avri.Altman@sandisk.com>
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
CC: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente
	<paolo.valente@linaro.org>
Subject: RE: Outstanding MQ questions from MMC
Date: Fri, 14 Apr 2017 18:41:32 +0000
Message-ID: <BY2PR0401MB0901B37DB60608662AE5C631E5050@BY2PR0401MB0901.namprd04.prod.outlook.com>
References: <CACRpkdbZrkAqEdP1-QqDww0ZuFcY47Jgj9dPqkG_whrx7pwC-w@mail.gmail.com>
 <CAK8P3a1CGtj5VSVoMM34VWn781WpS8ZcHpq6n0UfNOWWYEq=QQ@mail.gmail.com>
 <CAPDyKFqiyEcScuWLVXE9kAa2yQyJCZfbXyAdAQOb081nLjyvvw@mail.gmail.com>
 <CAK8P3a1yJJ33R9EPPcErLUO2enFGrSJzWmVRwHdHP+3_2iP7ow@mail.gmail.com>
 <CACRpkdYsWnXLZEpZr74pLB8zjTV4Q=sdAfX+sz0n_E46SaJa9Q@mail.gmail.com>
In-Reply-To: <CACRpkdYsWnXLZEpZr74pLB8zjTV4Q=sdAfX+sz0n_E46SaJa9Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

DQoNCj4gDQo+IDIuIFR1cm4gUlBNQiBhbmQgb3RoZXIgaW9jdGwoKSBNTUMgb3BlcmF0aW9ucyBp
bnRvIG1tY19xdWV1ZV9yZXENCj4gICAgdGhpbmdzIGFuZCBmdW5uZWwgdGhlbSBpbnRvIHRoZSBi
bG9jayBzY2hlZHVsZXINCj4gICAgdXNpbmcgUkVRX09QX0RSVl9JTi9PVVQgcmVxdWVzdHMuDQo+
IA0KDQpBY2Nlc3NpbmcgdGhlIFJQTUIgaXMgZG9uZSB2aWEgYSBzdHJhbmdlIHByb3RvY29sLCBp
biB3aGljaCBlYWNoIGFjY2VzcyBpcyBjb21wcmlzZWQgb2Ygc2V2ZXJhbCByZXF1ZXN0cy4NCkZv
ciBleGFtcGxlLCB3cml0aW5nIHRvIHRoZSBSUE1CIHdpbGwgcmVxdWlyZSBzZW5kaW5nIDUgZGlm
ZmVyZW50IHJlcXVlc3RzOiANCjIgcmVxdWVzdHMgdG8gcmVhZCB0aGUgd3JpdGUgY291bnRlciwg
YW5kIHRoZW4gMyBtb3JlIHJlcXVlc3RzIGZvciB0aGUgd3JpdGUgb3BlcmF0aW9uIGl0c2VsZi4N
Cg0KT25jZSB0aGUgc2VxdWVuY2UgaGFzIHN0YXJ0ZWQsIGl0IHNob3VsZCBub3QgZ2V0IGludGVy
ZmVyZWQgYnkgb3RoZXIgcmVxdWVzdHMsIG9yIHRoZSBvcGVyYXRpb24gd2lsbCBmYWlsLg0KDQpT
bywgaWYgeW91IGFyZSBsb29raW5nIHRvIGVsaW1pbmF0ZSB0aGUgaG9zdCBsb2NrLCBhbmQgY291
bnQgbWVyZWx5IG9uIHRoZSBibGsgcXVldWUgdG8gcmVndWxhdGUgIGFjY2VzcyB0byB0aGUgZGV2
aWNlLA0KWW91J2xsIGJlIG5lZWRpbmcgc29tZSBiYXJyaWVyIG1lY2hhbmlzbSB0aGF0IHdpbGwg
YXNzdXJlIHRoYXQgYSBzZXF1ZW5jZSBvZiByZXF1ZXN0cyB3aWxsIHRha2UgcGxhY2UgYXMgYW4g
YXRvbWljIHVuaXQuDQoNCkJ1dCB0aGVuIGFnYWluLCBpc24ndCBpdCBjb250cmFkaWN0cyB0aGUg
dmVyeSBpZGVhIG9mIGEgbXVsdGktcXVldWU/DQoNCkNoZWVycywNCkF2cmkNCg==
