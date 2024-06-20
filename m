Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2661AF6B5;
	Thu, 20 Jun 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897772; cv=none; b=ixGYQp9QJdWCNJdnbUWy43LFfLEbfNdb8eXH3K3rbPdTVR9YQnLyxFVLBoQma8Lptj8hOAvclk2GP6Rk5tU72ahMAJbJBWJ7mJrUnXaDVNx1HxNjUUA9lB0O8veKlHSO5uSiPCmUDQBtCAbHvrPbEnkIM0vLM34JE4vnZkbuFNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897772; c=relaxed/simple;
	bh=41XCtYZoil124ggqeaxldxUoAHOVlwIxa7ezDj9yWT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRxtlmdX16cmizI/isU4tgOUzzoBLA1h4JJ41z5FGdybtezxyjPXlrPE+AGWdJFeyGkmjr/f7Jmuh4RVfEtOQYeeHlk+EIhZ9TjfD/20qVKmOJ3YzFZLYqN5MRZhme+7mxcJtQOEGAJciwQfh39XaKh1nGEZk7eu2g84RMfJd98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVPjjknM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ufAIY1wh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVPjjknM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ufAIY1wh"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718897763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSUO1Lfh9dmWaOWg+yhEGkMIzbQkGi2VLM4kJm3yKcA=;
	b=gVPjjknMrRrMAjEozcQKij6eTWy2UxrJxWWQTja90GklIjM5JXmOjJIhcOUWRt62lK6/Cy
	ELP5wvnAJ5VSkyfotjM0PNBWwLfxl1k3NSHmIbyV000lUIofAV6322Bf8j2H0LLP5MOdGq
	agLJG9Y1dhdoJ7bmSCsoX56fon7u2aNNatnwMPxxC/jKvg94J3saY/NtWR8n0f4anOsVKJ
	35jJ+UDSKQj+N5GIQi8b2dI210tNCIMX87M8GgRyDx8PXXwq3hp80IfAk75cSPT7zxdq57
	BjVPksx3WQKLQ9aPSJmB/HBZ59MN1SuolwOI3zz6cDAHy1rn8rZKKoO4r5nT9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718897763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSUO1Lfh9dmWaOWg+yhEGkMIzbQkGi2VLM4kJm3yKcA=;
	b=ufAIY1whRVAoSCt55InORVfOHSm4rD2CGSwXc2aqXiPCwY2n1FTG7eTzZgD4kr04z1XkXr
	6I8Xo3fYw1Wh+IAg==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/3] zram: Remove ZRAM_LOCK
Date: Thu, 20 Jun 2024 17:28:51 +0200
Message-ID: <20240620153556.777272-3-bigeasy@linutronix.de>
In-Reply-To: <20240620153556.777272-1-bigeasy@linutronix.de>
References: <20240620153556.777272-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ZRAM_LOCK was used for locking and after the addition of spinlock_t
the bit set and cleared but there no reader of it.

Remove the ZRAM_LOCK bit.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zram_drv.c | 11 ++---------
 drivers/block/zram/zram_drv.h |  4 +---
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 036845cd4f25e..659966e00c300 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -67,23 +67,16 @@ static void zram_meta_init_table_locks(struct zram *zra=
m, size_t num_pages)
=20
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
-	int ret;
-
-	ret =3D spin_trylock(&zram->table[index].lock);
-	if (ret)
-		__set_bit(ZRAM_LOCK, &zram->table[index].flags);
-	return ret;
+	return spin_trylock(&zram->table[index].lock);
 }
=20
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
 	spin_lock(&zram->table[index].lock);
-	__set_bit(ZRAM_LOCK, &zram->table[index].flags);
 }
=20
 static void zram_slot_unlock(struct zram *zram, u32 index)
 {
-	__clear_bit(ZRAM_LOCK, &zram->table[index].flags);
 	spin_unlock(&zram->table[index].lock);
 }
=20
@@ -1299,7 +1292,7 @@ static void zram_free_page(struct zram *zram, size_t =
index)
 	zram_set_handle(zram, index, 0);
 	zram_set_obj_size(zram, index, 0);
 	WARN_ON_ONCE(zram->table[index].flags &
-		~(1UL << ZRAM_LOCK | 1UL << ZRAM_UNDER_WB));
+		~(1UL << ZRAM_UNDER_WB));
 }
=20
 /*
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index dcc3c106ce713..262fa960a0783 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -45,9 +45,7 @@
=20
 /* Flags for zram pages (table[page_no].flags) */
 enum zram_pageflags {
-	/* zram slot is locked */
-	ZRAM_LOCK =3D ZRAM_FLAG_SHIFT,
-	ZRAM_SAME,	/* Page consists the same element */
+	ZRAM_SAME =3D ZRAM_FLAG_SHIFT,	/* Page consists the same element */
 	ZRAM_WB,	/* page is stored on backing_device */
 	ZRAM_UNDER_WB,	/* page is under writeback */
 	ZRAM_HUGE,	/* Incompressible page */
--=20
2.45.2

