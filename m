Return-Path: <keith.busch@intel.com>
Date: Mon, 18 Sep 2017 19:08:03 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH] blk-mq: Fix lost request during timeout
Message-ID: <20170918230803.GB4671@localhost.localdomain>
References: <1505772186-4601-1-git-send-email-keith.busch@intel.com>
 <1505772477.12701.6.camel@wdc.com>
 <20170918223900.GA4671@localhost.localdomain>
 <1505775191.12701.20.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505775191.12701.20.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 18, 2017 at 10:53:12PM +0000, Bart Van Assche wrote:
> On Mon, 2017-09-18 at 18:39 -0400, Keith Busch wrote:
> > The nvme driver's use of blk_mq_reinit_tagset only happens during
> > controller initialisation, but I'm seeing lost commands well after that
> > during normal and stable running.
> > 
> > The timing is pretty narrow to hit, but I'm pretty sure this is what's
> > happening. For nvme, this occurs when nvme_timeout() runs concurrently
> > with nvme_handle_cqe() for the same struct request. For scsi-mq,
> > the same situation may arise if scsi_mq_done() runs concurrently with
> > scsi_times_out().
> 
> Hello Keith,
> 
> Are you sure that scenario can happen? The blk-mq core calls test_and_set_bit()
> for the REQ_ATOM_COMPLETE flag before any completion or timeout handler is
> called. See also blk_mark_rq_complete(). This avoids that the .complete() and
> .timeout() functions run concurrently.

Indeed that prevents .complete from running concurrently with the
timeout handler, but scsi_mq_done and nvme_handle_cqe are not .complete
callbacks. These are the LLD functions that call blk_mq_complete_request
well before .complete. If the driver calls blk_mq_complete_request on
a request that blk-mq is timing out, the request is lost because blk-mq
already called blk_mark_rq_complete. Nothing prevents these LLD functions
from running at the same time as the timeout handler.
 
> In case this wouldn't be clear, a block driver must not call
> blk_mq_end_request() after the timeout handler has finished because that would
> trigger a use-after-free of a request structure.
>
> I noticed that your patch includes changes for blk_mq_start_request(). No
> timeout or completion handler should be running while blk_mq_start_request() is
> being executed. If these changes make a difference in your tests then I think
> that means that there is something wrong with the NVMe driver.

The reason for changing blk_mq_start_request was because of how the
requeue was clearing STARTED. I had to remove that since it would have
otherwise been impossible for the blk_mq_rq_timed_out to know if the
request was requeued vs. completed.
