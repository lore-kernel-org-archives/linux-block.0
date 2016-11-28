Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:32966 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755384AbcK1Vjr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:47 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so15789216wjc.0
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:47 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 11/23] lightnvm: remove unnecessary variables in rrpc
Date: Mon, 28 Nov 2016 22:39:02 +0100
Message-Id: <20161128213914.12516-12-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Before vectored I/Os were supported on rrpc, the physical address was
stored as part of the nvm_rqd request. This variable become obsolete
when the ppa_list was introduced. Cleanup this variable.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/rrpc.c | 6 ------
 drivers/lightnvm/rrpc.h | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 9253acc..34d2ebf 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -758,7 +758,6 @@ static int rrpc_read_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 static int rrpc_read_rq(struct rrpc *rrpc, struct bio *bio, struct nvm_rq *rqd,
 							unsigned long flags)
 {
-	struct rrpc_rq *rrqd = nvm_rq_to_pdu(rqd);
 	int is_gc = flags & NVM_IOTYPE_GC;
 	sector_t laddr = rrpc_get_laddr(bio);
 	struct rrpc_addr *gp;
@@ -778,7 +777,6 @@ static int rrpc_read_rq(struct rrpc *rrpc, struct bio *bio, struct nvm_rq *rqd,
 	}
 
 	rqd->opcode = NVM_OP_HBREAD;
-	rrqd->addr = gp;
 
 	return NVM_IO_OK;
 }
@@ -821,7 +819,6 @@ static int rrpc_write_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 static int rrpc_write_rq(struct rrpc *rrpc, struct bio *bio,
 				struct nvm_rq *rqd, unsigned long flags)
 {
-	struct rrpc_rq *rrqd = nvm_rq_to_pdu(rqd);
 	struct rrpc_addr *p;
 	int is_gc = flags & NVM_IOTYPE_GC;
 	sector_t laddr = rrpc_get_laddr(bio);
@@ -839,7 +836,6 @@ static int rrpc_write_rq(struct rrpc *rrpc, struct bio *bio,
 
 	rqd->ppa_addr = rrpc_ppa_to_gaddr(rrpc->dev, p->addr);
 	rqd->opcode = NVM_OP_HBWRITE;
-	rrqd->addr = p;
 
 	return NVM_IO_OK;
 }
@@ -1389,7 +1385,6 @@ static void *rrpc_init(struct nvm_dev *dev, struct gendisk *tdisk,
 	INIT_WORK(&rrpc->ws_requeue, rrpc_requeue);
 
 	rrpc->nr_luns = lun_end - lun_begin + 1;
-	rrpc->total_blocks = (unsigned long)dev->blks_per_lun * rrpc->nr_luns;
 	rrpc->nr_sects = (unsigned long long)dev->sec_per_lun * rrpc->nr_luns;
 
 	/* simple round-robin strategy */
@@ -1409,7 +1404,6 @@ static void *rrpc_init(struct nvm_dev *dev, struct gendisk *tdisk,
 	}
 
 	rrpc->poffset = dev->sec_per_lun * lun_begin;
-	rrpc->lun_offset = lun_begin;
 
 	ret = rrpc_core_init(rrpc);
 	if (ret) {
diff --git a/drivers/lightnvm/rrpc.h b/drivers/lightnvm/rrpc.h
index 5e87d52..bed49ba 100644
--- a/drivers/lightnvm/rrpc.h
+++ b/drivers/lightnvm/rrpc.h
@@ -48,7 +48,6 @@ struct rrpc_inflight_rq {
 
 struct rrpc_rq {
 	struct rrpc_inflight_rq inflight_rq;
-	struct rrpc_addr *addr;
 	unsigned long flags;
 };
 
@@ -92,14 +91,12 @@ struct rrpc {
 
 	sector_t soffset; /* logical sector offset */
 	u64 poffset; /* physical page offset */
-	int lun_offset;
 
 	int nr_luns;
 	struct rrpc_lun *luns;
 
 	/* calculated values */
 	unsigned long long nr_sects;
-	unsigned long total_blocks;
 
 	/* Write strategy variables. Move these into each for structure for each
 	 * strategy
-- 
2.9.3

