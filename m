Return-Path: <msnitzer@redhat.com>
Date: Mon, 27 Mar 2017 10:03:07 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, agk@redhat.com, shli@kernel.org,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
	dm-devel@redhat.com, linux-raid@vger.kernel.org
Subject: Re: RFC: always use REQ_OP_WRITE_ZEROES for zeroing offload
Message-ID: <20170327140307.GA13020@redhat.com>
References: <20170323143341.31549-1-hch@lst.de>
 <20170323155410.GD1138@soda.linbit>
 <20170327091056.GB6879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170327091056.GB6879@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 27 2017 at  5:10am -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> It sounds like you don't want to support traditional discard at all,
> but only WRITE ZEROES.  So in many ways this series is the right way
> forward.  It would be nice if we could do a full blown
> REQ_OP_WRITE_ZEROES for dm_think that zeroes out partial blocks,
> similar to what hardware that implements WRITE SAME of zeroes
> or WRITE ZEROES would do.  I'll see if I could include that in my
> series.

By "you" I assume you're referring to Lars?  Lars' approach for discard,
when drbd is layered on dm-thinp, feels over-engineered.  Not his fault,
the way discard and zeroing got conflated certainly lends itself to
these ugly hacks.  SO I do appreciate that for anything to leverage
discard_zeroes_data it needs to be reliable.  Which runs counter to how
discard was implemented (discard may get silently dropped!)  But that is
why dm-thinp doesn't advertise dzd.  Anyway...

As for the blkdev_issue_zeroout() resorting to manually zeroing the
range, if the discard fails or dzd not supported, that certainly
requires DM thinp to implement manual zeroing of the head and tail of
the range if partial blocks are being zeroed.  So I welcome any advances
there.  It is probably something that is best left to Joe or myself to
tackle.  But I'll gladly accept patches ;)
