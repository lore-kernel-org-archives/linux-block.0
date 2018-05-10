Return-Path: <prvs=6616f3864=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
	"loberman@redhat.com" <loberman@redhat.com>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "snitzer@redhat.com" <snitzer@redhat.com>,
	"broonie@linaro.org" <broonie@linaro.org>, "axboe@fb.com" <axboe@fb.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
Date: Thu, 10 May 2018 15:16:49 +0000
Message-ID: <75617a7d85070b989245e26de21f708c8762c7b7.camel@wdc.com>
References: <1518202449.2871.32.camel@wdc.com>
	 <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
	 <13a55c03-b138-ca8c-0a0a-95c976b4909e@wdc.com>
	 <bee15d7a-de1f-daee-717d-b9e314ab06a1@kernel.dk>
	 <1FC84680-6482-4FE5-97D0-0F7079C45AA7@linaro.org>
	 <06795609-6ec6-4ae2-f219-3bf7219c11a3@wdc.com>
	 <D89FF8A1-871E-4661-AE9F-6515E6C5EF22@linaro.org>
	 <1518547636.2796.15.camel@wdc.com>
	 <0BF6AC73-69CE-41B5-BDAC-C5249037C83C@linaro.org>
	 <60f48ff1-7c8b-2c10-4560-744d70bccea1@wdc.com>
	 <6C49304C-D506-4719-9365-E7D35BEC9851@linaro.org>
	 <1519868123.2777.28.camel@wdc.com>
	 <10BDC305-A874-477C-9545-5617036C2E91@linaro.org>
	 <2dcb12b92e50a31c55dd3ab0e464cc819432c3d3.camel@wdc.com>
	 <7E372E2C-83A8-4EF4-B52E-E3AC6ED01C74@linaro.org>
	 <a6e512dff10d0cff12a688bbf1b30e275a91633e.camel@wdc.com>
	 <6A355080-C9A8-475D-9A35-32850D771ABB@linaro.org>
	 <1525466533.9055.1.camel@redhat.com>
In-Reply-To: <1525466533.9055.1.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTA1LTA0IGF0IDE2OjQyIC0wNDAwLCBMYXVyZW5jZSBPYmVybWFuIHdyb3Rl
Og0KPiBJIHdhcyBuZXZlciBhYmxlIHRvIHJlcHJvZHVjZSBCYXJ0cyBvcmlnaW5hbCBpc3N1ZSB1
c2luZyBoaXMgdHJlZSBhbmQNCj4gYWN0dWFsIG1seDUvY3g0IGhhcmR3YXJlIGFuZCBpYnNycA0K
PiBJIGVuYWJsZWQgQkZRIHdpdGggbm8gb3RoZXIgc3BlY2lhbCB0dW5pbmcgZm9yIHRoZSBtb2F0
aCBhbmQgc3VicGF0aHMuDQo+IEkgd2FzIHdhaXRpbmcgZm9yIGhpbSB0byBjb21lIGJhY2sgZnJv
bSB2YWNhdGlvbiB0byBjaGVjayB3aXRoIGhpbS4NCg0KKGJhY2sgaW4gdGhlIG9mZmljZSkNCg0K
SGVsbG8gTGF1cmVuY2UsDQoNCldoYXQgSSB1bmRlcnN0b29kIGZyb20gb2ZmLWxpc3QgY29tbXVu
aWNhdGlvbiBpcyB0aGF0IHlvdSB0cmllZCB0byBmaW5kDQphIHdheSB0byByZXByb2R1Y2Ugd2hh
dCBJIHJlcG9ydGVkIHdpdGhvdXQgdXNpbmcgdGhlIHNycC10ZXN0IHNvZnR3YXJlLg0KTXkgdW5k
ZXJzdGFuZGluZyBpcyB0aGF0IGJvdGggUGFvbG8gYW5kIEkgY2FuIHJlcHJvZHVjZSB0aGUgcmVw
b3J0ZWQgaXNzdWUNCndpdGggdGhlIHNycC10ZXN0IHNvZnR3YXJlLg0KDQpCYXJ0Lg0KDQoNCg0K
