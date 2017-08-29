Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Call .initialize_rq_fn() also for filesystem
 requests
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "hare@suse.com" <hare@suse.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <20170825190057.15592-1-bart.vanassche@wdc.com>
 <20170828081017.GC2851@lst.de> <1504040278.2653.66.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ebbccce0-aef7-08bb-24f7-aa1f26fcd993@kernel.dk>
Date: Tue, 29 Aug 2017 15:24:36 -0600
MIME-Version: 1.0
In-Reply-To: <1504040278.2653.66.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/29/2017 02:57 PM, Bart Van Assche wrote:
> On Mon, 2017-08-28 at 10:10 +0200, Christoph Hellwig wrote:
>> All that can be done by clearing or setting a flag on the first call to
>> ->queue_rq or ->queuecommand instead.  In NVMe we use RQF_DONTPREP for
>> that, but for SCSI we probablt can't use that given that it has more
>> meaning for the old request path.  But how about just adding a new
>> RQD_DRV_INITIALIZED or similar flag?
> 
> Hello Christoph,
> 
> More changes would have to be made to implement the above proposal
> than just setting a flag at the start of .queue_rq() / .queuecommand()
> for all filesystem requests. The numerous code paths that lead to a
> request not being executed immediately, e.g. a SCSI host being busy or
> a preparation status != BLKPREP_OK, would have to be inspected and
> code would have to be added to clear the "command initialized" flag to
> ensure that initialization occurs shortly before the first time a
> command is executed.
> 
> The choice we have to make is to add more state information and
> complicated code for keeping that state information up-to-date to the
> SCSI core or making a small and easy to maintain change to the block
> layer core that does not involve any new state information. That's why
> I'm asking you to reconsider the patch at the start of this e-mail
> thread.

I don't like this addition, and honestly I wasn't a huge fan of adding
->init() hooks to the alloc path when we initially added this earlier
this summer. The fact that we now have to make this more invasive
doesn't improve the situation at all.

So fwiw, I too would much rather see an implementation based on an RQF_
flag instead.

-- 
Jens Axboe
