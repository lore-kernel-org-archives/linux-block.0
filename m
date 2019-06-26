Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5379DC4646B
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 06:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2C32086D
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 06:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GXbcMQsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfFZGyk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:54:40 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6026 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfFZGyk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 02:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561532080; x=1593068080;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VjPtlQWr2bVvdjjQrZMbY+ggJbJGwrhxsb9X5zAbrdI=;
  b=GXbcMQsNt4Pn4k90RtT+S2kr0+qlk0AIQ7mwp5B0P//E2GIfQbBw0d17
   R+4anyBqBpUo/MFG7nbDCPSi6PZ+iwW5uxzMV8D+t0UYiQCE9g21xqA7a
   JgAM6QDfvxZrmoiFEAOVFBLyuTFoogjoUiIUQiZbLQcS+EILru3EJ5qIK
   ZmPncVrjbvROo2wmtNmCk0Re/v2VkOzC4gocyPS8Yz3/vrtcE6Z16R2iU
   9hNIWqSD5+c1AifLPErV17+hPdTelDd6n/zQf87wjJVWjRd62o3TSlyCX
   cuY7B0lW1VuGlS/OFxMs6ws+FKKKy6iHJ4W8aSyMJnZooSWW0QCCttyjr
   g==;
X-IronPort-AV: E=Sophos;i="5.63,418,1557158400"; 
   d="scan'208";a="113191693"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 14:54:40 +0800
IronPort-SDR: 88JKszEKCcvVQUThmT70Wb1grZmXBS1yBvoWGcMiC+XDsWkOTwUuHm3Z710deYNbMVI5wfCAts
 nX+6a3NWXSSfQtS7ehDiOVFMSPN7vNEac2atDpFNESBE+9VL0x8IWKHPq3vRusX8juZHR0Y5TA
 yWZVxgnvSV0/IPQzuJBWJAjjg7e4P40om2tmWy3Da8bi5laHRFuasrWiDxo6CkWO4WjcRaJ5gw
 tHjNxLwqqksDD1xmiWwHlkqcsspablCRsh2rv3QH/lIj/nWHM8x0ZPatGOCpbPyFjChPGDS2T/
 RuNtcHGXBmBeq/wXoTQkpPDi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 25 Jun 2019 23:53:55 -0700
IronPort-SDR: Vi5DOIY1r9yq46nUB0QobE78vW63GOiSPUoFUiG6Pao0hY5rUPUldJgR9DTUwktXfX1EBkad7d
 OYdgf90f5ag4WQbLBdUzy6R4PKZewF6e4Wdq+Ft44MlNTzPyw9dVvp0PayioNo3fd6R2+BA3il
 TN1BL64RowN1mPQIFTgiM79qFuN5AZuSI/ZEzh4SO9UFSrHe8enQ1cKcm9HiiH+AyHuqsEd1gc
 MyU1AhjgodYeUXBlzzdBCB1tzM2hRgUgUfFoe+HLpMNR4wbMvqQTWxNBWg9y4L4xNY4hVRm9Wc
 0VM=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2019 23:54:39 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V3 0/3] Fix zone revalidation memory allocation failures
Date:   Wed, 26 Jun 2019 15:54:35 +0900
Message-Id: <20190626065438.19307-1-damien.lemoal@wdc.com>
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

Changes from v2:
* Move invalidate_kernel_vmap_range() of vmalloc-ed buffer to sd_zbc.c
  in patch 2, after completion of scsi_execute_req().
* In patch 2, add flush_kernel_vmap_range() before scsi_execute_req().

Changes from V1:
* Added call to invalidate_kernel_vmap_range() for vmalloc-ed buffers
  in patch 1.
* Fixed patch 2 compilation error with Sparc64 (kbuild robot)

Damien Le Moal (3):
  block: Allow mapping of vmalloc-ed buffers
  sd_zbc: Fix report zones buffer allocation
  block: Limit zone array allocation size

 block/bio.c            |  8 +++-
 block/blk-zoned.c      | 29 +++++++-------
 drivers/scsi/sd_zbc.c  | 88 ++++++++++++++++++++++++++++++++----------
 include/linux/blkdev.h |  5 +++
 4 files changed, 92 insertions(+), 38 deletions(-)

-- 
2.21.0

