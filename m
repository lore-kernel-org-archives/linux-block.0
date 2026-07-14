Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5BA43F8A4;
	Tue, 14 Jul 2026 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038397; cv=none; b=VsYGkBTT/O40MRRyldn/flzj1hI7RURpotJG0jpQCPBIrkNW1GlP7ut7n3vholcJ1PZh5sg5MWWqhJP83Qh0Bj7B0u/EpLCPi9+/jCR5cJOLRNg3lnGSRIZ6JlLt26hZru7PlYLKyTGwowOtAyhccV3t3HBHriNZQLLPpOC3hnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038397; c=relaxed/simple;
	bh=Lz14LHV/GKPfduvhIs78fFB0H7V7oyIx6MeJz3SEHZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r71ldrI/rKJ9SzAiUOvmcr7DHuFNdBMs56yCSY7Lw3p+OE3BukzJcXdzsZ0obxThpJ5EqgZEGK0DIh9jmr+MCEtOdsR/20YxPW3XdUPhm/v//3C8xLvdz+g6qlte6/Tvy88z8TzOKP1hePtgG2sXADUtzrDd75ysxf8WPAxMWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ApArR5SE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txF525Nw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ApArR5SE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="txF525Nw"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784038393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGfk/iTews6O1kCW+NVFAgwJrxVcoYgpBHsw/V8K9qY=;
	b=ApArR5SEKDpJvVwY3AOWAvmCHdn1DCBBqP0tzj6O3/R2WSTxM7pun6QweEblcVbW0P25mi
	lh1m01Vih5incsncWwsvhHOBhkAaaw3BVPw4s5BDlxhHjHRlCy4HgXzmA32uaCQbho0eSA
	sOS12AmiFcGQ883gmsIiWpVW21B7nbq6wHrXI8bzvTDHp8WyotA4QlAEkE073B50imRBG5
	ls8w8jigajUMdPMVKneZ/xE+z8ze4kxocFWFsF8ncY7VJBU7g7TqaK1H2IJLd6jRmy9Rl5
	1IKovYS2jzkUy6kXgVz39oEVreck4P7tevUAc/5npUZ98RRrE65F6xJHzcwcpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784038393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGfk/iTews6O1kCW+NVFAgwJrxVcoYgpBHsw/V8K9qY=;
	b=txF525NwYBQDsn0MClrMOVvNdwx9GsSuuSvmAiIcSDpp7Kyr2IhdM4VR/QX+bEErEtXt23
	DeQ2dAOkqIWtChAQ==
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] zram: Move lockmap to be per-zram instead per table
Date: Tue, 14 Jul 2026 16:12:59 +0200
Message-ID: <20260714141300.3945672-2-bigeasy@linutronix.de>
In-Reply-To: <20260714141300.3945672-1-bigeasy@linutronix.de>
References: <20260714141300.3945672-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The zram object contains an array zram_table_entry. Each one has a
`lock' variable and each has a matching struct lockdep_map. This mimics
a struct mutex.

It uses always the same key for all lockdep_map instances. This makes it
look like the same lock to lockdep. Therefore it could be reduced to
have one lockdep_map per struct zram.

Use only one struct lockdep_map per struct zram.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zram_drv.c | 21 +++++++++------------
 drivers/block/zram/zram_drv.h |  2 +-
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ace65c586072b..4223002d80b41 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -57,14 +57,12 @@ static size_t huge_class_size;
 static const struct block_device_operations zram_devops;
=20
 static void slot_free(struct zram *zram, u32 index);
-#define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
=20
-static void slot_lock_init(struct zram *zram, u32 index)
+static void slot_lock_init(struct zram *zram)
 {
 	static struct lock_class_key __key;
=20
-	lockdep_init_map(slot_dep_map(zram, index), "zram->table[index].lock",
-			 &__key, 0);
+	lockdep_init_map(&zram->table_lock_map, "zram->table[index].lock", &__key=
, 0);
 }
=20
 /*
@@ -84,8 +82,8 @@ static __must_check bool slot_trylock(struct zram *zram, =
u32 index)
 	unsigned long *lock =3D &zram->table[index].__lock;
=20
 	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
-		mutex_acquire(slot_dep_map(zram, index), 0, 1, _RET_IP_);
-		lock_acquired(slot_dep_map(zram, index), _RET_IP_);
+		mutex_acquire(&zram->table_lock_map, 0, 1, _RET_IP_);
+		lock_acquired(&zram->table_lock_map, _RET_IP_);
 		return true;
 	}
=20
@@ -96,16 +94,16 @@ static void slot_lock(struct zram *zram, u32 index)
 {
 	unsigned long *lock =3D &zram->table[index].__lock;
=20
-	mutex_acquire(slot_dep_map(zram, index), 0, 0, _RET_IP_);
+	mutex_acquire(&zram->table_lock_map, 0, 0, _RET_IP_);
 	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
-	lock_acquired(slot_dep_map(zram, index), _RET_IP_);
+	lock_acquired(&zram->table_lock_map, _RET_IP_);
 }
=20
 static void slot_unlock(struct zram *zram, u32 index)
 {
 	unsigned long *lock =3D &zram->table[index].__lock;
=20
-	mutex_release(slot_dep_map(zram, index), _RET_IP_);
+	mutex_release(&zram->table_lock_map, _RET_IP_);
 	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
 }
=20
@@ -1984,7 +1982,7 @@ static void zram_meta_free(struct zram *zram, u64 dis=
ksize)
=20
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 {
-	size_t num_pages, index;
+	size_t num_pages;
=20
 	num_pages =3D disksize >> PAGE_SHIFT;
 	zram->table =3D vzalloc(array_size(num_pages, sizeof(*zram->table)));
@@ -2001,8 +1999,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 di=
sksize)
 	if (!huge_class_size)
 		huge_class_size =3D zs_huge_class_size(zram->mem_pool);
=20
-	for (index =3D 0; index < num_pages; index++)
-		slot_lock_init(zram, index);
+	slot_lock_init(zram);
=20
 	return true;
 }
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 08d1774c15db6..8290dc6e23352 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -74,7 +74,6 @@ struct zram_table_entry {
 #endif
 		} attr;
 	};
-	struct lockdep_map dep_map;
 };
=20
 struct zram_stats {
@@ -107,6 +106,7 @@ struct zram_stats {
=20
 struct zram {
 	struct zram_table_entry *table;
+	struct lockdep_map table_lock_map;
 	struct zs_pool *mem_pool;
 	struct zcomp *comps[ZRAM_MAX_COMPS];
 	struct zcomp_params params[ZRAM_MAX_COMPS];
--=20
2.53.0

