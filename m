Return-Path: <prvs=6935aac01=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "gi-oh.kim@profitbricks.com"
	<gi-oh.kim@profitbricks.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "jinpu.wang@profitbricks.com"
	<jinpu.wang@profitbricks.com>, "danil.kipnis@profitbricks.com"
	<danil.kipnis@profitbricks.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] blk-mq: reinit q->tag_set_list entry only after grace
 period
Date: Mon, 11 Jun 2018 13:26:46 +0000
Message-ID: <ad42ec94285aef510a9a95595ccc4702a84a1194.camel@wdc.com>
References: <20180610203824.16512-1-roman.penyaev@profitbricks.com>
In-Reply-To: <20180610203824.16512-1-roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gU3VuLCAyMDE4LTA2LTEwIGF0IDIyOjM4ICswMjAwLCBSb21hbiBQZW4gd3JvdGU6DQo+IEl0
IGlzIG5vdCBhbGxvd2VkIHRvIHJlaW5pdCBxLT50YWdfc2V0X2xpc3QgbGlzdCBlbnRyeSB3aGls
ZSBSQ1UgZ3JhY2UNCj4gcGVyaW9kIGhhcyBub3QgY29tcGxldGVkIHlldCwgb3RoZXJ3aXNlIHRo
ZSBmb2xsb3dpbmcgc29mdCBsb2NrdXAgaW4NCj4gYmxrX21xX3NjaGVkX3Jlc3RhcnQoKSBoYXBw
ZW5zOg0KDQpQbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmc6DQoNCkZpeGVzOiA3MDVjZGE5N2VlM2Eg
KCJibGstbXE6IE1ha2UgaXQgc2FmZSB0byB1c2UgUkNVIHRvIGl0ZXJhdGUgb3ZlciBibGtfbXFf
dGFnX3NldC50YWdfbGlzdCIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KDQpBbnl3YXk6
DQoNClJldmlld2VkLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+
DQoNCg0KDQo=
