Return-Path: <keith.busch@intel.com>
Date: Mon, 18 Sep 2017 18:39:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH] blk-mq: Fix lost request during timeout
Message-ID: <20170918223900.GA4671@localhost.localdomain>
References: <1505772186-4601-1-git-send-email-keith.busch@intel.com>
 <1505772477.12701.6.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505772477.12701.6.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 18, 2017 at 10:07:58PM +0000, Bart Van Assche wrote:
> On Mon, 2017-09-18 at 18:03 -0400, Keith Busch wrote:
> > I think we've always known it's possible to lose a request during timeout
> > handling, but just accepted that possibility. It seems to be causing
> > problems, though, leading to unnecessary error escalation and IO failures.
> > 
> > The possiblity arises when the block layer marks the request complete
> > prior to running the timeout handler. If that request happens to complete
> > while the handler is running, the request will be lost, inevitably
> > triggering a second timeout.
> > 
> > This patch attempts to shorten the window for this race condition by
> > clearing the started flag when the driver completes a request. The block
> > layer's timeout handler will then complete the command if it observes
> > the started flag is no longer set.
> > 
> > Note it's possible to lose the command even with this patch. It's just
> > less likely to happen.
> 
> Hello Keith,
> 
> Are you sure the root cause of this race condition is in the blk-mq core?
> I've never observed such behavior in any of my numerous scsi-mq tests (which
> trigger timeouts). Are you sure the race you observed is not caused by a
> blk_mq_reinit_tagset() call, a function that is only used by the NVMe driver
> and not by any other block driver?

Hi Bart,

The nvme driver's use of blk_mq_reinit_tagset only happens during
controller initialisation, but I'm seeing lost commands well after that
during normal and stable running.

The timing is pretty narrow to hit, but I'm pretty sure this is what's
happening. For nvme, this occurs when nvme_timeout() runs concurrently
with nvme_handle_cqe() for the same struct request. For scsi-mq,
the same situation may arise if scsi_mq_done() runs concurrently with
scsi_times_out().

I don't really like the proposed "fix" though since it only makes it
less likely, but I didn't see a way to close that without introducing
locks. If someone knows of a better way, that would be awesome.

Thanks,
Keith
