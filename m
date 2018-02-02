Return-Path: <prvs=564c18bbf=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jiangqi903@gmail.com" <jiangqi903@gmail.com>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "philipp.reisner@linbit.com"
	<philipp.reisner@linbit.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "keescook@chromium.org" <keescook@chromium.org>
Subject: Re: [PATCH v2 2/2] block: Fix a race between the throttling code and
 request queue initialization
Date: Fri, 2 Feb 2018 16:21:59 +0000
Message-ID: <1517588518.2675.14.camel@wdc.com>
References: <20180131235300.12773-1-bart.vanassche@wdc.com>
	 <20180131235300.12773-3-bart.vanassche@wdc.com>
	 <1ff1b2fa-ffe1-20f4-6be9-919c6a5b8227@linux.alibaba.com>
	 <1517501761.2746.21.camel@wdc.com>
	 <26f758cf-430c-aa7f-0d21-75fbad6db260@gmail.com>
In-Reply-To: <26f758cf-430c-aa7f-0d21-75fbad6db260@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTAyLTAyIGF0IDA5OjAyICswODAwLCBKb3NlcGggUWkgd3JvdGU6DQo+IFdl
IHRyaWdnZXJlZCB0aGlzIHJhY2Ugd2hlbiB1c2luZyBzaW5nbGUgcXVldWUuIEknbSBub3Qgc3Vy
ZSBpZiBpdA0KPiBleGlzdHMgaW4gbXVsdGktcXVldWUuDQoNClJlZ2FyZGluZyB0aGUgcmFjZXMg
YmV0d2VlbiBtb2RpZnlpbmcgdGhlIHF1ZXVlX2xvY2sgcG9pbnRlciBhbmQgdGhlIGNvZGUgdGhh
dA0KdXNlcyB0aGF0IHBvaW50ZXIsIEkgdGhpbmsgdGhlIGZvbGxvd2luZyBjb25zdHJ1Y3QgaW4g
YmxrX2NsZWFudXBfcXVldWUoKSBpcw0Kc3VmZmljaWVudCB0byBhdm9pZCByYWNlcyBiZXR3ZWVu
IHRoZSBxdWV1ZV9sb2NrIHBvaW50ZXIgYXNzaWdubWVudCBhbmQgdGhlIGNvZGUNCnRoYXQgZXhl
Y3V0ZXMgY29uY3VycmVudGx5IHdpdGggYmxrX2NsZWFudXBfcXVldWUoKToNCg0KCXNwaW5fbG9j
a19pcnEobG9jayk7DQoJaWYgKHEtPnF1ZXVlX2xvY2sgIT0gJnEtPl9fcXVldWVfbG9jaykNCgkJ
cS0+cXVldWVfbG9jayA9ICZxLT5fX3F1ZXVlX2xvY2s7DQoJc3Bpbl91bmxvY2tfaXJxKGxvY2sp
Ow0KDQpJbiBvdGhlciB3b3JkcywgSSB0aGluayB0aGF0IHRoaXMgcGF0Y2ggc2VyaWVzIHNob3Vs
ZCBiZSBzdWZmaWNpZW50IHRvIGFkZHJlc3MNCmFsbCByYWNlcyBiZXR3ZWVuIC5xdWV1ZV9sb2Nr
IGFzc2lnbm1lbnRzIGFuZCB0aGUgY29kZSB0aGF0IHVzZXMgdGhhdCBwb2ludGVyLg0KDQpUaGFu
a3MsDQoNCkJhcnQu
