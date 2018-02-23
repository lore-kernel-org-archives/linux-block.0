Return-Path: <prvs=585cc836a=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>
CC: "hch@lst.de" <hch@lst.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v4 4/6] block: Add a third argument to
 blk_alloc_queue_node()
Date: Fri, 23 Feb 2018 16:07:26 +0000
Message-ID: <1519402043.2904.5.camel@wdc.com>
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
	 <20180223010808.25765-5-bart.vanassche@wdc.com>
	 <mqdbmggdscz.fsf@linux-x5ow.site>
In-Reply-To: <mqdbmggdscz.fsf@linux-x5ow.site>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTAyLTIzIGF0IDA5OjI2ICswMTAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IGhvdyBhYm91dCAiYmxvY2s6IEFkZCAnbG9jaycgYXMgdGhpcmQgYXJndW1lbnQgdG8N
Cj4gYmxrX2FsbG9jX3F1ZXVlX25vZGUoKSI/DQo+IA0KPiBTbyBvbmUgYWN0dWFsbHkgc2VlcyBl
YXJseSBlbm91Z2ggd2hhdCB0aGUgdGhyaXJkIGFyZ3VtZW50IHdpbGwgYmU/DQoNCkhlbGxvIEpv
aGFubmVzLA0KDQpJZiBJIGhhdmUgdG8gcmVwb3N0IHRoaXMgcGF0Y2ggc2VyaWVzIEkgd2lsbCBt
YWtlIHRoYXQgY2hhbmdlLg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCkJhcnQuDQoNCg0K
