Return-Path: <prvs=668afa802=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "kernel-team@fb.com" <kernel-team@fb.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "jbacik@fb.com" <jbacik@fb.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] nbd: don't start req until after the dead connection
 logic
Date: Thu, 17 May 2018 18:21:40 +0000
Message-ID: <18f4a25c14a0803c87bf465c686f0274f558818a.camel@wdc.com>
References: <1508444519-8751-1-git-send-email-josef@toxicpanda.com>
	 <1508444519-8751-2-git-send-email-josef@toxicpanda.com>
In-Reply-To: <1508444519-8751-2-git-send-email-josef@toxicpanda.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE3LTEwLTE5IGF0IDE2OjIxIC0wNDAwLCBKb3NlZiBCYWNpayB3cm90ZToNCj4g
KwlibGtfbXFfc3RhcnRfcmVxdWVzdChyZXEpOw0KPiAgCWlmICh1bmxpa2VseShuc29jay0+cGVu
ZGluZyAmJiBuc29jay0+cGVuZGluZyAhPSByZXEpKSB7DQo+ICAJCWJsa19tcV9yZXF1ZXVlX3Jl
cXVlc3QocmVxLCB0cnVlKTsNCj4gIAkJcmV0ID0gMDsNCg0KKHJlcGx5aW5nIHRvIGFuIGUtbWFp
bCBmcm9tIHNldmVuIG1vbnRocyBhZ28pDQoNCkhlbGxvIEpvc2VmLA0KDQpBcmUgeW91IGF3YXJl
IHRoYXQgdGhlIG5iZCBkcml2ZXIgaXMgb25lIG9mIHRoZSB2ZXJ5IGZldyBibG9jayBkcml2ZXJz
IHRoYXQNCmNhbGxzIGJsa19tcV9yZXF1ZXVlX3JlcXVlc3QoKSBhZnRlciBhIHJlcXVlc3QgaGFz
IGJlZW4gc3RhcnRlZD8gSSB0aGluayB0aGF0DQpjYW4gbGVhZCB0byB0aGUgYmxvY2sgbGF5ZXIg
Y29yZSB0byB1bmRlc2lyZWQgYmVoYXZpb3IsIGUuZy4gdGhhdCB0aGUgdGltZW91dA0KaGFuZGxl
ciBmaXJlcyBjb25jdXJyZW50bHkgd2l0aCBhIHJlcXVlc3QgYmVpbmcgcmVpbnN0ZXJlZC4gQ2Fu
IHlvdSBvciBhDQpjb2xsZWFndWUgaGF2ZSBhIGxvb2sgYXQgdGhpcz8gSSB3b3VsZCBsaWtlIHRv
IGFkZCB0aGUgZm9sbG93aW5nIGNvZGUgdG8gdGhlDQpibG9jayBsYXllciBjb3JlIGFuZCBJIHRo
aW5rIHRoYXQgdGhlIG5iZCBkcml2ZXIgd291bGQgdHJpZ2dlciB0aGlzIHdhcm5pbmc6DQoNCiB2
b2lkIGJsa19tcV9yZXF1ZXVlX3JlcXVlc3Qoc3RydWN0IHJlcXVlc3QgKnJxLCBib29sIGtpY2tf
cmVxdWV1ZV9saXN0KQ0KIHsNCisgICAgICAgV0FSTl9PTl9PTkNFKG9sZF9zdGF0ZSAhPSBNUV9S
UV9DT01QTEVURSk7DQorDQogICAgICAgIF9fYmxrX21xX3JlcXVldWVfcmVxdWVzdChycSk7DQoN
ClRoYW5rcywNCg0KQmFydC4=
