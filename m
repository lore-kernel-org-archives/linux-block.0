Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65067C4646C
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCD0206DD
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MgpOZDQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfFYCq2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 22:46:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51033 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbfFYCq2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 22:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561430789; x=1592966789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oQYTRRb4w7hg1e0SdjKzlTX0Gjm46D514gz8bl+y+aA=;
  b=MgpOZDQqh1+oivw8s8aXHR6fCywjL0P60FY2JP8rOEDd76WiU7JBV6RY
   Qernn2iU5zEhQAtsoBn2SNho0s/5czX1r9D8To3G/omjLQjoO0AuyzvVa
   XGWDTlxBQInhIVgr1IM7LToP35EukQqfiVocWfPYC/m7nkfMaWzFgdzT5
   shf1S3TPg8gapCGMtEqsjJkc6yIKlG6kA8vpJ0i1olrHhJxhNOa3osv2e
   lIyOb8vkOemRmWnojhPaMeCEDpG21w4Td0M69nb9+aRJ1iX9knY5gCdih
   d1wVwA76+nBuP9rRCK3jJDt75XtRIJO41Wrt7FEStWVNofZ0W60Q/lZDn
   g==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; 
   d="scan'208";a="112654037"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 10:46:28 +0800
IronPort-SDR: gZwptn6SYaogOGWg5mug86EHFZUaHPZ+XXDUAPvPLtIZNUsT4qvXUkeq0GP5uy2rO2WtfJ3R/G
 bMmZk9BDpJlC8Cs6ThqTyutCwzkK0+TKp05Kb39v1yRHxUXAKpnJ2lxbTxuztRCuCyoV07up4t
 NsaVEp7Oi6uEpxxaCyHzAis4fBXjr4/mlRgwSRk9qmXBfH74gDF/gXMPDiKB6cKU7gr+X5csOU
 gnk48TFfvMqj7lejacotxxcjtDjoXmlvQyGqUqr7rFYzDZkTi6s4vo03BFwthmGZjGAaVElkh5
 Lz/Qa6+d1tWCz1v6LQQz2OpI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 24 Jun 2019 19:45:45 -0700
IronPort-SDR: ZxB01YmPsaiImBCl+TUFfap8Et9tixPw4umy1n0o/B9GU5icNVQq0VYR4PyasY3g+SUt1/rDUT
 mqwzJXEFLS+YWaKofIXdmRI+7y0SiaDMro29i22IkNdK74C6hBYXWceZUTLcTAGRHslx81braI
 NTPURWcrXkhUm2P0GWTMnNd7cw0Z9VE6zQz6LNZkbArjt3BtkjZW+b+ElJ0grJEeWEV2C/GU7E
 GfU7igE6pRdaraYVUOmSZNy8Mlo+cTo0uN3lQxPzOzQ/lordNTBU7OZSfiUwSiuRJja1XQukXt
 gNw=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jun 2019 19:46:26 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Fix zone revalidation memory allocation failures
Date:   Tue, 25 Jun 2019 11:46:22 +0900
Message-Id: <20190625024625.23976-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series addresses a reccuring problem with zone revalidation
failures observed during extensive testing with memory constrained
system and device hot-plugging.

The problem source is failure to allocate large memory areas with
alloc_pages() or kmalloc() in blk_revalidate_disk_zones() to store the
disk array of zones (struct blk_zone) or in sd_zbc_report_zones() for
the report zones command reply buffer.

The solution proposed here is to:
1) limit the number of zones to be reported with a single report zones
command execution, and
2) Use vmalloc to allocate large-ish arrays and buffers in place of
alloc_pages() and kmalloc().

With these changes, tests do not show any zone revalidation failures
while not impacting the time taken for a disk initial zone inspection
during device scan.

Damien Le Moal (3):
  block: Allow mapping of vmalloc-ed buffers
  sd_zbc: Fix report zones buffer allocation
  block: Limit zone array allocation size

 block/bio.c            |  8 ++++-
 block/blk-zoned.c      | 29 +++++++---------
 drivers/scsi/sd_zbc.c  | 79 +++++++++++++++++++++++++++++++-----------
 include/linux/blkdev.h |  5 +++
 4 files changed, 84 insertions(+), 37 deletions(-)

-- 
2.21.0

