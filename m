Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F5BC433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 01:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4218820575
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 01:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HoSPDKVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgENByz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 21:54:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56139 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgENByz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 21:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589421295; x=1620957295;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FT614p2Mr2ld8RdigBzkgb23b4eSYDETSYuA+u1mXj4=;
  b=HoSPDKVMFgV/DOHtMq5BrYUMvs2EgLXuKNtbTShiR5NiBynFq9UckkWK
   ObKFdJq7BrM/WiexwBwXMU7d1En6jLOtKiF/YE9XPXGOACWdLwMtq/xvH
   3iSPDmrAmnHHQ4uDGySGRNUTffxb1QffDhHpsX1CS563l60sjgX6SA8xH
   NcZUL40cKOChkdvkh30oGBIUfOXPI5c9Kv25c08evZXoFqS79+A+sI2zE
   xbXDB9Ny0tsJjuUa/6/Ecxdjzd202CfyKjzjEKqU+0y2n/FlNg6F2l8qK
   Puhv4P/d+VBLbd5iIOagY2Wi6f9+AgGV65uiAMzi0i8hFiPgx8ySL2A7M
   A==;
IronPort-SDR: snRSBDYXizN6owDe4FAj5dRbVl+EXh01A5PGu3X5nMir2PUYqwEzAabiczqFD55zReHCcxg7A3
 jVT/qgNv5JQpYkLodrPo/eoYfZ5xRlQENF4fecM3CcBOHElMo6ada48t5Moz3xA81Gvz7kTU70
 PCnSju3ExstVLnjS47V26fcJCQkvkLt5+G0UX89kh5D/YK4pCtCP/ECauxGKnK/MWqwtlG8Bo/
 mGg2PQIlzivAWW39UI0GzTw/HUkKfbq539Gatel3XwOE3EtQUaCk3Is33Jb7BhKF6Al51ZJJsq
 My8=
X-IronPort-AV: E=Sophos;i="5.73,389,1583164800"; 
   d="scan'208";a="137968820"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2020 09:54:54 +0800
IronPort-SDR: ojavWbh6hs6JTvAxRln1Gi53bo/G+zkg4C6p+QrOYDqzNdVSDMNcyTzsWSK6k2O85gnNLrd2vi
 1KL3lJPJxbU/nMv1CyNUu12+j2wX5hU14=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 18:45:08 -0700
IronPort-SDR: u3k/r/TOEVBK18KRUYuCnZBw4SprEq9lP2aNofssrfaxiYngjeRhIv/VO7N1Hr+PTlZxWLGnqd
 +IDtlPmXBfGw==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 May 2020 18:54:53 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nvme: Fix io_opt limit setting
Date:   Thu, 14 May 2020 10:54:52 +0900
Message-Id: <20200514015452.1055278-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, a namespace io_opt queue limit is set by default to the
physical sector size of the namespace and to the the write optimal
size (NOWS) when the namespace reports this value. This causes problems
with block limits stacking in blk_stack_limits() when a namespace block
device is combined with an HDD which generally do not report any optimal
transfer size (io_opt limit is 0). The code:

/* Optimal I/O a multiple of the physical block size? */
if (t->io_opt & (t->physical_block_size - 1)) {
	t->io_opt = 0;
	t->misaligned = 1;
	ret = -1;
}

results in blk_stack_limits() to return an error when the combined
devices have different but compatible physical sector sizes (e.g. 512B
sector SSD with 4KB sector disks).

Fix this by not setting the optiomal IO size limit if the namespace does
not report an optimal write size value.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3c037f5a9ba..0729173053ed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1809,7 +1809,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 {
 	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
 	unsigned short bs = 1 << ns->lba_shift;
-	u32 atomic_bs, phys_bs, io_opt;
+	u32 atomic_bs, phys_bs, io_opt = 0;
 
 	if (ns->lba_shift > PAGE_SHIFT) {
 		/* unsupported block size, set capacity to 0 later */
@@ -1832,12 +1832,11 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		atomic_bs = bs;
 	}
 	phys_bs = bs;
-	io_opt = bs;
 	if (id->nsfeat & (1 << 4)) {
 		/* NPWG = Namespace Preferred Write Granularity */
 		phys_bs *= 1 + le16_to_cpu(id->npwg);
 		/* NOWS = Namespace Optimal Write Size */
-		io_opt *= 1 + le16_to_cpu(id->nows);
+		io_opt = bs * (1 + le16_to_cpu(id->nows));
 	}
 
 	blk_queue_logical_block_size(disk->queue, bs);
@@ -1848,7 +1847,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 */
 	blk_queue_physical_block_size(disk->queue, min(phys_bs, atomic_bs));
 	blk_queue_io_min(disk->queue, phys_bs);
-	blk_queue_io_opt(disk->queue, io_opt);
+	if (io_opt)
+		blk_queue_io_opt(disk->queue, io_opt);
 
 	if (ns->ms && !ns->ext &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-- 
2.25.4

