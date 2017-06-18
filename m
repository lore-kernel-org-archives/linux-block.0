Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44905 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752998AbdFREke (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 00:40:34 -0400
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@fb.com>
Date: Sun, 18 Jun 2017 14:38:58 +1000
Subject: [PATCH 09/13] lightnvm/pblk-read: use bio_clone_fast()
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <149776073872.23258.5197619453109200550.stgit@noble>
In-Reply-To: <149776047907.23258.8058071140236879834.stgit@noble>
References: <149776047907.23258.8058071140236879834.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

pblk_submit_read() uses bio_clone_bioset() but doesn't change the
io_vec, so bio_clone_fast() is a better choice.

It also uses fs_bio_set which is intended for filesystems.  Using it
in a device driver can deadlock.
So allocate a new bioset, and and use bio_clone_fast().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Javier González <javier@cnexlabs.com>
Tested-by: Javier González <javier@cnexlabs.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/lightnvm/pblk-init.c |   12 +++++++++++-
 drivers/lightnvm/pblk-read.c |    2 +-
 drivers/lightnvm/pblk.h      |    1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b3fec8ec55b8..aaefbccce30e 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -23,6 +23,7 @@
 static struct kmem_cache *pblk_blk_ws_cache, *pblk_rec_cache, *pblk_r_rq_cache,
 					*pblk_w_rq_cache, *pblk_line_meta_cache;
 static DECLARE_RWSEM(pblk_lock);
+struct bio_set *pblk_bio_set;
 
 static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
 			  struct bio *bio)
@@ -946,11 +947,20 @@ static struct nvm_tgt_type tt_pblk = {
 
 static int __init pblk_module_init(void)
 {
-	return nvm_register_tgt_type(&tt_pblk);
+	int ret;
+
+	pblk_bio_set = bioset_create(BIO_POOL_SIZE, 0, 0);
+	if (!pblk_bio_set)
+		return -ENOMEM;
+	ret = nvm_register_tgt_type(&tt_pblk);
+	if (ret)
+		bioset_free(pblk_bio_set);
+	return ret;
 }
 
 static void pblk_module_exit(void)
 {
+	bioset_free(pblk_bio_set);
 	nvm_unregister_tgt_type(&tt_pblk);
 }
 
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 762c0b73cb67..74d3fc53022e 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -342,7 +342,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		struct pblk_r_ctx *r_ctx = nvm_rq_to_pdu(rqd);
 
 		/* Clone read bio to deal with read errors internally */
-		int_bio = bio_clone_bioset(bio, GFP_KERNEL, fs_bio_set);
+		int_bio = bio_clone_fast(bio, GFP_KERNEL, pblk_bio_set);
 		if (!int_bio) {
 			pr_err("pblk: could not clone read bio\n");
 			return NVM_IO_ERR;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 99f3186b5288..95b665f23925 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -702,6 +702,7 @@ void pblk_write_should_kick(struct pblk *pblk);
 /*
  * pblk read path
  */
+extern struct bio_set *pblk_bio_set;
 int pblk_submit_read(struct pblk *pblk, struct bio *bio);
 int pblk_submit_read_gc(struct pblk *pblk, u64 *lba_list, void *data,
 			unsigned int nr_secs, unsigned int *secs_to_gc,
