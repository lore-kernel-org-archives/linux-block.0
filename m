Return-Path: <prvs=469d6a95f=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"hare@suse.com" <hare@suse.com>, "keith.busch@intel.com"
	<keith.busch@intel.com>
Subject: Re: [PATCH] block: Fix a race between blk_cleanup_queue() and timeout
 handling
Date: Mon, 30 Oct 2017 17:44:26 +0000
Message-ID: <1509385465.3660.37.camel@wdc.com>
References: <20171019170048.16044-1-bart.vanassche@wdc.com>
In-Reply-To: <20171019170048.16044-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE3LTEwLTE5IGF0IDEwOjAwIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IE1ha2Ugc3VyZSB0aGF0IGlmIHRoZSB0aW1lb3V0IHRpbWVyIGZpcmVzIGFmdGVyIGEgcXVl
dWUgaGFzIGJlZW4NCj4gbWFya2VkICJkeWluZyIgdGhhdCB0aGUgYWZmZWN0ZWQgcmVxdWVzdHMg
YXJlIGZpbmlzaGVkLg0KPiANCj4gUmVwb3J0ZWQtYnk6IGNoZW54aWFuZyAoTSkgPGNoZW54aWFu
ZzY2QGhpc2lsaWNvbi5jb20+DQo+IEZpeGVzOiBjb21taXQgMjg3OTIyZWIwYjE4ICgiYmxvY2s6
IGRlZmVyIHRpbWVvdXRzIHRvIGEgd29ya3F1ZXVlIikNCg0KKHJlcGx5aW5nIHRvIG15IG93biBl
LW1haWwpDQoNCkhlbGxvLA0KDQpDYW4gYW55b25lIHJldmlldyB0aGlzIHBhdGNoIHN1Y2ggdGhh
dCBpdCBjYW4gYmUgcXVldWVkIGZvciBrZXJuZWwgdjQuMTU/DQoNClRoYW5rcywNCg0KQmFydC4=
