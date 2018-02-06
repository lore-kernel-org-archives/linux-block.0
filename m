Return-Path: <prvs=5689bd51d=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "danil.kipnis@profitbricks.com" <danil.kipnis@profitbricks.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "roman.penyaev@profitbricks.com"
	<roman.penyaev@profitbricks.com>, "jinpu.wang@profitbricks.com"
	<jinpu.wang@profitbricks.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"ogerlitz@mellanox.com" <ogerlitz@mellanox.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [PATCH 00/24] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Date: Tue, 6 Feb 2018 15:35:44 +0000
Message-ID: <1517931342.3934.16.camel@wdc.com>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
	 <1517591106.2675.28.camel@sandisk.com>
	 <CAMGffEkhqR9Z5bkMfnVn8an2OUM8k+jYoR5EFdtv3k9en1bh=w@mail.gmail.com>
	 <40a7fc35-f86c-1d9d-f057-e5822708fc32@grimberg.me>
	 <CAHg0HuxawAjCf711gkKKiQbbLskNsvUDhP+m32oiGFsY2BRz5g@mail.gmail.com>
	 <41347a8d-8a3b-c35f-801c-b4b21c37f285@grimberg.me>
	 <CAHg0HuxtvRvPcX8yZxcwSSP5XK6ZnLbxBkpx+X7QyDZtny3XZA@mail.gmail.com>
	 <9abc87a6-cb47-d3bf-65c6-6f386401bdb9@wdc.com>
	 <CAHg0Huxejb065yVRLquNUKDZHB=NhuCBOnkgE-Q4FW3_Y-A_rQ@mail.gmail.com>
In-Reply-To: <CAHg0Huxejb065yVRLquNUKDZHB=NhuCBOnkgE-Q4FW3_Y-A_rQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTAyLTA2IGF0IDEwOjQ0ICswMTAwLCBEYW5pbCBLaXBuaXMgd3JvdGU6DQo+
IHRoZSBjb25maWd1cmF0aW9uICh3aGljaCBkZXZpY2VzIGNhbiBiZSBhY2Nlc3NlZCBieSBhIHBh
cnRpY3VsYXINCj4gY2xpZW50KSBjYW4gaGFwcGVuIGFsc28gYWZ0ZXIgdGhlIGtlcm5lbCB0YXJn
ZXQgbW9kdWxlIGlzIGxvYWRlZC4gVGhlDQo+IGRpcmVjdG9yeSBpbiA8ZGV2X3NlYXJjaF9wYXRo
PiBpcyBhIG1vZHVsZSBwYXJhbWV0ZXIgYW5kIGlzIGZpeGVkLiBJdA0KPiBjb250YWlucyBmb3Ig
ZXhhbXBsZSAiL2libmJkX2RldmljZXMvIi4gQnV0IGEgcGFydGljdWxhciBjbGllbnQgWA0KPiB3
b3VsZCBiZSBhYmxlIHRvIG9ubHkgYWNjZXNzIHRoZSBkZXZpY2VzIGxvY2F0ZWQgaW4gdGhlIHN1
YmRpcmVjdG9yeQ0KPiAiL2libmJkX2RldmljZXMvY2xpZW50X3gvIi4gKFRoZSBzZXNzaW9ubmFt
ZSBoZXJlIGlzIGNsaWVudF94KSBPbmUgY2FuDQo+IGFkZCBvciByZW1vdmUgdGhlIGRldmljZXMg
ZnJvbSB0aGF0IGRpcmVjdG9yeSAodGhvc2UgYXJlIGp1c3Qgc3ltbGlua3MNCj4gdG8gL2Rldi94
eHgpIGF0IGFueSB0aW1lIC0gYmVmb3JlIG9yIGFmdGVyIHRoZSBzZXJ2ZXIgbW9kdWxlIGlzDQo+
IGxvYWRlZC4gQnV0IHlvdSBhcmUgcmlnaHQsIHdlIG5lZWQgc29tZXRoaW5nIGFkZGl0aW9uYWwg
aW4gb3JkZXIgdG8gYmUNCj4gYWJsZSB0byBzcGVjaWZ5IHdoaWNoIGRldmljZXMgYSBjbGllbnQg
Y2FuIGFjY2VzcyB3cml0YWJsZSBhbmQgd2hpY2gNCj4gcmVhZG9ubHkuIE1heSBiZSBhbm90aGVy
IHN1YmRpcmVjdG9yaWVzICJ3ciIgYW5kICJybyIgZm9yIGVhY2ggY2xpZW50Og0KPiB0aG9zZSB1
bmRlciAvaWJuYmRfZGV2aWNlcy9jbGllbnRfeC9yby8gY2FuIG9ubHkgYmUgcmVhZCBieSBjbGll
bnRfeA0KPiBhbmQgdGhvc2UgaW4gL2libmJkX2RldmljZXMvY2xpZW50X3gvd3IvIGNhbiBhbHNv
IGJlIHdyaXR0ZW4gdG8/DQoNClBsZWFzZSB1c2UgYSBzdGFuZGFyZCBrZXJuZWwgZmlsZXN5c3Rl
bSAoc3lzZnMgb3IgY29uZmlnZnMpIGluc3RlYWQgb2YNCnJlaW52ZW50aW5nIGl0Lg0KDQpUaGFu
a3MsDQoNCkJhcnQu
