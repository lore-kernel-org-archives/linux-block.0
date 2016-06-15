Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51747 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932465AbcFOCkE (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 22:40:04 -0400
Date: Tue, 14 Jun 2016 22:40:02 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Shaohua Li <shli@fb.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com, sitsofe@yahoo.com, Kernel-team@fb.com
Subject: Re: [PATCH V2] block: correctly fallback for zeroout
Message-ID: <20160615024002.GD5443@redhat.com>
References: <20160606223357.GA52883@shli-mbp.local>
 <yq18tydiyuf.fsf@sermon.lab.mkp.net>
 <20160610025435.GA48899@shli-mbp.local>
 <yq1shwkfq9z.fsf@sermon.lab.mkp.net>
 <20160613082001.GA27508@infradead.org>
 <20160614183612.GB26196@redhat.com>
 <yq17fdrb2ud.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq17fdrb2ud.fsf@sermon.lab.mkp.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 14 2016 at 10:30pm -0400,
Martin K. Petersen <martin.petersen@oracle.com> wrote:

> >>>>> "Mike" == Mike Snitzer <snitzer@redhat.com> writes:
> 
> Mike,
> 
> Mike> so long story short: making this change to remove this so-called
> Mike> "stupid behaviour" will require code like
> Mike> drivers/md/dm-thin.c:issue_discard(() to check the return from
> Mike> __blkdev_issue_discard() and if it is -EOPNOTSUPP then it should
> Mike> return 0.
> 
> Yes, please.
> 
> The original -EOPNOTSUPP equals success is a remnant from the days where
> discards were only a hint. And sadly that policy got encoded in the
> actual interface instead of being left up to the caller.
> 
> Now the world has moved on. And reliable zeroout behavior, the SCSI
> target drivers and other kernel users need an interface that tells them
> exactly what happened at the bottom of the stack so they in turn can
> provide a deterministic result (including partial block zeroing) to
> their clients.
> 
> It's imperative that this gets fixed up. And instead of perpetuating a
> weird interface that returns success on failure, let's fix DM and the
> callers that actually check the return of blkdev_issue_discard() so they
> do the right thing.
> 
> I really don't understand why you are objecting so much to this. It's a
> trivial change that may not directly benefit DM but it helps everybody
> else. And it cleans up a library call that's confusing, error prone and
> goes against the very grain of how all our kernel interfaces work in
> general.

I've been consistently objecting to changing the blkdev_issue_discard()
interface.  Fixing the async __blkdev_issue_discard() to offer
unfiltered return values is perfectly fine by me.

But the ship has sailed on the blkdev_issue_discard() interface.
