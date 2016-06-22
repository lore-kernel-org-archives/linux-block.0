Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:34276 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcFVNyk (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 22 Jun 2016 09:54:40 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, axboe@fb.com,
	shli@fb.com, snitzer@redhat.com, sitsofe@yahoo.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: introduce BLKDEV_DISCARD_ZERO to fix zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1466418523-22552-1-git-send-email-hch@lst.de>
	<yq1r3br5q25.fsf@sermon.lab.mkp.net> <20160621124059.GC1689@lst.de>
	<yq1shw62d7h.fsf@sermon.lab.mkp.net> <20160622075217.GA31610@lst.de>
Date: Wed, 22 Jun 2016 09:53:04 -0400
In-Reply-To: <20160622075217.GA31610@lst.de> (Christoph Hellwig's message of
	"Wed, 22 Jun 2016 09:52:17 +0200")
Message-ID: <yq1h9cl1gan.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph,

Christoph> Unlike discard outside the zeroout path, write same is a data
Christoph> integrity operation.  Just like in the zero out case turning
Christoph> an EOPNOTSUPP into 0 will get you data corruption, as the
Christoph> caller will see a successful return for an operation that did
Christoph> not actually write data to disk.

Exactly. So why add the dreaded -EOPNOTSUPP special casing to
blkdev_issue_write_same()?

Christoph> Re stacking drivers and discard / write same: why does
Christoph> blk_set_stacking_limits set discard_zeroes_data to 1 and
Christoph> max_write_same_sectors to UINT_MAX?  These seem like
Christoph> inherently dangerous defaults.

It's just shorthand for "stacking driver does not impose any limits, use
whatever the low-level device sets".

If the stacking driver has an actual constraint it is free to set a
different limit prior to calling the stacking function.

-- 
Martin K. Petersen	Oracle Linux Engineering
