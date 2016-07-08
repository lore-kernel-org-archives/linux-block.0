Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35605 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501AbcGHJgZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 8 Jul 2016 05:36:25 -0400
Date: Fri, 8 Jul 2016 11:36:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: shli@fb.com, martin.petersen@oracle.com, snitzer@redhat.com,
	sitsofe@yahoo.com, linux-block@vger.kernel.org
Subject: Re: zeroout fixes
Message-ID: <20160708093621.GA8682@lst.de>
References: <1466751651-9900-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466751651-9900-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 24, 2016 at 09:00:49AM +0200, Christoph Hellwig wrote:
> Note that the patches are against the block for-next tree, and
> unfortunately we have diverged significantly from 4.7 in this area:
> 4.7 has the missing bio_put for the sumbmit_bio_wait callers, and
> 4.8 has the various req_op changes, including a new calling
> convention for __blkdev_issue_zeroout.  I'm not sure how to best
> sort this mess out, but I really think we need the bio_put in the
> for-4.8 tree as well, and we should probably bring the changed
> __blkdev_issue_discard calling convention into 4.7 as well.
> Suggestion for how to best handle this?

Jens, any idea how to make forward progress on this issue?  Just
apply to 4.8 and then backport to stable?
