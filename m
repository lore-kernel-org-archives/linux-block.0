Return-Path: <keith.busch@intel.com>
Date: Mon, 18 Sep 2017 21:55:33 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH] blk-mq: Fix lost request during timeout
Message-ID: <20170919015533.GC4671@localhost.localdomain>
References: <1505772186-4601-1-git-send-email-keith.busch@intel.com>
 <1505772477.12701.6.camel@wdc.com>
 <20170918223900.GA4671@localhost.localdomain>
 <1505775191.12701.20.camel@wdc.com>
 <20170918230803.GB4671@localhost.localdomain>
 <1505776477.12701.28.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505776477.12701.28.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 18, 2017 at 11:14:38PM +0000, Bart Van Assche wrote:
> On Mon, 2017-09-18 at 19:08 -0400, Keith Busch wrote:
> > On Mon, Sep 18, 2017 at 10:53:12PM +0000, Bart Van Assche wrote:
> > > Are you sure that scenario can happen? The blk-mq core calls test_and_set_bit()
> > > for the REQ_ATOM_COMPLETE flag before any completion or timeout handler is
> > > called. See also blk_mark_rq_complete(). This avoids that the .complete() and
> > > .timeout() functions run concurrently.
> > 
> > Indeed that prevents .complete from running concurrently with the
> > timeout handler, but scsi_mq_done and nvme_handle_cqe are not .complete
> > callbacks. These are the LLD functions that call blk_mq_complete_request
> > well before .complete. If the driver calls blk_mq_complete_request on
> > a request that blk-mq is timing out, the request is lost because blk-mq
> > already called blk_mark_rq_complete. Nothing prevents these LLD functions
> > from running at the same time as the timeout handler.
> 
> Can you explain how you define "request is lost"? 

Sure, what I mean by "lost" is when nothing will call
__blk_mq_complete_request, which is required to make forward progress on
that request.

If a driver calls blk_mq_complete_request on a request being checked by
by the timeout handler, blk-mq will return immediately instead of
making progress toward completion since blk-mq already set
REQ_ATOM_COMPLETE while running the timeout hanlder.

> If a timeout occurs for a
> SCSI request then scsi_times_out() calls scsi_abort_command() (if no
> .eh_timed_out() callback has been defined by the LLD). It is the responsibility
> of the SCSI LLD to call .scsi_done() before its .eh_abort_handler() returns
> SUCCESS. If .eh_abort_handler() returns a value other than SUCCESS then the
> SCSI core will escalate the error further until .scsi_done() has been called for
> the command that timed out. See also scsi_abort_eh_cmnd(). So I think what you
> wrote is not correct for the SCSI core and a properly implemented SCSI LLD. 

Once blk-mq's blk_mq_check_expired calls blk_mark_rq_complete, an
LLD calling blk_mq_complete_request does absolutely nothing because
REQ_ATOM_COMPLETE is already set.

There's nothing stopping scsi_mq_done from running at the same time as
blk-mq's timeout handler.

It doesn't matter what path .scsi_done is called now. That will just
call scsi_mq_done -> blk_mq_complete_request, and since
REQ_ATOM_COMPLETE is already set, the command won't be completed.

The only way to complete that request now is if the timeout
handler returns BLK_EH_HANDLED, but the scsi-mq abort path returns
BLK_EH_NOT_HANDLED on success (very few drivers actually return
BLK_EH_HANDLED).

After the timeout handler runs, it's once again possible for the driver to
complete the request if it returned BLK_EH_RESET_TIMER, but if the driver
already completed the command during the timeout handler, how is the
driver supposed to know it needs to complete the request a second time?
