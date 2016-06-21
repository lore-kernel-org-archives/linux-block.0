Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46974 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbcFUMtQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 21 Jun 2016 08:49:16 -0400
Date: Tue, 21 Jun 2016 14:40:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, shli@fb.com,
	snitzer@redhat.com, sitsofe@yahoo.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: introduce BLKDEV_DISCARD_ZERO to fix zeroout
Message-ID: <20160621124059.GC1689@lst.de>
References: <1466418523-22552-1-git-send-email-hch@lst.de> <yq1r3br5q25.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1r3br5q25.fsf@sermon.lab.mkp.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 20, 2016 at 08:44:02PM -0400, Martin K. Petersen wrote:
> Christoph> operation.  This allows both to ignore the EOPNOTSUPP hack
> Christoph> and actually consolidating the discard_zeroes_data check into
> Christoph> the function.
> 
> I like this better than the I/O error tracking approach. The
> blkdev_issue_write_same() -EOPNOTSUPP regression is still present,
> though.

Which one?  Can't think of how that has anything to do with
blkdev_issue_discard.
