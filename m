Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2D7C5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 05:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CDF2089F
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 05:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Diqm30Kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfGAFJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:09:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:62457 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfGAFJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 01:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561957762; x=1593493762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qEEVG/GleY2IhHFbty0HJ0pJ2y5UIrI3mATRE7IF8Kc=;
  b=Diqm30Kcm7OGqNleARBRbibBtLzPGtoaDRrI4n9TlPDG3I6qELRo78b4
   uiy5eFw1z8mDMkMqQRwBMOJOf9XLifo98WJLC6qkMvVerhOnfwvCRl4t0
   Rn6zwV8qrt/BaszfE+kLHkudulUm1LBQO72m4BrE1clq4DECqB93Nfxmp
   MGSraM2GPnxWmFzHeMLCZtlR2lOA3ARylmEV0vYCaigEGYUw9TIj4RFZn
   DrNaB5mw97u1GBlRa1umZ9KgTyAtbbYcebH+3fV1mnajaNP1AMfBnDtCQ
   QMkkhrkTYC+izXo+LLfEi6mdvG95ShRlHicJm+I7IGtq0XEUyznmd+mzj
   A==;
X-IronPort-AV: E=Sophos;i="5.63,437,1557158400"; 
   d="scan'208";a="116777198"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2019 13:09:21 +0800
IronPort-SDR: OV7gG71o6gvIvME3VhUkOaUege/B4XGH5Hw4O0rFX61N1H8JUpnN0TWM55NUuOqCd6hODn1En2
 fI5rc+tTdhd04wzT4UwQftdKrD3Y1lQ/zOnH7w8Ms/UIt5P2T7ujmJDGqi+2MkiRASoCYjn+CF
 RYDLKKEB0JPH9RO9NSfLuSZpGvBdIEIvJsp9pxRh4a1Krt3NGNY8M6k1UzhlIMbKBxWFn2vmjB
 CfL2K1zKl3M87uYu7ju7A0VBxY/8TDjNKh43lj/yx0Eb/5aSvFP+BY2Mr+Lg+9/2d0jLqdpMlv
 Uzo1gtMd+WsozwG7zL4V+YNa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Jun 2019 22:08:25 -0700
IronPort-SDR: 5Q1/wtgNC7LQxTyrkYhLPNIik4AI54eskNVOntHzv7mffxKlteo9NrYKdCUn8bKYhw4isvZJ5g
 SPdVCloutID4n2c79mxSiUfb8JH8Z2Rket2Ka84Uno0LYrzN3jOtW/sXX6u8cp6ZTjGVry6aiJ
 Gc/2K7ZuhS/EQ4B35E28wEXte+jOZls35SdbunSPMbrjyus3Emt6VMM9Dakm7MbdAcItebyKxU
 qCXawUZNo+M7LvMfE8Mz4LdqTlekC2voQqegup+Sjma7hhN3izjmqYYrdmvhMeP/iTKRhZj74/
 KSU=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2019 22:09:19 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V6 0/4] Fix zone revalidation memory allocation failures
Date:   Mon,  1 Jul 2019 14:09:14 +0900
Message-Id: <20190701050918.27511-1-damien.lemoal@wdc.com>
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

Changes from v5:
* Remove the gfp_t argument from blkdev_report_zones() function and
  device report zones method, relying instead on
  memalloc_noio_save/restore() where GFP_NOIO was used.

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

Damien Le Moal (4):
  block: Allow mapping of vmalloc-ed buffers
  block: Kill gfp_t argument of blkdev_report_zones()
  sd_zbc: Fix report zones buffer allocation
  block: Limit zone array allocation size

 block/bio.c                    |  28 ++++++++-
 block/blk-zoned.c              |  67 +++++++++++---------
 drivers/block/null_blk.h       |   3 +-
 drivers/block/null_blk_zoned.c |   3 +-
 drivers/md/dm-flakey.c         |   5 +-
 drivers/md/dm-linear.c         |   5 +-
 drivers/md/dm-zoned-metadata.c |  16 +++--
 drivers/md/dm.c                |   6 +-
 drivers/scsi/sd.h              |   3 +-
 drivers/scsi/sd_zbc.c          | 108 +++++++++++++++++++++++----------
 fs/f2fs/super.c                |   4 +-
 include/linux/blkdev.h         |  10 ++-
 include/linux/device-mapper.h  |   3 +-
 13 files changed, 172 insertions(+), 89 deletions(-)

-- 
2.21.0

