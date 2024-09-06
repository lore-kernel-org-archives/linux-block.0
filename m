Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2281DFE1;
	Fri,  6 Sep 2024 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632129; cv=none; b=cZbGAshn0e1G9dJus/pzpGEQKDksG/5TrYXc4xCVlunGy1YbPQ3Ckb/olOvvSdtKbV9l07cc7DNX1wuqQHu8WPHb3qF5uKdzkxG/Vx7o/tz7kPy+wFVO5+FcuVlWA980c+YAuxhdjyOpGIESP9XbHJOZ+VOqugY5oZJauLuas6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632129; c=relaxed/simple;
	bh=BORmgJoSQwYfrE3e7mKqsG9MIXmz5U3HaHwYflO/6pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7NPxEMG9glAE9enqyZ27CiO/L0hP+gLx0xdv7YqiupsUDrVDjEJEcxr2H5NgeyukWiB7B1q1mc268rZbUpWN19coSO3k7RAvoMliZVNUTbEsv0R4bzGMpggSERsJhSnHZ7bvvHI6Ig18sRzy6iz8Gn/BzrLm8z7PIc/9AVlLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JwHOBp/a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WED7K7j5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JwHOBp/a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WED7K7j5"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725632126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjnaATEHBxbr+FrbsOxAqcu8XbXNUvS85WStCDTlyQs=;
	b=JwHOBp/aFMoU729gI+q/YSh05mS4IhcboKywbud3u0fBjRGR0gVCz47nhIJGrGabb0MnlL
	ZBunn/pTI1T55+jOR/Rq0GcWzq35bmDv09n/uR7eg0pQigqzqQiN/kCXqwZtBb10XHdbby
	Pews5SSjP2rpFu6BZaKggfA8Lt8KIoMwIo/oLjYFKjKRIDYZlpgqWt7BAUOIzsAfS7OIqX
	9Y+n6/PfMyUzN+O4znK4bhN64Y7Cg8+eeJVUuxGZBu5jEv/je3IgEawiyqmdHtY1CUj3o5
	EYmZumaUxRPdA/JQPoe/HxGD7T5sAdHKPl07IZWExaaAdwa+3bN5jEDx+rk9+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725632126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjnaATEHBxbr+FrbsOxAqcu8XbXNUvS85WStCDTlyQs=;
	b=WED7K7j5PvSeOEc2zvKwIk6/lJufbT80xRUNViiK/4mtBtgX/JZHu16zXdhKt2ZVksMKRq
	g/Q+gom+3vs/t0DQ==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 1/3] zram: Replace bit spinlocks with a spinlock_t.
Date: Fri,  6 Sep 2024 16:14:43 +0200
Message-ID: <20240906141520.730009-2-bigeasy@linutronix.de>
In-Reply-To: <20240906141520.730009-1-bigeasy@linutronix.de>
References: <20240906141520.730009-1-bigeasy@linutronix.de>
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
 drivers/block/zram/zram_drv.c | 18 ++++++++++++++----
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1f1bf175a6c34..0f35e1f20b18e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -60,17 +60,24 @@ static int zram_read_page(struct zram *zram, struct pag=
e *page, u32 index,
=20
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
@@ -1309,7 +1316,7 @@ static void zram_meta_free(struct zram *zram, u64 dis=
ksize)
=20
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 {
-	size_t num_pages;
+	size_t num_pages, index;
=20
 	num_pages =3D disksize >> PAGE_SHIFT;
 	zram->table =3D vzalloc(array_size(num_pages, sizeof(*zram->table)));
@@ -1324,6 +1331,9 @@ static bool zram_meta_alloc(struct zram *zram, u64 di=
sksize)
=20
 	if (!huge_class_size)
 		huge_class_size =3D zs_huge_class_size(zram->mem_pool);
+
+	for (index =3D 0; index < num_pages; index++)
+		spin_lock_init(&zram->table[index].lock);
 	return true;
 }
=20
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index b976824ead676..7aeff672b96f1 100644
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

