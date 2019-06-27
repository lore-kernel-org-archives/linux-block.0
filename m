Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E436BC48BD3
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 02:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D60216E3
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 02:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="khTcvIHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfF0CtN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:49:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34994 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfF0CtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 22:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561603752; x=1593139752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E0hftjpsF+Kau0lGhV8j+bPXbIbWwoKJzrqW74jtxtE=;
  b=khTcvIHLfMCVLzwG1ee2y1D8Uq36+WdoOKbh9kjpYqcqaQXl3AZF5vqc
   S4YZyFAFtDIi+WQSLTJ2NE+TwDxC6rS0YV4loqCdGoKldQC+W/kzEJEj+
   vI4Av0HMK45vjH+wWwtrDjjDi2fR9CxJyDvsqmd00GZDNP8Oxw1Ux2yEA
   NTUBDx9mRvQQpZ44wzPmLeJUW78lDBs4k+UR9vxv0+gdhp7a8sIznUDxA
   PY6hkC50W43BGXmzCoH46CXMlal0kS/xF7R/ZKL96Bt8z83IkK6wTP7YN
   n404BEDvxoLa4cxG30Q0zhyQZuxNToTm9dmodeLvCxwfkFlZO/0Z1BQoj
   g==;
X-IronPort-AV: E=Sophos;i="5.63,422,1557158400"; 
   d="scan'208";a="218022024"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 10:49:11 +0800
IronPort-SDR: /+A0qUZw4sEPySWSRUGbfX87WlPZL84ApO2CecYTwoPy53Doqnqlc7NNzks2AtUSImz9k5z1oy
 SIRMWo+QQshFeuqlheFUcrWRMvIjhMJ9GI6RJMFx698Enx27VqoVJupV9GjyXKuoQr9XYVLXKl
 LUEJtUE1hvRPWF6Xu5Jx9baro5RVnmJ9mdoEM922gChtBfFbxgybwABiR+kvZj0+/anu/anNu/
 W4HfueNlo6fHmUjrJi2SOIhT8sIBk20KOF4CI4bz8FXqbjzJNLcsj6KgqXmLgQ0QsdbfmXMiGb
 62dQsFADeFhn433hRr/ve+Yp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jun 2019 19:48:20 -0700
IronPort-SDR: 16n8vWYVWNzHhnxF8f5OkL82zZYTsytQY3GffVNo7kPkI9P2vrwl8nleWo+tUuZbnslJKQEBhY
 eZNCbJA9uPHBaiSXx+N6NKVp2GRehNJOTBwHysGgj5LMULaCCzXJRfNBCR0tb9x05heqb+O3Bu
 Y3PrdSTUrosngpkvSTv27TR3hVv1d6Awp9WiykvH2NpQ9CG1OL3/YLejlaRmKmDtfd7RGVG34x
 ZEszuAmN2mflH+/N8ZndLH31JE9jJ+jJdXgxqi2wY3mHQsH/aiSOLGGcwjkTAZUlfYoY6eQkpe
 HQA=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2019 19:49:11 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V4 0/3] Fix zone revalidation memory allocation failures
Date:   Thu, 27 Jun 2019 11:49:07 +0900
Message-Id: <20190627024910.23987-1-damien.lemoal@wdc.com>
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

 block/bio.c            | 43 +++++++++++++++++++++-
 block/blk-zoned.c      | 29 +++++++--------
 drivers/scsi/sd_zbc.c  | 83 +++++++++++++++++++++++++++++++-----------
 include/linux/blkdev.h |  5 +++
 4 files changed, 122 insertions(+), 38 deletions(-)

-- 
2.21.0

