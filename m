Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mingo@kernel.org" <mingo@kernel.org>, "longman@redhat.com"
	<longman@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3] blktrace: Fix potentail deadlock between delete &
 sysfs ops
Date: Fri, 18 Aug 2017 18:07:06 +0000
Message-ID: <1503079624.2622.10.camel@wdc.com>
References: <1503078848-15779-1-git-send-email-longman@redhat.com>
In-Reply-To: <1503078848-15779-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTA4LTE4IGF0IDEzOjU0IC0wNDAwLCBXYWltYW4gTG9uZyB3cm90ZToNCj4g
SW5zdGVhZCwgYSBnbG9iYWwgYmxrdHJhY2UNCj4gbXV0ZXggd2lsbCBiZSB1c2VkIHRvIHNlcmlh
bGl6ZSB0aGUgcmVhZC93cml0ZSBvZiB0aGUgYmxrdHJhY2Ugc3lzZnMNCj4gYXR0cmlidXRlcy4N
Cg0KSGVsbG8gV2FpbWFuLA0KDQpVc2luZyBhIG11dGV4IHRvIHNlcmlhbGl6ZSBjb2RlIGlzIHdy
b25nLiBXaGF0IGlzIG5lZWRlZCBpcyBleGFjdA0KZG9jdW1lbnRhdGlvbiBvZiB3aGF0IGRhdGEg
c3RydWN0dXJlcyBhbmQvb3IgbWVtYmVyIHZhcmlhYmxlcyBhcmUNCnByb3RlY3RlZCBieSBiZGV2
LT5iZF9tdXRleCBhbmQgYnkgYmxrdHJhY2VfbXV0ZXguDQoNCkFsc28sIHBsZWFzZSBzcGVsbCAi
cG90ZW50aWFsIiBjb3JyZWN0bHkgaW4gdGhlIHN1YmplY3Qgb2YgdGhpcyBwYXRjaC4NCg0KVGhh
bmtzLA0KDQpCYXJ0Lg==
