Return-Path: <prvs=7319e9ae6=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "tom.leiming@gmail.com"
	<tom.leiming@gmail.com>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] block, scsi: Rework runtime power management
Date: Thu, 19 Jul 2018 15:54:53 +0000
Message-ID: <c15e8f2b15b734284a983102e8e91a8f28cd2686.camel@wdc.com>
References: <20180717234940.11231-1-bart.vanassche@wdc.com>
	 <20180717234940.11231-3-bart.vanassche@wdc.com>
	 <CACVXFVPP6bY9YijDSyQg9OOR4ge9LyR+naWNDeLGOS=WFL_7CA@mail.gmail.com>
	 <60ce50f281bf41483b53246d509697f6d95360f8.camel@wdc.com>
	 <20180718224545.GA15589@ming.t460p>
In-Reply-To: <20180718224545.GA15589@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-07-19 at 06:45 +-0800, Ming Lei wrote:
+AD4- So once blk+AF8-freeze+AF8-queue+AF8-start() returns, percpu+AF8-ref+=
AF8-is+AF8-zero() won't
+AD4- return true only until the rcu confirmation is done. That means this
+AD4- approach may not put device down.

Hello Ming,

I agree with your conclusion that it is not guaranteed that q-+AD4-q+AF8-us=
age+AF8-counter
is in atomic mode when percpu+AF8-ref+AF8-is+AF8-zero() is called. However,=
 I think that's
fine: if blk+AF8-pre+AF8-runtime+AF8-suspend() returns -EBUSY then the runt=
ime core will
try again at a later time to perform runtime suspend.

Bart.=
