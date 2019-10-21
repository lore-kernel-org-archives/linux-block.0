Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC88CA9EAB
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 03:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F1521897
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 03:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qy4W5rDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfJUDkJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Oct 2019 23:40:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24472 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfJUDkJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Oct 2019 23:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571629209; x=1603165209;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=J7WyRvqo3UbXsXANJ9cqX0+tOb31i78YTA41A9CQYN8=;
  b=qy4W5rDo58A5RpvwEiGIjK5DHibU9JQwkF2IGPhaHhZxgY9HY6G5njm+
   Vd4m9Z5zCrcy6ftvh3XLputXBUMn9ndt3hidYTzLa2hgh6zuprvjmPQOt
   uRDHrrtrzeyFg4CEQTPgJX3wsXOqPNpI3nnO+gOST6+xAF29l4OjGaakN
   GV50bhJTXVMnkZLx6mUUmbuWHoSXukVt4ZXHYZGDRf45oKm03gs1SPtgh
   s14ivh87LdtgCuk62lKYjYdu4Ev5yIjXnyFk5qPfjq4KRlHw4gfnkFuNN
   5q5CiFjv7vhmjeyD6dNzcWb9pmBgxKLRtS+qCqRkPhGgNFS/lYWgGpUqB
   Q==;
IronPort-SDR: h3ORiyqH8+N0X7+ZW5I481gTPrXKhOpWBzYIkZtuiud9P4oq1Jo46mhUkOT4ydf79wKA6ZxtM/
 XuOr+yy0PyTDASd5v+2UXiwE46jkLeGLRESWEFgQxNmbpoexAK7gi75bmRG8OEvnLpNWkB8lBN
 9hWa9O0oRqeoL8per8G1LTSV+sAX0+sIEo0pSEkgouvkiVIIBwp9X5Z/AAOidovYbL0eThvDOv
 1aFBjBV6dBCEbwsBHt4N9h7zg4BgFXS+ssaGxYuOKEw8p6NjEtQjRDlDtYW+Sw4xEJ/uSTJAWq
 cqg=
X-IronPort-AV: E=Sophos;i="5.67,322,1566835200"; 
   d="scan'208";a="122530393"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2019 11:40:09 +0800
IronPort-SDR: Z8CjCSduSH6qUzqRMhtUbby8kk6eQCO8GN0ALDS13fL7duRqYQ+ekDKlOk9KTxpzTeA4Rw+I4K
 aJStNAGiI1lCJ0uYh4EZeb2OxtI867HgxcLNq3LJGGnY4p1265NoY9hHguEsBnFsqF8tJOSWqL
 4C2E0X8MKk1Pd7uxhqFWxuK9NSM7iH5FUnF/193gAZjwClVT5+4lG537zr5621kvOqUyoZU2yM
 JInY/VrJPg7sb07U0mK2vuptGzKs5hmqASn9Sjabo144gwjnVqrFNza8KdAmf0Gfmzo/eWK433
 qlJoZOSZ08U2oC7Nnj4cS1CC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 20:35:49 -0700
IronPort-SDR: mVFWyiIr1h+YcihDMA8WL/6VmOwWPzeOG9OOCtDBWXwpzhoxHeRJDeUoX95Iuxl5zJD3VyijaV
 HaWYpW4XDPLqLDY6cjhm5yd/fpD2YVVGnZaUXl38Vmq0j88VFoZ3CkVFZ7aMxea59ZVSSvrHH7
 VmU9LhNvRzeI0L8HpOPrXgKT7OOrfb/Nf0reduJisDAB6snBiRsdA5v+xqqfvhLpBkUTbQviLg
 WH0bNWyIjdeG0FVpkZrv31/hlM7wnlGh3a5GbZSPR5zU8ctZSXNLTYirTYxcFr5DT7rNvIxqMM
 rxQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Oct 2019 20:40:08 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2 v2] nvme: Introduce nvme_lba_to_sect()
Date:   Mon, 21 Oct 2019 12:40:04 +0900
Message-Id: <20191021034004.11063-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021034004.11063-1-damien.lemoal@wdc.com>
References: <20191021034004.11063-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the new helper function nvme_lba_to_sect() to convert a device
logical block number to a 512B sector number. Use this new helper in
obvious places, cleaning up the code.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/host/core.c | 14 +++++++-------
 drivers/nvme/host/nvme.h |  8 ++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6b37103b31d9..5a5d83dd9689 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1647,7 +1647,7 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 
 static void nvme_set_chunk_size(struct nvme_ns *ns)
 {
-	u32 chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));
+	u32 chunk_size = nvme_lba_to_sect(ns, ns->noiob);
 	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
 }
 
@@ -1684,8 +1684,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 
 static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 {
-	u32 max_sectors;
-	unsigned short bs = 1 << ns->lba_shift;
+	u64 max_blocks;
 
 	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
 	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
@@ -1701,11 +1700,12 @@ static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 	 * nvme_init_identify() if available.
 	 */
 	if (ns->ctrl->max_hw_sectors == UINT_MAX)
-		max_sectors = ((u32)(USHRT_MAX + 1) * bs) >> 9;
+		max_blocks = (u64)USHRT_MAX + 1;
 	else
-		max_sectors = ((u32)(ns->ctrl->max_hw_sectors + 1) * bs) >> 9;
+		max_blocks = ns->ctrl->max_hw_sectors + 1;
 
-	blk_queue_max_write_zeroes_sectors(disk->queue, max_sectors);
+	blk_queue_max_write_zeroes_sectors(disk->queue,
+					   nvme_lba_to_sect(ns, max_blocks));
 }
 
 static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
@@ -1748,7 +1748,7 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	sector_t capacity = le64_to_cpu(id->nsze) << (ns->lba_shift - 9);
+	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
 	unsigned short bs = 1 << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 617ee8512f91..837ca66a7e33 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -427,6 +427,14 @@ static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
 	return sector >> (ns->lba_shift - SECTOR_SHIFT);
 }
 
+/*
+ * Convert a device logical block number to a 512B sector number.
+ */
+static inline sector_t nvme_lba_to_sect(struct nvme_ns *ns, u64 lba)
+{
+	return lba << (ns->lba_shift - SECTOR_SHIFT);
+}
+
 static inline void nvme_end_request(struct request *req, __le16 status,
 		union nvme_result result)
 {
-- 
2.21.0

