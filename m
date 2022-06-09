Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A21C43334
	for <linux-block@archiver.kernel.org>; Thu,  9 Jun 2022 16:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiFIQJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jun 2022 12:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiFIQJa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2022 12:09:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066D31212
        for <linux-block@vger.kernel.org>; Thu,  9 Jun 2022 09:09:26 -0700 (PDT)
Date:   Thu, 9 Jun 2022 18:09:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654790963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9T9BroPC8U1J8ThUR5sFvLY5XwQH7HjX+JJ0jqAEnvA=;
        b=4k7IZT2g4c6tjuH2C716VAHNpRaFrUaFylgJOAwlG1eqUqoQBHNdI07cGAm9/1/fVdbSHm
        mzUSv8On3p5Buc9OSd0IiCUlq9QbMf7qokWSSSB33C6AWMLF4nT5Vym5g22Ej3KJGXP8b9
        1468FHzeZs/wHM1wnYathd7iKclYV5eB57CP6XtxLBM5HIxJgYOvYnupazXQ3GTkkY01cH
        FhvFIpq640I1Pu1+EoHKR9I7NaPv+K1PZN4V075tsMVnFPZ0QltMldxrdBgWO9IQuciMDd
        4+ahw+4ni4KGd9mWhffuoGIBcWKeuCqG9eA7ROk6ZA/gw/1g/qgSzt3nGf5qlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654790963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9T9BroPC8U1J8ThUR5sFvLY5XwQH7HjX+JJ0jqAEnvA=;
        b=arAA6grq7+qH/FFdXmTkADPIS+S120DttN4g/UFvknhi5WlvmoDg7FM0bjQ5NCyvGyjkOh
        OzCeDlRcPcME61DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: zram: Replace bit spinlocks with spinlock_t for PREEMPT_RT.
Message-ID: <YqIbMuHCPiQk+Ac2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mike Galbraith <umgwanakikbuti@gmail.com>

The bit spinlock disables preemption on PREEMPT_RT. With disabled preemption it
is not allowed to acquire other sleeping locks which includes invoking
zs_free().

Use a spinlock_t on PREEMPT_RT for locking and set/ clear ZRAM_LOCK after the
lock has been acquired/ dropped.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

I'm simply forwarding Mike's patch here. The other alternative is to let
the driver depend on !PREEMPT_RT. I can't tell likely it is that this
driver is used. Mike most likely stumbled upon it while running LTP.

 drivers/block/zram/zram_drv.c |   36 ++++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.h |    3 +++
 2 files changed, 39 insertions(+)
---
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -58,6 +58,40 @@ static void zram_free_page(struct zram *
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 				u32 index, int offset, struct bio *bio);
 
+#ifdef CONFIG_PREEMPT_RT
+static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
+{
+	size_t index;
+
+	for (index = 0; index < num_pages; index++)
+		spin_lock_init(&zram->table[index].lock);
+}
+
+static int zram_slot_trylock(struct zram *zram, u32 index)
+{
+	int ret;
+
+	ret = spin_trylock(&zram->table[index].lock);
+	if (ret)
+		__set_bit(ZRAM_LOCK, &zram->table[index].flags);
+	return ret;
+}
+
+static void zram_slot_lock(struct zram *zram, u32 index)
+{
+	spin_lock(&zram->table[index].lock);
+	__set_bit(ZRAM_LOCK, &zram->table[index].flags);
+}
+
+static void zram_slot_unlock(struct zram *zram, u32 index)
+{
+	__clear_bit(ZRAM_LOCK, &zram->table[index].flags);
+	spin_unlock(&zram->table[index].lock);
+}
+
+#else
+
+static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages) { }
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
@@ -73,6 +107,7 @@ static void zram_slot_unlock(struct zram
 {
 	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].flags);
 }
+#endif
 
 static inline bool init_done(struct zram *zram)
 {
@@ -1195,6 +1230,7 @@ static bool zram_meta_alloc(struct zram
 
 	if (!huge_class_size)
 		huge_class_size = zs_huge_class_size(zram->mem_pool);
+	zram_meta_init_table_locks(zram, num_pages);
 	return true;
 }
 
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -63,6 +63,9 @@ struct zram_table_entry {
 		unsigned long element;
 	};
 	unsigned long flags;
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t lock;
+#endif
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	ktime_t ac_time;
 #endif

