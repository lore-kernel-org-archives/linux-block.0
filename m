Return-Path: <BATV+a6fbff1bfc78a84bb09b+4713+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: shli@fb.com,
	martin.petersen@oracle.com,
	snitzer@redhat.com,
	sitsofe@yahoo.com,
	linux-block@vger.kernel.org
Subject: resend: zeroout fixes
Date: Tue, 19 Jul 2016 11:23:32 +0200
Message-Id: <1468920214-32400-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The first one is a repost of my BLKDEV_DISCARD_ZERO with the spelling
fixes suggest from Martin, the second one just drops the -EOPNOTSUPP
special casing in blkdev_issue_write_same.

Note that the patches are against the block for-next tree, and
unfortunately we have diverged significantly from 4.7 in this area:
4.7 has the missing bio_put for the sumbmit_bio_wait callers, and
4.8 has the various req_op changes, including a new calling
convention for __blkdev_issue_zeroout.  I'm not sure how to best
sort this mess out, but I really think we need the bio_put in the
for-4.8 tree as well, and we should probably bring the changed
__blkdev_issue_discard calling convention into 4.7 as well.
Suggestion for how to best handle this?

Compared to the last posting on June 24th this just adds the Reviewed-by:
tags from Martin.
