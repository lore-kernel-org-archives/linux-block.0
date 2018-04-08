Return-Path: <prvs=629e88300=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>, "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [block regression] kernel oops triggered by removing scsi device
 dring IO
Date: Sun, 8 Apr 2018 14:58:27 +0000
Message-ID: <be14a24e675272e316b7e64978cc0ea966cc2043.camel@wdc.com>
References: <20180408042112.GB19128@ming.t460p>
	 <0c744185-2374-1485-81da-068e4ed0d82f@linux.alibaba.com>
In-Reply-To: <0c744185-2374-1485-81da-068e4ed0d82f@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gU3VuLCAyMDE4LTA0LTA4IGF0IDE2OjExICswODAwLCBKb3NlcGggUWkgd3JvdGU6DQo+IFRo
aXMgaXMgYmVjYXVzZSBzY3NpX3JlbW92ZV9kZXZpY2UoKSB3aWxsIGNhbGwgYmxrX2NsZWFudXBf
cXVldWUoKSwgYW5kDQo+IHRoZW4gYWxsIGJsa2dzIGhhdmUgYmVlbiBkZXN0cm95ZWQgYW5kIHJv
b3RfYmxrZyBpcyBOVUxMLg0KPiBUaHVzIHRnIGlzIE5VTEwgYW5kIHRyaWdnZXIgTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlIHdoZW4gZ2V0IHRkIGZyb20NCj4gdGcgKHRnLT50ZCkuDQo+IEl0IHNl
ZW1zIHRoYXQgd2UgY2Fubm90IHNpbXBseSBtb3ZlIGJsa2NnX2V4aXRfcXVldWUoKSB1cCB0bw0K
PiBibGtfY2xlYW51cF9xdWV1ZSgpLg0KDQpIYWQgeW91IGNvbnNpZGVyZWQgdG8gYWRkIGEgYmxr
X3F1ZXVlX2VudGVyKCkgLyBibGtfcXVldWVfZXhpdCgpIHBhaXIgaW4NCmdlbmVyaWNfbWFrZV9y
ZXF1ZXN0KCk/IGJsa19xdWV1ZV9lbnRlcigpIG5hbWVseSBjaGVja3MgdGhlIERZSU5HIGZsYWcu
DQoNClRoYW5rcywNCg0KQmFydC4NCg0KDQo=
