Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33128 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdAXLwt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 06:52:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id r144so34103192wme.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2017 03:52:49 -0800 (PST)
From: "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH] lightnvm: use end_io callback instead of instance
Date: Tue, 24 Jan 2017 12:52:37 +0100
Message-Id: <20170124115237.18698-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When the lightnvm core had the "gennvm" layer between the device and the
target, there was a need for the core to be able to figure out which
target it should send an end_io callback to. Leading to a "double"
end_io, first for the media manager instance, and then for the target
instance. Now that core and gennvm is merged, there is no longer a need
for this, and a single end_io callback will do.

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c  |  5 ++---
 drivers/lightnvm/rrpc.c  | 11 +++++------
 drivers/lightnvm/rrpc.h  |  3 ---
 include/linux/lightnvm.h | 11 +++--------
 4 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 80cd767..4abd334 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -776,14 +776,13 @@ EXPORT_SYMBOL(nvm_free_rqd_ppalist);
 void nvm_end_io(struct nvm_rq *rqd, int error)
 {
 	struct nvm_tgt_dev *tgt_dev = rqd->dev;
-	struct nvm_tgt_instance *ins = rqd->ins;
 
 	/* Convert address space */
 	if (tgt_dev)
 		nvm_rq_dev_to_tgt(tgt_dev, rqd);
 
-	rqd->error = error;
-	ins->tt->end_io(rqd);
+	if (rqd->end_io)
+		rqd->end_io(rqd, error);
 }
 EXPORT_SYMBOL(nvm_end_io);
 
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 9fb7de3..c399f55 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -777,16 +777,16 @@ static void rrpc_end_io_write(struct rrpc *rrpc, struct rrpc_rq *rrqd,
 	}
 }
 
-static void rrpc_end_io(struct nvm_rq *rqd)
+static void rrpc_end_io(struct nvm_rq *rqd, int error)
 {
-	struct rrpc *rrpc = container_of(rqd->ins, struct rrpc, instance);
+	struct rrpc *rrpc = rqd->private;
 	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_rq *rrqd = nvm_rq_to_pdu(rqd);
 	uint8_t npages = rqd->nr_ppas;
 	sector_t laddr = rrpc_get_laddr(rqd->bio) - npages;
 
 	if (bio_data_dir(rqd->bio) == WRITE) {
-		if (rqd->error == NVM_RSP_ERR_FAILWRITE)
+		if (error == NVM_RSP_ERR_FAILWRITE)
 			rrpc_mark_bad_block(rrpc, rqd);
 
 		rrpc_end_io_write(rrpc, rrqd, laddr, npages);
@@ -972,8 +972,9 @@ static int rrpc_submit_io(struct rrpc *rrpc, struct bio *bio,
 
 	bio_get(bio);
 	rqd->bio = bio;
-	rqd->ins = &rrpc->instance;
+	rqd->private = rrpc;
 	rqd->nr_ppas = nr_pages;
+	rqd->end_io = rrpc_end_io;
 	rrq->flags = flags;
 
 	err = nvm_submit_io(dev, rqd);
@@ -1532,7 +1533,6 @@ static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk)
 	if (!rrpc)
 		return ERR_PTR(-ENOMEM);
 
-	rrpc->instance.tt = &tt_rrpc;
 	rrpc->dev = dev;
 	rrpc->disk = tdisk;
 
@@ -1611,7 +1611,6 @@ static struct nvm_tgt_type tt_rrpc = {
 
 	.make_rq	= rrpc_make_rq,
 	.capacity	= rrpc_capacity,
-	.end_io		= rrpc_end_io,
 
 	.init		= rrpc_init,
 	.exit		= rrpc_exit,
diff --git a/drivers/lightnvm/rrpc.h b/drivers/lightnvm/rrpc.h
index 94e4d73..fdb6ff9 100644
--- a/drivers/lightnvm/rrpc.h
+++ b/drivers/lightnvm/rrpc.h
@@ -102,9 +102,6 @@ struct rrpc_lun {
 };
 
 struct rrpc {
-	/* instance must be kept in top to resolve rrpc in unprep */
-	struct nvm_tgt_instance instance;
-
 	struct nvm_tgt_dev *dev;
 	struct gendisk *disk;
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index ce0b2da..f6e2376 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -213,10 +213,6 @@ struct nvm_target {
 	struct gendisk *disk;
 };
 
-struct nvm_tgt_instance {
-	struct nvm_tgt_type *tt;
-};
-
 #define ADDR_EMPTY (~0ULL)
 
 #define NVM_VERSION_MAJOR 1
@@ -224,10 +220,9 @@ struct nvm_tgt_instance {
 #define NVM_VERSION_PATCH 0
 
 struct nvm_rq;
-typedef void (nvm_end_io_fn)(struct nvm_rq *);
+typedef void (nvm_end_io_fn)(struct nvm_rq *, int);
 
 struct nvm_rq {
-	struct nvm_tgt_instance *ins;
 	struct nvm_tgt_dev *dev;
 
 	struct bio *bio;
@@ -250,7 +245,8 @@ struct nvm_rq {
 	uint16_t flags;
 
 	u64 ppa_status; /* ppa media status */
-	int error;
+
+	void *private;
 };
 
 static inline struct nvm_rq *nvm_rq_from_pdu(void *pdu)
@@ -450,7 +446,6 @@ struct nvm_tgt_type {
 	/* target entry points */
 	nvm_tgt_make_rq_fn *make_rq;
 	nvm_tgt_capacity_fn *capacity;
-	nvm_end_io_fn *end_io;
 
 	/* module-specific init/teardown */
 	nvm_tgt_init_fn *init;
-- 
2.9.3

