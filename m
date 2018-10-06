Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jan Kara <jack@suse.cz>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Jens Axboe <axboe@kernel.dk>, Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>, Artem Bityutskiy <dedekind1@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andreas Herrmann <aherrmann@suse.com>, Mel Gorman <mgorman@suse.com>,
 Chunyan Zhang <zhang.chunyan@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <20181004202553.71c2599c@alans-desktop>
 <1538683746.230807.9.camel@acm.org>
 <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
 <1538692972.8223.7.camel@acm.org> <20181005091626.GA9686@quack2.suse.cz>
 <20bfa679-3131-e0af-f69d-2fbec32fbced@acm.org>
 <A6518C7A-C7DF-48A6-A57A-F4B4162DC16E@linaro.org>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <bb934140-ef97-05b3-2bfc-d82be4766578@acm.org>
Date: Sat, 6 Oct 2018 09:20:36 -0700
MIME-Version: 1.0
In-Reply-To: <A6518C7A-C7DF-48A6-A57A-F4B4162DC16E@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/5/18 11:46 PM, Paolo Valente wrote:
>> Il giorno 06 ott 2018, alle ore 05:12, Bart Van Assche <bvanassche@acm.org> ha scritto:
>> On 10/5/18 2:16 AM, Jan Kara wrote:
>>> On Thu 04-10-18 15:42:52, Bart Van Assche wrote:
>>>> What I think is missing is measurement results for BFQ on a system with
>>>> multiple CPU sockets and against a fast storage medium. Eliminating
>>>> the host lock from the SCSI core yielded a significant performance
>>>> improvement for such storage devices. Since the BFQ scheduler locks and
>>>> unlocks bfqd->lock for every dispatch operation it is very likely that BFQ
>>>> will slow down I/O for fast storage devices, even if their driver only
>>>> creates a single hardware queue.
>>> Well, I'm not sure why that is missing. I don't think anyone proposed to
>>> default to BFQ for such setup? Neither was anyone claiming that BFQ is
>>> better in such situation... The proposal has been: Default to BFQ for slow
>>> storage, leave it to deadline-mq otherwise.
>>
>> How do you define slow storage? The proposal at the start of this thread
>> was to make BFQ the default for all block devices that create a single
>> hardware queue. That includes all SATA storage since scsi-mq only creates
>> a single hardware queue when using the SATA protocol. The proposal to make >> BFQ the default for systems with a single hard disk probably makes sense
>> but I am not sure that making BFQ the default for systems equipped with
>> one or more (SATA) SSDs is also a good idea. Especially for multi-socket
>> systems since BFQ reintroduces a queue-wide lock.
> 
> No, BFQ has no queue-wide lock.  The very first change made to BFQ for
> porting it to blk-mq was to remove the queue lock.  Guided by Jens, I
> replaced that lock with the exact, same scheduler lock used in
> mq-deadline.

It's easy to see that both mq-deadline and BFQ define a queue-wide lock. 
For mq-deadline its deadline_data.lock. For BFQ it's bfq_data.lock. That 
last lock serializes all bfq_dispatch_request() calls and hence reduces 
concurrency while processing I/O requests. From bfq_dispatch_request():

static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
{
	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
	[ ... ]
	spin_lock_irq(&bfqd->lock);
	[ ... ]
}

I think the above makes it very clear that bfqd->lock is queue-wide.

It is easy to understand why both I/O schedulers need a queue-wide lock: 
the only way to avoid race conditions when considering all pending I/O 
requests for scheduling decisions is to use a lock that covers all 
pending requests and hence that is queue-wide.

Bart.
