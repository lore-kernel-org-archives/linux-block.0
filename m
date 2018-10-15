Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-um@lists.infradead.org, anton.ivanov@cambridgegreys.com, dwalter@google.com
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
Date: Tue, 16 Oct 2018 00:44:03 +0200
Message-ID: <2132215.oDDApMmxLa@blindfold>
In-Reply-To: <a33c7dfb-3eb6-3955-0336-257b8fcbfbe7@kernel.dk>
References: <20181015065637.1860-1-hch@lst.de> <48119384.A7YGth2QHM@blindfold> <a33c7dfb-3eb6-3955-0336-257b8fcbfbe7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Am Dienstag, 16. Oktober 2018, 00:04:20 CEST schrieb Jens Axboe:
> On 10/15/18 3:46 PM, Richard Weinberger wrote:
> > Am Montag, 15. Oktober 2018, 22:55:29 CEST schrieb Christoph Hellwig:
> >> On Mon, Oct 15, 2018 at 10:42:47PM +0200, Richard Weinberger wrote:
> >>>> Sadly not. I'm checking now what exactly is broken.
> >>>
> >>> I take this back. Christoph's fixup makes reading work.
> >>> The previous version corrupted my test block device in interesting ways
> >>> and confused all tests.
> >>> But the removal of blk_rq_map_sg() still has issues.
> >>> Now the device blocks endless upon flush.
> >>
> >> I suspect we still need to special case flush.  Updated patch below
> >> including your other suggestion:
> > 
> > While playing further with the patch I managed to hit
> > BUG_ON(blk_queued_rq(rq)) in blk_mq_requeue_request().
> > 
> > UML requeues the request in ubd_queue_one_vec() if it was not able
> > to submit the request to the host io-thread.
> > The fd can return -EAGAIN, then UML has to try later.
> > 
> > Isn't this allowed in that context?
> 
> It is, the problem is that queue_one_vec() doesn't always return an
> error. The caller is doing a loop per bio, so we can encounter an
> error, requeue, and then the caller will call us again. We're in
> an illegal state at that point, and the next requeue will make that
> obvious since it's already pending. Actually, both the caller and
> ubd_queue_one_vec() also requeue. So it's a bit of a mess, the below
> might help.

I agree, the driver *is* a mess.
Unless someone else volunteers to clean it up, I'll push that task on
my never ending TODO list.

Thanks for your hint with the illegal state.
Now with correct requeuing the driver seems to work fine!
Write/Flush support also suffered from that but didn't trigger the BUG_ON()...

Thanks,
//richard
