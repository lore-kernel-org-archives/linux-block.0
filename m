Return-Path: <keith.busch@linux.intel.com>
Date: Wed, 25 Jul 2018 10:48:31 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv2 2/2] scsi: set timed out out mq requests to complete
Message-ID: <20180725164831.GA16208@localhost.localdomain>
References: <20180723143751.10843-1-keith.busch@intel.com>
 <20180723143751.10843-2-keith.busch@intel.com>
 <bd7fe6618616db1c2de80386d1a916d86bccbcfd.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bd7fe6618616db1c2de80386d1a916d86bccbcfd.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 25, 2018 at 03:52:17PM +0000, Bart Van Assche wrote:
> On Mon, 2018-07-23 at 08:37 -0600, Keith Busch wrote:
> > diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> > index 8932ae81a15a..2715cdaa669c 100644
> > --- a/drivers/scsi/scsi_error.c
> > +++ b/drivers/scsi/scsi_error.c
> > @@ -296,6 +296,20 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
> >  		rtn = host->hostt->eh_timed_out(scmd);
> >  
> >  	if (rtn == BLK_EH_DONE) {
> > +		/*
> > +		 * For blk-mq, we must set the request state to complete now
> > +		 * before sending the request to the scsi error handler. This
> > +		 * will prevent a use-after-free in the event the LLD manages
> > +		 * to complete the request before the error handler finishes
> > +		 * processing this timed out request.
> > +		 *
> > +		 * If the request was already completed, then the LLD beat the
> > +		 * time out handler from transferring the request to the scsi
> > +		 * error handler. In that case we can return immediately as no
> > +		 * further action is required.
> > +		 */
> > +		if (req->q->mq_ops && !blk_mq_mark_complete(req))
> > +			return rtn;
> >  		if (scsi_abort_command(scmd) != SUCCESS) {
> >  			set_host_byte(scmd, DID_TIME_OUT);
> >  			scsi_eh_scmd_add(scmd);
> 
> Hello Keith,
> 
> What will happen if a completion occurs after scsi_times_out() has started and
> before or during the host->hostt->eh_timed_out()? Can that cause a use-after-free
> in .eh_timed_out()? Can that cause .eh_timed_out() to return BLK_EH_RESET_TIMER
> when it should return BLK_EH_DONE? Can that cause blk_mq_rq_timed_out() to call
> blk_add_timer() when that function shouldn't be called?

That's what the request's refcount protects. The whole point was that
driver returning RESET_TIMER doesn't lose the completion. In the worst
case scenario, the blk-mq timeout work spends some CPU cycles re-arming
a timer that it didn't need to.
