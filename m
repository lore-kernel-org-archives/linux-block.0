Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:29865 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbcF2FDu (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 29 Jun 2016 01:03:50 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, shli@fb.com, martin.petersen@oracle.com,
	snitzer@redhat.com, sitsofe@yahoo.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: introduce BLKDEV_DISCARD_ZERO to fix zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1466751651-9900-1-git-send-email-hch@lst.de>
	<1466751651-9900-2-git-send-email-hch@lst.de>
Date: Wed, 29 Jun 2016 01:03:38 -0400
In-Reply-To: <1466751651-9900-2-git-send-email-hch@lst.de> (Christoph
	Hellwig's message of "Fri, 24 Jun 2016 09:00:50 +0200")
Message-ID: <yq1k2h8si1h.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> Currently blkdev_issue_zeroout cascades down from discards
Christoph> (if the driver guarantees that discards zero data), to WRITE
Christoph> SAME and then to a loop writing zeroes.  Unfortunately we
Christoph> ignore run-time EOPNOTSUPP errors in the block layer
Christoph> blkdev_issue_discard helper to work around DM volumes that
Christoph> may have mixed discard support underneath.

Christoph> This patch intoroduces a new BLKDEV_DISCARD_ZERO flag to
Christoph> blkdev_issue_discard that indicates we are called for zeroing
Christoph> operation.  This allows both to ignore the EOPNOTSUPP hack
Christoph> and actually consolidating the discard_zeroes_data check into
Christoph> the function.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
