Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:22660 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbcFVCCX (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 21 Jun 2016 22:02:23 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, axboe@fb.com,
	shli@fb.com, snitzer@redhat.com, sitsofe@yahoo.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: introduce BLKDEV_DISCARD_ZERO to fix zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1466418523-22552-1-git-send-email-hch@lst.de>
	<yq1r3br5q25.fsf@sermon.lab.mkp.net> <20160621124059.GC1689@lst.de>
Date: Tue, 21 Jun 2016 22:02:10 -0400
In-Reply-To: <20160621124059.GC1689@lst.de> (Christoph Hellwig's message of
	"Tue, 21 Jun 2016 14:40:59 +0200")
Message-ID: <yq1shw62d7h.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph,

>> I like this better than the I/O error tracking approach. The
>> blkdev_issue_write_same() -EOPNOTSUPP regression is still present,
>> though.

Christoph> Which one?  Can't think of how that has anything to do with
Christoph> blkdev_issue_discard.

In 9082e87bfbf8 ("block: remove struct bio_batch") you changed the error
return for blkdev_issue_write_same() to look like the one for discard:

-	if (bb.error)
-		return bb.error;
-	return ret;
+	if (bio)
+		ret = submit_bio_wait(REQ_WRITE | REQ_WRITE_SAME, bio);
+	return ret != -EOPNOTSUPP ? ret : 0;

It's not a problem for SCSI since I'd be returning -EREMOTEIO. But if a
stacking driver returns -EOPNOTSUPP in response to a WRITE SAME request
we'll get data corruption.

-- 
Martin K. Petersen	Oracle Linux Engineering
