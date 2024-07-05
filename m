Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC81E867;
	Fri,  5 Jul 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183864; cv=none; b=cjR51YiYeDvcPFiWRu4l7i8lz9HbBFal22Ml4XfR0AUYr/lnYIJ/cvo1woCcuVXJcMiD/I2rIVg3h1YDAbheYZMmcxGs+MUBriKmxmj9L5B/rWvKUCsFeBs0FKGZpMgbM1QNKmPNMiUC3QpQbbR076BIXsBUulhvbKrW9uqAzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183864; c=relaxed/simple;
	bh=k71QRPmSseA5MCLgBwvhkMDWTpuFZICNWc1N3USp+9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9nwRkh7ocaJSm8THXKVMnLLEoirmMg7fO89b/6d2fsonSu9VUwL63fAb7mrB24DbJdlCgrhf333hmxFXlvyq+gDxoGAn4TurQOpWdoDHc5IHtcstJ7DpMFqRpfyn6B9PlPdTIY8G/gw9ywP8nHH+zCmMZpDHWb/ShfZXbIUAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Lh1PBAs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HHrSQufw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Lh1PBAs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HHrSQufw"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720183861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdUrf3Hy2C34gl1jMZkbRbR9ItFYBrR+sH8mMQClkz4=;
	b=3Lh1PBAs1KQUkvSVdgAnshIcgNXY3ZXbt0HlfUH74Va7RBk7TA/HdqfAAesULro2A9svql
	DzAu+EkOM+/xrf+hBzxKnLSAUdcz0zV3Xgrs5Q/KwfEo3RYFBMlAFCD+KUFHAd/sF159ON
	NDgGxSlSrb54/M81eE0rxTL++3SI/4SpFdPAKHV2qaXDVfTeiSSgnq/SM5fXN/BUTnZlst
	g+TyI/7M6WpRYJ/GqAMebUb1Kecn73FKdMbl9XEayl6NUmrl4ZFuk3XhWySCT8QbS02gM9
	ubzA4/dOh4pIP8/fDBx2y3lAUb2kF6ouPokxcuA9IdbEGI8ULQrR1xtmV/qkew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720183861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdUrf3Hy2C34gl1jMZkbRbR9ItFYBrR+sH8mMQClkz4=;
	b=HHrSQufwqCEvgf3s77nlhkCBKa8qcQtCUB14NFbQIOzuIZGfN5TeddGqQu3WUNYIjgFE3O
	wVqT4gXrACulkvAQ==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 1/3] zram: Replace bit spinlocks with a spinlock_t.
Date: Fri,  5 Jul 2024 14:49:14 +0200
Message-ID: <20240705125058.1564001-2-bigeasy@linutronix.de>
In-Reply-To: <20240705125058.1564001-1-bigeasy@linutronix.de>
References: <20240705125058.1564001-1-bigeasy@linutronix.de>
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
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zram_drv.c | 20 +++++++++++++++++---
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3acd7006ad2cc..72006e6e34883 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -57,19 +57,32 @@ static void zram_free_page(struct zram *zram, size_t in=
dex);
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 			  struct bio *parent);
=20
+static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
+{
+	for (size_t index =3D 0; index < num_pages; index++)
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
@@ -1226,6 +1239,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 di=
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

