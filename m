Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:34182 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbcFOCb3 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 22:31:29 -0400
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, axboe@fb.com, sitsofe@yahoo.com,
	Kernel-team@fb.com
Subject: Re: [PATCH V2] block: correctly fallback for zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20160606223357.GA52883@shli-mbp.local>
	<yq18tydiyuf.fsf@sermon.lab.mkp.net>
	<20160610025435.GA48899@shli-mbp.local>
	<yq1shwkfq9z.fsf@sermon.lab.mkp.net>
	<20160613082001.GA27508@infradead.org>
	<20160614183612.GB26196@redhat.com>
Date: Tue, 14 Jun 2016 22:30:50 -0400
In-Reply-To: <20160614183612.GB26196@redhat.com> (Mike Snitzer's message of
	"Tue, 14 Jun 2016 14:36:12 -0400")
Message-ID: <yq17fdrb2ud.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Mike" == Mike Snitzer <snitzer@redhat.com> writes:

Mike,

Mike> so long story short: making this change to remove this so-called
Mike> "stupid behaviour" will require code like
Mike> drivers/md/dm-thin.c:issue_discard(() to check the return from
Mike> __blkdev_issue_discard() and if it is -EOPNOTSUPP then it should
Mike> return 0.

Yes, please.

The original -EOPNOTSUPP equals success is a remnant from the days where
discards were only a hint. And sadly that policy got encoded in the
actual interface instead of being left up to the caller.

Now the world has moved on. And reliable zeroout behavior, the SCSI
target drivers and other kernel users need an interface that tells them
exactly what happened at the bottom of the stack so they in turn can
provide a deterministic result (including partial block zeroing) to
their clients.

It's imperative that this gets fixed up. And instead of perpetuating a
weird interface that returns success on failure, let's fix DM and the
callers that actually check the return of blkdev_issue_discard() so they
do the right thing.

I really don't understand why you are objecting so much to this. It's a
trivial change that may not directly benefit DM but it helps everybody
else. And it cleans up a library call that's confusing, error prone and
goes against the very grain of how all our kernel interfaces work in
general.

-- 
Martin K. Petersen	Oracle Linux Engineering
