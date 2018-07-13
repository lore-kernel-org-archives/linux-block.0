Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f50.google.com ([209.85.160.50]:46851 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbeGMJDU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:20 -0400
Received: by mail-pl0-f50.google.com with SMTP id 30-v6so11915431pld.13
        for <linux-block@vger.kernel.org>; Fri, 13 Jul 2018 01:49:39 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 07/10] lightnvm: pblk: expose generic disk name on pr_* msgs
Date: Fri, 13 Jul 2018 10:48:42 +0200
Message-Id: <20180713084845.19511-8-mb@lightnvm.io>
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The error messages in pblk does not say which pblk instance that
a message occurred from. Update each error message to reflect the
instance it belongs to, and also prefix it with pblk, so we know
the message comes from the pblk module.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c     | 51 ++++++++++++-------------
 drivers/lightnvm/pblk-gc.c       | 32 ++++++++--------
 drivers/lightnvm/pblk-init.c     | 80 ++++++++++++++++++++--------------------
 drivers/lightnvm/pblk-rb.c       |  8 ++--
 drivers/lightnvm/pblk-read.c     | 25 +++++++------
 drivers/lightnvm/pblk-recovery.c | 44 +++++++++++-----------
 drivers/lightnvm/pblk-sysfs.c    |  5 +--
 drivers/lightnvm/pblk-write.c    | 21 ++++++-----
 drivers/lightnvm/pblk.h          | 29 ++++++++++-----
 9 files changed, 155 insertions(+), 140 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 66ab1036f2fb..b829460fe827 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -35,7 +35,7 @@ static void pblk_line_mark_bb(struct work_struct *work)
 		line = &pblk->lines[pblk_ppa_to_line(*ppa)];
 		pos = pblk_ppa_to_pos(&dev->geo, *ppa);
 
-		pr_err("pblk: failed to mark bb, line:%d, pos:%d\n",
+		pblk_err(pblk, "failed to mark bb, line:%d, pos:%d\n",
 				line->id, pos);
 	}
 
@@ -51,12 +51,12 @@ static void pblk_mark_bb(struct pblk *pblk, struct pblk_line *line,
 	struct ppa_addr *ppa;
 	int pos = pblk_ppa_to_pos(geo, ppa_addr);
 
-	pr_debug("pblk: erase failed: line:%d, pos:%d\n", line->id, pos);
+	pblk_debug(pblk, "erase failed: line:%d, pos:%d\n", line->id, pos);
 	atomic_long_inc(&pblk->erase_failed);
 
 	atomic_dec(&line->blk_in_line);
 	if (test_and_set_bit(pos, line->blk_bitmap))
-		pr_err("pblk: attempted to erase bb: line:%d, pos:%d\n",
+		pblk_err(pblk, "attempted to erase bb: line:%d, pos:%d\n",
 							line->id, pos);
 
 	/* Not necessary to mark bad blocks on 2.0 spec. */
@@ -274,7 +274,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 		pool = &pblk->e_rq_pool;
 		break;
 	default:
-		pr_err("pblk: trying to free unknown rqd type\n");
+		pblk_err(pblk, "trying to free unknown rqd type\n");
 		return;
 	}
 
@@ -310,7 +310,7 @@ int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 
 		ret = bio_add_pc_page(q, bio, page, PBLK_EXPOSED_PAGE_SIZE, 0);
 		if (ret != PBLK_EXPOSED_PAGE_SIZE) {
-			pr_err("pblk: could not add page to bio\n");
+			pblk_err(pblk, "could not add page to bio\n");
 			mempool_free(page, &pblk->page_bio_pool);
 			goto err;
 		}
@@ -410,7 +410,7 @@ struct list_head *pblk_line_gc_list(struct pblk *pblk, struct pblk_line *line)
 		line->state = PBLK_LINESTATE_CORRUPT;
 		line->gc_group = PBLK_LINEGC_NONE;
 		move_list =  &l_mg->corrupt_list;
-		pr_err("pblk: corrupted vsc for line %d, vsc:%d (%d/%d/%d)\n",
+		pblk_err(pblk, "corrupted vsc for line %d, vsc:%d (%d/%d/%d)\n",
 						line->id, vsc,
 						line->sec_in_line,
 						lm->high_thrs, lm->mid_thrs);
@@ -452,7 +452,7 @@ void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd)
 		atomic_long_inc(&pblk->read_failed);
 		break;
 	default:
-		pr_err("pblk: unknown read error:%d\n", rqd->error);
+		pblk_err(pblk, "unknown read error:%d\n", rqd->error);
 	}
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	pblk_print_failed_rqd(pblk, rqd, rqd->error);
@@ -517,7 +517,7 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 	for (i = 0; i < nr_secs; i++) {
 		page = vmalloc_to_page(kaddr);
 		if (!page) {
-			pr_err("pblk: could not map vmalloc bio\n");
+			pblk_err(pblk, "could not map vmalloc bio\n");
 			bio_put(bio);
 			bio = ERR_PTR(-ENOMEM);
 			goto out;
@@ -525,7 +525,7 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 
 		ret = bio_add_pc_page(dev->q, bio, page, PAGE_SIZE, 0);
 		if (ret != PAGE_SIZE) {
-			pr_err("pblk: could not add page to bio\n");
+			pblk_err(pblk, "could not add page to bio\n");
 			bio_put(bio);
 			bio = ERR_PTR(-ENOMEM);
 			goto out;
@@ -711,7 +711,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 			while (test_bit(pos, line->blk_bitmap)) {
 				paddr += min;
 				if (pblk_boundary_paddr_checks(pblk, paddr)) {
-					pr_err("pblk: corrupt emeta line:%d\n",
+					pblk_err(pblk, "corrupt emeta line:%d\n",
 								line->id);
 					bio_put(bio);
 					ret = -EINTR;
@@ -723,7 +723,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 			}
 
 			if (pblk_boundary_paddr_checks(pblk, paddr + min)) {
-				pr_err("pblk: corrupt emeta line:%d\n",
+				pblk_err(pblk, "corrupt emeta line:%d\n",
 								line->id);
 				bio_put(bio);
 				ret = -EINTR;
@@ -738,7 +738,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 
 	ret = pblk_submit_io_sync(pblk, &rqd);
 	if (ret) {
-		pr_err("pblk: emeta I/O submission failed: %d\n", ret);
+		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
 		goto free_rqd_dma;
 	}
@@ -843,7 +843,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	 */
 	ret = pblk_submit_io_sync(pblk, &rqd);
 	if (ret) {
-		pr_err("pblk: smeta I/O submission failed: %d\n", ret);
+		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
 		goto free_ppa_list;
 	}
@@ -905,7 +905,7 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 		struct nvm_tgt_dev *dev = pblk->dev;
 		struct nvm_geo *geo = &dev->geo;
 
-		pr_err("pblk: could not sync erase line:%d,blk:%d\n",
+		pblk_err(pblk, "could not sync erase line:%d,blk:%d\n",
 					pblk_ppa_to_line(ppa),
 					pblk_ppa_to_pos(geo, ppa));
 
@@ -945,7 +945,7 @@ int pblk_line_erase(struct pblk *pblk, struct pblk_line *line)
 
 		ret = pblk_blk_erase_sync(pblk, ppa);
 		if (ret) {
-			pr_err("pblk: failed to erase line %d\n", line->id);
+			pblk_err(pblk, "failed to erase line %d\n", line->id);
 			return ret;
 		}
 	} while (1);
@@ -1012,7 +1012,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 		list_add_tail(&line->list, &l_mg->bad_list);
 		spin_unlock(&l_mg->free_lock);
 
-		pr_debug("pblk: line %d is bad\n", line->id);
+		pblk_debug(pblk, "line %d is bad\n", line->id);
 
 		return 0;
 	}
@@ -1122,7 +1122,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	line->cur_sec = off + lm->smeta_sec;
 
 	if (init && pblk_line_submit_smeta_io(pblk, line, off, PBLK_WRITE)) {
-		pr_debug("pblk: line smeta I/O failed. Retry\n");
+		pblk_debug(pblk, "line smeta I/O failed. Retry\n");
 		return 0;
 	}
 
@@ -1154,7 +1154,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 		spin_unlock(&line->lock);
 
 		list_add_tail(&line->list, &l_mg->bad_list);
-		pr_err("pblk: unexpected line %d is bad\n", line->id);
+		pblk_err(pblk, "unexpected line %d is bad\n", line->id);
 
 		return 0;
 	}
@@ -1299,7 +1299,7 @@ struct pblk_line *pblk_line_get(struct pblk *pblk)
 
 retry:
 	if (list_empty(&l_mg->free_list)) {
-		pr_err("pblk: no free lines\n");
+		pblk_err(pblk, "no free lines\n");
 		return NULL;
 	}
 
@@ -1315,7 +1315,7 @@ struct pblk_line *pblk_line_get(struct pblk *pblk)
 
 		list_add_tail(&line->list, &l_mg->bad_list);
 
-		pr_debug("pblk: line %d is bad\n", line->id);
+		pblk_debug(pblk, "line %d is bad\n", line->id);
 		goto retry;
 	}
 
@@ -1329,7 +1329,7 @@ struct pblk_line *pblk_line_get(struct pblk *pblk)
 			list_add(&line->list, &l_mg->corrupt_list);
 			goto retry;
 		default:
-			pr_err("pblk: failed to prepare line %d\n", line->id);
+			pblk_err(pblk, "failed to prepare line %d\n", line->id);
 			list_add(&line->list, &l_mg->free_list);
 			l_mg->nr_free_lines++;
 			return NULL;
@@ -1477,7 +1477,7 @@ static void pblk_line_close_meta_sync(struct pblk *pblk)
 
 			ret = pblk_submit_meta_io(pblk, line);
 			if (ret) {
-				pr_err("pblk: sync meta line %d failed (%d)\n",
+				pblk_err(pblk, "sync meta line %d failed (%d)\n",
 							line->id, ret);
 				return;
 			}
@@ -1507,7 +1507,7 @@ void __pblk_pipeline_flush(struct pblk *pblk)
 
 	ret = pblk_recov_pad(pblk);
 	if (ret) {
-		pr_err("pblk: could not close data on teardown(%d)\n", ret);
+		pblk_err(pblk, "could not close data on teardown(%d)\n", ret);
 		return;
 	}
 
@@ -1687,7 +1687,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 		struct nvm_tgt_dev *dev = pblk->dev;
 		struct nvm_geo *geo = &dev->geo;
 
-		pr_err("pblk: could not async erase line:%d,blk:%d\n",
+		pblk_err(pblk, "could not async erase line:%d,blk:%d\n",
 					pblk_ppa_to_line(ppa),
 					pblk_ppa_to_pos(geo, ppa));
 	}
@@ -1866,7 +1866,8 @@ static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
 
 	ret = down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
 	if (ret == -ETIME || ret == -EINTR)
-		pr_err("pblk: taking lun semaphore timed out: err %d\n", -ret);
+		pblk_err(pblk, "taking lun semaphore timed out: err %d\n",
+				-ret);
 }
 
 void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 40d2dcb4f2bd..157c2567c9e8 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -90,7 +90,7 @@ static void pblk_gc_line_ws(struct work_struct *work)
 
 	gc_rq->data = vmalloc(array_size(gc_rq->nr_secs, geo->csecs));
 	if (!gc_rq->data) {
-		pr_err("pblk: could not GC line:%d (%d/%d)\n",
+		pblk_err(pblk, "could not GC line:%d (%d/%d)\n",
 					line->id, *line->vsc, gc_rq->nr_secs);
 		goto out;
 	}
@@ -98,7 +98,7 @@ static void pblk_gc_line_ws(struct work_struct *work)
 	/* Read from GC victim block */
 	ret = pblk_submit_read_gc(pblk, gc_rq);
 	if (ret) {
-		pr_err("pblk: failed GC read in line:%d (err:%d)\n",
+		pblk_err(pblk, "failed GC read in line:%d (err:%d)\n",
 								line->id, ret);
 		goto out;
 	}
@@ -146,7 +146,7 @@ static __le64 *get_lba_list_from_emeta(struct pblk *pblk,
 
 	ret = pblk_line_read_emeta(pblk, line, emeta_buf);
 	if (ret) {
-		pr_err("pblk: line %d read emeta failed (%d)\n",
+		pblk_err(pblk, "line %d read emeta failed (%d)\n",
 				line->id, ret);
 		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
 		return NULL;
@@ -160,7 +160,7 @@ static __le64 *get_lba_list_from_emeta(struct pblk *pblk,
 
 	ret = pblk_recov_check_emeta(pblk, emeta_buf);
 	if (ret) {
-		pr_err("pblk: inconsistent emeta (line %d)\n",
+		pblk_err(pblk, "inconsistent emeta (line %d)\n",
 				line->id);
 		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
 		return NULL;
@@ -201,7 +201,7 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	} else {
 		lba_list = get_lba_list_from_emeta(pblk, line);
 		if (!lba_list) {
-			pr_err("pblk: could not interpret emeta (line %d)\n",
+			pblk_err(pblk, "could not interpret emeta (line %d)\n",
 					line->id);
 			goto fail_free_invalid_bitmap;
 		}
@@ -213,7 +213,7 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	spin_unlock(&line->lock);
 
 	if (sec_left < 0) {
-		pr_err("pblk: corrupted GC line (%d)\n", line->id);
+		pblk_err(pblk, "corrupted GC line (%d)\n", line->id);
 		goto fail_free_lba_list;
 	}
 
@@ -289,7 +289,7 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	kref_put(&line->ref, pblk_line_put);
 	atomic_dec(&gc->read_inflight_gc);
 
-	pr_err("pblk: Failed to GC line %d\n", line->id);
+	pblk_err(pblk, "failed to GC line %d\n", line->id);
 }
 
 static int pblk_gc_line(struct pblk *pblk, struct pblk_line *line)
@@ -297,7 +297,7 @@ static int pblk_gc_line(struct pblk *pblk, struct pblk_line *line)
 	struct pblk_gc *gc = &pblk->gc;
 	struct pblk_line_ws *line_ws;
 
-	pr_debug("pblk: line '%d' being reclaimed for GC\n", line->id);
+	pblk_debug(pblk, "line '%d' being reclaimed for GC\n", line->id);
 
 	line_ws = kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL);
 	if (!line_ws)
@@ -351,7 +351,7 @@ static int pblk_gc_read(struct pblk *pblk)
 	pblk_gc_kick(pblk);
 
 	if (pblk_gc_line(pblk, line))
-		pr_err("pblk: failed to GC line %d\n", line->id);
+		pblk_err(pblk, "failed to GC line %d\n", line->id);
 
 	return 0;
 }
@@ -523,7 +523,7 @@ static int pblk_gc_reader_ts(void *data)
 	}
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
-	pr_info("pblk: flushing gc pipeline, %d lines left\n",
+	pblk_info(pblk, "flushing gc pipeline, %d lines left\n",
 		atomic_read(&gc->pipeline_gc));
 #endif
 
@@ -540,7 +540,7 @@ static int pblk_gc_reader_ts(void *data)
 static void pblk_gc_start(struct pblk *pblk)
 {
 	pblk->gc.gc_active = 1;
-	pr_debug("pblk: gc start\n");
+	pblk_debug(pblk, "gc start\n");
 }
 
 void pblk_gc_should_start(struct pblk *pblk)
@@ -605,14 +605,14 @@ int pblk_gc_init(struct pblk *pblk)
 
 	gc->gc_ts = kthread_create(pblk_gc_ts, pblk, "pblk-gc-ts");
 	if (IS_ERR(gc->gc_ts)) {
-		pr_err("pblk: could not allocate GC main kthread\n");
+		pblk_err(pblk, "could not allocate GC main kthread\n");
 		return PTR_ERR(gc->gc_ts);
 	}
 
 	gc->gc_writer_ts = kthread_create(pblk_gc_writer_ts, pblk,
 							"pblk-gc-writer-ts");
 	if (IS_ERR(gc->gc_writer_ts)) {
-		pr_err("pblk: could not allocate GC writer kthread\n");
+		pblk_err(pblk, "could not allocate GC writer kthread\n");
 		ret = PTR_ERR(gc->gc_writer_ts);
 		goto fail_free_main_kthread;
 	}
@@ -620,7 +620,7 @@ int pblk_gc_init(struct pblk *pblk)
 	gc->gc_reader_ts = kthread_create(pblk_gc_reader_ts, pblk,
 							"pblk-gc-reader-ts");
 	if (IS_ERR(gc->gc_reader_ts)) {
-		pr_err("pblk: could not allocate GC reader kthread\n");
+		pblk_err(pblk, "could not allocate GC reader kthread\n");
 		ret = PTR_ERR(gc->gc_reader_ts);
 		goto fail_free_writer_kthread;
 	}
@@ -641,7 +641,7 @@ int pblk_gc_init(struct pblk *pblk)
 	gc->gc_line_reader_wq = alloc_workqueue("pblk-gc-line-reader-wq",
 			WQ_MEM_RECLAIM | WQ_UNBOUND, PBLK_GC_MAX_READERS);
 	if (!gc->gc_line_reader_wq) {
-		pr_err("pblk: could not allocate GC line reader workqueue\n");
+		pblk_err(pblk, "could not allocate GC line reader workqueue\n");
 		ret = -ENOMEM;
 		goto fail_free_reader_kthread;
 	}
@@ -650,7 +650,7 @@ int pblk_gc_init(struct pblk *pblk)
 	gc->gc_reader_wq = alloc_workqueue("pblk-gc-line_wq",
 					WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
 	if (!gc->gc_reader_wq) {
-		pr_err("pblk: could not allocate GC reader workqueue\n");
+		pblk_err(pblk, "could not allocate GC reader workqueue\n");
 		ret = -ENOMEM;
 		goto fail_free_reader_line_wq;
 	}
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 9ea30102f61c..d023ea6116bc 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -117,13 +117,13 @@ static int pblk_l2p_recover(struct pblk *pblk, bool factory_init)
 	} else {
 		line = pblk_recov_l2p(pblk);
 		if (IS_ERR(line)) {
-			pr_err("pblk: could not recover l2p table\n");
+			pblk_err(pblk, "could not recover l2p table\n");
 			return -EFAULT;
 		}
 	}
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
-	pr_info("pblk init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
+	pblk_info(pblk, "init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
 #endif
 
 	/* Free full lines directly as GC has not been started yet */
@@ -166,7 +166,7 @@ static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
 static void pblk_rwb_free(struct pblk *pblk)
 {
 	if (pblk_rb_tear_down_check(&pblk->rwb))
-		pr_err("pblk: write buffer error on tear down\n");
+		pblk_err(pblk, "write buffer error on tear down\n");
 
 	pblk_rb_data_free(&pblk->rwb);
 	vfree(pblk_rb_entries_ref(&pblk->rwb));
@@ -203,7 +203,8 @@ static int pblk_rwb_init(struct pblk *pblk)
 /* Minimum pages needed within a lun */
 #define ADDR_POOL_SIZE 64
 
-static int pblk_set_addrf_12(struct nvm_geo *geo, struct nvm_addrf_12 *dst)
+static int pblk_set_addrf_12(struct pblk *pblk, struct nvm_geo *geo,
+			     struct nvm_addrf_12 *dst)
 {
 	struct nvm_addrf_12 *src = (struct nvm_addrf_12 *)&geo->addrf;
 	int power_len;
@@ -211,14 +212,14 @@ static int pblk_set_addrf_12(struct nvm_geo *geo, struct nvm_addrf_12 *dst)
 	/* Re-calculate channel and lun format to adapt to configuration */
 	power_len = get_count_order(geo->num_ch);
 	if (1 << power_len != geo->num_ch) {
-		pr_err("pblk: supports only power-of-two channel config.\n");
+		pblk_err(pblk, "supports only power-of-two channel config.\n");
 		return -EINVAL;
 	}
 	dst->ch_len = power_len;
 
 	power_len = get_count_order(geo->num_lun);
 	if (1 << power_len != geo->num_lun) {
-		pr_err("pblk: supports only power-of-two LUN config.\n");
+		pblk_err(pblk, "supports only power-of-two LUN config.\n");
 		return -EINVAL;
 	}
 	dst->lun_len = power_len;
@@ -285,18 +286,19 @@ static int pblk_set_addrf(struct pblk *pblk)
 	case NVM_OCSSD_SPEC_12:
 		div_u64_rem(geo->clba, pblk->min_write_pgs, &mod);
 		if (mod) {
-			pr_err("pblk: bad configuration of sectors/pages\n");
+			pblk_err(pblk, "bad configuration of sectors/pages\n");
 			return -EINVAL;
 		}
 
-		pblk->addrf_len = pblk_set_addrf_12(geo, (void *)&pblk->addrf);
+		pblk->addrf_len = pblk_set_addrf_12(pblk, geo,
+							(void *)&pblk->addrf);
 		break;
 	case NVM_OCSSD_SPEC_20:
 		pblk->addrf_len = pblk_set_addrf_20(geo, (void *)&pblk->addrf,
-								&pblk->uaddrf);
+							&pblk->uaddrf);
 		break;
 	default:
-		pr_err("pblk: OCSSD revision not supported (%d)\n",
+		pblk_err(pblk, "OCSSD revision not supported (%d)\n",
 								geo->version);
 		return -EINVAL;
 	}
@@ -375,7 +377,7 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
 
 	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
-		pr_err("pblk: vector list too big(%u > %u)\n",
+		pblk_err(pblk, "vector list too big(%u > %u)\n",
 				pblk->max_write_pgs, PBLK_MAX_REQ_ADDRS);
 		return -EINVAL;
 	}
@@ -608,7 +610,7 @@ static int pblk_luns_init(struct pblk *pblk)
 
 	/* TODO: Implement unbalanced LUN support */
 	if (geo->num_lun < 0) {
-		pr_err("pblk: unbalanced LUN config.\n");
+		pblk_err(pblk, "unbalanced LUN config.\n");
 		return -EINVAL;
 	}
 
@@ -1027,7 +1029,7 @@ static int pblk_line_meta_init(struct pblk *pblk)
 					lm->emeta_sec[0], geo->clba);
 
 	if (lm->min_blk_line > lm->blk_per_line) {
-		pr_err("pblk: config. not supported. Min. LUN in line:%d\n",
+		pblk_err(pblk, "config. not supported. Min. LUN in line:%d\n",
 							lm->blk_per_line);
 		return -EINVAL;
 	}
@@ -1079,7 +1081,7 @@ static int pblk_lines_init(struct pblk *pblk)
 	}
 
 	if (!nr_free_chks) {
-		pr_err("pblk: too many bad blocks prevent for sane instance\n");
+		pblk_err(pblk, "too many bad blocks prevent for sane instance\n");
 		return -EINTR;
 	}
 
@@ -1109,7 +1111,7 @@ static int pblk_writer_init(struct pblk *pblk)
 		int err = PTR_ERR(pblk->writer_ts);
 
 		if (err != -EINTR)
-			pr_err("pblk: could not allocate writer kthread (%d)\n",
+			pblk_err(pblk, "could not allocate writer kthread (%d)\n",
 					err);
 		return err;
 	}
@@ -1155,7 +1157,7 @@ static void pblk_tear_down(struct pblk *pblk, bool graceful)
 	pblk_rb_sync_l2p(&pblk->rwb);
 	pblk_rl_free(&pblk->rl);
 
-	pr_debug("pblk: consistent tear down (graceful:%d)\n", graceful);
+	pblk_debug(pblk, "consistent tear down (graceful:%d)\n", graceful);
 }
 
 static void pblk_exit(void *private, bool graceful)
@@ -1167,7 +1169,7 @@ static void pblk_exit(void *private, bool graceful)
 	pblk_tear_down(pblk, graceful);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
-	pr_info("pblk exit: L2P CRC: %x\n", pblk_l2p_crc(pblk));
+	pblk_info(pblk, "exit: L2P CRC: %x\n", pblk_l2p_crc(pblk));
 #endif
 
 	pblk_free(pblk);
@@ -1190,20 +1192,6 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	struct pblk *pblk;
 	int ret;
 
-	/* pblk supports 1.2 and 2.0 versions */
-	if (!(geo->version == NVM_OCSSD_SPEC_12 ||
-					geo->version == NVM_OCSSD_SPEC_20)) {
-		pr_err("pblk: OCSSD version not supported (%u)\n",
-							geo->version);
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
-		pr_err("pblk: host-side L2P table not supported. (%x)\n",
-							geo->dom);
-		return ERR_PTR(-EINVAL);
-	}
-
 	pblk = kzalloc(sizeof(struct pblk), GFP_KERNEL);
 	if (!pblk)
 		return ERR_PTR(-ENOMEM);
@@ -1213,6 +1201,21 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	pblk->state = PBLK_STATE_RUNNING;
 	pblk->gc.gc_enabled = 0;
 
+	if (!(geo->version == NVM_OCSSD_SPEC_12 ||
+					geo->version == NVM_OCSSD_SPEC_20)) {
+		pblk_err(pblk, "OCSSD version not supported (%u)\n",
+							geo->version);
+		kfree(pblk);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
+		pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
+							geo->dom);
+		kfree(pblk);
+		return ERR_PTR(-EINVAL);
+	}
+
 	spin_lock_init(&pblk->resubmit_lock);
 	spin_lock_init(&pblk->trans_lock);
 	spin_lock_init(&pblk->lock);
@@ -1242,38 +1245,38 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 
 	ret = pblk_core_init(pblk);
 	if (ret) {
-		pr_err("pblk: could not initialize core\n");
+		pblk_err(pblk, "could not initialize core\n");
 		goto fail;
 	}
 
 	ret = pblk_lines_init(pblk);
 	if (ret) {
-		pr_err("pblk: could not initialize lines\n");
+		pblk_err(pblk, "could not initialize lines\n");
 		goto fail_free_core;
 	}
 
 	ret = pblk_rwb_init(pblk);
 	if (ret) {
-		pr_err("pblk: could not initialize write buffer\n");
+		pblk_err(pblk, "could not initialize write buffer\n");
 		goto fail_free_lines;
 	}
 
 	ret = pblk_l2p_init(pblk, flags & NVM_TARGET_FACTORY);
 	if (ret) {
-		pr_err("pblk: could not initialize maps\n");
+		pblk_err(pblk, "could not initialize maps\n");
 		goto fail_free_rwb;
 	}
 
 	ret = pblk_writer_init(pblk);
 	if (ret) {
 		if (ret != -EINTR)
-			pr_err("pblk: could not initialize write thread\n");
+			pblk_err(pblk, "could not initialize write thread\n");
 		goto fail_free_l2p;
 	}
 
 	ret = pblk_gc_init(pblk);
 	if (ret) {
-		pr_err("pblk: could not initialize gc\n");
+		pblk_err(pblk, "could not initialize gc\n");
 		goto fail_stop_writer;
 	}
 
@@ -1288,8 +1291,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	blk_queue_max_discard_sectors(tqueue, UINT_MAX >> 9);
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, tqueue);
 
-	pr_info("pblk(%s): luns:%u, lines:%d, secs:%llu, buf entries:%u\n",
-			tdisk->disk_name,
+	pblk_info(pblk, "luns:%u, lines:%d, secs:%llu, buf entries:%u\n",
 			geo->all_luns, pblk->l_mg.nr_lines,
 			(unsigned long long)pblk->rl.nr_secs,
 			pblk->rwb.nr_entries);
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 529def80966b..f6eec0212dfc 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -547,7 +547,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
 
 		page = virt_to_page(entry->data);
 		if (!page) {
-			pr_err("pblk: could not allocate write bio page\n");
+			pblk_err(pblk, "could not allocate write bio page\n");
 			flags &= ~PBLK_WRITTEN_DATA;
 			flags |= PBLK_SUBMITTED_ENTRY;
 			/* Release flags on context. Protect from writes */
@@ -557,7 +557,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
 
 		if (bio_add_pc_page(q, bio, page, rb->seg_size, 0) !=
 								rb->seg_size) {
-			pr_err("pblk: could not add page to write bio\n");
+			pblk_err(pblk, "could not add page to write bio\n");
 			flags &= ~PBLK_WRITTEN_DATA;
 			flags |= PBLK_SUBMITTED_ENTRY;
 			/* Release flags on context. Protect from writes */
@@ -576,14 +576,14 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
 
 	if (pad) {
 		if (pblk_bio_add_pages(pblk, bio, GFP_KERNEL, pad)) {
-			pr_err("pblk: could not pad page in write bio\n");
+			pblk_err(pblk, "could not pad page in write bio\n");
 			return NVM_IO_ERR;
 		}
 
 		if (pad < pblk->min_write_pgs)
 			atomic64_inc(&pblk->pad_dist[pad - 1]);
 		else
-			pr_warn("pblk: padding more than min. sectors\n");
+			pblk_warn(pblk, "padding more than min. sectors\n");
 
 		atomic64_add(pad, &pblk->pad_wa);
 	}
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index bcfc6ea86e9d..9c9362b20861 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -121,9 +121,9 @@ static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 			struct ppa_addr *p;
 
 			p = (nr_lbas == 1) ? &rqd->ppa_list[i] : &rqd->ppa_addr;
-			print_ppa(&pblk->dev->geo, p, "seq", i);
+			print_ppa(pblk, p, "seq", i);
 #endif
-			pr_err("pblk: corrupted read LBA (%llu/%llu)\n",
+			pblk_err(pblk, "corrupted read LBA (%llu/%llu)\n",
 							lba, (u64)blba + i);
 			WARN_ON(1);
 		}
@@ -154,9 +154,9 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 			int nr_ppas = rqd->nr_ppas;
 
 			p = (nr_ppas == 1) ? &rqd->ppa_list[j] : &rqd->ppa_addr;
-			print_ppa(&pblk->dev->geo, p, "seq", j);
+			print_ppa(pblk, p, "seq", j);
 #endif
-			pr_err("pblk: corrupted read LBA (%llu/%llu)\n",
+			pblk_err(pblk, "corrupted read LBA (%llu/%llu)\n",
 								lba, meta_lba);
 			WARN_ON(1);
 		}
@@ -256,7 +256,7 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 		goto fail_add_pages;
 
 	if (nr_holes != new_bio->bi_vcnt) {
-		pr_err("pblk: malformed bio\n");
+		pblk_err(pblk, "malformed bio\n");
 		goto fail;
 	}
 
@@ -279,7 +279,7 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 	ret = pblk_submit_io_sync(pblk, rqd);
 	if (ret) {
 		bio_put(rqd->bio);
-		pr_err("pblk: sync read IO submission failed\n");
+		pblk_err(pblk, "sync read IO submission failed\n");
 		goto fail;
 	}
 
@@ -346,7 +346,7 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 	/* Free allocated pages in new bio */
 	pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
 fail_add_pages:
-	pr_err("pblk: failed to perform partial read\n");
+	pblk_err(pblk, "failed to perform partial read\n");
 	__pblk_end_io_read(pblk, rqd, false);
 	return NVM_IO_ERR;
 }
@@ -436,7 +436,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
 							&rqd->dma_meta_list);
 	if (!rqd->meta_list) {
-		pr_err("pblk: not able to allocate ppa list\n");
+		pblk_err(pblk, "not able to allocate ppa list\n");
 		goto fail_rqd_free;
 	}
 
@@ -462,14 +462,14 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		/* Clone read bio to deal with read errors internally */
 		int_bio = bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
 		if (!int_bio) {
-			pr_err("pblk: could not clone read bio\n");
+			pblk_err(pblk, "could not clone read bio\n");
 			goto fail_end_io;
 		}
 
 		rqd->bio = int_bio;
 
 		if (pblk_submit_io(pblk, rqd)) {
-			pr_err("pblk: read IO submission failed\n");
+			pblk_err(pblk, "read IO submission failed\n");
 			ret = NVM_IO_ERR;
 			goto fail_end_io;
 		}
@@ -595,7 +595,8 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 	bio = pblk_bio_map_addr(pblk, gc_rq->data, gc_rq->secs_to_gc, data_len,
 						PBLK_VMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
-		pr_err("pblk: could not allocate GC bio (%lu)\n", PTR_ERR(bio));
+		pblk_err(pblk, "could not allocate GC bio (%lu)\n",
+				PTR_ERR(bio));
 		goto err_free_dma;
 	}
 
@@ -609,7 +610,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 
 	if (pblk_submit_io_sync(pblk, &rqd)) {
 		ret = -EIO;
-		pr_err("pblk: GC read request failed\n");
+		pblk_err(pblk, "GC read request failed\n");
 		goto err_free_bio;
 	}
 
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index d83466b3821b..e232e47e1353 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -77,7 +77,7 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 	}
 
 	if (nr_valid_lbas != nr_lbas)
-		pr_err("pblk: line %d - inconsistent lba list(%llu/%llu)\n",
+		pblk_err(pblk, "line %d - inconsistent lba list(%llu/%llu)\n",
 				line->id, nr_valid_lbas, nr_lbas);
 
 	line->left_msecs = 0;
@@ -184,7 +184,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 	/* If read fails, more padding is needed */
 	ret = pblk_submit_io_sync(pblk, rqd);
 	if (ret) {
-		pr_err("pblk: I/O submission failed: %d\n", ret);
+		pblk_err(pblk, "I/O submission failed: %d\n", ret);
 		return ret;
 	}
 
@@ -194,7 +194,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 	 * we cannot recover from here. Need FTL log.
 	 */
 	if (rqd->error && rqd->error != NVM_RSP_WARN_HIGHECC) {
-		pr_err("pblk: L2P recovery failed (%d)\n", rqd->error);
+		pblk_err(pblk, "L2P recovery failed (%d)\n", rqd->error);
 		return -EINTR;
 	}
 
@@ -273,7 +273,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 next_pad_rq:
 	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
 	if (rq_ppas < pblk->min_write_pgs) {
-		pr_err("pblk: corrupted pad line %d\n", line->id);
+		pblk_err(pblk, "corrupted pad line %d\n", line->id);
 		goto fail_free_pad;
 	}
 
@@ -342,7 +342,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 
 	ret = pblk_submit_io(pblk, rqd);
 	if (ret) {
-		pr_err("pblk: I/O submission failed: %d\n", ret);
+		pblk_err(pblk, "I/O submission failed: %d\n", ret);
 		pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
 		goto fail_free_bio;
 	}
@@ -356,12 +356,12 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 
 	if (!wait_for_completion_io_timeout(&pad_rq->wait,
 				msecs_to_jiffies(PBLK_COMMAND_TIMEOUT_MS))) {
-		pr_err("pblk: pad write timed out\n");
+		pblk_err(pblk, "pad write timed out\n");
 		ret = -ETIME;
 	}
 
 	if (!pblk_line_is_full(line))
-		pr_err("pblk: corrupted padded line: %d\n", line->id);
+		pblk_err(pblk, "corrupted padded line: %d\n", line->id);
 
 	vfree(data);
 free_rq:
@@ -461,7 +461,7 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
 
 	ret = pblk_submit_io_sync(pblk, rqd);
 	if (ret) {
-		pr_err("pblk: I/O submission failed: %d\n", ret);
+		pblk_err(pblk, "I/O submission failed: %d\n", ret);
 		return ret;
 	}
 
@@ -501,11 +501,11 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
 
 		ret = pblk_recov_pad_oob(pblk, line, pad_secs);
 		if (ret)
-			pr_err("pblk: OOB padding failed (err:%d)\n", ret);
+			pblk_err(pblk, "OOB padding failed (err:%d)\n", ret);
 
 		ret = pblk_recov_read_oob(pblk, line, p, r_ptr);
 		if (ret)
-			pr_err("pblk: OOB read failed (err:%d)\n", ret);
+			pblk_err(pblk, "OOB read failed (err:%d)\n", ret);
 
 		left_ppas = 0;
 	}
@@ -592,7 +592,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 
 	ret = pblk_submit_io_sync(pblk, rqd);
 	if (ret) {
-		pr_err("pblk: I/O submission failed: %d\n", ret);
+		pblk_err(pblk, "I/O submission failed: %d\n", ret);
 		bio_put(bio);
 		return ret;
 	}
@@ -671,14 +671,14 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 
 	ret = pblk_recov_scan_oob(pblk, line, p, &done);
 	if (ret) {
-		pr_err("pblk: could not recover L2P from OOB\n");
+		pblk_err(pblk, "could not recover L2P from OOB\n");
 		goto out;
 	}
 
 	if (!done) {
 		ret = pblk_recov_scan_all_oob(pblk, line, p);
 		if (ret) {
-			pr_err("pblk: could not recover L2P from OOB\n");
+			pblk_err(pblk, "could not recover L2P from OOB\n");
 			goto out;
 		}
 	}
@@ -737,14 +737,14 @@ static int pblk_recov_check_line_version(struct pblk *pblk,
 	struct line_header *header = &emeta->header;
 
 	if (header->version_major != EMETA_VERSION_MAJOR) {
-		pr_err("pblk: line major version mismatch: %d, expected: %d\n",
-		       header->version_major, EMETA_VERSION_MAJOR);
+		pblk_err(pblk, "line major version mismatch: %d, expected: %d\n",
+			 header->version_major, EMETA_VERSION_MAJOR);
 		return 1;
 	}
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	if (header->version_minor > EMETA_VERSION_MINOR)
-		pr_info("pblk: newer line minor version found: %d\n",
+		pblk_info(pblk, "newer line minor version found: %d\n",
 				header->version_minor);
 #endif
 
@@ -852,7 +852,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			continue;
 
 		if (smeta_buf->header.version_major != SMETA_VERSION_MAJOR) {
-			pr_err("pblk: found incompatible line version %u\n",
+			pblk_err(pblk, "found incompatible line version %u\n",
 					smeta_buf->header.version_major);
 			return ERR_PTR(-EINVAL);
 		}
@@ -864,7 +864,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		}
 
 		if (memcmp(pblk->instance_uuid, smeta_buf->header.uuid, 16)) {
-			pr_debug("pblk: ignore line %u due to uuid mismatch\n",
+			pblk_debug(pblk, "ignore line %u due to uuid mismatch\n",
 					i);
 			continue;
 		}
@@ -888,7 +888,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 
 		pblk_recov_line_add_ordered(&recov_list, line);
 		found_lines++;
-		pr_debug("pblk: recovering data line %d, seq:%llu\n",
+		pblk_debug(pblk, "recovering data line %d, seq:%llu\n",
 						line->id, smeta_buf->seq_nr);
 	}
 
@@ -948,7 +948,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			line->emeta = NULL;
 		} else {
 			if (open_lines > 1)
-				pr_err("pblk: failed to recover L2P\n");
+				pblk_err(pblk, "failed to recover L2P\n");
 
 			open_lines++;
 			line->meta_line = meta_line;
@@ -977,7 +977,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 
 out:
 	if (found_lines != recovered_lines)
-		pr_err("pblk: failed to recover all found lines %d/%d\n",
+		pblk_err(pblk, "failed to recover all found lines %d/%d\n",
 						found_lines, recovered_lines);
 
 	return data_line;
@@ -1000,7 +1000,7 @@ int pblk_recov_pad(struct pblk *pblk)
 
 	ret = pblk_recov_pad_oob(pblk, line, left_msecs);
 	if (ret) {
-		pr_err("pblk: Tear down padding failed (%d)\n", ret);
+		pblk_err(pblk, "tear down padding failed (%d)\n", ret);
 		return ret;
 	}
 
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index b0e5e93a9d5f..9fc3dfa168b4 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -268,7 +268,7 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 	spin_unlock(&l_mg->free_lock);
 
 	if (nr_free_lines != free_line_cnt)
-		pr_err("pblk: corrupted free line list:%d/%d\n",
+		pblk_err(pblk, "corrupted free line list:%d/%d\n",
 						nr_free_lines, free_line_cnt);
 
 	sz = snprintf(page, PAGE_SIZE - sz,
@@ -697,8 +697,7 @@ int pblk_sysfs_init(struct gendisk *tdisk)
 					kobject_get(&parent_dev->kobj),
 					"%s", "pblk");
 	if (ret) {
-		pr_err("pblk: could not register %s/pblk\n",
-						tdisk->disk_name);
+		pblk_err(pblk, "could not register\n");
 		return ret;
 	}
 
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 5f44df999aed..ee774a86cf1e 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -238,7 +238,7 @@ static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
 
 	recovery = mempool_alloc(&pblk->rec_pool, GFP_ATOMIC);
 	if (!recovery) {
-		pr_err("pblk: could not allocate recovery work\n");
+		pblk_err(pblk, "could not allocate recovery work\n");
 		return;
 	}
 
@@ -279,7 +279,7 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 
 	if (rqd->error) {
 		pblk_log_write_err(pblk, rqd);
-		pr_err("pblk: metadata I/O failed. Line %d\n", line->id);
+		pblk_err(pblk, "metadata I/O failed. Line %d\n", line->id);
 		line->w_err_gc->has_write_err = 1;
 	}
 
@@ -360,7 +360,7 @@ static int pblk_calc_secs_to_sync(struct pblk *pblk, unsigned int secs_avail,
 	if ((!secs_to_sync && secs_to_flush)
 			|| (secs_to_sync < 0)
 			|| (secs_to_sync > secs_avail && !secs_to_flush)) {
-		pr_err("pblk: bad sector calculation (a:%d,s:%d,f:%d)\n",
+		pblk_err(pblk, "bad sector calculation (a:%d,s:%d,f:%d)\n",
 				secs_avail, secs_to_sync, secs_to_flush);
 	}
 #endif
@@ -397,7 +397,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
 					l_mg->emeta_alloc_type, GFP_KERNEL);
 	if (IS_ERR(bio)) {
-		pr_err("pblk: failed to map emeta io");
+		pblk_err(pblk, "failed to map emeta io");
 		ret = PTR_ERR(bio);
 		goto fail_free_rqd;
 	}
@@ -428,7 +428,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 
 	ret = pblk_submit_io(pblk, rqd);
 	if (ret) {
-		pr_err("pblk: emeta I/O submission failed: %d\n", ret);
+		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
 		goto fail_rollback;
 	}
 
@@ -518,7 +518,7 @@ static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 	/* Assign lbas to ppas and populate request structure */
 	err = pblk_setup_w_rq(pblk, rqd, &erase_ppa);
 	if (err) {
-		pr_err("pblk: could not setup write request: %d\n", err);
+		pblk_err(pblk, "could not setup write request: %d\n", err);
 		return NVM_IO_ERR;
 	}
 
@@ -527,7 +527,7 @@ static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 	/* Submit data write for current data line */
 	err = pblk_submit_io(pblk, rqd);
 	if (err) {
-		pr_err("pblk: data I/O submission failed: %d\n", err);
+		pblk_err(pblk, "data I/O submission failed: %d\n", err);
 		return NVM_IO_ERR;
 	}
 
@@ -549,7 +549,8 @@ static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 		/* Submit metadata write for previous data line */
 		err = pblk_submit_meta_io(pblk, meta_line);
 		if (err) {
-			pr_err("pblk: metadata I/O submission failed: %d", err);
+			pblk_err(pblk, "metadata I/O submission failed: %d",
+					err);
 			return NVM_IO_ERR;
 		}
 	}
@@ -614,7 +615,7 @@ static int pblk_submit_write(struct pblk *pblk)
 		secs_to_sync = pblk_calc_secs_to_sync(pblk, secs_avail,
 					secs_to_flush);
 		if (secs_to_sync > pblk->max_write_pgs) {
-			pr_err("pblk: bad buffer sync calculation\n");
+			pblk_err(pblk, "bad buffer sync calculation\n");
 			return 1;
 		}
 
@@ -633,7 +634,7 @@ static int pblk_submit_write(struct pblk *pblk)
 
 	if (pblk_rb_read_to_bio(&pblk->rwb, rqd, pos, secs_to_sync,
 								secs_avail)) {
-		pr_err("pblk: corrupted write bio\n");
+		pblk_err(pblk, "corrupted write bio\n");
 		goto fail_put_bio;
 	}
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index c072955d72c2..5c6904eb8557 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -703,6 +703,15 @@ struct pblk_line_ws {
 #define pblk_g_rq_size (sizeof(struct nvm_rq) + sizeof(struct pblk_g_ctx))
 #define pblk_w_rq_size (sizeof(struct nvm_rq) + sizeof(struct pblk_c_ctx))
 
+#define pblk_err(pblk, fmt, ...)			\
+	pr_err("pblk %s: " fmt, pblk->disk->disk_name, ##__VA_ARGS__)
+#define pblk_info(pblk, fmt, ...)			\
+	pr_info("pblk %s: " fmt, pblk->disk->disk_name, ##__VA_ARGS__)
+#define pblk_warn(pblk, fmt, ...)			\
+	pr_warn("pblk %s: " fmt, pblk->disk->disk_name, ##__VA_ARGS__)
+#define pblk_debug(pblk, fmt, ...)			\
+	pr_debug("pblk %s: " fmt, pblk->disk->disk_name, ##__VA_ARGS__)
+
 /*
  * pblk ring buffer operations
  */
@@ -1280,19 +1289,21 @@ static inline int pblk_io_aligned(struct pblk *pblk, int nr_secs)
 }
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
-static inline void print_ppa(struct nvm_geo *geo, struct ppa_addr *p,
+static inline void print_ppa(struct pblk *pblk, struct ppa_addr *p,
 			     char *msg, int error)
 {
+	struct nvm_geo *geo = &pblk->dev->geo;
+
 	if (p->c.is_cached) {
-		pr_err("ppa: (%s: %x) cache line: %llu\n",
+		pblk_err(pblk, "ppa: (%s: %x) cache line: %llu\n",
 				msg, error, (u64)p->c.line);
 	} else if (geo->version == NVM_OCSSD_SPEC_12) {
-		pr_err("ppa: (%s: %x):ch:%d,lun:%d,blk:%d,pg:%d,pl:%d,sec:%d\n",
+		pblk_err(pblk, "ppa: (%s: %x):ch:%d,lun:%d,blk:%d,pg:%d,pl:%d,sec:%d\n",
 			msg, error,
 			p->g.ch, p->g.lun, p->g.blk,
 			p->g.pg, p->g.pl, p->g.sec);
 	} else {
-		pr_err("ppa: (%s: %x):ch:%d,lun:%d,chk:%d,sec:%d\n",
+		pblk_err(pblk, "ppa: (%s: %x):ch:%d,lun:%d,chk:%d,sec:%d\n",
 			msg, error,
 			p->m.grp, p->m.pu, p->m.chk, p->m.sec);
 	}
@@ -1304,16 +1315,16 @@ static inline void pblk_print_failed_rqd(struct pblk *pblk, struct nvm_rq *rqd,
 	int bit = -1;
 
 	if (rqd->nr_ppas ==  1) {
-		print_ppa(&pblk->dev->geo, &rqd->ppa_addr, "rqd", error);
+		print_ppa(pblk, &rqd->ppa_addr, "rqd", error);
 		return;
 	}
 
 	while ((bit = find_next_bit((void *)&rqd->ppa_status, rqd->nr_ppas,
 						bit + 1)) < rqd->nr_ppas) {
-		print_ppa(&pblk->dev->geo, &rqd->ppa_list[bit], "rqd", error);
+		print_ppa(pblk, &rqd->ppa_list[bit], "rqd", error);
 	}
 
-	pr_err("error:%d, ppa_status:%llx\n", error, rqd->ppa_status);
+	pblk_err(pblk, "error:%d, ppa_status:%llx\n", error, rqd->ppa_status);
 }
 
 static inline int pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
@@ -1344,7 +1355,7 @@ static inline int pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
 				continue;
 		}
 
-		print_ppa(geo, ppa, "boundary", i);
+		print_ppa(tgt_dev->q->queuedata, ppa, "boundary", i);
 
 		return 1;
 	}
@@ -1374,7 +1385,7 @@ static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 
 			spin_lock(&line->lock);
 			if (line->state != PBLK_LINESTATE_OPEN) {
-				pr_err("pblk: bad ppa: line:%d,state:%d\n",
+				pblk_err(pblk, "bad ppa: line:%d,state:%d\n",
 							line->id, line->state);
 				WARN_ON(1);
 				spin_unlock(&line->lock);
-- 
2.11.0
