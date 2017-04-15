Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdYsWnXLZEpZr74pLB8zjTV4Q=sdAfX+sz0n_E46SaJa9Q@mail.gmail.com>
References: <CACRpkdbZrkAqEdP1-QqDww0ZuFcY47Jgj9dPqkG_whrx7pwC-w@mail.gmail.com>
 <CAK8P3a1CGtj5VSVoMM34VWn781WpS8ZcHpq6n0UfNOWWYEq=QQ@mail.gmail.com>
 <CAPDyKFqiyEcScuWLVXE9kAa2yQyJCZfbXyAdAQOb081nLjyvvw@mail.gmail.com>
 <CAK8P3a1yJJ33R9EPPcErLUO2enFGrSJzWmVRwHdHP+3_2iP7ow@mail.gmail.com> <CACRpkdYsWnXLZEpZr74pLB8zjTV4Q=sdAfX+sz0n_E46SaJa9Q@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sat, 15 Apr 2017 12:20:28 +0200
Message-ID: <CAPDyKFp3M7tK7VACUH8Ox9vD=wRV0bDETUgk0MEHjOhtxmbUSA@mail.gmail.com>
Subject: Re: Outstanding MQ questions from MMC
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	linux-block@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

[...]

>> Alternatively, I had this idea that we could translate blk requests into
>> mmc commands and then have a (short fixed length) set of outstanding
>> mmc commands in the device that always get done in order. The card
>> detect and the user space I/O would then directly put mmc commands
>> onto the command queue, as would the blk-mq scheduler. You
>> still need a lock to access that command queue, but the mmc host
>> would just always pick the next command off the list when one
>> command completes.
>
> I looked into this.
>
> The block layer queue can wrap and handle custom device commands
> using REQ_OP_DRV_IN/OUT, and that seems to be the best way
> to play with the block layer IMO.
>
> The card detect work is a special case because it is also used by
> SDIO which does not use the block layer. But that could maybe be
> solved by a separate host lock just for the SDIO case, letting
> devices accessed as block devices use the method of inserting
> custom commands.

The problem with trying to manage the SDIO case as a specific case, it
that it is the same work (mmc_rescan()) that runs to detect any kind
of removable card.

Moreover, it's not until the card has been fully detected and
initialized, when we can realize what kind of card it is.

Perhaps we can re-factor the hole mmc_rescan() thing so there is one
part that can be run only to detect new cards being inserted in
lockless fashion, while another part could deal with the
polling/removal - which then perhaps could be different depending on
the card type.

Not sure if this helps...

>
> I looked at how e.g. IDE and SCSI does this, drivers/ide/ide-ioctls.c
> looks like this nowadays:
>
> static int generic_drive_reset(ide_drive_t *drive)
> {
>         struct request *rq;
>         int ret = 0;
>
>         rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
>         scsi_req_init(rq);
>         ide_req(rq)->type = ATA_PRIV_MISC;
>         scsi_req(rq)->cmd_len = 1;
>         scsi_req(rq)->cmd[0] = REQ_DRIVE_RESET;
>         if (blk_execute_rq(drive->queue, NULL, rq, 1))
>                 ret = rq->errors;
>         blk_put_request(rq);
>         return ret;
> }
>
> So it creates a custom REQ_OP_DRV_IN request, then scsi_req_init()
> sets up the special command, in this case
> ATA_PRIV_MISC/REQ_DRIVE_RESET and toss this into the block
> queue like everything else.
>
> We could do the same, especially the RPMB operations should
> probably have been done like this from the beginning. But due to
> historical factors they were not.
>
> It is a bit hairy and the whole thing is in a bit of flux because Christoph
> is heavily refactoring this and cleaning up the old block devices as
> we speak (I bet) so it is a bit hard to do the right thing.
>
> I easily get confused here ... for example there is custom
> per-request data access by this simple:
>
> scsi_req_init(rq)
>
> which does
>
> struct scsi_request *req = scsi_req(rq);
>
> which does
>
> static inline struct scsi_request *scsi_req(struct request *rq)
> {
>         return blk_mq_rq_to_pdu(rq);
> }
>
> Oohps blk_mq_* namespace? You would assume this means that
> you have to use blk-mq? Nah, I think not, because all it does is:
>
> static inline void *blk_mq_rq_to_pdu(struct request *rq)
> {
>         return rq + 1;
> }
>
> So while we have to #include <linux/blk-mq.h> this is one of these
> mixed semantics that just give you a pointer to something behind
> the request, a method that is simple and natural in blk-mq but which
> is (I guess) set up by some other mechanism in the !mq case,
> albeit access by this inline.
>
> And I have to do this with the old block layer to get to a point
> where we can start using blk-mq, sigh.
>
> The border between blk and blk-mq is a bit blurry right now.
>
> With blk-mq I do this:
>
> mq->tag_set.cmd_size = sizeof(foo_cmd);
> blk_mq_alloc_tag_set(...)
>
> To do this with the old blk layer I may need some help to figure
> out how to set up per-request additional data in a way that works
> with the old layer.
>
> scsi_lib.c scsi_alloc_queue() does this:
>
> q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
> if (!q)
>       return NULL;
> q->cmd_size = sizeof(foo_cmd);
>
> And this means there will be sizeof(foo_cmd) after the request
> that can be dereferenced by blk_mq_rq_to_pdu(rq);...
>
> Yeah I'll try it.
>
> Just trying to give a picture of why it's a bit in flux here.
> Or documenting it for myself :D
>
>> This also lets you integrate packed commands: if the next outstanding
>> command is the same type as the request coming in from blk-mq,
>> you can merge it into a single mmc command to be submitted
>> together, otherwise it gets deferred.
>
> Essentially the heavy lifting that needs to happen is:
>
> 1. Start allocating per-request PDU (extra data) in the MMC case
>    this will then be struct mmc_queue_req request items.
>
> 2. Turn RPMB and other ioctl() MMC operations into mmc_queue_req
>    things and funnel them into the block scheduler
>    using REQ_OP_DRV_IN/OUT requests.
>
> 3. Turn the card detect into an mmc_queue_req as well
>
> 4. We can kill the big MMC host lock for block devices and
>    split off an SDIO-only host lock.
>
> I'm onto it ... I guess.

It looks hairy, but please have a try!

In the meantime, I will wrap my head around and try to see if we can
find a possible easier intermediate step.

Kind regards
Uffe
