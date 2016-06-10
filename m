Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:50406 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbcFJBiJ (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2016 21:38:09 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, mchristi@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: add a separate operation type for secure erase
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1465480836-32093-1-git-send-email-hch@lst.de>
	<1465480836-32093-3-git-send-email-hch@lst.de>
Date: Thu, 09 Jun 2016 21:37:59 -0400
In-Reply-To: <1465480836-32093-3-git-send-email-hch@lst.de> (Christoph
	Hellwig's message of "Thu, 9 Jun 2016 16:00:36 +0200")
Message-ID: <yq1d1npj020.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> Instead of overloading the discard support with the
Christoph> REQ_SECURE flag.  Use the opportunity to rename the queue
Christoph> flag as well, and remove the dead checks for this flag in the
Christoph> RAID 1 and RAID 10 drivers that don't claim support for
Christoph> secure erase.

Great! That flag has always bothered me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
