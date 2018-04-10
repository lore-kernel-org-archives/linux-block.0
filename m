Return-Path: <prvs=63144aee1=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Date: Tue, 10 Apr 2018 21:46:23 +0000
Message-ID: <d88becef654cde4b5382c1ebddb0aeba963c0578.camel@wdc.com>
References: <20180410084133.GB9133@ming.t460p>
	 <b36ea1107be4f32fb04fffdde3ee45a2e0fcc36c.camel@wdc.com>
	 <20180410135541.GA22340@ming.t460p>
	 <7c4a8b019182d5a9259ef20e6462b3f6a533abed.camel@wdc.com>
	 <20180410143007.GB22340@ming.t460p>
	 <e2762e359649946543ee22cf6ebf0c08410f7963.camel@wdc.com>
	 <20180410152553.GC22340@ming.t460p>
	 <20180410153031.GO3126663@devbig577.frc2.facebook.com>
	 <20180410153812.GA3219@ming.t460p>
	 <20180410154043.GP3126663@devbig577.frc2.facebook.com>
	 <20180410213323.GC793541@devbig577.frc2.facebook.com>
In-Reply-To: <20180410213323.GC793541@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA0LTEwIGF0IDE0OjMzIC0wNzAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiArICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgIHJxLT5taXNzZWRfY29tcGxldGlvbiA9
IHRydWU7DQoNCkluIHRoaXMgcGF0Y2ggSSBmb3VuZCBjb2RlIHRoYXQgc2V0cyBycS0+bWlzc2Vk
X2NvbXBsZXRpb24gYnV0IG5vIGNvZGUgdGhhdA0KY2xlYXJzIGl0LiBEaWQgSSBwZXJoYXBzIG1p
c3Mgc29tZXRoaW5nPw0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0K
