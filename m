Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpdhu3FBe5OP2mR1-3EK0JFPojGKS1F2K_whzZ249Ue8Q@mail.gmail.com>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <20170510082418.10513-3-linus.walleij@linaro.org> <CAPDyKFpdhu3FBe5OP2mR1-3EK0JFPojGKS1F2K_whzZ249Ue8Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 18 May 2017 10:01:59 +0200
Message-ID: <CACRpkdb5kE2ETLFDDAW4zyqo3-y2JD2f87bNPfXc9i9oe5gOyQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] mmc: core: Allocate per-request data using the block
 layer core
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, May 16, 2017 at 11:02 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 10 May 2017 at 10:24, Linus Walleij <linus.walleij@linaro.org> wrote:

>> @@ -1662,7 +1655,7 @@ static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req,
>>         if (mmc_card_removed(mq->card)) {
>>                 req->rq_flags |= RQF_QUIET;
>>                 blk_end_request_all(req, -EIO);
>> -               mmc_queue_req_free(mq, mqrq);
>> +               mq->qcnt--; /* FIXME: just set to 0? */
>
> As mentioned below, perhaps this FIXME is fine to add. As I assume you
> soon intend to take care of it, right?

Yes that goes away with my MQ patches (not yet rebased)
by stopping to try to look when the queue is empty and just
issue requests asynchronously. I just wanted to point this out,
that counter is kind of fragile and scary to me.

>> -       for (i = 0; i < qdepth; i++) {
>> -               mqrq[i].sg = mmc_alloc_sg(max_segs);
>> -               if (!mqrq[i].sg)
>> +       /* FIXME: use req_to_mq_rq() everywhere this is dereferenced */
>
> Why not do that right now, instead of adding a FIXME comment?

This comment is wrong, just a development artifact I will just delete it.

>>         mq->card = card;
>> -       mq->queue = blk_init_queue(mmc_request_fn, lock);
>> +       mq->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
>
> Seems like we should use blk_alloc_queue() instead, as it calls
> blk_alloc_queue_node(gfp_mask, NUMA_NO_NODE) for us.

OK

>> +static inline struct mmc_queue_req *req_to_mq_rq(struct request *rq)
>
> To be more consistent with existing function names, perhaps rename this to:
> req_to_mmc_queue_req()
>
>> +{
>> +       return blk_mq_rq_to_pdu(rq);
>> +}
>> +
>
> [...]
>
>>  struct mmc_queue {
>> @@ -45,14 +50,15 @@ struct mmc_queue {
>>         bool                    asleep;
>>         struct mmc_blk_data     *blkdata;
>>         struct request_queue    *queue;
>> -       struct mmc_queue_req    *mqrq;
>> -       int                     qdepth;
>> +       /*
>> +        * FIXME: this counter is not a very reliable way of keeping
>> +        * track of how many requests that are ongoing. Switch to just
>> +        * letting the block core keep track of requests and per-request
>> +        * associated mmc_queue_req data.
>> +        */
>>         int                     qcnt;
>
> I am not very fond of FIXME comments, however perhaps this one really
> deserves to be a FIXME because you intend to fix this asap, right?

Same as the first comment. It is fragile and I don't like it,
with asynchronous issueing in MQ this goes away.

Yours,
Linus Walleij
