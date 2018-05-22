Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180522142030.GR5528@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com> <20180521231131.6685-4-keith.busch@intel.com>
 <20180522024910.GD20430@ming.t460p> <20180522142030.GR5528@localhost.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 22 May 2018 22:37:32 +0800
Message-ID: <CACVXFVNT5qiamN0ydXzNYDWE0szi2fTsAAmyG9Q884LEqUhSdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Bart Van Assche <bart.vanassche@wdc.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 10:20 PM, Keith Busch
<keith.busch@linux.intel.com> wrote:
> On Tue, May 22, 2018 at 10:49:11AM +0800, Ming Lei wrote:
>> On Mon, May 21, 2018 at 05:11:31PM -0600, Keith Busch wrote:
>> > -static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
>> > +static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
>> >             struct request *rq, void *priv, bool reserved)
>> >  {
>> > +   unsigned long *next = priv;
>> > +
>> >     /*
>> > -    * We marked @rq->aborted_gstate and waited for RCU.  If there were
>> > -    * completions that we lost to, they would have finished and
>> > -    * updated @rq->gstate by now; otherwise, the completion path is
>> > -    * now guaranteed to see @rq->aborted_gstate and yield.  If
>> > -    * @rq->aborted_gstate still matches @rq->gstate, @rq is ours.
>> > +    * Just do a quick check if it is expired before locking the request in
>> > +    * so we're not unnecessarilly synchronizing across CPUs.
>> >      */
>> > -   if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
>> > -       READ_ONCE(rq->gstate) == rq->aborted_gstate)
>> > +   if (!blk_mq_req_expired(rq, next))
>> > +           return;
>> > +
>> > +   /*
>> > +    * We have reason to believe the request may be expired. Take a
>> > +    * reference on the request to lock this request lifetime into its
>> > +    * currently allocated context to prevent it from being reallocated in
>> > +    * the event the completion by-passes this timeout handler.
>> > +    *
>> > +    * If the reference was already released, then the driver beat the
>> > +    * timeout handler to posting a natural completion.
>> > +    */
>> > +   if (!kref_get_unless_zero(&rq->ref))
>> > +           return;
>>
>> If this request is just completed in normal path and its state isn't
>> updated yet, timeout will hold the request, and may complete this
>> request again, then this req can be completed two times.
>
> Hi Ming,
>
> In the event the driver requests a normal completion, the timeout work
> releasing the last reference doesn't do a second completion: it only

The reference only covers request's lifetime, not related with completion.

It isn't the last reference. When driver returns EH_HANDLED, blk-mq
will complete this request on extra time.

Yes, if driver's timeout code and normal completion code can sync
about this completion, that should be fine, but the current behaviour
doesn't depend driver's sync since the req is always completed atomically
via the following way:

1) timeout

if (mark_completed(rq))
   timed_out(rq)

2) normal completion
if (mark_completed(rq))
    complete(rq)

For example, before nvme_timeout() is trying to run nvme_dev_disable(),
irq comes and this req is completed from normal completion path, but
nvme_timeout() still returns EH_HANDLED, and blk-mq may complete
the req one extra time since the normal completion path may not update
req's state yet.

Thanks,
Ming Lei
