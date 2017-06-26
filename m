Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35659 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdFZJ6P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:15 -0400
Received: by mail-wm0-f41.google.com with SMTP id w126so2844254wme.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:14 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 04/20] lightnvm: pblk: add debug stat for read cache hits
Date: Mon, 26 Jun 2017 11:57:13 +0200
Message-Id: <1498471049-25505-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add a new debug counter to measure cache hits on the read path

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c  | 1 +
 drivers/lightnvm/pblk-read.c  | 6 ++++++
 drivers/lightnvm/pblk-sysfs.c | 3 ++-
 drivers/lightnvm/pblk.h       | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index ae8cd6d5af8b..3ec3deff709f 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -838,6 +838,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	atomic_long_set(&pblk->sync_writes, 0);
 	atomic_long_set(&pblk->compl_writes, 0);
 	atomic_long_set(&pblk->inflight_reads, 0);
+	atomic_long_set(&pblk->cache_reads, 0);
 	atomic_long_set(&pblk->sync_reads, 0);
 	atomic_long_set(&pblk->recov_writes, 0);
 	atomic_long_set(&pblk->recov_writes, 0);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 762c0b73cb67..91307297e444 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -76,6 +76,9 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			}
 			WARN_ON(test_and_set_bit(i, read_bitmap));
 			advanced_bio = 1;
+#ifdef CONFIG_NVM_DEBUG
+			atomic_long_inc(&pblk->cache_reads);
+#endif
 		} else {
 			/* Read from media non-cached sectors */
 			rqd->ppa_list[j++] = p;
@@ -280,6 +283,9 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			goto retry;
 		}
 		WARN_ON(test_and_set_bit(0, read_bitmap));
+#ifdef CONFIG_NVM_DEBUG
+			atomic_long_inc(&pblk->cache_reads);
+#endif
 	} else {
 		rqd->ppa_addr = ppa;
 	}
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index f0af1d1ceeff..3c1a586c09a2 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -294,7 +294,7 @@ static ssize_t pblk_sysfs_lines_info(struct pblk *pblk, char *page)
 static ssize_t pblk_sysfs_stats_debug(struct pblk *pblk, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-		"%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\n",
+		"%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\n",
 			atomic_long_read(&pblk->inflight_writes),
 			atomic_long_read(&pblk->inflight_reads),
 			atomic_long_read(&pblk->req_writes),
@@ -307,6 +307,7 @@ static ssize_t pblk_sysfs_stats_debug(struct pblk *pblk, char *page)
 			atomic_long_read(&pblk->recov_writes),
 			atomic_long_read(&pblk->recov_gc_writes),
 			atomic_long_read(&pblk->recov_gc_reads),
+			atomic_long_read(&pblk->cache_reads),
 			atomic_long_read(&pblk->sync_reads));
 }
 #endif
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 99f3186b5288..70b65d308dea 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -513,6 +513,7 @@ struct pblk {
 	atomic_long_t sync_writes;	/* Sectors synced to media */
 	atomic_long_t compl_writes;	/* Sectors completed in write bio */
 	atomic_long_t inflight_reads;	/* Inflight sector read requests */
+	atomic_long_t cache_reads;	/* Read requests that hit the cache */
 	atomic_long_t sync_reads;	/* Completed sector read requests */
 	atomic_long_t recov_writes;	/* Sectors submitted from recovery */
 	atomic_long_t recov_gc_writes;	/* Sectors submitted from write GC */
-- 
2.7.4
