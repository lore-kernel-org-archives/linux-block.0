Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:30003 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbcF2FEO (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 29 Jun 2016 01:04:14 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, shli@fb.com, martin.petersen@oracle.com,
	snitzer@redhat.com, sitsofe@yahoo.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: don't ignore -EOPNOTSUPP blkdev_issue_write_same
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1466751651-9900-1-git-send-email-hch@lst.de>
	<1466751651-9900-3-git-send-email-hch@lst.de>
Date: Wed, 29 Jun 2016 01:04:02 -0400
In-Reply-To: <1466751651-9900-3-git-send-email-hch@lst.de> (Christoph
	Hellwig's message of "Fri, 24 Jun 2016 09:00:51 +0200")
Message-ID: <yq1furwsi0t.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> WRITE SAME is a data integrity operation and we can't simply
Christoph> ignore errors.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
