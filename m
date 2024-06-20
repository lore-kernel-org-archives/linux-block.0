Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEA1AF6B4;
	Thu, 20 Jun 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897772; cv=none; b=ap7SNIeE+Hc6E7uC/q0Hf3CjaHc8qpQn7Z5C8SLEtNnsfXh3NR4oZagpKJ7W1/LPrfsug1oyIrHIIGg9v0Eo5yrQnbWLJtfF36Whxv033xlXFIM11VY7pN1QoB/NbpZXoS7a6epIvrhxAG3eX1wUobzBJkmX5d0h9J/QSkhKVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897772; c=relaxed/simple;
	bh=YXyPcSBPlpPYufm75AgrQX5YC6L7hQSvZGAXUKH6HcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+qAF3mVlkMGFGttFCI76H9dibZGBxf8UcDb2/5cIkZ/U+ucOKEZKKiOIFO4oRPkaUDbRR2clwIJv39BHvvkDLhwlQRkUMLGWHoC+7+vFr8IXWfP3z/P8Obe6dmbkKIscFQ/5PLDaDhid4zQm4OlZXq62Cp+5GkhKGKi36Ce39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o/OhD4d2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8Yr5fxfn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o/OhD4d2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8Yr5fxfn"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718897763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBOAfjSISfflCVpyoflTryup4k2GWDjwHCEfQlVKqA8=;
	b=o/OhD4d2v+WnYbUIGTQasO5G/81YDg0/TURU4xqeJC1fNvptJurNyUENMmn47IkmtZ5K2g
	zZ3e74sRCwq+jsb/KmF0AuRF99PsAu/Hc1p1A6Xp0lh6fhAEnfumtWkbaAhRAdZImS2MN9
	8hPs8phZGua2OyN9DON40Uq/AclssIU4qY4n+1diIGIv0t/RV5d7JZu15/gutUeAY0LURE
	X28JgdvzEQxOVwL9mmD71EWJiOQPvMLiJGCZTANuOTBdI1lWXyhhfmik2rx06cDi438w37
	1OkYza/rAVmwUazENSu5/L5ITBBuQ/DXGtZHDNyG29qdJyPdYuf77g8iJFgbfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718897763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBOAfjSISfflCVpyoflTryup4k2GWDjwHCEfQlVKqA8=;
	b=8Yr5fxfn5M04DM2f1g4w1W9pvc5hv9AfEarzbPSzxfmp6HCy4T0NuKOxT+ts4Wd5BOV8gk
	xYbJQw8uL5/nbUBw==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/3] zram: Replace bit spinlocks with a spinlock_t.
Date: Thu, 20 Jun 2024 17:28:50 +0200
Message-ID: <20240620153556.777272-2-bigeasy@linutronix.de>
In-Reply-To: <20240620153556.777272-1-bigeasy@linutronix.de>
References: <20240620153556.777272-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mike Galbraith <umgwanakikbuti@gmail.com>

The bit spinlock disables preemption. The spinlock_t lock becomes a sleeping
lock on PREEMPT_RT and it can not be acquired in this context. In this lock=
ed
section, zs_free() acquires a zs_pool::lock, and there is access to
zram::wb_limit_lock.

Add a spinlock_t for locking. Keep the set/ clear ZRAM_LOCK bit after
the lock has been acquired/ dropped. The size of struct zram_table_entry
increases by 4 bytes due to lock and additional 4 bytes padding with
CONFIG_ZRAM_TRACK_ENTRY_ACTIME enabled.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zram_drv.c | 22 +++++++++++++++++++---
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3acd7006ad2cc..036845cd4f25e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -57,19 +57,34 @@ static void zram_free_page(struct zram *zram, size_t in=
dex);
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 			  struct bio *parent);
=20
+static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
+{
+	size_t index;
+
+	for (index =3D 0; index < num_pages; index++)
+		spin_lock_init(&zram->table[index].lock);
+}
+
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
-	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].flags);
+	int ret;
+
+	ret =3D spin_trylock(&zram->table[index].lock);
+	if (ret)
+		__set_bit(ZRAM_LOCK, &zram->table[index].flags);
+	return ret;
 }
=20
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
-	bit_spin_lock(ZRAM_LOCK, &zram->table[index].flags);
+	spin_lock(&zram->table[index].lock);
+	__set_bit(ZRAM_LOCK, &zram->table[index].flags);
 }
=20
 static void zram_slot_unlock(struct zram *zram, u32 index)
 {
-	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].flags);
+	__clear_bit(ZRAM_LOCK, &zram->table[index].flags);
+	spin_unlock(&zram->table[index].lock);
 }
=20
 static inline bool init_done(struct zram *zram)
@@ -1226,6 +1241,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 di=
sksize)
=20
 	if (!huge_class_size)
 		huge_class_size =3D zs_huge_class_size(zram->mem_pool);
+	zram_meta_init_table_locks(zram, num_pages);
 	return true;
 }
=20
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 35e3221446292..dcc3c106ce713 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -69,6 +69,7 @@ struct zram_table_entry {
 		unsigned long element;
 	};
 	unsigned long flags;
+	spinlock_t lock;
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	ktime_t ac_time;
 #endif
--=20
2.45.2

