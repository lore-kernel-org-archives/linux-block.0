Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2018 12:09:51 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180207200951.GE695913@devbig577.frc2.facebook.com>
References: <20180207011133.25957-1-bart.vanassche@wdc.com>
 <20180207170612.GB695913@devbig577.frc2.facebook.com>
 <1518030233.2870.57.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518030233.2870.57.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Feb 07, 2018 at 07:03:56PM +0000, Bart Van Assche wrote:
> I tried the above patch but already during the first iteration of the test I
> noticed that the test hung, probably due to the following request that got stuck:
> 
> $ (cd /sys/kernel/debug/block && grep -aH . */*/*/rq_list)
> 00000000a98cff60 {.op=SCSI_IN, .cmd_flags=, .rq_flags=MQ_INFLIGHT|PREEMPT|QUIET|IO_STAT|PM,
>  .state=idle, .tag=22, .internal_tag=-1, .cmd=Synchronize Cache(10) 35 00 00 00 00 00, .retries=0,
>  .result = 0x0, .flags=TAGGED, .timeout=60.000, allocated 872.690 s ago}

I'm wonder how this happened, so we can lose a completion when it
races against BLK_EH_RESET_TIMER; however, the command should timeout
later cuz the timer is running again now.  Maybe we actually had the
memory barrier race that you pointed out in the other message?

Thanks.

-- 
tejun
