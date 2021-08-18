Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3CDC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963826103A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbhHRGdK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbhHRGdF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:33:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EA9C0611BE
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CThYPac9DIckPTASsrC7EvRahC9uloAP5ZnCk+n63Vs=; b=UAbPGqU0J/0YnToeZmh6J1YFTJ
        QTBQH0r7L+uYZpqoaAhA8HIgezeFNgqmGFXTatYrKfxo2J45kFAsiW/myIAt/sRH1shBghluQxqM0
        zJuS4IFaR2AiPF1vGohL70l8zzvgq+dUve6M3N+X244VXFbENrPPeeps8ZirTMbzUDhaV1uvCujb4
        OT/WHMugcbNquLe2Rvic0se8YwCAvo+ot4S4cOxlz3OLn5/9BssdvSEGOXi8SGRRuRt8RcAcbP7VQ
        WNOYMP/xhaBKvoYQshg2MaxMsKtarc71tDVTTP4P9hyW69/JGT+7O6f0m3JRi/OD0q2n8RNA8fMmw
        Zm+U2UPw==;
Received: from 213-225-12-39.nat.highway.a1.net ([213.225.12.39] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGF51-003RL8-0D; Wed, 18 Aug 2021 06:30:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 3/7] loop: merge the cryptoloop module into the main loop module
Date:   Wed, 18 Aug 2021 08:24:51 +0200
Message-Id: <20210818062455.211065-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818062455.211065-1-hch@lst.de>
References: <20210818062455.211065-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need to keep a separate loadable module infrastructure for a tiny
amount of cryptoapi glue, especially as unloading of the cryptoloop
module leads to nasty interactions with the loop device state machine
through loop_unregister_transfer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/Kconfig      |   6 +-
 drivers/block/Makefile     |   1 -
 drivers/block/cryptoloop.c | 191 -----------------------------------
 drivers/block/loop.c       | 202 +++++++++++++++++++++++++++----------
 drivers/block/loop.h       |   5 -
 5 files changed, 153 insertions(+), 252 deletions(-)
 delete mode 100644 drivers/block/cryptoloop.c

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 63056cfd4b62..c63386576ef6 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -156,6 +156,8 @@ config BLK_DEV_COW_COMMON
 
 config BLK_DEV_LOOP
 	tristate "Loopback device support"
+	select CRYPTO if CRYPTOLOOP
+	select CRYPTO_CBC if CRYPTOLOOP
 	help
 	  Saying Y here will allow you to use a regular file as a block
 	  device; you can then create a file system on that block device and
@@ -213,9 +215,7 @@ config BLK_DEV_LOOP_MIN_COUNT
 	  dynamically allocated with the /dev/loop-control interface.
 
 config BLK_DEV_CRYPTOLOOP
-	tristate "Cryptoloop Support"
-	select CRYPTO
-	select CRYPTO_CBC
+	bool "Cryptoloop Support"
 	depends on BLK_DEV_LOOP
 	help
 	  Say Y here if you want to be able to use the ciphers that are 
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index bc68817ef496..11a74f17c9ad 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -24,7 +24,6 @@ obj-$(CONFIG_CDROM_PKTCDVD)	+= pktcdvd.o
 obj-$(CONFIG_SUNVDC)		+= sunvdc.o
 
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
-obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
 obj-$(CONFIG_VIRTIO_BLK)	+= virtio_blk.o
 
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
deleted file mode 100644
index 1d9e56860e56..000000000000
--- a/drivers/block/cryptoloop.c
+++ /dev/null
@@ -1,191 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
-   Linux loop encryption enabling module
-
-   Copyright (C)  2002 Herbert Valerio Riedel <hvr@gnu.org>
-   Copyright (C)  2003 Fruhwirth Clemens <clemens@endorphin.org>
-
- */
-
-#include <linux/module.h>
-
-#include <crypto/skcipher.h>
-#include <linux/init.h>
-#include <linux/string.h>
-#include <linux/blkdev.h>
-#include <linux/scatterlist.h>
-#include <linux/uaccess.h>
-#include "loop.h"
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("loop blockdevice transferfunction adaptor / CryptoAPI");
-MODULE_AUTHOR("Herbert Valerio Riedel <hvr@gnu.org>");
-
-#define LOOP_IV_SECTOR_BITS 9
-#define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)
-
-static int
-cryptoloop_init(struct loop_device *lo, const struct loop_info64 *info)
-{
-	int err = -EINVAL;
-	int cipher_len;
-	int mode_len;
-	char cms[LO_NAME_SIZE];			/* cipher-mode string */
-	char *mode;
-	char *cmsp = cms;			/* c-m string pointer */
-	struct crypto_sync_skcipher *tfm;
-
-	/* encryption breaks for non sector aligned offsets */
-
-	if (info->lo_offset % LOOP_IV_SECTOR_SIZE)
-		goto out;
-
-	strncpy(cms, info->lo_crypt_name, LO_NAME_SIZE);
-	cms[LO_NAME_SIZE - 1] = 0;
-
-	cipher_len = strcspn(cmsp, "-");
-
-	mode = cmsp + cipher_len;
-	mode_len = 0;
-	if (*mode) {
-		mode++;
-		mode_len = strcspn(mode, "-");
-	}
-
-	if (!mode_len) {
-		mode = "cbc";
-		mode_len = 3;
-	}
-
-	if (cipher_len + mode_len + 3 > LO_NAME_SIZE)
-		return -EINVAL;
-
-	memmove(cms, mode, mode_len);
-	cmsp = cms + mode_len;
-	*cmsp++ = '(';
-	memcpy(cmsp, info->lo_crypt_name, cipher_len);
-	cmsp += cipher_len;
-	*cmsp++ = ')';
-	*cmsp = 0;
-
-	tfm = crypto_alloc_sync_skcipher(cms, 0, 0);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	err = crypto_sync_skcipher_setkey(tfm, info->lo_encrypt_key,
-					  info->lo_encrypt_key_size);
-
-	if (err != 0)
-		goto out_free_tfm;
-
-	lo->key_data = tfm;
-	return 0;
-
- out_free_tfm:
-	crypto_free_sync_skcipher(tfm);
-
- out:
-	return err;
-}
-
-
-typedef int (*encdec_cbc_t)(struct skcipher_request *req);
-
-static int
-cryptoloop_transfer(struct loop_device *lo, int cmd,
-		    struct page *raw_page, unsigned raw_off,
-		    struct page *loop_page, unsigned loop_off,
-		    int size, sector_t IV)
-{
-	struct crypto_sync_skcipher *tfm = lo->key_data;
-	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
-	struct scatterlist sg_out;
-	struct scatterlist sg_in;
-
-	encdec_cbc_t encdecfunc;
-	struct page *in_page, *out_page;
-	unsigned in_offs, out_offs;
-	int err;
-
-	skcipher_request_set_sync_tfm(req, tfm);
-	skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
-				      NULL, NULL);
-
-	sg_init_table(&sg_out, 1);
-	sg_init_table(&sg_in, 1);
-
-	if (cmd == READ) {
-		in_page = raw_page;
-		in_offs = raw_off;
-		out_page = loop_page;
-		out_offs = loop_off;
-		encdecfunc = crypto_skcipher_decrypt;
-	} else {
-		in_page = loop_page;
-		in_offs = loop_off;
-		out_page = raw_page;
-		out_offs = raw_off;
-		encdecfunc = crypto_skcipher_encrypt;
-	}
-
-	while (size > 0) {
-		const int sz = min(size, LOOP_IV_SECTOR_SIZE);
-		u32 iv[4] = { 0, };
-		iv[0] = cpu_to_le32(IV & 0xffffffff);
-
-		sg_set_page(&sg_in, in_page, sz, in_offs);
-		sg_set_page(&sg_out, out_page, sz, out_offs);
-
-		skcipher_request_set_crypt(req, &sg_in, &sg_out, sz, iv);
-		err = encdecfunc(req);
-		if (err)
-			goto out;
-
-		IV++;
-		size -= sz;
-		in_offs += sz;
-		out_offs += sz;
-	}
-
-	err = 0;
-
-out:
-	skcipher_request_zero(req);
-	return err;
-}
-
-static void
-cryptoloop_release(struct loop_device *lo)
-{
-	crypto_free_sync_skcipher(lo->key_data);
-	lo->key_data = NULL;
-}
-
-static struct loop_func_table cryptoloop_funcs = {
-	.number = LO_CRYPT_CRYPTOAPI,
-	.init = cryptoloop_init,
-	.transfer = cryptoloop_transfer,
-	.release = cryptoloop_release,
-	.owner = THIS_MODULE
-};
-
-static int __init
-init_cryptoloop(void)
-{
-	int rc = loop_register_transfer(&cryptoloop_funcs);
-
-	if (rc)
-		printk(KERN_ERR "cryptoloop: loop_register_transfer failed\n");
-	return rc;
-}
-
-static void __exit
-cleanup_cryptoloop(void)
-{
-	if (loop_unregister_transfer(LO_CRYPT_CRYPTOAPI))
-		printk(KERN_ERR
-			"cryptoloop: loop_unregister_transfer failed\n");
-}
-
-module_init(init_cryptoloop);
-module_exit(cleanup_cryptoloop);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d63e9f2c9e9b..8b187987904e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -39,6 +39,10 @@
  * Support up to 256 loop devices
  * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
  *
+ * Cryptoloop support:
+ * Copyright (C)  2002 Herbert Valerio Riedel <hvr@gnu.org>
+ * Copyright (C)  2003 Fruhwirth Clemens <clemens@endorphin.org>
+ *
  * Support for falling back on the write file operation when the address space
  * operations write_begin is not available on the backing filesystem.
  * Anton Altaparmakov, 16 Feb 2005
@@ -79,13 +83,16 @@
 #include <linux/ioprio.h>
 #include <linux/blk-cgroup.h>
 #include <linux/sched/mm.h>
-
+#include <crypto/skcipher.h>
 #include "loop.h"
 
 #include <linux/uaccess.h>
 
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
 
+#define LOOP_IV_SECTOR_BITS 9
+#define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)
+
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
@@ -179,10 +186,146 @@ static struct loop_func_table xor_funcs = {
 	.init = xor_init
 }; 
 
+#ifdef CONFIG_BLK_DEV_CRYPTOLOOP
+static int cryptoloop_init(struct loop_device *lo,
+		const struct loop_info64 *info)
+{
+	int err = -EINVAL;
+	int cipher_len;
+	int mode_len;
+	char cms[LO_NAME_SIZE];			/* cipher-mode string */
+	char *mode;
+	char *cmsp = cms;			/* c-m string pointer */
+	struct crypto_sync_skcipher *tfm;
+
+	/* encryption breaks for non sector aligned offsets */
+	if (info->lo_offset % LOOP_IV_SECTOR_SIZE)
+		return -EINVAL;
+
+	strncpy(cms, info->lo_crypt_name, LO_NAME_SIZE);
+	cms[LO_NAME_SIZE - 1] = 0;
+
+	cipher_len = strcspn(cmsp, "-");
+	mode = cmsp + cipher_len;
+	mode_len = 0;
+	if (*mode) {
+		mode++;
+		mode_len = strcspn(mode, "-");
+	}
+	if (!mode_len) {
+		mode = "cbc";
+		mode_len = 3;
+	}
+	if (cipher_len + mode_len + 3 > LO_NAME_SIZE)
+		return -EINVAL;
+
+	memmove(cms, mode, mode_len);
+	cmsp = cms + mode_len;
+	*cmsp++ = '(';
+	memcpy(cmsp, info->lo_crypt_name, cipher_len);
+	cmsp += cipher_len;
+	*cmsp++ = ')';
+	*cmsp = 0;
+
+	tfm = crypto_alloc_sync_skcipher(cms, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	err = crypto_sync_skcipher_setkey(tfm, info->lo_encrypt_key,
+					  info->lo_encrypt_key_size);
+	if (err != 0)
+		goto out_free_tfm;
+	lo->key_data = tfm;
+	return 0;
+
+ out_free_tfm:
+	crypto_free_sync_skcipher(tfm);
+	return err;
+}
+
+typedef int (*encdec_cbc_t)(struct skcipher_request *req);
+
+static int cryptoloop_transfer(struct loop_device *lo, int cmd,
+		struct page *raw_page, unsigned raw_off, struct page *loop_page,
+		unsigned loop_off, int size, sector_t IV)
+{
+	struct crypto_sync_skcipher *tfm = lo->key_data;
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	struct scatterlist sg_out;
+	struct scatterlist sg_in;
+
+	encdec_cbc_t encdecfunc;
+	struct page *in_page, *out_page;
+	unsigned in_offs, out_offs;
+	int err;
+
+	skcipher_request_set_sync_tfm(req, tfm);
+	skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
+				      NULL, NULL);
+
+	sg_init_table(&sg_out, 1);
+	sg_init_table(&sg_in, 1);
+
+	if (cmd == READ) {
+		in_page = raw_page;
+		in_offs = raw_off;
+		out_page = loop_page;
+		out_offs = loop_off;
+		encdecfunc = crypto_skcipher_decrypt;
+	} else {
+		in_page = loop_page;
+		in_offs = loop_off;
+		out_page = raw_page;
+		out_offs = raw_off;
+		encdecfunc = crypto_skcipher_encrypt;
+	}
+
+	while (size > 0) {
+		const int sz = min(size, LOOP_IV_SECTOR_SIZE);
+		u32 iv[4] = { 0, };
+		iv[0] = cpu_to_le32(IV & 0xffffffff);
+
+		sg_set_page(&sg_in, in_page, sz, in_offs);
+		sg_set_page(&sg_out, out_page, sz, out_offs);
+
+		skcipher_request_set_crypt(req, &sg_in, &sg_out, sz, iv);
+		err = encdecfunc(req);
+		if (err)
+			goto out;
+
+		IV++;
+		size -= sz;
+		in_offs += sz;
+		out_offs += sz;
+	}
+
+	err = 0;
+out:
+	skcipher_request_zero(req);
+	return err;
+}
+
+static void cryptoloop_release(struct loop_device *lo)
+{
+	crypto_free_sync_skcipher(lo->key_data);
+	lo->key_data = NULL;
+}
+
+static struct loop_func_table cryptoloop_funcs = {
+	.number		= LO_CRYPT_CRYPTOAPI,
+	.init		= cryptoloop_init,
+	.transfer	= cryptoloop_transfer,
+	.release	= cryptoloop_release,
+};
+#endif /* CONFIG_BLK_DEV_CRYPTOLOOP */
+
 /* xfer_funcs[0] is special - its release function is never called */
 static struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
-	&none_funcs,
-	&xor_funcs
+	[LO_CRYPT_NONE]		= &none_funcs,
+	[LO_CRYPT_XOR]		= &xor_funcs,
+#ifdef CONFIG_BLK_DEV_CRYPTOLOOP
+	[LO_CRYPT_CRYPTOAPI]	= &cryptoloop_funcs,
+#endif
 };
 
 static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
@@ -1094,7 +1237,6 @@ loop_release_xfer(struct loop_device *lo)
 			xfer->release(lo);
 		lo->transfer = NULL;
 		lo->lo_encryption = NULL;
-		module_put(xfer->owner);
 	}
 }
 
@@ -1104,16 +1246,9 @@ loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
 {
 	int err = 0;
 
-	if (xfer) {
-		struct module *owner = xfer->owner;
-
-		if (!try_module_get(owner))
-			return -EINVAL;
-		if (xfer->init)
-			err = xfer->init(lo, i);
-		if (err)
-			module_put(owner);
-		else
+	if (xfer && xfer->init) {
+		err = xfer->init(lo, i);
+		if (!err)
 			lo->lo_encryption = xfer;
 	}
 	return err;
@@ -2094,44 +2229,7 @@ module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
-
-int loop_register_transfer(struct loop_func_table *funcs)
-{
-	unsigned int n = funcs->number;
-
-	if (n >= MAX_LO_CRYPT || xfer_funcs[n])
-		return -EINVAL;
-	xfer_funcs[n] = funcs;
-	return 0;
-}
-
-static int unregister_transfer_cb(int id, void *ptr, void *data)
-{
-	struct loop_device *lo = ptr;
-	struct loop_func_table *xfer = data;
-
-	mutex_lock(&lo->lo_mutex);
-	if (lo->lo_encryption == xfer)
-		loop_release_xfer(lo);
-	mutex_unlock(&lo->lo_mutex);
-	return 0;
-}
-
-int loop_unregister_transfer(int number)
-{
-	unsigned int n = number;
-	struct loop_func_table *xfer;
-
-	if (n == 0 || n >= MAX_LO_CRYPT || (xfer = xfer_funcs[n]) == NULL)
-		return -EINVAL;
-
-	xfer_funcs[n] = NULL;
-	idr_for_each(&loop_index_idr, &unregister_transfer_cb, xfer);
-	return 0;
-}
-
-EXPORT_SYMBOL(loop_register_transfer);
-EXPORT_SYMBOL(loop_unregister_transfer);
+MODULE_ALIAS("cryptoloop");
 
 static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 7b84ef724de1..dd12d7f1ce30 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -87,12 +87,7 @@ struct loop_func_table {
 			struct page *loop_page, unsigned loop_off,
 			int size, sector_t real_block);
 	int (*init)(struct loop_device *, const struct loop_info64 *); 
-	/* release is called from loop_unregister_transfer or clr_fd */
 	void (*release)(struct loop_device *); 
-	struct module *owner;
 }; 
 
-int loop_register_transfer(struct loop_func_table *funcs);
-int loop_unregister_transfer(int number); 
-
 #endif
-- 
2.30.2

