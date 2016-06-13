Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38414 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965086AbcFMIUF (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 13 Jun 2016 04:20:05 -0400
Date: Mon, 13 Jun 2016 01:20:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, axboe@fb.com, sitsofe@yahoo.com,
	snitzer@redhat.com, hch@infradead.org, Kernel-team@fb.com
Subject: Re: [PATCH V2] block: correctly fallback for zeroout
Message-ID: <20160613082001.GA27508@infradead.org>
References: <20160606223357.GA52883@shli-mbp.local>
 <yq18tydiyuf.fsf@sermon.lab.mkp.net>
 <20160610025435.GA48899@shli-mbp.local>
 <yq1shwkfq9z.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1shwkfq9z.fsf@sermon.lab.mkp.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 10, 2016 at 09:49:44PM -0400, Martin K. Petersen wrote:
> >> What does the extra io_err buy us? Just have this function return an
> >> error. And then in blkdev_issue_discard if you get -EOPNOTSUPP you
> >> special case it there.
> 
> Shaohua> The __blkdev_issue_discard returns -EOPNOTSUPP if disk doesn't
> Shaohua> support discard.  in that case, blkdev_issue_discard doesn't
> Shaohua> return 0. blkdev_issue_discard only returns 0 if IO error is
> Shaohua> -EOPNOTSUPP.
> 
> Oh, I see. The sanity checks are now in __blkdev_issue_discard() so
> there is no way to distinguish between -EOPNOTSUPP and the other
> -EOPNOTSUPP. *sigh*

We can move the sanity checks out.  Or even better get rid of the
stupid behavior of ignoring the late -EOPNOTSUPP in this low level
helper and instead leaving it to the caller(s) that care.  So far
the DM test suite seems to be the only one that does.

> I am OK with your patch as a stable fix but this really needs to be
> fixed up properly.

And I'd much prefer to get this right now.  It's not like this is
recently introduced behavior.
