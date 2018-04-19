Return-Path: <prvs=6401ab460=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "maier@linux.ibm.com" <maier@linux.ibm.com>, "osandov@osandov.com"
	<osandov@osandov.com>
CC: "lizefan@huawei.com" <lizefan@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "mingo@redhat.com" <mingo@redhat.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"lizf@cn.fujitsu.com" <lizf@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] tracing/events: block: dev_t via driver core for plug
 and unplug events
Date: Thu, 19 Apr 2018 20:56:47 +0000
Message-ID: <8624e2bec853f0bb195966ab54bc42bf15eda0ec.camel@wdc.com>
References: <20180413130719.22921-1-maier@linux.ibm.com>
	 <20180413130719.22921-3-maier@linux.ibm.com>
	 <20180415083154.GA12254@kroah.com>
	 <59186bf6-abf1-87b0-914d-eed1b40ef4a8@linux.ibm.com>
	 <20180419192341.GC20941@vader>
In-Reply-To: <20180419192341.GC20941@vader>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTA0LTE5IGF0IDEyOjI0IC0wNzAwLCBPbWFyIFNhbmRvdmFsIHdyb3RlOg0K
PiBXZSBxdWllc2NlIGFuZCBmcmVlemUgdGhlIHF1ZXVlIGJlZm9yZSB0ZWFyaW5nIGl0IGRvd24s
IHNvIGl0IHdvbid0IGJlDQo+IE5VTEwgd2hpbGUgd2UncmUgc3RpbGwgZG9pbmcgSS9PLiBDYydp
bmcgQmFydCBpbiBjYXNlIEknbSBseWluZyB0byB5b3UsDQo+IHRob3VnaCA7KQ0KDQpibGtfY2xl
YW51cF9xdWV1ZSgpIHdhaXRzIHVudGlsIGFsbCBJL08gcmVxdWVzdHMgaGF2ZSBmaW5pc2hlZC4g
U2luY2UgdGhlDQpibG9jayBsYXllciB0cmFjaW5nIGNvZGUgaXMgdHJpZ2dlcmVkIGZyb20gaW5z
aWRlIHRoZSBjb2RlIHRoYXQgcHJvY2Vzc2VzIGENCnJlcXVlc3QgaXQgaXMgc2FmZSB0byBhY2Nl
c3MgdGhlIHJlcXVlc3QgcG9pbnRlciBmcm9tIGluc2lkZSB0aGUgdHJhY2luZyBjb2RlLg0KQnV0
IEkgdGhpbmsgdGhlIHF1ZXN0aW9uIHdhcyBhYm91dCB0aGUgcGFyZW50IG9mIHRoZSByZXF1ZXN0
IHF1ZXVlIGtvYmoNCmluc3RlYWQgb2YgYWJvdXQgdGhlIHJlcXVlc3QgcXVldWUgcG9pbnRlciwg
dGhlIGRldmljZSBzdHJ1Y3R1cmUgdGhhdCBpcw0KZW1iZWRkZWQgaW4gc3RydWN0IGdlbmRpc2s/
IEkgdGhpbmsgdGhhdCBwYXJlbnQgY2FuIGRpc2FwcGVhciBhdCBhbnkgdGltZS4NCk1vc3QgYmxv
Y2sgZHJpdmVycyBjYWxsIGRlbF9nZW5kaXNrKCkgYmVmb3JlIHRoZXkgY2FsbCBibGtfY2xlYW51
cF9xdWV1ZSgpLg0KVW5sZXNzIEknbSBvdmVybG9va2luZyBzb21ldGhpbmcgSSB0aGluayB0aGUg
cmVxdWVzdCBxdWV1ZSB3aWxsIG5lZWQgdG8NCm9idGFpbiBhIHJlZmVyZW5jZSB0byB0aGUgZ2Vu
ZGlzayBkZXZpY2UgZnJvbSBpbnNpZGUgYmxrX3JlZ2lzdGVyX3F1ZXVlKCkNCmFuZCBkcm9wIHRo
YXQgcmVmZXJlbmNlIGZyb20gaW5zaWRlIGJsa19jbGVhbnVwX3F1ZXVlKCkgdG8gbWFrZSBpdCBz
YWZlIGZvcg0KdGhlIHRyYWNpbmcgY29kZSB0byBhY2Nlc3Mgc3RydWN0IGdlbmRpc2suDQoNCkJh
cnQuDQoNCg0KDQo=
