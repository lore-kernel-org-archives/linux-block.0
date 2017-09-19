Return-Path: <keith.busch@intel.com>
Date: Tue, 19 Sep 2017 12:00:05 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH] blk-mq: Fix lost request during timeout
Message-ID: <20170919160004.GB6180@localhost.localdomain>
References: <1505772186-4601-1-git-send-email-keith.busch@intel.com>
 <1505772477.12701.6.camel@wdc.com>
 <20170918223900.GA4671@localhost.localdomain>
 <1505775191.12701.20.camel@wdc.com>
 <20170918230803.GB4671@localhost.localdomain>
 <CACVXFVO4joG1zzipABWK4bc5Rwo9bDa4by4_mFOTx10nQPAUpQ@mail.gmail.com>
 <20170919150721.GA6180@localhost.localdomain>
 <CACVXFVOyAeFEQCVznKCtD_-gMPCi+5+v+-kgscYxgP642QCB7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVOyAeFEQCVznKCtD_-gMPCi+5+v+-kgscYxgP642QCB7A@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 19, 2017 at 11:22:20PM +0800, Ming Lei wrote:
> On Tue, Sep 19, 2017 at 11:07 PM, Keith Busch <keith.busch@intel.com> wrote:
> > On Tue, Sep 19, 2017 at 12:16:31PM +0800, Ming Lei wrote:
> >> On Tue, Sep 19, 2017 at 7:08 AM, Keith Busch <keith.busch@intel.com> wrote:
> >> >
> >> > Indeed that prevents .complete from running concurrently with the
> >> > timeout handler, but scsi_mq_done and nvme_handle_cqe are not .complete
> >> > callbacks. These are the LLD functions that call blk_mq_complete_request
> >> > well before .complete. If the driver calls blk_mq_complete_request on
> >> > a request that blk-mq is timing out, the request is lost because blk-mq
> >> > already called blk_mark_rq_complete. Nothing prevents these LLD functions
> >>
> >> That shouldn't happen because only one blk_mark_rq_complete() can win
> >> and it is the winner's responsibility to complete the request, so
> >> there shouldn't
> >> be request lost. Especially in your case, it is the responsibility of timeout
> >> to complete the rq really.
> >
> > Hm, either I'm explaining this poorly, or I'm missing something that's
> > obvious to everyone else.
> >
> > The driver's IRQ handler has no idea it's racing with the blk-mq timeout
> > handler, and there's nothing indicating it lost the race. The IRQ handler
> > just calls blk_mq_complete_request. As far as the driver is concerned,
> > it has done its part to complete the request at that point.
> 
> Both blk_mark_rq_complete() and blk_mq_check_expired() calls
> blk_mark_rq_complete() to try to complete the req, but only
> one of them can do that actually, right?

Yes, only one can successfully call that.

The problem I'm asking about is the driver's IRQ handler doesn't know it
lost the race. Only blk-mq knows that. At the point the driver's timeout
handler runs, the driver believes it already completed the request.
 
> > The problem is when blk-mq's timeout handler prevents the request from
> > completing, and doesn't leave any indication the driver requested to
> > complete it. Who is responsible for completing that request now?
> 
> Who sets ATOM_COMPLETE successfully is responsible for completing
> the request. In this case it should be timeout handler, and irq handler
> shouldn't touch the request any more, otherwise use-after-free may
> happen.

Blk-mq sets ATOM_COMPLETE well before the driver's timeout handler is
executed. The IRQ handler doesn't know blk-mq did that, so suggesting
the IRQ handler can't touch the request doesn't make sense.
