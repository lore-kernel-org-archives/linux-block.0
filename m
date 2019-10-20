Return-Path: <SRS0=V/uB=YN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A6CA9EA0
	for <linux-block@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA71621D80
	for <linux-block@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ol9T6Dk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfJTXm0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Oct 2019 19:42:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54880 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfJTXmZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Oct 2019 19:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571614946; x=1603150946;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=fSVJJZwvKl0netpa4sdM1YaY5nLWMEfZVkbALuqt6NI=;
  b=Ol9T6Dk7ybYJZabjhtYliEAWrSaZwxwZ4SA89VLWZhxFHx12XACC/Ru5
   At9bvbq4/u5fRcUQfhXYRcRufeaYc60CMPUe6IOVZG4JpPxYYxNlxhDBY
   bbSJ+uyHU//AYOIeSXxCD4XchH10habxyasVFlgFg7EAjEo5BjHfVno7E
   GVwz5q3fG/LMTRB+6GpuHAqrm08dBWeWWHIA/pC+mNl78uWlmk+OC2ys2
   Out7nN6y6JetR1CzeoIj+8BOF9ayY6EVmzufUReX/SE3TFhsiDVAsm4IG
   ByE7iSFdPASjPwiNWyW/0uL2tvUttt17+Wh918JeB7chWWh+cPOKePlB6
   w==;
IronPort-SDR: BO4UsbGUNgA2kU+/F3PCOlGouuPN0AB1rLo7JDnKvCGSAK1Am49o0LbA2iIvakJ+JphPC9bdup
 ZXoEKGMMsra5/RrGOknKNIi3R9+RAw1UQyh11JjDWEfcCOpt+TQmY5EUn4UmRJQFlylUdhtasQ
 S06zNpR+aofVKR55sAcV++Q9gUI1TP+dLSYARFXSWDEDDceQ8y+CqvONUKX/cr4r6OO7P0Ks93
 CoD6NQbF32xjpEO8U8SF7/MB1KPOn0FXldynrwI6gSIrWuDGy6E6BytURcLYA3xrEC9yXu5oN0
 84I=
X-IronPort-AV: E=Sophos;i="5.67,321,1566835200"; 
   d="scan'208";a="121710478"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2019 07:42:26 +0800
IronPort-SDR: KyeAnxZ7pT1aA8+moI9H6UO7PbfOW7nC3uDMU9/oGUK8k/7jwh2H24XhUO2UXIgoNVx5UfDT9L
 rKvX79j1qDhKf/X9uDZCjLxV/s4QYTULXjXrgSiJa0BWmPIflUMNKZUfQ/L3Nj5dg4JUrfhd0D
 ESQx2njJdpRGCWoCyaPBCnrLSo/UURtC/QovyqV+EcT903uKkivqxJj9IXqOoyDQHEYJMQkjLL
 SHGdZa5fikNYFB+8ueuyT3Wnx9NEoBDTFcpmbv4PyEN7wcr85hEhRIpqZ6MYZxNgEIRnjo+0aS
 z1hR/PyPGnF4Qs9udHRZNfKG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 16:37:59 -0700
IronPort-SDR: Ceu8fhDANrmFJUSTsSY8AgnkZRsn6qXkvVH6juAb8/yiCz+jbBlAATUiIT2zPQz0qAWSYlUYUd
 McD+cHNzbgN5hKmA4lPPxx8mn+SSdObzDt5Ef3TDTHQAmJrPJ7Abc82h2zqHG1Hf78zXO/MG+C
 nn1XS/bK+Yf2cK0EaxuzHmm1stbX7tsddwoUqZQDGa3cee/INPhMb+mIICdXFWqsr0kE+ZpZ0m
 8+WZADVM/DuQVn9vxX2HVsmXdaRaUWEk7TCFsxx6XaU3ZAdCAShNL+dlNqDnx1AP3q5wU8RqiW
 X+w=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Oct 2019 16:42:24 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] nvme: Introduce nvme_block_sect()
Date:   Mon, 21 Oct 2019 08:42:20 +0900
Message-Id: <20191020234220.14888-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020234220.14888-1-damien.lemoal@wdc.com>
References: <20191020234220.14888-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the new helper function nvme_block_sect() to convert a device
logical block number to a 512B sector number. Use this new helper in
obvious places, cleaning up the code.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/host/core.c | 14 +++++++-------
 drivers/nvme/host/nvme.h |  8 ++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca77..1945c18d4b62 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1647,7 +1647,7 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 
 static void nvme_set_chunk_size(struct nvme_ns *ns)
 {
-	u32 chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));
+	u32 chunk_size = nvme_block_sect(ns, ns->noiob);
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
+					   nvme_block_sect(ns, max_blocks));
 }
 
 static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
@@ -1748,7 +1748,7 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	sector_t capacity = le64_to_cpu(id->nsze) << (ns->lba_shift - 9);
+	sector_t capacity = nvme_block_sect(ns, le64_to_cpu(id->nsze));
 	unsigned short bs = 1 << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a979b62ea4b2..c629a37bc778 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -427,6 +427,14 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 	return sector >> (ns->lba_shift - SECTOR_SHIFT);
 }
 
+/*
+ * Convert a logical block number to a 512B sector number.
+ */
+static inline sector_t nvme_block_sect(struct nvme_ns *ns, u64 lba)
+{
+	return lba << (ns->lba_shift - SECTOR_SHIFT);
+}
+
 static inline void nvme_end_request(struct request *req, __le16 status,
 		union nvme_result result)
 {
-- 
2.21.0

