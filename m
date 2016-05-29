Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49476 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbcE2Gra (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Sun, 29 May 2016 02:47:30 -0400
Date: Sat, 28 May 2016 23:47:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	sitsofe@yahoo.com, snitzer@redhat.com, axboe@fb.com,
	martin.petersen@oracle.com, Kernel-team@fb.com
Subject: Re: [PATCH] block: correctly fallback for zeroout
Message-ID: <20160529064728.GA14383@infradead.org>
References: <20160526180813.GA49039@shli-mbp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160526180813.GA49039@shli-mbp.local>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 26, 2016 at 11:08:14AM -0700, Shaohua Li wrote:
> -int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> -		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags)
> +static int do_blkdev_issue_discard(struct block_device *bdev, sector_t sector,

We've split blkdev_issue_discard into __blkdev_issue_discard and a small
wrapper around in for 4.7, so this will need a bit of an update.

As part of that I also removed the strange EOPNOTSUPP ignore, but Mike
reverted it just because it changed something in the dm testsuite.

I still believe we should never ignore it in this helper, and only
do so in callers that believe it's the right thing.
