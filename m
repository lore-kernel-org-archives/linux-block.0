Return-Path: <lars.ellenberg@linbit.com>
Return-Path: <lars.ellenberg@linbit.com>
Date: Thu, 30 Mar 2017 14:50:34 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com, dm-devel@redhat.com,
	linux-raid@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 22/23] drbd: implement REQ_OP_WRITE_ZEROES
Message-ID: <20170330125034.GJ5939@soda.linbit>
References: <20170323143341.31549-1-hch@lst.de>
 <20170323143341.31549-23-hch@lst.de>
 <20170330100641.GI5939@soda.linbit>
 <20170330114408.GA15777@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170330114408.GA15777@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 30, 2017 at 01:44:09PM +0200, Christoph Hellwig wrote:
> On Thu, Mar 30, 2017 at 12:06:41PM +0200, Lars Ellenberg wrote:
> > On Thu, Mar 23, 2017 at 10:33:40AM -0400, Christoph Hellwig wrote:
> > > It seems like DRBD assumes its on the wire TRIM request always zeroes data.
> > > Use that fact to implement REQ_OP_WRITE_ZEROES.
> > > 
> > > XXX: will need a careful audit from the drbd team!
> > 
> > Thanks, this one looks ok to me.
> 
> So the DRBD protocol requires the TRIM operation to always zero?

"users" (both as in submitting entities, and people using DRBD)
expect that DRBD guarantees replicas to be identical after whatever
operations have been completed by all replicas.

Which means that for trim/discard/unmap, we can only expose that to
upper layers (or use it for internal purposes) if the operation has
a well defined, and on all backends identical, result.

Short answer: Yes.

> > The real question for me is, will the previous one (21/23)
> > return != 0 (some EOPNOTSUPP or else) to DRBD in more situations than
> > what we have now?
> 
> No, blkdev_issue_zeroout should never return -EOPNOTSUPP.
> 
> > Will it make an fstrim cause thinly provisioned
> > devices to suddenly be fully allocated?
> 
> Not for SCSI devices.  Yes for dm-thinp until it implements
> REQ_OP_WRITE_ZEROES, which will hopefully be soon.

"good enough for me" ;-)

Thanks,

    Lars
