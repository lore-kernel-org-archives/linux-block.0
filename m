Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:27615 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbcHLBeN (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 11 Aug 2016 21:34:13 -0400
To: tom.ty89@gmail.com
Cc: tj@kernel.org, shaun.tancheff@seagate.com, shaun@tancheff.com,
	martin.petersen@oracle.com, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC] libata-scsi: make sure Maximum Write Same Length is not too large
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <833713246c1a70d85150289c1537797d6f7dd606.1470903899.git.tom.ty89@gmail.com>
Date: Thu, 11 Aug 2016 21:34:02 -0400
In-Reply-To: <833713246c1a70d85150289c1537797d6f7dd606.1470903899.git.tom.ty89@gmail.com>
	(tom's message of "Thu, 11 Aug 2016 16:26:39 +0800")
Message-ID: <yq1r39upy7p.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Tom," == tom ty89 <tom.ty89@gmail.com> writes:

Tom,

+		put_unaligned_be64(65535 * ATA_MAX_TRIM_RNUM /
+				   (sector_size / 512), &rbuf[36]);

MAXIMUM WRITE SAME LENGTH is in units of the device's logical block
size.

-- 
Martin K. Petersen	Oracle Linux Engineering
