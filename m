Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:34931 "EHLO
	userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbcFUB4b (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 20 Jun 2016 21:56:31 -0400
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u5L0jPXt032136
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-block@vger.kernel.org>; Tue, 21 Jun 2016 00:45:25 GMT
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, shli@fb.com, martin.petersen@oracle.com,
	snitzer@redhat.com, sitsofe@yahoo.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: introduce BLKDEV_DISCARD_ZERO to fix zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1466418523-22552-1-git-send-email-hch@lst.de>
Date: Mon, 20 Jun 2016 20:44:02 -0400
In-Reply-To: <1466418523-22552-1-git-send-email-hch@lst.de> (Christoph
	Hellwig's message of "Mon, 20 Jun 2016 12:28:43 +0200")
Message-ID: <yq1r3br5q25.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> Currently blkdev_issue_zeroout cascades down from discards
Christoph> (if the driver gurantees that discards zero data), to WRITE

guarantees

Christoph> SAME and then to a loop writing zeroes.  Unfortunately we
Christoph> ignore tun-time EOPNOTSUPP errors in the block layer

run-time

Christoph> blkdev_issue_discard helper to work around DM volumes that
Christoph> may have mixed discard support underneath.

Christoph> This path intoroduces a new BLKDEV_DISCARD_ZERO flag to

patch introduces

Christoph> blkdev_issue_discard that indicates we are called for zeroing
Christoph> operation.  This allows both to ignore the EOPNOTSUPP hack
Christoph> and actually consolidating the discard_zeroes_data check into
Christoph> the function.

I like this better than the I/O error tracking approach. The
blkdev_issue_write_same() -EOPNOTSUPP regression is still present,
though.

-- 
Martin K. Petersen	Oracle Linux Engineering
