Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0044E335A7;
	Wed, 19 Jun 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809699; cv=none; b=CjJ3k4t6RejNNqyqvSwekDPOQkquq7Wvvx6Cq1T0+CaSKB/Fk0jUqA8aEcRDpTIY9oK3x+DWiaITccNWMzaP/1iXGqWzm4dsj0yHdGVlmNGYp4SABOn9jc8aq8PqhPzNoo9haeigT8HsjVyxKFha/U8OtYp+OGTxzxpqY18pSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809699; c=relaxed/simple;
	bh=ABCcemSNEbE7rCsra2BS0VgQhdESrD0mKGqGjnuktjM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P0sXGNsOsQN9FMRA5YhftQcbc35rpRF8WZMObR+wJOWai7csw3N4lAtmg66UFLp5unvBlA9RKo7Gqin3mP7vqR9ttuRNpRWmR6emRqp03mHS1d2i9QiyKpwb6xprlHcW9/Qx9Heboc9ilwkM6kVB1bweDgF2w0U9rlTJmgMNnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M9H415DL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l2bBuiLI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M9H415DL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l2bBuiLI"
Date: Wed, 19 Jun 2024 17:08:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718809695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pcjM/1ffZBGxlyWRn5r0TyHP3SCAYh82B8FLcXLwEjk=;
	b=M9H415DLEMuTH3BNGY2hAB05Bdy0jw3UZyqyG8n82jhz3PaFvT4audMJHBclNONJk+/F4u
	X4353plyV+3u4WdlyXzgyoL9MZSIsrH4Isv6omQEBygdPnnuX91VFxbeZ/e4UnnkWLECTh
	useg8S8ZxCPbSWCnhGolDyAlNoz4Km+Pmww5GF9olCO7ub9DnLOsVh4Mq0Otekx1cr2Sv+
	cp5ENfZYXSCUZBg5c4FfVRw9nlDob9BMK3xV+NkCUm1aykDun45QtLbTsDkLQI4wxieiql
	XbilGpBHCx7eY7JPVzajhqy0oGGZ+xdkbELJUxGhKcx4pGaMzSr8+qaEngz/CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718809695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pcjM/1ffZBGxlyWRn5r0TyHP3SCAYh82B8FLcXLwEjk=;
	b=l2bBuiLIXKpnLuJflb3Top7Xus3aTbUI+b1g1rJbL3PJxQuuHMvCuVOm3FnuUi653Xmxxq
	xYBPNBzmTWWLQCDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] zram: Replace bit spinlocks with spinlock_t for PREEMPT_RT.
Message-ID: <20240619150814.BRAvaziM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From: Mike Galbraith <umgwanakikbuti@gmail.com>

The bit spinlock disables preemption. The spinlock_t lock becomes a sleeping
lock on PREEMPT_RT and it can not be acquired in this context. In this locked
section, zs_free() acquires a zs_pool::lock, and there is access to
zram::wb_limit_lock.

Use a spinlock_t on PREEMPT_RT for locking and set/ clear ZRAM_LOCK bit after
the lock has been acquired/ dropped.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
I posted this few times. Mikes intents to keep it based on last feedback.
Any reason not to apply it?

https://lkml.kernel.org/r/YqIbMuHCPiQk+Ac2@linutronix.de
https://lore.kernel.org/20230323161830.jFbWCosd@linutronix.de

 drivers/block/zram/zram_drv.c |   37 +++++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.h |    3 +++
 2 files changed, 40 insertions(+)

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -57,6 +57,41 @@ static void zram_free_page(struct zram *
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 			  struct bio *parent);
 
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
+
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
 	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].flags);
@@ -71,6 +106,7 @@ static void zram_slot_unlock(struct zram
 {
 	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].flags);
 }
+#endif
 
 static inline bool init_done(struct zram *zram)
 {
@@ -1226,6 +1262,7 @@ static bool zram_meta_alloc(struct zram
 
 	if (!huge_class_size)
 		huge_class_size = zs_huge_class_size(zram->mem_pool);
+	zram_meta_init_table_locks(zram, num_pages);
 	return true;
 }
 
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -69,6 +69,9 @@ struct zram_table_entry {
 		unsigned long element;
 	};
 	unsigned long flags;
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t lock;
+#endif
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	ktime_t ac_time;
 #endif
