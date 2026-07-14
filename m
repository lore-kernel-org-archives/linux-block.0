Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98643FD1C;
	Tue, 14 Jul 2026 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038398; cv=none; b=p6nmYPoikSo5oqDD0G1vr9h6OOiCVWxi7YGYfo57tTZ6r2biHfGHSfcivja5sYPupl4d+2s4P5IrQZEdfxUl4iBkOSmpb0uqIEE/aK34TpRJov2m+jar6xJypgiuHQoUdzkw01+voewk3WBVPLBRJSlSsD3rG02gzOuN3g7LQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038398; c=relaxed/simple;
	bh=oRmaXnHN0ayfDrTMYsdXZ0Mem+BCPm/UB7MrRLyMIKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwiI5zoOfZAtIAHHOur0gOE4bC/Kcr5/jF8jo8V/HTn1CpUcYikx8tcdYqAt4tpHqJ1JhQ0+09AkqlKr5W6q33xZ1OvAICDcx6keJ9pihny3+KXtkn1IbloZy4RtDSflDvFTLv/lGNb7zxBLjTizQe0OC23o1VOdylExdA4uQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hmTqbaKv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W52rBs29; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hmTqbaKv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W52rBs29"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784038394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fH6QF9yATWUhra9HdeeIVOBVGoCNBanFCVe0Xj7Vijw=;
	b=hmTqbaKvb1DpJdtrksLDOXc8F4cAygT/3cTWGy4yLM8/sB+vLV+8uwsD+Tv4P0psCp5eSH
	/Zd+UZv+GwydBcqs5urna43Mh6ukApjORYnF6+gLHWmvTzTAdGpfLMtB7nOx0jI2gG+4Ru
	9A2K4ORlBHfyZQyMJ2MPG4GeUw0F4SaDktOFCheV8qcn7RwUHddtXYEC4HDhx6ZRnWhlkh
	ddEPIVQG+PS4CUYbXWRdJnI7phhQnWhf6c9S4N+VChnei9JYXSwjpvlLB8+tJ4kLIe3KKu
	0BTOUWXxHnJSdq4wmLamXvM/zLmeJgra1U4stl2iRde8quF1qW31X6By+sWJHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784038394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fH6QF9yATWUhra9HdeeIVOBVGoCNBanFCVe0Xj7Vijw=;
	b=W52rBs29rO2r+Cxt/KM9w4/7fgMEeiGwYGmmGlJg7+8aB3nOCOsjCbYYKQAO+nJqtORdT8
	pmB5EwHnYLrB/GAA==
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] zram: Use a custom key for each zram object.
Date: Tue, 14 Jul 2026 16:13:00 +0200
Message-ID: <20260714141300.3945672-3-bigeasy@linutronix.de>
In-Reply-To: <20260714141300.3945672-1-bigeasy@linutronix.de>
References: <20260714141300.3945672-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Each struct zram uses the same key for its struct lockdep_map which is
used for locking analysis.
According to Sergey the lock chains might be different if zram1 is used
for and zram2 is for ext4. This might lead to false dead lock reports if
it mixes a zram1 chain with a zram2. This can be avoided if each lockmap
gets its own unique key.c

Use a dynamic lock_class_key for the table_lock_map.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zram_drv.c | 11 +++--------
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4223002d80b41..4bfe63a5225d8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -58,13 +58,6 @@ static const struct block_device_operations zram_devops;
=20
 static void slot_free(struct zram *zram, u32 index);
=20
-static void slot_lock_init(struct zram *zram)
-{
-	static struct lock_class_key __key;
-
-	lockdep_init_map(&zram->table_lock_map, "zram->table[index].lock", &__key=
, 0);
-}
-
 /*
  * entry locking rules:
  *
@@ -1978,6 +1971,7 @@ static void zram_meta_free(struct zram *zram, u64 dis=
ksize)
 	zs_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
 	zram->table =3D NULL;
+	lockdep_unregister_key(&zram->table_lock_key);
 }
=20
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
@@ -1999,7 +1993,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 di=
sksize)
 	if (!huge_class_size)
 		huge_class_size =3D zs_huge_class_size(zram->mem_pool);
=20
-	slot_lock_init(zram);
+	lockdep_register_key(&zram->table_lock_key);
+	lockdep_init_map(&zram->table_lock_map, "zram->table[index].lock", &zram-=
>table_lock_key, 0);
=20
 	return true;
 }
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 8290dc6e23352..4fddc582f3b82 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -107,6 +107,7 @@ struct zram_stats {
 struct zram {
 	struct zram_table_entry *table;
 	struct lockdep_map table_lock_map;
+	struct lock_class_key table_lock_key;
 	struct zs_pool *mem_pool;
 	struct zcomp *comps[ZRAM_MAX_COMPS];
 	struct zcomp_params params[ZRAM_MAX_COMPS];
--=20
2.53.0

