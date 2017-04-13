Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1yJJ33R9EPPcErLUO2enFGrSJzWmVRwHdHP+3_2iP7ow@mail.gmail.com>
References: <CACRpkdbZrkAqEdP1-QqDww0ZuFcY47Jgj9dPqkG_whrx7pwC-w@mail.gmail.com>
 <CAK8P3a1CGtj5VSVoMM34VWn781WpS8ZcHpq6n0UfNOWWYEq=QQ@mail.gmail.com>
 <CAPDyKFqiyEcScuWLVXE9kAa2yQyJCZfbXyAdAQOb081nLjyvvw@mail.gmail.com> <CAK8P3a1yJJ33R9EPPcErLUO2enFGrSJzWmVRwHdHP+3_2iP7ow@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Apr 2017 15:22:09 +0200
Message-ID: <CACRpkdYsWnXLZEpZr74pLB8zjTV4Q=sdAfX+sz0n_E46SaJa9Q@mail.gmail.com>
Subject: Re: Outstanding MQ questions from MMC
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 31, 2017 at 10:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Mar 30, 2017 at 6:39 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 30 March 2017 at 14:42, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wed, Mar 29, 2017 at 5:09 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>>>> In MQ, I have simply locked the host on the first request and then I never
>>>> release it. Clearly this does not work. I am uncertain on how to handle this
>>>> and whether MQ has a way to tell us that the queue is empty so we may release
>>>> the host. I toyed with the idea to just set up a timer, but a "queue
>>>> empty" callback
>>>> from the block layer is what would be ideal.
>>>
>>> Would it be possible to change the userspace code to go through
>>> the block layer instead and queue a request there, to avoid having
>>> to lock the card at all?
>>
>> That would be good from an I/O scheduling point of view, as it would
>> avoid one side being able to starve the other.
>>
>> However, we would still need a lock, as we also have card detect work
>> queue, which also needs to claim the host when it polls for removable
>> cards.
>
> Hmm, In theory the card-detect work queue should not be active
> at the same time as any I/O, but I see you point. Could the card-detect
> wq perhaps also use the blk queue for sending a special request that
> triggers the detection logic?
>
> Alternatively, I had this idea that we could translate blk requests into
> mmc commands and then have a (short fixed length) set of outstanding
> mmc commands in the device that always get done in order. The card
> detect and the user space I/O would then directly put mmc commands
> onto the command queue, as would the blk-mq scheduler. You
> still need a lock to access that command queue, but the mmc host
> would just always pick the next command off the list when one
> command completes.

I looked into this.

The block layer queue can wrap and handle custom device commands
using REQ_OP_DRV_IN/OUT, and that seems to be the best way
to play with the block layer IMO.

The card detect work is a special case because it is also used by
SDIO which does not use the block layer. But that could maybe be
solved by a separate host lock just for the SDIO case, letting
devices accessed as block devices use the method of inserting
custom commands.

I looked at how e.g. IDE and SCSI does this, drivers/ide/ide-ioctls.c
looks like this nowadays:

static int generic_drive_reset(ide_drive_t *drive)
{
        struct request *rq;
        int ret = 0;

        rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
        scsi_req_init(rq);
        ide_req(rq)->type = ATA_PRIV_MISC;
        scsi_req(rq)->cmd_len = 1;
        scsi_req(rq)->cmd[0] = REQ_DRIVE_RESET;
        if (blk_execute_rq(drive->queue, NULL, rq, 1))
                ret = rq->errors;
        blk_put_request(rq);
        return ret;
}

So it creates a custom REQ_OP_DRV_IN request, then scsi_req_init()
sets up the special command, in this case
ATA_PRIV_MISC/REQ_DRIVE_RESET and toss this into the block
queue like everything else.

We could do the same, especially the RPMB operations should
probably have been done like this from the beginning. But due to
historical factors they were not.

It is a bit hairy and the whole thing is in a bit of flux because Christoph
is heavily refactoring this and cleaning up the old block devices as
we speak (I bet) so it is a bit hard to do the right thing.

I easily get confused here ... for example there is custom
per-request data access by this simple:

scsi_req_init(rq)

which does

struct scsi_request *req = scsi_req(rq);

which does

static inline struct scsi_request *scsi_req(struct request *rq)
{
        return blk_mq_rq_to_pdu(rq);
}

Oohps blk_mq_* namespace? You would assume this means that
you have to use blk-mq? Nah, I think not, because all it does is:

static inline void *blk_mq_rq_to_pdu(struct request *rq)
{
        return rq + 1;
}

So while we have to #include <linux/blk-mq.h> this is one of these
mixed semantics that just give you a pointer to something behind
the request, a method that is simple and natural in blk-mq but which
is (I guess) set up by some other mechanism in the !mq case,
albeit access by this inline.

And I have to do this with the old block layer to get to a point
where we can start using blk-mq, sigh.

The border between blk and blk-mq is a bit blurry right now.

With blk-mq I do this:

mq->tag_set.cmd_size = sizeof(foo_cmd);
blk_mq_alloc_tag_set(...)

To do this with the old blk layer I may need some help to figure
out how to set up per-request additional data in a way that works
with the old layer.

scsi_lib.c scsi_alloc_queue() does this:

q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
if (!q)
      return NULL;
q->cmd_size = sizeof(foo_cmd);

And this means there will be sizeof(foo_cmd) after the request
that can be dereferenced by blk_mq_rq_to_pdu(rq);...

Yeah I'll try it.

Just trying to give a picture of why it's a bit in flux here.
Or documenting it for myself :D

> This also lets you integrate packed commands: if the next outstanding
> command is the same type as the request coming in from blk-mq,
> you can merge it into a single mmc command to be submitted
> together, otherwise it gets deferred.

Essentially the heavy lifting that needs to happen is:

1. Start allocating per-request PDU (extra data) in the MMC case
   this will then be struct mmc_queue_req request items.

2. Turn RPMB and other ioctl() MMC operations into mmc_queue_req
   things and funnel them into the block scheduler
   using REQ_OP_DRV_IN/OUT requests.

3. Turn the card detect into an mmc_queue_req as well

4. We can kill the big MMC host lock for block devices and
   split off an SDIO-only host lock.

I'm onto it ... I guess.

Yours,
Linus Walleij
