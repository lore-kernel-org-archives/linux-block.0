Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A137FC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F93360F11
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbhHRGdv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbhHRGdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:33:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A68BC061764
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IAQIPftlELSH1/9hRsE95A7kNRHPhuK0f5/GC1npILU=; b=omnOpLwtD4d4aoifDgsub4Nq8I
        a0QESqqcoxiY1TXdFd5rTy44ClvG5m79agslCLM24iFx6kecVXzeXqvkOvM/QHdQAytuBv9Wf6GMC
        TyqBZuLoeIHYYB9ZasBHu/tro2537mB5/Qce7GS9wiYib5CMPFObDR8j/+AkhYrB08oBkEGzk/fq7
        d/J1VZIc6Ws81vlE6/EshpqFi2dVc6lwTWWzNQo4heziBbRJwLa6FjvxncKa4a8DHQELIYgpCrXe9
        R+6MQO5hfL++FZMxsLG6Zv4qBsT2NccAuaCNvEKD/L65ff0uTbQUvPCz/kqlX7u4QBqdHqNOMbmJL
        ysbZTV7A==;
Received: from 213-225-12-39.nat.highway.a1.net ([213.225.12.39] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGF6L-003RTQ-8o; Wed, 18 Aug 2021 06:31:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/7] loop: devirtualize transfer transformations
Date:   Wed, 18 Aug 2021 08:24:52 +0200
Message-Id: <20210818062455.211065-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818062455.211065-1-hch@lst.de>
References: <20210818062455.211065-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Besides the already special cased non-transform fastpath there are only
two different transfers.  Hardcode them instead of the maze of indirect
calls and switch the whole cryptoloop code to use IS_ENABLED for dead
code elimination.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 146 +++++++++++--------------------------------
 drivers/block/loop.h |  21 ++-----
 2 files changed, 41 insertions(+), 126 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8b187987904e..9176784d4fca 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -140,7 +140,7 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
 static int max_part;
 static int part_shift;
 
-static int transfer_xor(struct loop_device *lo, int cmd,
+static void xor_transfer(struct loop_device *lo, int cmd,
 			struct page *raw_page, unsigned raw_off,
 			struct page *loop_page, unsigned loop_off,
 			int size, sector_t real_block)
@@ -166,27 +166,14 @@ static int transfer_xor(struct loop_device *lo, int cmd,
 	kunmap_atomic(loop_buf);
 	kunmap_atomic(raw_buf);
 	cond_resched();
-	return 0;
 }
 
-static int xor_init(struct loop_device *lo, const struct loop_info64 *info)
+static inline bool is_cryptoloop(int encrypt_type)
 {
-	if (unlikely(info->lo_encrypt_key_size <= 0))
-		return -EINVAL;
-	return 0;
+	return IS_ENABLED(CONFIG_BLK_DEV_CRYPTOLOOP) &&
+		encrypt_type == LO_CRYPT_CRYPTOAPI;
 }
 
-static struct loop_func_table none_funcs = {
-	.number = LO_CRYPT_NONE,
-}; 
-
-static struct loop_func_table xor_funcs = {
-	.number = LO_CRYPT_XOR,
-	.transfer = transfer_xor,
-	.init = xor_init
-}; 
-
-#ifdef CONFIG_BLK_DEV_CRYPTOLOOP
 static int cryptoloop_init(struct loop_device *lo,
 		const struct loop_info64 *info)
 {
@@ -235,7 +222,7 @@ static int cryptoloop_init(struct loop_device *lo,
 					  info->lo_encrypt_key_size);
 	if (err != 0)
 		goto out_free_tfm;
-	lo->key_data = tfm;
+	lo->lo_encrypt_tfm = tfm;
 	return 0;
 
  out_free_tfm:
@@ -249,7 +236,7 @@ static int cryptoloop_transfer(struct loop_device *lo, int cmd,
 		struct page *raw_page, unsigned raw_off, struct page *loop_page,
 		unsigned loop_off, int size, sector_t IV)
 {
-	struct crypto_sync_skcipher *tfm = lo->key_data;
+	struct crypto_sync_skcipher *tfm = lo->lo_encrypt_tfm;
 	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
 	struct scatterlist sg_out;
 	struct scatterlist sg_in;
@@ -302,32 +289,11 @@ static int cryptoloop_transfer(struct loop_device *lo, int cmd,
 	err = 0;
 out:
 	skcipher_request_zero(req);
+	pr_err_ratelimited("loop: Transfer error at byte offset %llu, length %i.\n",
+			IV << 9, size);
 	return err;
 }
 
-static void cryptoloop_release(struct loop_device *lo)
-{
-	crypto_free_sync_skcipher(lo->key_data);
-	lo->key_data = NULL;
-}
-
-static struct loop_func_table cryptoloop_funcs = {
-	.number		= LO_CRYPT_CRYPTOAPI,
-	.init		= cryptoloop_init,
-	.transfer	= cryptoloop_transfer,
-	.release	= cryptoloop_release,
-};
-#endif /* CONFIG_BLK_DEV_CRYPTOLOOP */
-
-/* xfer_funcs[0] is special - its release function is never called */
-static struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
-	[LO_CRYPT_NONE]		= &none_funcs,
-	[LO_CRYPT_XOR]		= &xor_funcs,
-#ifdef CONFIG_BLK_DEV_CRYPTOLOOP
-	[LO_CRYPT_CRYPTOAPI]	= &cryptoloop_funcs,
-#endif
-};
-
 static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
 {
 	loff_t loopsize;
@@ -382,7 +348,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
 				!(lo->lo_offset & dio_align) &&
 				mapping->a_ops->direct_IO &&
-				!lo->transfer)
+				!lo->lo_encrypt_type)
 			use_dio = true;
 		else
 			use_dio = false;
@@ -448,16 +414,11 @@ lo_do_transfer(struct loop_device *lo, int cmd,
 	       struct page *lpage, unsigned loffs,
 	       int size, sector_t rblock)
 {
-	int ret;
-
-	ret = lo->transfer(lo, cmd, rpage, roffs, lpage, loffs, size, rblock);
-	if (likely(!ret))
-		return 0;
-
-	printk_ratelimited(KERN_ERR
-		"loop: Transfer error at byte offset %llu, length %i.\n",
-		(unsigned long long)rblock << 9, size);
-	return ret;
+	if (is_cryptoloop(lo->lo_encrypt_type))
+		return cryptoloop_transfer(lo, cmd, rpage, roffs, lpage, loffs,
+					   size, rblock);
+	xor_transfer(lo, cmd, rpage, roffs, lpage, loffs, size, rblock);
+	return 0;
 }
 
 static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
@@ -803,14 +764,14 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
-		if (lo->transfer)
+		if (lo->lo_encrypt_type)
 			return lo_write_transfer(lo, rq, pos);
 		else if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, WRITE);
 		else
 			return lo_write_simple(lo, rq, pos);
 	case REQ_OP_READ:
-		if (lo->transfer)
+		if (lo->lo_encrypt_type)
 			return lo_read_transfer(lo, rq, pos);
 		else if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, READ);
@@ -1227,33 +1188,6 @@ static void loop_update_rotational(struct loop_device *lo)
 		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
 }
 
-static void
-loop_release_xfer(struct loop_device *lo)
-{
-	struct loop_func_table *xfer = lo->lo_encryption;
-
-	if (xfer) {
-		if (xfer->release)
-			xfer->release(lo);
-		lo->transfer = NULL;
-		lo->lo_encryption = NULL;
-	}
-}
-
-static int
-loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
-	       const struct loop_info64 *i)
-{
-	int err = 0;
-
-	if (xfer && xfer->init) {
-		err = xfer->init(lo, i);
-		if (!err)
-			lo->lo_encryption = xfer;
-	}
-	return err;
-}
-
 /**
  * loop_set_status_from_info - configure device from loop_info
  * @lo: struct loop_device to configure
@@ -1267,29 +1201,28 @@ loop_set_status_from_info(struct loop_device *lo,
 			  const struct loop_info64 *info)
 {
 	int err;
-	struct loop_func_table *xfer;
 	kuid_t uid = current_uid();
 
 	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
 
-	loop_release_xfer(lo);
-
-	if (info->lo_encrypt_type) {
-		unsigned int type = info->lo_encrypt_type;
+	if (is_cryptoloop(lo->lo_encrypt_type))
+		crypto_free_sync_skcipher(lo->lo_encrypt_tfm);
+	lo->lo_encrypt_tfm = NULL;
 
-		if (type >= MAX_LO_CRYPT)
+	if (info->lo_encrypt_type == LO_CRYPT_XOR) {
+		if (info->lo_encrypt_key_size <= 0)
 			return -EINVAL;
-		xfer = xfer_funcs[type];
-		if (xfer == NULL)
+	} else if (is_cryptoloop(info->lo_encrypt_type)) {
+		err = cryptoloop_init(lo, info);
+		if (err)
+			return err;
+	} else {
+		if (info->lo_encrypt_type != LO_CRYPT_NONE)
 			return -EINVAL;
-	} else
-		xfer = NULL;
-
-	err = loop_init_xfer(lo, xfer, info);
-	if (err)
-		return err;
+	}
 
+	lo->lo_encrypt_type = info->lo_encrypt_type;
 	lo->lo_offset = info->lo_offset;
 	lo->lo_sizelimit = info->lo_sizelimit;
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
@@ -1297,10 +1230,6 @@ loop_set_status_from_info(struct loop_device *lo,
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
 	lo->lo_crypt_name[LO_NAME_SIZE-1] = 0;
 
-	if (!xfer)
-		xfer = &none_funcs;
-	lo->transfer = xfer->transfer;
-
 	lo->lo_flags = info->lo_flags;
 
 	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
@@ -1511,10 +1440,10 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	lo->lo_backing_file = NULL;
 	spin_unlock_irq(&lo->lo_lock);
 
-	loop_release_xfer(lo);
-	lo->transfer = NULL;
+	if (is_cryptoloop(lo->lo_encrypt_type))
+		crypto_free_sync_skcipher(lo->lo_encrypt_tfm);
+	lo->lo_encrypt_tfm = NULL;
 	lo->lo_device = NULL;
-	lo->lo_encryption = NULL;
 	lo->lo_offset = 0;
 	lo->lo_sizelimit = 0;
 	lo->lo_encrypt_key_size = 0;
@@ -1727,8 +1656,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	info->lo_flags = lo->lo_flags;
 	memcpy(info->lo_file_name, lo->lo_file_name, LO_NAME_SIZE);
 	memcpy(info->lo_crypt_name, lo->lo_crypt_name, LO_NAME_SIZE);
-	info->lo_encrypt_type =
-		lo->lo_encryption ? lo->lo_encryption->number : 0;
+	info->lo_encrypt_type = lo->lo_encrypt_type;
 	if (lo->lo_encrypt_key_size && capable(CAP_SYS_ADMIN)) {
 		info->lo_encrypt_key_size = lo->lo_encrypt_key_size;
 		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
@@ -1764,7 +1692,7 @@ loop_info64_from_old(const struct loop_info *info, struct loop_info64 *info64)
 	info64->lo_flags = info->lo_flags;
 	info64->lo_init[0] = info->lo_init[0];
 	info64->lo_init[1] = info->lo_init[1];
-	if (info->lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
+	if (is_cryptoloop(info->lo_encrypt_type))
 		memcpy(info64->lo_crypt_name, info->lo_name, LO_NAME_SIZE);
 	else
 		memcpy(info64->lo_file_name, info->lo_name, LO_NAME_SIZE);
@@ -1785,7 +1713,7 @@ loop_info64_to_old(const struct loop_info64 *info64, struct loop_info *info)
 	info->lo_flags = info64->lo_flags;
 	info->lo_init[0] = info64->lo_init[0];
 	info->lo_init[1] = info64->lo_init[1];
-	if (info->lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
+	if (is_cryptoloop(info->lo_encrypt_type))
 		memcpy(info->lo_name, info64->lo_crypt_name, LO_NAME_SIZE);
 	else
 		memcpy(info->lo_name, info64->lo_file_name, LO_NAME_SIZE);
@@ -2048,7 +1976,7 @@ loop_info64_from_compat(const struct compat_loop_info __user *arg,
 	info64->lo_flags = info.lo_flags;
 	info64->lo_init[0] = info.lo_init[0];
 	info64->lo_init[1] = info.lo_init[1];
-	if (info.lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
+	if (is_cryptoloop(info.lo_encrypt_type))
 		memcpy(info64->lo_crypt_name, info.lo_name, LO_NAME_SIZE);
 	else
 		memcpy(info64->lo_file_name, info.lo_name, LO_NAME_SIZE);
@@ -2077,7 +2005,7 @@ loop_info64_to_compat(const struct loop_info64 *info64,
 	info.lo_flags = info64->lo_flags;
 	info.lo_init[0] = info64->lo_init[0];
 	info.lo_init[1] = info64->lo_init[1];
-	if (info.lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
+	if (is_cryptoloop(info.lo_encrypt_type))
 		memcpy(info.lo_name, info64->lo_crypt_name, LO_NAME_SIZE);
 	else
 		memcpy(info.lo_name, info64->lo_file_name, LO_NAME_SIZE);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index dd12d7f1ce30..d14ce6bdc014 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -16,6 +16,8 @@
 #include <linux/mutex.h>
 #include <uapi/linux/loop.h>
 
+struct crypto_sync_skcipher;
+
 /* Possible states of device */
 enum {
 	Lo_unbound,
@@ -32,21 +34,17 @@ struct loop_device {
 	loff_t		lo_offset;
 	loff_t		lo_sizelimit;
 	int		lo_flags;
-	int		(*transfer)(struct loop_device *, int cmd,
-				    struct page *raw_page, unsigned raw_off,
-				    struct page *loop_page, unsigned loop_off,
-				    int size, sector_t real_block);
 	char		lo_file_name[LO_NAME_SIZE];
 	char		lo_crypt_name[LO_NAME_SIZE];
 	char		lo_encrypt_key[LO_KEY_SIZE];
 	int		lo_encrypt_key_size;
-	struct loop_func_table *lo_encryption;
+	int		lo_encrypt_type;
+	struct crypto_sync_skcipher *lo_encrypt_tfm; 
 	__u32           lo_init[2];
 	kuid_t		lo_key_owner;	/* Who set the key */
 
 	struct file *	lo_backing_file;
 	struct block_device *lo_device;
-	void		*key_data; 
 
 	gfp_t		old_gfp_mask;
 
@@ -79,15 +77,4 @@ struct loop_cmd {
 	struct cgroup_subsys_state *memcg_css;
 };
 
-/* Support for loadable transfer modules */
-struct loop_func_table {
-	int number;	/* filter type */ 
-	int (*transfer)(struct loop_device *lo, int cmd,
-			struct page *raw_page, unsigned raw_off,
-			struct page *loop_page, unsigned loop_off,
-			int size, sector_t real_block);
-	int (*init)(struct loop_device *, const struct loop_info64 *); 
-	void (*release)(struct loop_device *); 
-}; 
-
 #endif
-- 
2.30.2

