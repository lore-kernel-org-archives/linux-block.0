Return-Path: <hch@lst.de>
Date: Thu, 24 Aug 2017 10:41:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH for-next] block: Fix left-over bi_bdev usage
Message-ID: <20170824084133.GA19313@lst.de>
References: <1503531955-2626-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503531955-2626-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 23, 2017 at 07:45:55PM -0400, Keith Busch wrote:
> The bi_bdev field was replaced with the gendisk. This patch just fixes
> an omission.

Thanks Keith.  I'm pretty sure I fixed exactly this one when
rebasing from my nvme tree to the block tree.  But I guess I didn't
finish the rebase fully, as usual - git rebase considered harmful :)


Acked-by: Christoph Hellwig <hch@lst.de>
