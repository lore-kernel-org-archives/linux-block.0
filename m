Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E612C48BD6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 09:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E78420815
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 09:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HAurZVzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfF0J3r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:29:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13113 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0J3r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 05:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561627786; x=1593163786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d0tYtK7vudhZyD4L09P8fkQ18yATEivI05m+fQi8yGY=;
  b=HAurZVzYeac3VVnchxxpIfN2sPEey+GKj2Tz7x3wwn2NNlom7cjo/rmk
   axiXXMjDFXxMigvn6yvdHMF8xvDmgq4NhGpyP5VWzclwVAynIiNenPo7E
   CtviA6BFhyHtVKZgOTgYw9tgh4mR3h6O0XfBXVND8g7XmJaeEHoQlMZ31
   rL1iAUSrmnykQmYT/Vek/pBlULwbNysg9LSMSf5A26qek45gNrGEy8V5Q
   XevgnjpC1YbaQyW+KfnGWC8qLFJwrZNu1O7NyTl2PgyqhwWP5xtphIxj5
   9v9uMUIOAoCiqh6RaHHHAM+rk/HO5wPEkWgtOCHqgvnEmGTbERZsm/PJx
   A==;
X-IronPort-AV: E=Sophos;i="5.63,423,1557158400"; 
   d="scan'208";a="116545294"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 17:29:46 +0800
IronPort-SDR: Sr/3r/47QY8/XIvPcOmX1KqALZm5An/kAw5tSdGN28btPb8/KYTf6EWgn7DsVL8g3K11vYbGq9
 kGIk45V7mS+leFFLMSEAA8VgoxQoB9Q/1j4WRO8v/di4DWW0oAlbKu780r1SKjycM/Rx/czLws
 H9i1kAF/d/KsFhiznuwybsENRFALSUcF/jBz2U4faK2t+eOC3fs0jDNvzSWTFK9HTCF7aJsbHP
 PW60Y1f+L3Jmx2JpAOJUCgz2xyZchFLUyncm7plRBvN4/l9T3elL6fpSCHl68gNFW1us7av9NM
 Weq0qdDM0hzL4mPuQ+ldUMgS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 27 Jun 2019 02:28:53 -0700
IronPort-SDR: DDKDQDa+LwB4fBEwo933WrtHRUoBMZsdqpfblSycgdAFfi4LeXwGlOWWddXQzgAPowWWn4ha/c
 N6cOSjgiRScuOyKW6kt+HqC2ILbV4F+iWuHnF6VTZeK4ottr6CCAtDlysg1gOnpaFSu3qdWEgK
 +L+2OP4Z4w/3rzJPDVWV8P5kOw9WXFFgv6iAQgyPa4d/aM/iJvaUiW8VD2rff2mMRl3R/tDtOk
 KSd5XFWvQa+d6+7YfhwYPPU4IQOcswdPKk+dcZrZN+z4/c/yPcn4Q7bvjNPVNJZDIuRiJjv3b3
 sS0=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jun 2019 02:29:45 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V5 0/3] Fix zone revalidation memory allocation failures
Date:   Thu, 27 Jun 2019 18:29:41 +0900
Message-Id: <20190627092944.20957-1-damien.lemoal@wdc.com>
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
alloc_pages() or kmalloc().

With these changes, tests do not show any zone revalidation failures
while not impacting the time taken for a disk zone inspection during
device scan and revalidation.

Changes from v4:
* bio_copy_kern does not use the vmalloc buffer for IO so does not
  need flush/invalidate_kernel_vmap_range() of the buffer.

Changes from v3:
* Reworked use of flush_kernel_vmap_range() and
  invalidate_kernel_vmap_range() to contain the calls within bio.c,
  transparently to the user of bio_map_kern().
* Add similar support to bio_copy_kern().

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

 block/bio.c            | 29 ++++++++++++++-
 block/blk-zoned.c      | 29 +++++++--------
 drivers/scsi/sd_zbc.c  | 83 +++++++++++++++++++++++++++++++-----------
 include/linux/blkdev.h |  5 +++
 4 files changed, 108 insertions(+), 38 deletions(-)

-- 
2.21.0

