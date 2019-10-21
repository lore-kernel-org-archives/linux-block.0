Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B6FCA9EAC
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 03:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3C62190F
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 03:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yq7cOU7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfJUDkH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Oct 2019 23:40:07 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24472 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfJUDkH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Oct 2019 23:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571629207; x=1603165207;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=au0G1pgDW3DNrrjgUkL/ruIzQrmyLurQUvshjXvhijI=;
  b=Yq7cOU7gZCP9aZXUKXroMl6vMKCAa2L0OkyewPUTYOFUeWHXW53jU2hk
   DjnFYvAqL7ydGEYLFJ7ZUPEZ4geNoTAq7cD6v192UJG3mZwoTCrZ09A9/
   467VlvtAEN49uUp018QdCYZkCcOcU8Nf08z5FIAkDdiD+kVr6vqVom/eA
   AAGDhVv0fCTWnSC5dI3m7aY7DXQyk6VEpF+U5IJfK0bRElYZwWOgIQv2U
   kmN8y5hx7rBpLBzaqOU8+4IrkiOZ41K1VD+Oujyrhm2nZh4/uR8a1AiFM
   OP5BKshBn4QzgCO4e6BGvcFuVV84JuIuDaJt/3OYS/MNeA/X5p1Se3kqC
   A==;
IronPort-SDR: B1t1zYlzA3FxDgkFGxNd0667QNMAZCydPsF99rmW9Z3k74yw6o4qBazVvDH6yXL1a+4IrLexi1
 U7PJ1NVXLCdIhsR2CkscgoW8qb2xkCpPmEsILyj2OaDlzu93ULPFNbgXk+gQAjEEEYJF5+Ds57
 lSQRNiM45gEngo+DzXfIYv2ErC/PkSLsrTGw8M3MqZAegFiYh9jE9yDf1SxsE0zGa3AT7LJNVE
 07PY/ulHv/SWeq5Z16+8gQ8BwGEA6oFfuQXdYWtEiyqh9BUUku4zzgVvbCi97PXNmiJqB30vwh
 Hz8=
X-IronPort-AV: E=Sophos;i="5.67,322,1566835200"; 
   d="scan'208";a="122530388"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2019 11:40:07 +0800
IronPort-SDR: 5GgSSwIwPAPflLsLjjvF8XAqZ/ddYrbr4DHJIYANBtKzLuuePIcnp5Pm0I8Kg3k1vgG8M95cDE
 qT+VAUupjSmlSSxz3Rel0J5K5mcYhE9YIQ8p3X66PbFoBOibpfHNvELkFMNDu5RD1de0fZnsZZ
 HX5YdoV/qvMU0z4kOAVtt083na1iejGShMejsTtbTSZcV285zTmw9S/A/EX7LN15nXNA7Mesvp
 foQqn1c+A6eyhoTjceS8WAsCel07/K4cIBJHdM5TkO2ayEq0dPbBfxlB4W9OCIwGIo6U1mSbmG
 Qk5FQkjVVufglCn344OAKire
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 20:35:47 -0700
IronPort-SDR: Nj6qZn5E5glP1BejzB1k/G8skpZczsP6tHtKg+U/i9x/C8ptI0fe7EnNDDhyS3Unea7peaIQfG
 Ix+8hBpwU+apVdH0uKbOEPz8VScSbHelHCOdmHU9HZ9d4mWhnOq0sdHgjIQwpsxrp7gw2QWE/w
 fJ9tGNIeJwxEWwabIeJA9thYQ5dSv9h6G6YScDUagUcdtNCdhY9hIqK7o9xdKQtxiIhU0ZjKCt
 T1/+vQ6HeORjt7aTw9nV6BsLJJ9KztINt0YJFZBhxwnQE6tTQEdsoCXWdsVv6T+gbVQnSHeMGz
 1I0=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Oct 2019 20:40:07 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2 v2] nvme: Cleanup and rename nvme_block_nr()
Date:   Mon, 21 Oct 2019 12:40:03 +0900
Message-Id: <20191021034004.11063-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021034004.11063-1-damien.lemoal@wdc.com>
References: <20191021034004.11063-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rename nvme_block_nr() to nvme_sect_to_lba() and use SECTOR_SHIFT
instead of its hard coded value 9. Also add a comment to decribe this
helper.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/nvme.h | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca77..6b37103b31d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -626,7 +626,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	}
 
 	__rq_for_each_bio(bio, req) {
-		u64 slba = nvme_block_nr(ns, bio->bi_iter.bi_sector);
+		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
 		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
 
 		if (n < segments) {
@@ -667,7 +667,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
 	cmnd->write_zeroes.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->write_zeroes.slba =
-		cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 	cmnd->write_zeroes.control = 0;
@@ -691,7 +691,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
-	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
 	if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 22e8401352c2..617ee8512f91 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -419,9 +419,12 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
 }
 
-static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
+/*
+ * Convert a 512B sector number to a device logical block number.
+ */
+static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
 {
-	return (sector >> (ns->lba_shift - 9));
+	return sector >> (ns->lba_shift - SECTOR_SHIFT);
 }
 
 static inline void nvme_end_request(struct request *req, __le16 status,
-- 
2.21.0

