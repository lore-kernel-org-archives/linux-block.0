Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v5] blk-mq: reimplement timeout handling
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "jbacik@fb.com"
 <jbacik@fb.com>, "tj@kernel.org" <tj@kernel.org>, "jack@suse.cz"
 <jack@suse.cz>, "clm@fb.com" <clm@fb.com>
Cc: "kernel-team@fb.com" <kernel-team@fb.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
References: <20180109162953.1211451-1-tj@kernel.org>
 <1515790585.2396.50.camel@wdc.com>
 <3b2ad58c-837a-a084-fdb5-7e8913e5e285@kernel.dk>
 <1515791983.2396.65.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0ea8dcd6-009e-bd2b-fc83-16c0ed4412c3@kernel.dk>
Date: Fri, 12 Jan 2018 14:55:26 -0700
MIME-Version: 1.0
In-Reply-To: <1515791983.2396.65.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/12/18 2:19 PM, Bart Van Assche wrote:
> On Fri, 2018-01-12 at 14:07 -0700, Jens Axboe wrote:
>> You're really not making it easy for folks to run this :-)
> 
> My hope is that the ib_srp and ib_srpt patches will be accepted upstream soon.
> As long as these are not upstream, anyone who wants to retrieve these patches
> is welcome to clone https://github.com/bvanassche/linux/tree/block-scsi-for-next,
> a kernel tree with all my pending patches.
> 
>> Do you have the matching blk-mq debugfs output for the device?
> 
> Sorry but I only retrieved the blk-mq debugfs several minutes after the hang
> started so I'm not sure the state information is relevant. Anyway, I have attached
> it to this e-mail. The most remarkable part is the following:
> 
> ./000000009ddfa913/requeue_list:000000009646711c {.op=READ, .state=idle, gen=0x1
> 18, abort_gen=0x0, .cmd_flags=, .rq_flags=SORTED|1|SOFTBARRIER|IO_STAT, complete
> =0, .tag=-1, .internal_tag=217}

Two things come to mind here:

1) We forgot to add RQF_STARTED to the debugfs bits, I just rectified
   that.

2) You are using a scheduler (which one?). The request was inserted, and
   retrieved by the driver, then requeued. After this requeue,
   apparently nothing happened. The queue should have been re-run, but
   that didn't happen. What are the queue/hctx states?

-- 
Jens Axboe
