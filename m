Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mingo@kernel.org" <mingo@kernel.org>, "longman@redhat.com"
	<longman@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v5] blktrace: Fix potentail deadlock between delete &
 sysfs ops
Date: Mon, 18 Sep 2017 16:36:23 +0000
Message-ID: <1505752582.2685.11.camel@wdc.com>
References: <1505615828-6623-1-git-send-email-longman@redhat.com>
In-Reply-To: <1505615828-6623-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gU2F0LCAyMDE3LTA5LTE2IGF0IDE5OjM3IC0wNzAwLCBXYWltYW4gTG9uZyB3cm90ZToNCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaA0KPiBp
bmRleCAzMzllNzM3Li4zMzBiNTcyIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ZzLmgN
Cj4gKysrIGIvaW5jbHVkZS9saW51eC9mcy5oDQo+IEBAIC00NDgsNyArNDQ4LDcgQEAgc3RydWN0
IGJsb2NrX2RldmljZSB7DQo+ICANCj4gIAkvKiBUaGUgY291bnRlciBvZiBmcmVlemUgcHJvY2Vz
c2VzICovDQo+ICAJaW50CQkJYmRfZnNmcmVlemVfY291bnQ7DQo+IC0JLyogTXV0ZXggZm9yIGZy
ZWV6ZSAqLw0KPiArCS8qIE11dGV4IGZvciBmcmVlemUgYW5kIGJsa3RyYWNlICovDQo+ICAJc3Ry
dWN0IG11dGV4CQliZF9mc2ZyZWV6ZV9tdXRleDsNCj4gIH0gX19yYW5kb21pemVfbGF5b3V0Ow0K
DQpUaGlzIHBhdGNoIGNoYW5nZXMgdGhlIG1lYW5pbmcgb2YgYmRfZnNmcmVlemVfbXV0ZXggc2ln
bmlmaWNhbnRseS4gUGxlYXNlIHJlbmFtZQ0KdGhhdCBtdXRleCBzdWNoIHRoYXQgaXRzIG5hbWUg
bWF0Y2hlcyBpdHMgbmV3IHJvbGUuDQoNClRoYW5rcywNCg0KQmFydC4=
