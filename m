Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:51340 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbcFXHBA (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 24 Jun 2016 03:01:00 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: shli@fb.com, martin.petersen@oracle.com, snitzer@redhat.com,
	sitsofe@yahoo.com, linux-block@vger.kernel.org
Subject: zeroout fixes
Date: Fri, 24 Jun 2016 09:00:49 +0200
Message-Id: <1466751651-9900-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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

