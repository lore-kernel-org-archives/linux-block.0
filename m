Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CEFC10F0E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 12:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455FA2183E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 12:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="cKxvqjIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbfDRMCV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:02:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35980 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388686AbfDRMCU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 08:02:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id u17so1438193lfi.3
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2019 05:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FikUPCget4rCaml8RT6XEIQkfGsDs/ATScRSNZkQyRc=;
        b=cKxvqjIJiQa1Hlch2oWm38fmC/fJr9XVuO6xJNcwEvasQbtkNEBNh4FnzOkxEHfMiX
         d3I45cPsEAqLX/AePOK7GY1MV9mLzDYDUJik+pE0Dh45puXFp08qcKkeY08Rk2bVgSg9
         lDYVGVsHQfg6aTJq7LOeUAZI1lmEooa90vloX35cnhxR8Z3zFUbr5pGJUm4P/Uft6bOq
         +d+t678178JZ2j/ZmggUDqDwJMnT2MiUSL8xY6RDJNVW1TcT/wGWccPo7OEtrsICfbf7
         BlzdOsop4k/GqVholx+kb7AuqPM9iyaiKHO2rSRPuqc6eTFyxDyvPLLakMYeq2yPh4Mj
         Z1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FikUPCget4rCaml8RT6XEIQkfGsDs/ATScRSNZkQyRc=;
        b=GNAVx8GHe3FpUbaIHT+aHX9mmht8W4G9O3xyzqW10rH07N6AOwL4a2hGImQzkaIipr
         n9Gu1ZX8kTwxeyoFQcKYLvVW8Z5f3emG/9eIoz92z9IZr1VYU2pQEdq2tIQuFJj6iYjM
         OAFzHpjb/oHuRlfD9AXno+0/8crlyUzkP9OkGeaWeAvFu1Z+RBf6Ho/E/+61RWjnFxs3
         7qEx1g2o4S8CCM4mUBvQ54lrfV51DFv4i5HoyKEE9jUmOMrjE8wi1EQ/fBZB3Nxzjhz+
         pY3BA1VoD+mmpxJiT36BRq+vLwyG4lwgNiR6M5V1j7+n7X2IPWj28daAtNrY556KgD6Q
         UPjA==
X-Gm-Message-State: APjAAAVEzcz+MWlTVyyGDKfs77R8vKRIkvv7KyPc8KG7n6gquZ5K3YjH
        FL7PDXIKlWIfdBu0afvjk06CIQ==
X-Google-Smtp-Source: APXvYqzBGLgfMi6Qpk7Zc3z57NHnNDVEaP2XePHSGHfMUGWDsttkB2amOKt5BclGcKzRhFEU5C+YbQ==
X-Received: by 2002:a19:f24c:: with SMTP id d12mr3311398lfk.163.1555588934110;
        Thu, 18 Apr 2019 05:02:14 -0700 (PDT)
Received: from titan.bredbandsbolaget.se (c-bebee655.03-91-6d6c6d4.bbcust.telenor.se. [85.230.190.190])
        by smtp.gmail.com with ESMTPSA id l16sm409659lfk.44.2019.04.18.05.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Apr 2019 05:02:13 -0700 (PDT)
From:   hans@owltronix.com
To:     =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Igor Konopko <igor.j.konopko@intel.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Klaus Jensen <klaus.jensen@cnexlabs.com>,
        Simon Lund <slund@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [RFC PATCH 1/1] lightnvm: add lzbd - a zoned block device target
Date:   Thu, 18 Apr 2019 14:01:25 +0200
Message-Id: <1555588885-22546-2-git-send-email-hans@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555588885-22546-1-git-send-email-hans@owltronix.com>
References: <1555588885-22546-1-git-send-email-hans@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Introduce a new target: lzbd - LightNVM Zoned Block Device

The new target makes it possible to expose an
Open-Channel 2.0 SSD as one or more zoned block devices.

See Documentation/lightnvm/lzbd.txt for more information.

Experimental in its present state of implementation.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 Documentation/lightnvm/lzbd.txt | 122 +++++++++++
 drivers/lightnvm/Kconfig        |  11 +
 drivers/lightnvm/Makefile       |   3 +
 drivers/lightnvm/lzbd-io.c      | 342 +++++++++++++++++++++++++++++++
 drivers/lightnvm/lzbd-target.c  | 392 +++++++++++++++++++++++++++++++++++
 drivers/lightnvm/lzbd-user.c    | 310 ++++++++++++++++++++++++++++
 drivers/lightnvm/lzbd-zone.c    | 444 ++++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/lzbd.h         | 139 +++++++++++++
 8 files changed, 1763 insertions(+)
 create mode 100644 Documentation/lightnvm/lzbd.txt
 create mode 100644 drivers/lightnvm/lzbd-io.c
 create mode 100644 drivers/lightnvm/lzbd-target.c
 create mode 100644 drivers/lightnvm/lzbd-user.c
 create mode 100644 drivers/lightnvm/lzbd-zone.c
 create mode 100644 drivers/lightnvm/lzbd.h

diff --git a/Documentation/lightnvm/lzbd.txt b/Documentation/lightnvm/lzbd.txt
new file mode 100644
index 000000000000..8bdbc01a25be
--- /dev/null
+++ b/Documentation/lightnvm/lzbd.txt
@@ -0,0 +1,122 @@
+lzbd: A Zoned Block Device LightNVM Target
+==========================================
+
+The lzbd lightnvm target makes it possible to expose an Open-Channel 2.0 SSD
+as one or more zoned block devices.
+
+Each lightnvm target is assigned a range of parallel units. Parallel units(PUs)
+are not shared among targets avoiding I/O QoS disturbances between targets as
+far as possible.
+
+For more information on lightnvm, see [1]
+For more information on Open-Channel 2.0, see [2].
+For more information on zoned block devices see [3].
+
+lzbd is designed to act as a slim adaptor, making it possible to plug
+OCSSD 2.0 SSDs into the zone block device ecosystem.
+
+lzbd manages zone to chunk mapping, read/write restrictions,  wear leveling
+and write errors.
+
+Zone geometry
+-------------
+
+From a user perspective, lzbd targets form a number of sequential-write-required
+(BLK_ZONE_TYPE_SEQWRITE_REQ) zones.
+
+Not all of the target's capacity is exposed to the user.
+Some chunks are reserved for metadata and over-provisioning.
+
+The zones follow the same constraints as described in [3].
+
+All zones are of the same size (SZ).
+
+Simple example:
+
+Sector	 		Zone type
+		 _______________________
+0    -->	| Sequential write req. |
+		|                       |
+		|_______________________|
+SZ   -->	| Sequential write req. |
+		|                       |
+		|_______________________|
+SZ*2..-->	| Sequential write req. |
+		|                       |
+..........	.........................
+		|_______________________|
+SZ*N-1 -->	| Sequential write req. |
+		|_______________________|
+
+
+SZ is configurable, but is restricted to a multiple of
+(chunk size (CLBA) * Number of PUs).
+
+Zone to chunk mapping
+---------------------
+
+Zones are spread across PUs to allow maximum write throughput through striping.
+One or more chunks (CHK) per PU is assigned.
+
+Example:
+
+OCSSD 2.0 Geometry: 4 PUs, 16 chunks per PU.
+Zones: 3
+
+ Zone	  PU0	PU1   PU2   PU3
+_______  _____ _____ _____ _____
+        |CHK 0|CHK 0|CHK A|CHK 0|
+ 0      |CHK 2|CHK 3|CHK 3|CHK 1|
+_______ |_____|_____|_____|_____|
+        |CHK 3|CHK B|CHK 8|CHK A|
+ 1      |CHK 7|CHK F|CHK 2|CHK 3|
+_______ |_____|_____|_____|_____|
+        |CHK 8|CHK 2|CHK 7|CHK 4|
+ 2      |CHK 1|CHK A|CHK 5|CHK 2|
+_______ |_____|_____|_____|_____|
+
+Chunks are assigned to a zone when it is opened based on the chunk wear index.
+
+Note: The disk's Maximum Open Chunks (MAXOC) limit puts an upper bound on
+maximum simultaneously open zones (unless MAXOC = 0).
+
+Meta data and over-provisioning
+-------------------------------
+
+lzbd needs the following meta data to be persisted:
+
+* a zone-to chunk mapping (Z2C) table, size: 4 bytes * Number of chunks
+* a superblock containing target configuration, guuid, on-disk format version,
+  etc.
+
+Additionally, chunks need to be reserved for handling:
+
+* write errors
+* chunks wearing out and going offline
+* persisting data not aligned with the minimal write constraint
+
+The meta data is stored a separate set of chunks from the user data.
+
+Host memory requirements
+------------------------
+
+The Z2C mapping table needs to be kept in host memory (see above), and:
+
+* in order to achieve maximum throughput and alignment requirements,
+  a small write buffer is needed
+	Size: Optimal Write Size (WS_OPT) * Maximum number of open zones.
+
+* to satisify OCSSD 2.0 read restrictions, a read buffer is needed.
+	Size: Number of PUs * Cache Minimum Write Size Units (MW_CUNITS) *
+	Maximum number of open zones.
+
+If MW_CUNITS = 0, no read buffer is needed and data can be written without
+any host copying/buffering (except for handling WS_OPT alignment).
+
+References
+----------
+
+[1] Lightnvm website: http://lightnvm.io/
+[2] OCSSD 2.0 Specification: http://lightnvm.io/docs/OCSSD-2_0-20180129.pdf
+[3] ZBC / Zoned block device support: https://lwn.net/Articles/703871/
+
diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index a872cd720967..98882874bda6 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -16,6 +16,17 @@ menuconfig NVM
 
 if NVM
 
+config NVM_LZBD
+	tristate "Zoned Block Device Open-Channel SSD target"
+	depends on BLK_DEV_ZONED
+	help
+	  Allows an open-channel SSD to be exposed as a zoned block device to the
+	  host.
+
+	  Highly EXPERIMENTAL for now.
+
+	  Only say Y if you want to play with it.
+
 config NVM_PBLK
 	tristate "Physical Block Device Open-Channel SSD target"
 	help
diff --git a/drivers/lightnvm/Makefile b/drivers/lightnvm/Makefile
index 97d9d7c71550..f9eea8b23b33 100644
--- a/drivers/lightnvm/Makefile
+++ b/drivers/lightnvm/Makefile
@@ -9,3 +9,6 @@ pblk-y				:= pblk-init.o pblk-core.o pblk-rb.o \
 				   pblk-write.o pblk-cache.o pblk-read.o \
 				   pblk-gc.o pblk-recovery.o pblk-map.o \
 				   pblk-rl.o pblk-sysfs.o
+
+obj-$(CONFIG_NVM_LZBD)		+= lzbd.o
+lzbd-y				:= lzbd-target.o lzbd-user.o lzbd-io.o lzbd-zone.o
diff --git a/drivers/lightnvm/lzbd-io.c b/drivers/lightnvm/lzbd-io.c
new file mode 100644
index 000000000000..b210ab33fdd3
--- /dev/null
+++ b/drivers/lightnvm/lzbd-io.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * Zoned block device lightnvm target
+ * Copyright (C) 2019 CNEX Labs
+ *
+ * Disk I/O
+ */
+
+#include "lzbd.h"
+
+static inline void lzbd_chunk_log(char *message, int err,
+				  struct lzbd_chunk *lzbd_chunk)
+{
+
+	/* TODO: create trace points in stead */
+	pr_err("lzbd: %s: err: %d grp: %d pu: %d chk: %d slba: %llu state: %d wp: %llu\n",
+		message,
+		err,
+		lzbd_chunk->ppa.m.grp,
+		lzbd_chunk->ppa.m.pu,
+		lzbd_chunk->ppa.m.chk,
+		lzbd_chunk->meta->slba,
+		lzbd_chunk->meta->state,
+		lzbd_chunk->meta->wp);
+}
+
+int lzbd_reset_chunk(struct lzbd *lzbd, struct lzbd_chunk *chunk)
+{
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_rq rqd = {NULL};
+	int ret;
+
+	if ((chunk->meta->state & (NVM_CHK_ST_FREE | NVM_CHK_ST_OFFLINE))) {
+		pr_err("lzbd: reset of chunk in illegal state: %d\n",
+				chunk->meta->state);
+		return -EINVAL;
+	}
+
+	rqd.opcode = NVM_OP_ERASE;
+	rqd.ppa_addr = chunk->ppa;
+	rqd.nr_ppas = 1;
+	rqd.is_seq = 1;
+
+	ret = nvm_submit_io_sync(dev, &rqd);
+
+	/* For now, set the chunk offline if the request fails
+	 * TODO: Pass a buffer in the request so  we get a full
+	 *       meta update from the device
+	 */
+
+	if (!ret) {
+		if (rqd.error) {
+			if ((rqd.error & 0xfff) == 0x2c0) {
+				lzbd_chunk_log("chunk went offline", 0, chunk);
+				chunk->meta->state = NVM_CHK_ST_OFFLINE;
+			} else {
+				if ((rqd.error & 0xfff) == 0x2c1) {
+					lzbd_chunk_log("invalid reset",
+						-EINVAL, chunk);
+				} else {
+					lzbd_chunk_log("unknown error",
+						-EINVAL, chunk);
+				}
+				return -EINVAL;
+			}
+		} else {
+			chunk->meta->state = NVM_CHK_ST_FREE;
+			chunk->meta->wp = 0;
+		}
+	}
+
+	return ret;
+}
+
+/* Prepare a write request to a chunk. If the function call succeeds
+ * the call must be paired with a lzbd_free_wr_rq
+ */
+static int lzbd_init_wr_rq(struct lzbd *lzbd, struct lzbd_chunk *chunk,
+			   struct bio *bio, struct nvm_rq *rq)
+{
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct ppa_addr ppa;
+	struct ppa_addr *ppa_list;
+	int metadata_sz = geo->sos * NVM_MAX_VLBA;
+	int nr_ppas = geo->ws_opt;
+	int i;
+
+	memset(rq, 0, sizeof(struct nvm_rq));
+
+	rq->bio = bio;
+	rq->opcode = NVM_OP_PWRITE;
+	rq->nr_ppas = nr_ppas;
+	rq->is_seq = 1;
+	rq->private = &chunk->wr_ctx;
+
+	/* Do we respect the write size restrictions? */
+	if (nr_ppas > geo->ws_opt || (nr_ppas % geo->ws_min)) {
+		pr_err("lzbd: write size violation size: %d\n", nr_ppas);
+		return -EINVAL;
+	}
+
+	/* Is the chunk in the right state? */
+	if (!(chunk->meta->state & (NVM_CHK_ST_FREE | NVM_CHK_ST_OPEN))) {
+		pr_err("lzbd: write to chunk in wrong state: %d\n",
+				chunk->meta->state);
+		return -EINVAL;
+	}
+
+	/* Do we have room for the write? */
+	if ((chunk->meta->wp + nr_ppas) > geo->clba) {
+		pr_err("lzbd: cant fit write into chunk size %d\n", nr_ppas);
+		return -EINVAL;
+	}
+
+	rq->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+						&rq->dma_meta_list);
+	if (!rq->meta_list)
+		return -ENOMEM;
+
+	/* We don't care about metadata. yet. */
+	memset(rq->meta_list, 42, metadata_sz);
+
+	if (nr_ppas > 1) {
+		rq->ppa_list = rq->meta_list + metadata_sz;
+		rq->dma_ppa_list = rq->dma_meta_list + metadata_sz;
+	}
+
+	//pr_err("lzbd: writing %d sectors\n", nr_ppas);
+
+	ppa.ppa = chunk->ppa.ppa;
+
+	mutex_lock(&chunk->wr_ctx.wr_lock);
+
+	ppa.m.sec = chunk->meta->wp;
+
+	ppa_list = nvm_rq_to_ppa_list(rq);
+	for (i = 0; i < nr_ppas; i++) {
+		ppa_list[i].ppa = ppa.ppa;
+		ppa.m.sec++;
+	}
+
+	return 0;
+}
+
+static void lzbd_free_wr_rq(struct lzbd *lzbd, struct nvm_rq *rq)
+{
+	struct lzbd_wr_ctx *wr_ctx = rq->private;
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct lzbd_chunk *chunk;
+
+	chunk = container_of(wr_ctx, struct lzbd_chunk, wr_ctx);
+
+	mutex_unlock(&chunk->wr_ctx.wr_lock);
+	nvm_dev_dma_free(dev->parent, rq->meta_list, rq->dma_meta_list);
+}
+
+static inline void lzbd_wr_rq_post(struct nvm_rq *rq)
+{
+	struct lzbd_wr_ctx *wr_ctx = rq->private;
+	struct lzbd *lzbd = wr_ctx->lzbd;
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct lzbd_chunk *chunk;
+
+	chunk = container_of(wr_ctx, struct lzbd_chunk, wr_ctx);
+
+	if (!rq->error) {
+		if (chunk->meta->wp == 0)
+			chunk->meta->state = NVM_CHK_ST_OPEN;
+
+		chunk->meta->wp += rq->nr_ppas;
+		if (chunk->meta->wp == geo->clba)
+			chunk->meta->state = NVM_CHK_ST_CLOSED;
+	}
+}
+
+int lzbd_write_to_chunk_sync(struct lzbd *lzbd, struct lzbd_chunk *chunk,
+			     struct bio *bio)
+{
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_rq rq;
+	int ret;
+
+	ret = lzbd_init_wr_rq(lzbd, chunk, bio, &rq);
+	if (ret)
+		return ret;
+
+	ret = nvm_submit_io_sync(dev, &rq);
+	if (ret) {
+		ret = rq.error;
+		pr_err("lzbd: sync write request submit failed: %d\n", ret);
+	} else {
+		lzbd_wr_rq_post(&rq);
+	}
+
+	lzbd_free_wr_rq(lzbd, &rq);
+
+	return ret;
+}
+
+static void lzbd_read_endio(struct nvm_rq *rq)
+{
+	struct lzbd_rd_ctx *rd_ctx = container_of(rq, struct lzbd_rd_ctx, rqd);
+	struct lzbd *lzbd = rd_ctx->lzbd;
+	struct lzbd_user_read *read = rd_ctx->read;
+	struct nvm_tgt_dev *dev = lzbd->dev;
+
+	if (unlikely(rq->error))
+		read->error = true;
+
+	if (rq->meta_list)
+		nvm_dev_dma_free(dev->parent, rq->meta_list, rq->dma_meta_list);
+
+	kref_put(&read->ref, lzbd_user_read_put);
+	kfree(rd_ctx);
+}
+
+static int lzbd_read_from_chunk_async(struct lzbd *lzbd,
+				      struct lzbd_chunk *chunk,
+				      struct bio *bio,
+				      struct lzbd_user_read *user_read,
+				      int start)
+{
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct lzbd_rd_ctx *rd_ctx;
+	struct nvm_rq *rq;
+	struct ppa_addr ppa;
+	struct ppa_addr *ppa_list;
+	int metadata_sz = geo->sos * NVM_MAX_VLBA;
+	int nr_ppas = lzbd_get_bio_len(bio);
+	int ret;
+	int i;
+
+	/* Do we respect the read size restrictions? */
+	if (nr_ppas >= NVM_MAX_VLBA) {
+		pr_err("lzbd: read size violation size: %d\n", nr_ppas);
+		return -EINVAL;
+	}
+
+	/* Is the chunk in the right state? */
+	if (!(chunk->meta->state & (NVM_CHK_ST_OPEN | NVM_CHK_ST_CLOSED))) {
+		pr_err("lzbd: read from chunk in wrong state: %d\n",
+				chunk->meta->state);
+		return -EINVAL;
+	}
+
+	/*Are we reading within bounds? */
+	if ((start + nr_ppas) > geo->clba) {
+		pr_err("lzbd: read past the chunk size %d start: %d\n",
+			nr_ppas, start);
+		return -EINVAL;
+	}
+
+	rd_ctx = kzalloc(sizeof(struct lzbd_rd_ctx), GFP_KERNEL);
+	if (!rd_ctx)
+		return -ENOMEM;
+
+	rd_ctx->read = user_read;
+	rd_ctx->lzbd = lzbd;
+
+	rq = &rd_ctx->rqd;
+	rq->bio = bio;
+	rq->opcode = NVM_OP_PREAD;
+	rq->nr_ppas = nr_ppas;
+	rq->end_io = lzbd_read_endio;
+	rq->private = lzbd;
+	rq->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+					&rq->dma_meta_list);
+	if (!rq->meta_list) {
+		kfree(rd_ctx);
+		return -ENOMEM;
+	}
+
+	if (nr_ppas > 1) {
+		rq->ppa_list = rq->meta_list + metadata_sz;
+		rq->dma_ppa_list = rq->dma_meta_list + metadata_sz;
+	}
+
+	ppa.ppa = chunk->ppa.ppa;
+	ppa.m.sec = start;
+
+	ppa_list = nvm_rq_to_ppa_list(rq);
+	for (i = 0; i < nr_ppas; i++) {
+		ppa_list[i].ppa = ppa.ppa;
+		ppa.m.sec++;
+	}
+
+	ret = nvm_submit_io(dev, rq);
+
+	if (ret) {
+		pr_err("lzbd: read request submit failed: %d\n", ret);
+		nvm_dev_dma_free(dev->parent, rq->meta_list, rq->dma_meta_list);
+		kfree(rd_ctx);
+	}
+
+	return ret;
+}
+
+int lzbd_write_to_chunk_user(struct lzbd *lzbd, struct lzbd_chunk *chunk,
+			     struct bio *user_bio)
+{
+	struct bio *write_bio;
+	int ret = 0;
+
+	write_bio = bio_clone_fast(user_bio, GFP_KERNEL, &lzbd_bio_set);
+	if (!write_bio)
+		return -ENOMEM;
+
+	ret = lzbd_write_to_chunk_sync(lzbd, chunk, write_bio);
+	if (ret) {
+		ret = -EIO;
+		bio_io_error(user_bio);
+	} else {
+		ret = 0;
+		bio_endio(user_bio);
+	}
+
+	return ret;
+}
+
+int lzbd_read_from_chunk_user(struct lzbd *lzbd, struct lzbd_chunk *chunk,
+			 struct bio *bio, struct lzbd_user_read *user_read,
+			 int start)
+{
+	struct bio *read_bio;
+	int ret = 0;
+
+	read_bio = bio_clone_fast(bio, GFP_KERNEL, &lzbd_bio_set);
+	if (!read_bio) {
+		pr_err("lzbd: bio clone failed!\n");
+		return -ENOMEM;
+	}
+
+	ret = lzbd_read_from_chunk_async(lzbd, chunk,
+			read_bio, user_read, start);
+
+	return ret;
+}
+
diff --git a/drivers/lightnvm/lzbd-target.c b/drivers/lightnvm/lzbd-target.c
new file mode 100644
index 000000000000..04dd22873eeb
--- /dev/null
+++ b/drivers/lightnvm/lzbd-target.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * Zoned block device lightnvm target
+ * Copyright (C) 2019 CNEX Labs
+ *
+ * Target handling: module boilerplate, init and remove
+ */
+
+#include <linux/module.h>
+
+#include "lzbd.h"
+
+struct bio_set lzbd_bio_set;
+
+static sector_t lzbd_capacity(void *private)
+{
+	struct lzbd *lzbd = private;
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+
+	return dl->capacity;
+}
+
+static void lzbd_free_chunks(struct lzbd *lzbd)
+{
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct lzbd_chunks *chunks = &lzbd->chunks;
+	int parallel_units = geo->all_luns;
+	int i;
+
+	for (i = 0; i < parallel_units; i++) {
+		struct lzbd_pu *pu = &chunks->pus[i];
+		struct list_head *pos, *n;
+		struct lzbd_chunk *chunk;
+
+		mutex_destroy(&pu->lock);
+
+		list_for_each_safe(pos, n, &pu->chk_list) {
+			chunk = list_entry(pos, struct lzbd_chunk, list);
+
+			list_del(pos);
+			mutex_destroy(&chunk->wr_ctx.wr_lock);
+			kfree(chunk);
+		}
+	}
+
+	kfree(chunks->pus);
+	vfree(chunks->meta);
+}
+
+/* Add chunk to chunklist in falling wi order */
+void lzbd_add_chunk(struct lzbd_chunk *chunk,
+		    struct list_head *head)
+{
+	struct lzbd_chunk *c = NULL;
+
+	list_for_each_entry(c, head, list) {
+		if (chunk->meta->wi < c->meta->wi)
+			break;
+	}
+
+	list_add_tail(&chunk->list, &c->list);
+}
+
+
+static int lzbd_init_chunks(struct lzbd *lzbd)
+{
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct nvm_chk_meta *meta;
+	struct lzbd_chunks *chunks = &lzbd->chunks;
+	int parallel_units = geo->all_luns;
+	struct ppa_addr ppa;
+	int ret;
+	int chk;
+	int i;
+
+	chunks->pus = kcalloc(parallel_units, sizeof(struct lzbd_pu),
+				GFP_KERNEL);
+	if (!chunks->pus)
+		return -ENOMEM;
+
+	meta = vzalloc(geo->all_chunks * sizeof(*meta));
+	if (!meta) {
+		kfree(chunks->pus);
+		return -ENOMEM;
+	}
+
+	chunks->meta = meta;
+
+	for (i = 0; i < parallel_units; i++) {
+		struct lzbd_pu *lzbd_pu = &chunks->pus[i];
+
+		INIT_LIST_HEAD(&lzbd_pu->chk_list);
+		mutex_init(&lzbd_pu->lock);
+	}
+
+	ppa.ppa = 0; /* get all chunks */
+	ret = nvm_get_chunk_meta(dev, ppa, geo->all_chunks, meta);
+	if (ret) {
+		lzbd_free_chunks(lzbd);
+		return -EIO;
+	}
+
+	for (chk = 0; chk < geo->num_chk; chk++) {
+		for (i = 0; i < parallel_units; i++) {
+			struct lzbd_pu *lzbd_pu = &chunks->pus[i];
+			struct nvm_chk_meta *chk_meta;
+			int grp = i / geo->num_lun;
+			int pu = i % geo->num_lun;
+			int offset = 0;
+
+			offset += grp * geo->num_lun * geo->num_chk;
+			offset += pu * geo->num_chk;
+			offset += chk;
+
+			chk_meta = &meta[offset];
+
+			if (!(chk_meta->state & NVM_CHK_ST_OFFLINE)) {
+				struct lzbd_chunk *chunk;
+
+				chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+				if (!chunk) {
+					lzbd_free_chunks(lzbd);
+					return -ENOMEM;
+				}
+
+				INIT_LIST_HEAD(&chunk->list);
+				chunk->meta = chk_meta;
+				chunk->ppa.m.grp = grp;
+				chunk->ppa.m.pu = pu;
+				chunk->ppa.m.chk = chk;
+				chunk->pu = i;
+
+				lzbd_add_chunk(chunk, &lzbd_pu->chk_list);
+
+				mutex_init(&chunk->wr_ctx.wr_lock);
+				chunk->wr_ctx.lzbd = lzbd;
+			} else {
+				lzbd_pu->offline_chks++;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static struct lzbd_zone *lzbd_init_zones(struct lzbd *lzbd)
+{
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+	int i;
+	struct lzbd_zone *zones;
+	u64 zone_offset = 0;
+
+	zones = kmalloc_array(dl->zones, sizeof(*zones), GFP_KERNEL);
+	if (!zones)
+		return NULL;
+
+	/* Sequential zones */
+	for (i = 0; i < dl->zones; i++, zone_offset += dl->zone_size) {
+		struct lzbd_zone *zone = &zones[i];
+		struct blk_zone *bz = &zone->blk_zone;
+
+		bz->start = zone_offset;
+		bz->len = dl->zone_size;
+		bz->wp = zone_offset + dl->zone_size;
+		bz->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
+		bz->cond = BLK_ZONE_COND_FULL;
+
+		bz->non_seq = 0;
+		bz->reset = 1;
+
+		/* zero-out reserved bytes to be forward-compatible */
+		memset(bz->reserved, 0, sizeof(bz->reserved));
+
+		zones[i].chunks = NULL;
+		mutex_init(&zone->lock);
+
+		zone->wr_align.buffer = NULL;
+		mutex_init(&zone->wr_align.lock);
+	}
+
+	return zones;
+}
+
+
+static void lzbd_config_disk_queue(struct lzbd *lzbd)
+{
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct gendisk *disk = lzbd->disk;
+	struct nvm_geo *geo = &dev->geo;
+	struct request_queue *bqueue = dev->q;
+	struct request_queue *dqueue = disk->queue;
+
+	blk_queue_logical_block_size(dqueue, queue_physical_block_size(bqueue));
+	blk_queue_max_hw_sectors(dqueue, queue_max_hw_sectors(bqueue));
+
+	blk_queue_write_cache(dqueue, true, false);
+
+	dqueue->limits.discard_granularity = geo->clba * geo->csecs;
+	dqueue->limits.discard_alignment = 0;
+	blk_queue_max_discard_sectors(dqueue, UINT_MAX >> 9);
+	blk_queue_flag_set(QUEUE_FLAG_DISCARD, dqueue);
+
+	dqueue->limits.zoned = BLK_ZONED_HM;
+	dqueue->nr_zones = dl->zones;
+	dqueue->limits.chunk_sectors = dl->zone_size;
+}
+
+
+static int lzbd_dev_is_supported(struct nvm_tgt_dev *dev)
+{
+	struct nvm_geo *geo = &dev->geo;
+
+	if (geo->major_ver_id != 2) {
+		pr_err("lzbd only supports Open Channel 2.x devices\n");
+		return 0;
+	}
+
+	if (geo->csecs != LZBD_SECTOR_SIZE) {
+		pr_err("lzbd: unsupported block size %d", geo->csecs);
+		return 0;
+	}
+
+	/* We will need to check(some of) these parameters later on,
+	 * but for now, just print them. TODO: check cunit, maxoc
+	 */
+	pr_info("lzbd: ws_min:%d ws_opt:%d cunits:%d maxoc:%d maxocpu:%d\n",
+		geo->ws_min, geo->ws_opt, geo->mw_cunits,
+		geo->maxoc, geo->maxocpu);
+
+	return 1;
+}
+
+
+static const struct block_device_operations lzbd_fops = {
+	.report_zones	= lzbd_report_zones,
+	.owner		= THIS_MODULE,
+};
+
+static void lzbd_dump_geo(struct nvm_tgt_dev *dev)
+{
+	struct nvm_geo *geo = &dev->geo;
+
+	pr_info("lzbd: target geo: num_grp: %d num_pu: %d num_chk: %d ws_opt: %d\n",
+		geo->num_ch, geo->all_luns, geo->num_chk, geo->ws_opt);
+}
+
+static void lzbd_create_layout(struct lzbd *lzbd)
+{
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_geo *geo = &dev->geo;
+	int user_chunks;
+
+	/* Default to 20% over-provisioning if not specified
+	 * (better safe than sorry)
+	 */
+	if (geo->op == NVM_TARGET_DEFAULT_OP)
+		dl->op = 20;
+	else
+		dl->op = geo->op;
+
+	dl->meta_chunks = 4;
+	dl->zone_chunks = geo->all_luns;
+	dl->zone_size = (geo->clba * dl->zone_chunks) << 3;
+
+	user_chunks = geo->all_chunks * (100 - dl->op);
+	sector_div(user_chunks, 100);
+
+	dl->zones = user_chunks / dl->zone_chunks;
+	dl->capacity = dl->zones * dl->zone_size;
+}
+
+static void lzbd_dump_layout(struct lzbd *lzbd)
+{
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+
+	pr_info("lzbd: layout: op: %d zones: %d per zone chks: %d secs: %llu\n",
+		dl->op, dl->zones, dl->zone_chunks,
+		(unsigned long long)dl->zone_size);
+}
+
+static void *lzbd_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
+		       int flags)
+{
+	struct lzbd *lzbd;
+
+	lzbd_dump_geo(dev);
+
+	if (!lzbd_dev_is_supported(dev))
+		return ERR_PTR(-EINVAL);
+
+
+	if (!(flags & NVM_TARGET_FACTORY)) {
+		pr_err("lzbd: metadata not persisted, only factory init supported\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	lzbd = kzalloc(sizeof(struct lzbd), GFP_KERNEL);
+	if (!lzbd)
+		return ERR_PTR(-ENOMEM);
+
+	lzbd->dev = dev;
+	lzbd->disk = tdisk;
+
+	lzbd_create_layout(lzbd);
+	lzbd_dump_layout(lzbd);
+
+	lzbd->zones = lzbd_init_zones(lzbd);
+
+	if (!lzbd->zones)
+		goto err_free_lzbd;
+
+	if (lzbd_init_chunks(lzbd))
+		goto err_free_zones;
+	lzbd_config_disk_queue(lzbd);
+
+	/* Override the fops to enable zone reporting support */
+	lzbd->disk->fops = &lzbd_fops;
+
+	return lzbd;
+
+err_free_zones:
+	kfree(lzbd->zones);
+err_free_lzbd:
+	kfree(lzbd);
+
+	return ERR_PTR(-ENOMEM);
+}
+
+static void lzbd_exit(void *private, bool graceful)
+{
+	struct lzbd *lzbd = private;
+
+	lzbd_free_chunks(lzbd);
+	kfree(lzbd->zones);
+	kfree(lzbd);
+}
+
+
+static int lzbd_sysfs_init(struct gendisk *tdisk)
+{
+	/* Crickets */
+	return 0;
+}
+
+static void lzbd_sysfs_exit(struct gendisk *tdisk)
+{
+	/* Tumbleweed */
+}
+
+static struct nvm_tgt_type tt_lzbd = {
+	.name		= "lzbd",
+	.version	= {0, 0, 1},
+
+	.init		= lzbd_init,
+	.exit		= lzbd_exit,
+
+	.capacity	= lzbd_capacity,
+	.make_rq	= lzbd_make_rq,
+
+	.sysfs_init	= lzbd_sysfs_init,
+	.sysfs_exit	= lzbd_sysfs_exit,
+
+	.owner		= THIS_MODULE,
+};
+
+static int __init lzbd_module_init(void)
+{
+	int ret;
+
+	ret = bioset_init(&lzbd_bio_set, BIO_POOL_SIZE, 0, 0);
+	if (ret)
+		return ret;
+
+	return nvm_register_tgt_type(&tt_lzbd);
+}
+
+static void lzbd_module_exit(void)
+{
+	bioset_exit(&lzbd_bio_set);
+	nvm_unregister_tgt_type(&tt_lzbd);
+}
+
+module_init(lzbd_module_init);
+module_exit(lzbd_module_exit);
+MODULE_AUTHOR("Hans Holmberg <hans.holmberg@cnexlabs.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Zoned Block-Device for Open-Channel SSDs");
diff --git a/drivers/lightnvm/lzbd-user.c b/drivers/lightnvm/lzbd-user.c
new file mode 100644
index 000000000000..e38ec763941e
--- /dev/null
+++ b/drivers/lightnvm/lzbd-user.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * Zoned block device lightnvm target
+ * Copyright (C) 2019 CNEX Labs
+ *
+ * User interfacing code: read/write/reset requests
+ */
+
+#include "lzbd.h"
+
+static void lzbd_fail_bio(struct bio *bio, char *op)
+{
+	pr_err("lzbd: failing %s. start lba: %lu  length: %lu\n", op,
+		lzbd_get_bio_lba(bio), lzbd_get_bio_len(bio));
+
+	bio_io_error(bio);
+}
+
+static struct lzbd_zone *lzbd_get_zone(struct lzbd *lzbd, sector_t sector)
+{
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+	struct lzbd_zone *zone;
+	struct blk_zone *bz;
+
+	sector_div(sector, dl->zone_size);
+
+	if (sector >= dl->zones)
+		return NULL;
+
+	zone = &lzbd->zones[sector];
+	bz = &zone->blk_zone;
+
+	return zone;
+}
+
+static int lzbd_write_rq(struct lzbd *lzbd, struct lzbd_zone *zone,
+			  struct bio *bio)
+{
+	sector_t sector = bio->bi_iter.bi_sector;
+	sector_t nr_secs = lzbd_get_bio_len(bio);
+	struct blk_zone *bz;
+	int left;
+
+	mutex_lock(&zone->lock);
+
+	bz = &zone->blk_zone;
+
+	if (bz->cond == BLK_ZONE_COND_OFFLINE) {
+		mutex_unlock(&zone->lock);
+		return -EIO;
+	}
+
+	if (bz->cond == BLK_ZONE_COND_EMPTY)
+		bz->cond = BLK_ZONE_COND_IMP_OPEN;
+
+	if (sector != bz->wp) {
+		if (sector == bz->start) {
+			if (lzbd_zone_reset(lzbd, zone)) {
+				pr_err("lzbd: zone reset failed");
+				bz->cond = BLK_ZONE_COND_OFFLINE;
+				mutex_unlock(&zone->lock);
+				return -EIO;
+			}
+			bz->cond = BLK_ZONE_COND_IMP_OPEN;
+			bz->wp = bz->start;
+		} else {
+			pr_err("lzbd: write pointer error");
+			mutex_unlock(&zone->lock);
+			return -EIO;
+		}
+	}
+
+	left = lzbd_zone_write(lzbd, zone, bio);
+
+	bz->wp += (nr_secs - left) << 3;
+	if (bz->wp == (bz->start + bz->len)) {
+		lzbd_zone_free_wr_buffer(zone);
+		bz->cond = BLK_ZONE_COND_FULL;
+	}
+
+	mutex_unlock(&zone->lock);
+
+	if (left > 0) {
+		pr_err("lzbd: write did not complete");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int lzbd_read_rq(struct lzbd *lzbd, struct lzbd_zone *zone,
+			 struct bio *bio)
+{
+	struct blk_zone *bz;
+	sector_t read_end, data_end;
+	sector_t data_start = bio->bi_iter.bi_sector;
+	int ret;
+
+	if (!zone) {
+		lzbd_fail_bio(bio, "lzbd: no zone mapped to read sector");
+		return -EIO;
+	}
+
+	bz = &zone->blk_zone;
+
+	if (!zone->chunks || bz->cond == BLK_ZONE_COND_OFFLINE) {
+		/* No valid data in this zone */
+		zero_fill_bio(bio);
+		bio_endio(bio);
+		return 0;
+	}
+
+	if (data_start >= bz->wp) {
+		zero_fill_bio(bio);
+		bio_endio(bio);
+		return 0;
+	}
+
+	read_end = bio_end_sector(bio);
+	data_end = min_t(sector_t, bz->wp, read_end);
+
+	if (read_end > data_end) {
+		sector_t split_sz = data_end - data_start;
+		struct bio *split;
+
+		if (data_end <= data_start) {
+			lzbd_fail_bio(bio, "internal error(read)");
+			return -EIO;
+		}
+
+		split = bio_split(bio, split_sz,
+				GFP_KERNEL, &lzbd_bio_set);
+
+		ret = lzbd_zone_read(lzbd, zone, split);
+		if (ret) {
+			lzbd_fail_bio(bio, "split read");
+			return -EIO;
+		}
+
+		zero_fill_bio(bio);
+		bio_endio(bio);
+
+	} else {
+		lzbd_zone_read(lzbd, zone, bio);
+	}
+
+	return 0;
+}
+
+static void lzbd_zone_reset_rq(struct lzbd *lzbd, struct request_queue *q,
+			     struct bio *bio)
+{
+	sector_t sector = bio->bi_iter.bi_sector;
+	struct lzbd_zone *zone;
+
+	zone = lzbd_get_zone(lzbd, sector);
+
+	if (zone) {
+		struct blk_zone *bz = &zone->blk_zone;
+		int ret;
+
+		mutex_lock(&zone->lock);
+
+		ret = lzbd_zone_reset(lzbd, zone);
+		if (ret) {
+			bz->cond = BLK_ZONE_COND_OFFLINE;
+			lzbd_fail_bio(bio, "zone reset");
+			mutex_unlock(&zone->lock);
+			return;
+		}
+
+		bz->cond = BLK_ZONE_COND_EMPTY;
+		bz->wp = bz->start;
+
+		mutex_unlock(&zone->lock);
+
+		bio_endio(bio);
+	} else {
+		bio_io_error(bio);
+	}
+}
+
+static void lzbd_discard_rq(struct lzbd *lzbd, struct request_queue *q,
+			     struct bio *bio)
+{
+	/* TODO: Implement discard */
+	bio_endio(bio);
+}
+
+static struct bio *lzbd_zplit(struct lzbd *lzbd, struct bio *bio,
+			      struct lzbd_zone **first_zone)
+{
+	sector_t bio_start = bio->bi_iter.bi_sector;
+	sector_t bio_end, zone_end;
+	struct lzbd_zone *zone;
+	struct blk_zone *bz;
+	struct bio *zone_bio;
+
+	zone = lzbd_get_zone(lzbd, bio_start);
+	if (!zone)
+		return NULL;
+
+	bio_end = bio_end_sector(bio);
+	bz = &zone->blk_zone;
+	zone_end = bz->start + bz->len;
+
+	if (bio_end > zone_end) {
+		zone_bio = bio_split(bio, zone_end - bio_start,
+				GFP_KERNEL, &lzbd_bio_set);
+	} else {
+		zone_bio = bio;
+	}
+
+	*first_zone = zone;
+	return zone_bio;
+}
+
+blk_qc_t lzbd_make_rq(struct request_queue *q, struct bio *bio)
+{
+	struct lzbd *lzbd = q->queuedata;
+
+	if (bio->bi_opf & REQ_PREFLUSH) {
+		/* TODO: Implement syncs */
+		pr_err("lzbd: ignoring sync!\n");
+	}
+
+	if (bio_op(bio) == REQ_OP_READ ||  bio_op(bio) == REQ_OP_WRITE) {
+		struct bio *zplit;
+		struct lzbd_zone *zone;
+
+		if (!lzbd_get_bio_len(bio)) {
+			bio_endio(bio);
+			return BLK_QC_T_NONE;
+		}
+
+		do  {
+			zplit = lzbd_zplit(lzbd, bio, &zone);
+			if (!zplit || !zone) {
+				lzbd_fail_bio(bio, "zone split");
+				return BLK_QC_T_NONE;
+			}
+
+			if (op_is_write(bio_op(bio))) {
+				if (lzbd_write_rq(lzbd, zone, zplit)) {
+					lzbd_fail_bio(zplit, "write");
+					if (zplit != bio)
+						lzbd_fail_bio(bio,
+							"write");
+
+					return BLK_QC_T_NONE;
+				}
+			} else {
+				if (lzbd_read_rq(lzbd, zone, zplit)) {
+					lzbd_fail_bio(zplit, "read");
+					if (zplit != bio)
+						lzbd_fail_bio(bio,
+							"read");
+					return BLK_QC_T_NONE;
+				}
+			}
+		} while (bio != zplit);
+
+		return BLK_QC_T_NONE;
+	}
+
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+		lzbd_discard_rq(lzbd, q, bio);
+		break;
+	case REQ_OP_ZONE_RESET:
+		lzbd_zone_reset_rq(lzbd, q, bio);
+		break;
+	default:
+		pr_err("lzbd: unsupported operation: %d", bio_op(bio));
+		bio_io_error(bio);
+		break;
+	}
+
+	return BLK_QC_T_NONE;
+}
+
+int lzbd_report_zones(struct gendisk *disk, sector_t sector,
+		      struct blk_zone *zones, unsigned int *nr_zones,
+		      gfp_t gfp_mask)
+{
+	struct lzbd *lzbd = disk->private_data;
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+	unsigned int max_zones = *nr_zones;
+	unsigned int reported = 0;
+	struct lzbd_zone *zone;
+
+	sector_div(sector, dl->zone_size);
+
+	while ((zone = lzbd_get_zone(lzbd, sector))) {
+		struct blk_zone *bz = &zone->blk_zone;
+
+		if (reported >= max_zones)
+			break;
+
+		memcpy(&zones[reported], bz, sizeof(*bz));
+
+		sector = sector + dl->zone_size;
+		reported++;
+	}
+
+	*nr_zones = reported;
+
+	return 0;
+}
diff --git a/drivers/lightnvm/lzbd-zone.c b/drivers/lightnvm/lzbd-zone.c
new file mode 100644
index 000000000000..813f7b006ef1
--- /dev/null
+++ b/drivers/lightnvm/lzbd-zone.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * Zoned block device lightnvm target
+ * Copyright (C) 2019 CNEX Labs
+ *
+ * Internal zone handling
+ */
+
+#include "lzbd.h"
+
+static struct lzbd_chunk *lzbd_get_chunk(struct lzbd *lzbd, int pref_pu)
+{
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_geo *geo = &dev->geo;
+	int parallel_units = geo->all_luns;
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+	struct lzbd_chunks *chunks = &lzbd->chunks;
+	int i = pref_pu;
+	int retries = dl->zone_chunks - 1;
+
+	do {
+		struct lzbd_pu *pu = &chunks->pus[i];
+		struct list_head *chk_list = &pu->chk_list;
+
+		mutex_lock(&pu->lock);
+
+		if (!list_empty(&pu->chk_list)) {
+			struct lzbd_chunk *chunk;
+
+			chunk = list_first_entry(chk_list,
+						 struct lzbd_chunk, list);
+			list_del(&chunk->list);
+			mutex_unlock(&pu->lock);
+			return chunk;
+		}
+		mutex_unlock(&pu->lock);
+
+		if (++i == parallel_units)
+			i = 0;
+
+	} while (retries--);
+
+	return NULL;
+}
+
+void lzbd_zone_free_wr_buffer(struct lzbd_zone *zone)
+{
+	kfree(zone->wr_align.buffer);
+	zone->wr_align.buffer = NULL;
+	zone->wr_align.secs = 0;
+}
+
+static void lzbd_zone_deallocate(struct lzbd *lzbd, struct lzbd_zone *zone)
+{
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+	struct lzbd_chunks *chunks = &lzbd->chunks;
+	int i;
+
+	if (!zone->chunks)
+		return;
+
+	for (i = 0; i < dl->zone_chunks; i++) {
+		struct lzbd_chunk *chunk = zone->chunks[i];
+
+		if (chunk) {
+			struct lzbd_pu *pu = &chunks->pus[chunk->pu];
+
+			mutex_lock(&pu->lock);
+
+			/* TODO: implement proper wear leveling
+			 * The wear indices do not get updated right now
+			 * so just add the chunk at the bottom of the list
+			 */
+			list_add_tail(&chunk->list, &pu->chk_list);
+			mutex_unlock(&pu->lock);
+		}
+	}
+
+	lzbd_zone_free_wr_buffer(zone);
+	kfree(zone->chunks);
+	zone->chunks = NULL;
+}
+
+int lzbd_zone_allocate(struct lzbd *lzbd, struct lzbd_zone *zone)
+{
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+	int to_allocate = dl->zone_chunks;
+	int i;
+
+	zone->chunks = kmalloc_array(to_allocate,
+			sizeof(struct lzbd_chunk *),
+			GFP_KERNEL | __GFP_ZERO);
+
+	if (!zone->chunks)
+		return -ENOMEM;
+
+	zone->wr_align.secs = 0;
+
+	zone->wr_align.buffer = kzalloc(geo->ws_opt << LZBD_SECTOR_BITS,
+					GFP_KERNEL);
+	if (!zone->wr_align.buffer) {
+		kfree(zone->chunks);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < to_allocate; i++) {
+		struct lzbd_chunk *chunk = lzbd_get_chunk(lzbd, i);
+
+		if (!chunk) {
+			pr_err("failed to allocate zone!\n");
+			lzbd_zone_deallocate(lzbd, zone);
+			return -ENOSPC;
+		}
+
+		zone->chunks[i] = chunk;
+	}
+
+	return 0;
+}
+
+static int lzbd_zone_reset_chunks(struct lzbd *lzbd, struct lzbd_zone *zone)
+{
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+	int i = 0;
+
+	/* TODO: Do parallel resetting and handle reset failures */
+	for (i = 0; i < dl->zone_chunks; i++) {
+		struct lzbd_chunk *chunk = zone->chunks[i];
+		int state = chunk->meta->state;
+		int ret;
+
+		if (state & (NVM_CHK_ST_CLOSED | NVM_CHK_ST_OPEN)) {
+			ret = lzbd_reset_chunk(lzbd, chunk);
+			if (ret) {
+				pr_err("lzbd: reset failed!\n");
+				return -EIO; /* Fail for now if reset fails */
+			}
+		}
+	}
+
+	return 0;
+}
+
+int lzbd_zone_reset(struct lzbd *lzbd, struct lzbd_zone *zone)
+{
+	int ret;
+
+	lzbd_zone_deallocate(lzbd, zone);
+	ret = lzbd_zone_allocate(lzbd, zone);
+	if (ret)
+		return ret;
+
+	ret = lzbd_zone_reset_chunks(lzbd, zone);
+
+	zone->wi = 0;
+	atomic_set(&zone->s_wp, 0);
+
+	return ret;
+}
+
+
+static void lzbd_add_to_align_buf(struct lzbd_wr_align *wr_align,
+				   struct bio *bio, int secs)
+{
+	char *buffer = wr_align->buffer;
+
+	buffer += (wr_align->secs * LZBD_SECTOR_SIZE);
+
+	mutex_lock(&wr_align->lock);
+	while (secs--) {
+		char *data = bio_data(bio);
+
+		memcpy(buffer, data, LZBD_SECTOR_SIZE);
+		buffer += LZBD_SECTOR_SIZE;
+		wr_align->secs++;
+		bio_advance(bio, LZBD_SECTOR_SIZE);
+
+	}
+
+	mutex_unlock(&wr_align->lock);
+}
+
+static void lzbd_read_from_align_buf(struct lzbd_wr_align *wr_align,
+				   struct bio *bio, int start, int secs)
+{
+	char *buffer = wr_align->buffer;
+
+	buffer += (start * LZBD_SECTOR_SIZE);
+
+	mutex_lock(&wr_align->lock);
+	while (secs--) {
+		char *data = bio_data(bio);
+
+		memcpy(data, buffer, LZBD_SECTOR_SIZE);
+		buffer += LZBD_SECTOR_SIZE;
+
+		bio_advance(bio, LZBD_SECTOR_SIZE);
+	}
+
+	mutex_unlock(&wr_align->lock);
+}
+
+int lzbd_zone_write(struct lzbd *lzbd, struct lzbd_zone *zone, struct bio *bio)
+{
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+	struct lzbd_wr_align *wr_align = &zone->wr_align;
+	int sectors_left = lzbd_get_bio_len(bio);
+	int ret;
+
+	/* Unaligned write? */
+	if (wr_align->secs) {
+		int secs;
+
+		secs = min_t(int, geo->ws_opt - wr_align->secs, sectors_left);
+		lzbd_add_to_align_buf(wr_align, bio, secs);
+		sectors_left -= secs;
+
+		/* Time to flush the alignment buffer ? */
+		if (wr_align->secs == geo->ws_opt) {
+			struct bio *bio;
+
+			bio = bio_map_kern(dev->q, wr_align->buffer,
+					geo->ws_opt * LZBD_SECTOR_SIZE,
+					GFP_KERNEL);
+			if (!bio) {
+				pr_err("lzbd: failed to map align bio\n");
+				return -EIO;
+			}
+
+			ret = lzbd_write_to_chunk_user(lzbd,
+				zone->chunks[zone->wi], bio);
+
+			if (ret) {
+				pr_err("lzbd: alignment write failed\n");
+				return sectors_left;
+			}
+
+			wr_align->secs = 0;
+			zone->wi = (zone->wi + 1) % dl->zone_chunks;
+			atomic_add(geo->ws_opt, &zone->s_wp);
+		}
+	}
+
+	if (sectors_left == 0) {
+		bio_endio(bio);
+		return 0;
+	}
+
+	while (sectors_left > geo->ws_opt) {
+		struct bio *split;
+
+		split = bio_split(bio, geo->ws_opt << 3,
+				GFP_KERNEL, &lzbd_bio_set);
+
+		if (split == NULL) {
+			pr_err("lzbd: split failed!\n");
+			return sectors_left;
+		}
+
+		ret = lzbd_write_to_chunk_user(lzbd,
+				zone->chunks[zone->wi], split);
+
+		if (ret)
+			return sectors_left;
+
+		zone->wi = (zone->wi + 1) % dl->zone_chunks;
+		atomic_add(geo->ws_opt, &zone->s_wp);
+
+		sectors_left -= geo->ws_opt;
+	}
+
+	if (sectors_left == geo->ws_opt) {
+		ret = lzbd_write_to_chunk_user(lzbd,
+				zone->chunks[zone->wi], bio);
+		if (ret) {
+			pr_err("lzbd: last aligned write failed\n");
+			return sectors_left;
+		}
+
+		zone->wi = (zone->wi + 1) % dl->zone_chunks;
+		atomic_add(geo->ws_opt, &zone->s_wp);
+		sectors_left -= geo->ws_opt;
+	} else {
+		wr_align->secs = 0;
+		lzbd_add_to_align_buf(wr_align, bio, sectors_left);
+		bio_endio(bio);
+		sectors_left = 0;
+	}
+
+	return sectors_left;
+}
+
+void lzbd_user_read_put(struct kref *ref)
+{
+	struct lzbd_user_read *read;
+
+	read = container_of(ref, struct lzbd_user_read, ref);
+
+	if (unlikely(read->error))
+		bio_io_error(read->user_bio);
+	else
+		bio_endio(read->user_bio);
+
+	kfree(read);
+}
+
+
+static struct lzbd_user_read *lzbd_init_user_read(struct bio *bio)
+{
+	struct lzbd_user_read *rd;
+
+	rd = kmalloc(sizeof(struct lzbd_user_read), GFP_KERNEL);
+	if (!rd)
+		return NULL;
+
+	rd->user_bio = bio;
+	kref_init(&rd->ref);
+	rd->error = false;
+
+	return rd;
+}
+
+
+int lzbd_zone_read(struct lzbd *lzbd, struct lzbd_zone *zone, struct bio *bio)
+{
+	struct lzbd_disk_layout *dl = &lzbd->disk_layout;
+	struct nvm_tgt_dev *dev = lzbd->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct blk_zone *bz = &zone->blk_zone;
+	struct lzbd_chunk *read_chunk;
+	sector_t lba = lzbd_get_bio_lba(bio);
+	int to_read = lzbd_get_bio_len(bio);
+	struct lzbd_user_read *read;
+	int readsize;
+	int zsi, zso, csi, co;
+	int pu;
+	int ret;
+
+	read = lzbd_init_user_read(bio);
+	if (!read) {
+		pr_err("lzbd: failed to init read\n");
+		bio_io_error(bio);
+		return -EIO;
+	}
+
+	if (!zone->chunks) {
+		/* No data has been written to this zone */
+		zero_fill_bio(bio);
+		bio_endio(bio);
+		kfree(read);
+		return 0;
+	}
+
+	lba -= bz->start >> 3;
+
+	/* TODO: use sector_div instead */
+
+	/* Zone stripe index and offset */
+	zsi = lba / geo->ws_opt; /* zone stripe index */
+	zso = lba % geo->ws_opt; /* zone stripe offset */
+
+	pu = zsi % dl->zone_chunks;
+	read_chunk = zone->chunks[pu];
+
+	/* Chunk stripe index and chunk offset */
+	csi = lba / (dl->zone_chunks * geo->ws_opt);
+	co = csi * geo->ws_opt + zso;
+
+	readsize = min_t(int, geo->ws_opt - zso, to_read);
+
+	while (to_read > 0) {
+		struct bio *rbio = bio;
+		int s_wp = atomic_read(&zone->s_wp);
+
+		if (lba >= s_wp) {
+			/* Grab the write lock to prevent races
+			 * with writes
+			 */
+			mutex_lock(&zone->lock);
+			if (lba >= atomic_read(&zone->s_wp)) {
+				lzbd_read_from_align_buf(&zone->wr_align, bio,
+						zso, to_read);
+				mutex_unlock(&zone->lock);
+				ret = 0;
+				goto done;
+			}
+			mutex_unlock(&zone->lock);
+		}
+
+		if ((zso + to_read) > geo->ws_opt) {
+
+			rbio = bio_split(bio, readsize << 3, GFP_KERNEL,
+					&lzbd_bio_set);
+
+			if (!rbio) {
+				read->error = true;
+				ret = -EIO;
+				goto done;
+			}
+
+		}
+
+		if (lba + to_read >= s_wp)
+			readsize = s_wp - lba;
+
+		kref_get(&read->ref);
+		ret = lzbd_read_from_chunk_user(lzbd, zone->chunks[pu],
+						rbio, read, co);
+		if (ret) {
+			pr_err("lzbd: user disk read failed!\n");
+			read->error = true;
+			kref_put(&read->ref, lzbd_user_read_put);
+			ret = -EIO;
+			goto done;
+		}
+
+		lba += readsize;
+
+		if (zso) {
+			co -= zso;
+			zso = 0;
+		}
+
+		if (++pu == dl->zone_chunks) {
+			pu = 0;
+			co += geo->ws_opt;
+		}
+
+		to_read -= readsize;
+		readsize = min_t(int, geo->ws_opt, to_read);
+		read_chunk = zone->chunks[pu];
+	}
+
+	ret = 0;
+done:
+	kref_put(&read->ref, lzbd_user_read_put);
+	return ret;
+}
+
diff --git a/drivers/lightnvm/lzbd.h b/drivers/lightnvm/lzbd.h
new file mode 100644
index 000000000000..97cca99a49bf
--- /dev/null
+++ b/drivers/lightnvm/lzbd.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *
+ * Zoned block device lightnvm target
+ * Copyright (C) 2019 CNEX Labs
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/bio.h>
+#include <linux/lightnvm.h>
+
+#define LZBD_SECTOR_BITS (12) /* 4096 */
+#define LZBD_SECTOR_SIZE (4096UL)
+
+/* sector unit to lzbd sector shift*/
+#define LZBD_SECTOR_SHIFT (3)
+
+extern struct bio_set lzbd_bio_set;
+
+
+/* Get length, in lzbd sectors, of bio */
+static inline sector_t lzbd_get_bio_len(struct bio *bio)
+{
+	return bio->bi_iter.bi_size >> LZBD_SECTOR_BITS;
+}
+
+/* Get bio start lba in lzbd sectors */
+static inline sector_t lzbd_get_bio_lba(struct bio *bio)
+{
+	return bio->bi_iter.bi_sector >> LZBD_SECTOR_SHIFT;
+}
+
+struct lzbd_wr_ctx {
+	struct lzbd *lzbd;
+	struct mutex wr_lock;		/* Max one outstanding write */
+
+	void *private;
+	/* bio completion list goes here, along with lock*/
+};
+
+struct lzbd_user_read {
+	struct bio *user_bio;
+	struct kref ref;
+	bool error;
+};
+
+struct lzbd_rd_ctx {
+	struct lzbd *lzbd;
+	struct lzbd_user_read *read;
+	struct nvm_rq rqd;
+};
+
+struct lzbd_chunk {
+	struct nvm_chk_meta *meta;	/* Metadata for the chunk */
+	struct ppa_addr ppa;		/* Start ppa */
+	int pu;				/* Parallel unit */
+
+	struct lzbd_wr_ctx wr_ctx;
+	struct list_head list;		/* A chunk is offline or
+					 * part of a PU free list or
+					 * part of a zone chunk list or
+					 * part of a metadata list
+					 */
+
+	/* a cuinits buffer should go here */
+};
+
+struct lzbd_pu {
+	struct list_head chk_list;	/* One list per parallel unit */
+	struct mutex lock;		/* Protecting list */
+	int offline_chks;
+};
+
+struct lzbd_chunks {
+	struct lzbd_pu *pus;		/* Chunks organized per parallel unit*/
+	struct nvm_chk_meta *meta;	/* Metadata for all chunks */
+};
+
+struct lzbd_wr_align {
+	void *buffer;		/* Buffer data */
+	int secs;		/* Number of 4k secs in buffer */
+	struct mutex lock;
+};
+
+struct lzbd_zone {
+	struct blk_zone blk_zone;
+	struct lzbd_chunk **chunks;
+
+	int wi;				/* Write chunk index */
+	atomic_t s_wp;			/* Sync write pointer */
+
+	struct lzbd_wr_align wr_align;	/* Write alignment buffer */
+
+	struct mutex lock;		/* Write lock */
+};
+
+struct lzbd_disk_layout {
+	int		op;		/* Over provision ratio */
+	int		meta_chunks;	/* Metadata chunks */
+
+	int		zones;		/* Number of zones */
+	int		zone_chunks;	/* Zone per chunk */
+	sector_t	zone_size;	/* Number of 512b sectors per zone */
+
+	sector_t	capacity;	/* Disk capacity in 512b sectors */
+};
+
+struct lzbd {
+	struct nvm_tgt_dev *dev;
+	struct gendisk *disk;
+
+	struct lzbd_zone *zones;
+
+	struct lzbd_chunks chunks;
+	struct lzbd_disk_layout disk_layout;
+};
+
+blk_qc_t lzbd_make_rq(struct request_queue *q, struct bio *bio);
+
+int lzbd_report_zones(struct gendisk *disk, sector_t sector,
+			       struct blk_zone *zones, unsigned int *nr_zones,
+			       gfp_t gfp_mask);
+
+int lzbd_reset_chunk(struct lzbd *lzbd, struct lzbd_chunk *chunk);
+int lzbd_write_to_chunk_sync(struct lzbd *lzbd, struct lzbd_chunk *chunk,
+			     struct bio *bio);
+int lzbd_write_to_chunk_user(struct lzbd *lzbd, struct lzbd_chunk *chunk,
+			     struct bio *user_bio);
+int lzbd_read_from_chunk_user(struct lzbd *lzbd, struct lzbd_chunk *chunk,
+			 struct bio *bio, struct lzbd_user_read *user_read,
+			 int start);
+int lzbd_zone_reset(struct lzbd *lzbd, struct lzbd_zone *zone);
+int lzbd_zone_write(struct lzbd *lzbd, struct lzbd_zone *zone, struct bio *bio);
+int lzbd_zone_read(struct lzbd *lzbd, struct lzbd_zone *zone, struct bio *bio);
+void lzbd_zone_free_wr_buffer(struct lzbd_zone *zone);
+void lzbd_user_read_put(struct kref *ref);
+
-- 
2.7.4

