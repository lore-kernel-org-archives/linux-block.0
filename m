Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35782 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932422AbcFNSgO (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 14:36:14 -0400
Date: Tue, 14 Jun 2016 14:36:12 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, axboe@fb.com, sitsofe@yahoo.com,
	Kernel-team@fb.com
Subject: Re: [PATCH V2] block: correctly fallback for zeroout
Message-ID: <20160614183612.GB26196@redhat.com>
References: <20160606223357.GA52883@shli-mbp.local>
 <yq18tydiyuf.fsf@sermon.lab.mkp.net>
 <20160610025435.GA48899@shli-mbp.local>
 <yq1shwkfq9z.fsf@sermon.lab.mkp.net>
 <20160613082001.GA27508@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160613082001.GA27508@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 13 2016 at  4:20am -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Jun 10, 2016 at 09:49:44PM -0400, Martin K. Petersen wrote:
> > >> What does the extra io_err buy us? Just have this function return an
> > >> error. And then in blkdev_issue_discard if you get -EOPNOTSUPP you
> > >> special case it there.
> > 
> > Shaohua> The __blkdev_issue_discard returns -EOPNOTSUPP if disk doesn't
> > Shaohua> support discard.  in that case, blkdev_issue_discard doesn't
> > Shaohua> return 0. blkdev_issue_discard only returns 0 if IO error is
> > Shaohua> -EOPNOTSUPP.
> > 
> > Oh, I see. The sanity checks are now in __blkdev_issue_discard() so
> > there is no way to distinguish between -EOPNOTSUPP and the other
> > -EOPNOTSUPP. *sigh*
> 
> We can move the sanity checks out.  Or even better get rid of the
> stupid behavior of ignoring the late -EOPNOTSUPP in this low level
> helper and instead leaving it to the caller(s) that care.

I'm not onboard with blkdev_issue_discard() no longer masking the late
return of -EOPNOTSUPP.

I'd be fine with moving the early -EOPNOTSUPP checks and the masking of
late -EOPNOTSUPP out to blkdev_issue_discard().  But to be clear,
the masking of late -EOPNOTSUPP return is there for stacking drivers
like MD and DM.  So long as the upper level ioctl code, filesystems, etc
makes use of blkdev_issue_discard() then they'll still get the benefit
of that masking.

drivers/md/dm-thin.c is now using the new async __blkdev_issue_discard()
and it'll only ever do so to a device it knows supports discards -- BUT
it could be that the DM thin-pool's data device is itself a stacked
device that doesn't uniformly support discards throughout its entire
logical address space.  So it could issue a discard to a portion of the
stacked data device that will return -EOPNOTSUPP.. so long story short:
making this change to remove this so-called "stupid behaviour" will
require code like drivers/md/dm-thin.c:issue_discard(() to check the
return from __blkdev_issue_discard() and if it is -EOPNOTSUPP then it
should return 0.

> So far the DM test suite seems to be the only one that does.

The device-mapper-test-suite was only ever relying on
blkdev_issue_discard()'s early return of -EOPNOTSUPP.

> > I am OK with your patch as a stable fix but this really needs to be
> > fixed up properly.
> 
> And I'd much prefer to get this right now.  It's not like this is
> recently introduced behavior.

We need to sequence the fixes such that stable kernels get the zeroout
fallback fixed.  Right?  Not sure if that is a goal of shli's though..

In 4.7-rc, where you introduced __blkdev_issue_discard and I made
dm-thin.c consume it, I'm fine with seeing __blkdev_issue_discard stop
masking -EOPNOTSUPP... but at the same time that change is made
dm-thin.c would need to be fixed (in the same commit as the interface
change).  Though I'm now missing what lifting the -EOPNOTSUPP behavior
into blkdev_issue_discard() buys us... maybe purity of the new async
__blkdev_issue_discard()?

Mike
