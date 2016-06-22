Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:52170 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbcFVOFS (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 22 Jun 2016 10:05:18 -0400
Date: Wed, 22 Jun 2016 16:04:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, shli@fb.com,
	snitzer@redhat.com, sitsofe@yahoo.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: introduce BLKDEV_DISCARD_ZERO to fix zeroout
Message-ID: <20160622140441.GA9484@lst.de>
References: <1466418523-22552-1-git-send-email-hch@lst.de> <yq1r3br5q25.fsf@sermon.lab.mkp.net> <20160621124059.GC1689@lst.de> <yq1shw62d7h.fsf@sermon.lab.mkp.net> <20160622075217.GA31610@lst.de> <yq1h9cl1gan.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1h9cl1gan.fsf@sermon.lab.mkp.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 22, 2016 at 09:53:04AM -0400, Martin K. Petersen wrote:
> >>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:
> 
> Christoph,
> 
> Christoph> Unlike discard outside the zeroout path, write same is a data
> Christoph> integrity operation.  Just like in the zero out case turning
> Christoph> an EOPNOTSUPP into 0 will get you data corruption, as the
> Christoph> caller will see a successful return for an operation that did
> Christoph> not actually write data to disk.
> 
> Exactly. So why add the dreaded -EOPNOTSUPP special casing to
> blkdev_issue_write_same()?

This is a leftover from bio_batch_end_io and not new behavior.  But
I agree that we should kill it.

