Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37267 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbdFZJ6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:21 -0400
Received: by mail-wm0-f47.google.com with SMTP id i127so3035813wma.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:20 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 11/20] lightnvm: pblk: issue multiplane reads if possible
Date: Mon, 26 Jun 2017 11:57:20 +0200
Message-Id: <1498471049-25505-12-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If a read request is sequential and its size aligns with a
multi-plane page size, use the multi-plane hint to process the I/O in
parallel in the controller.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c     | 12 +++++++-----
 drivers/lightnvm/pblk-read.c     | 11 +++++++++--
 drivers/lightnvm/pblk-recovery.c | 18 +++++++++++++++---
 drivers/lightnvm/pblk.h          | 22 ++++++++++++++++++++--
 4 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index beae1618483f..29565f89a85e 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -564,7 +564,6 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	int id = line->id;
 	int rq_ppas, rq_len;
 	int cmd_op, bio_op;
-	int flags;
 	int i, j;
 	int ret;
 	DECLARE_COMPLETION_ONSTACK(wait);
@@ -572,11 +571,9 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	if (dir == WRITE) {
 		bio_op = REQ_OP_WRITE;
 		cmd_op = NVM_OP_PWRITE;
-		flags = pblk_set_progr_mode(pblk, WRITE);
 	} else if (dir == READ) {
 		bio_op = REQ_OP_READ;
 		cmd_op = NVM_OP_PREAD;
-		flags = pblk_set_read_mode(pblk);
 	} else
 		return -EINVAL;
 
@@ -601,7 +598,6 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 
 	rqd.bio = bio;
 	rqd.opcode = cmd_op;
-	rqd.flags = flags;
 	rqd.nr_ppas = rq_ppas;
 	rqd.ppa_list = ppa_list;
 	rqd.dma_ppa_list = dma_ppa_list;
@@ -609,6 +605,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	rqd.private = &wait;
 
 	if (dir == WRITE) {
+		rqd.flags = pblk_set_progr_mode(pblk, WRITE);
 		for (i = 0; i < rqd.nr_ppas; ) {
 			spin_lock(&line->lock);
 			paddr = __pblk_alloc_page(pblk, line, min);
@@ -621,6 +618,11 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 		for (i = 0; i < rqd.nr_ppas; ) {
 			struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, id);
 			int pos = pblk_dev_ppa_to_pos(geo, ppa);
+			int read_type = PBLK_READ_RANDOM;
+
+			if (pblk_io_aligned(pblk, rq_ppas))
+				read_type = PBLK_READ_SEQUENTIAL;
+			rqd.flags = pblk_set_read_mode(pblk, read_type);
 
 			while (test_bit(pos, line->blk_bitmap)) {
 				paddr += min;
@@ -717,7 +719,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	} else if (dir == READ) {
 		bio_op = REQ_OP_READ;
 		cmd_op = NVM_OP_PREAD;
-		flags = pblk_set_read_mode(pblk);
+		flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
 	} else
 		return -EINVAL;
 
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index cea958e96fc3..d6499cdb7d33 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -88,6 +88,11 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			bio_advance(bio, PBLK_EXPOSED_PAGE_SIZE);
 	}
 
+	if (pblk_io_aligned(pblk, nr_secs))
+		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
+	else
+		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
+
 #ifdef CONFIG_NVM_DEBUG
 	atomic_long_add(nr_secs, &pblk->inflight_reads);
 #endif
@@ -97,8 +102,6 @@ static int pblk_submit_read_io(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	int err;
 
-	rqd->flags = pblk_set_read_mode(pblk);
-
 	err = pblk_submit_io(pblk, rqd);
 	if (err)
 		return NVM_IO_ERR;
@@ -177,6 +180,7 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 
 	rqd->bio = new_bio;
 	rqd->nr_ppas = nr_holes;
+	rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
 	rqd->end_io = NULL;
 
 	if (unlikely(nr_secs > 1 && nr_holes == 1)) {
@@ -290,6 +294,8 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	} else {
 		rqd->ppa_addr = ppa;
 	}
+
+	rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
 }
 
 int pblk_submit_read(struct pblk *pblk, struct bio *bio)
@@ -497,6 +503,7 @@ int pblk_submit_read_gc(struct pblk *pblk, u64 *lba_list, void *data,
 	rqd.end_io = pblk_end_io_sync;
 	rqd.private = &wait;
 	rqd.nr_ppas = *secs_to_gc;
+	rqd.flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
 	rqd.bio = bio;
 
 	ret = pblk_submit_read_io(pblk, &rqd);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 7b0ace2f4957..b9f2b40bd5a7 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -257,7 +257,6 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 
 	rqd->bio = bio;
 	rqd->opcode = NVM_OP_PREAD;
-	rqd->flags = pblk_set_read_mode(pblk);
 	rqd->meta_list = meta_list;
 	rqd->nr_ppas = rq_ppas;
 	rqd->ppa_list = ppa_list;
@@ -266,6 +265,11 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 	rqd->end_io = pblk_end_io_sync;
 	rqd->private = &wait;
 
+	if (pblk_io_aligned(pblk, rq_ppas))
+		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
+	else
+		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
+
 	for (i = 0; i < rqd->nr_ppas; ) {
 		struct ppa_addr ppa;
 		int pos;
@@ -473,7 +477,6 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
 
 	rqd->bio = bio;
 	rqd->opcode = NVM_OP_PREAD;
-	rqd->flags = pblk_set_read_mode(pblk);
 	rqd->meta_list = meta_list;
 	rqd->nr_ppas = rq_ppas;
 	rqd->ppa_list = ppa_list;
@@ -482,6 +485,11 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
 	rqd->end_io = pblk_end_io_sync;
 	rqd->private = &wait;
 
+	if (pblk_io_aligned(pblk, rq_ppas))
+		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
+	else
+		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
+
 	for (i = 0; i < rqd->nr_ppas; ) {
 		struct ppa_addr ppa;
 		int pos;
@@ -607,7 +615,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 
 	rqd->bio = bio;
 	rqd->opcode = NVM_OP_PREAD;
-	rqd->flags = pblk_set_read_mode(pblk);
 	rqd->meta_list = meta_list;
 	rqd->nr_ppas = rq_ppas;
 	rqd->ppa_list = ppa_list;
@@ -616,6 +623,11 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	rqd->end_io = pblk_end_io_sync;
 	rqd->private = &wait;
 
+	if (pblk_io_aligned(pblk, rq_ppas))
+		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
+	else
+		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
+
 	for (i = 0; i < rqd->nr_ppas; ) {
 		struct ppa_addr ppa;
 		int pos;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 407d15c69fb4..eb8515fd9044 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1074,9 +1074,27 @@ static inline int pblk_set_progr_mode(struct pblk *pblk, int type)
 	return flags;
 }
 
-static inline int pblk_set_read_mode(struct pblk *pblk)
+enum {
+	PBLK_READ_RANDOM	= 0,
+	PBLK_READ_SEQUENTIAL	= 1,
+};
+
+static inline int pblk_set_read_mode(struct pblk *pblk, int type)
 {
-	return NVM_IO_SNGL_ACCESS | NVM_IO_SUSPEND | NVM_IO_SCRAMBLE_ENABLE;
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	int flags;
+
+	flags = NVM_IO_SUSPEND | NVM_IO_SCRAMBLE_ENABLE;
+	if (type == PBLK_READ_SEQUENTIAL)
+		flags |= geo->plane_mode >> 1;
+
+	return flags;
+}
+
+static inline int pblk_io_aligned(struct pblk *pblk, int nr_secs)
+{
+	return !(nr_secs % pblk->min_write_pgs);
 }
 
 #ifdef CONFIG_NVM_DEBUG
-- 
2.7.4
