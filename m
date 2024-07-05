Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128C914A087;
	Fri,  5 Jul 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183864; cv=none; b=q3RX1v8jDYc8DDI6gWtq3rFDCWSr5im0HLJn0zY1zWd7DgQmesWVcMR1te71+75ytybFFSXtG1G87oBvnXnSye+67xCw0YC2/CYTS58gryTKUUw7v74t0WoN4PDV7Cq/9+SIl/5Eix28F9TlUhhX15pUrAelgKdQsDvl2m8UXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183864; c=relaxed/simple;
	bh=EAWubWSnfGSGLRqgS01JzvZesUh7mES4zlMOY/GQMM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vp26rcBnO+xvBw2BfGS6lcyT/PTM0tNKjqQm9XjvmCM68cb74aedPI3YbYX67iiTpHAYl56JvftW3sopPh1dfNeBczXun6jIUcdRwMxShyn16Nge0A3Z608HF8/jXM1IHtQ1ykBDx7vyl6/0T09vGsb6K8cqJ8xnZhbVBMEs3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bRcTjfaO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KsMTcShT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bRcTjfaO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KsMTcShT"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720183861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmesQQeq7k8AI187QyjXjrDqOsgX4aH0MdV/eZEBAmI=;
	b=bRcTjfaOWuYXOOT3gphUlvV3nG65Wbw1a8UHbkFCTC++6yWmnqPxPHPaVWmjy7j5weI2De
	g7fXtezolZwV+1pBFAu66TEF4O8vARHD72zfFDR8Sq4hAri0QrDkNFDv1p9z5Lkm/EeJrA
	2Noeqe6F96SQvDcPkP5gwrhNSyxYRpQT0G5kLdJgicp0qTZ68EBWrY9YNCeuRZKxUyLfj8
	QmdeEsE6MGML4IwhTAp4KosC19iZ+mqmPOAZgie3YD2u685SI348u+56lNPV5ew3ALyzPb
	QwneXfiVmwSbUovrOBnmozoan9tTnSI8U6G/N5JfRwRjqH1HBDSTR0c/7JRKCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720183861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmesQQeq7k8AI187QyjXjrDqOsgX4aH0MdV/eZEBAmI=;
	b=KsMTcShT3c5TRRIqJ4sgA3XV3Qvo0oOQfJ5MU7i+mbfTdndUY4PfidS/Mv9dPfvHe7ev+t
	a/7IoTHMS++PD4AQ==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 2/3] zram: Remove ZRAM_LOCK
Date: Fri,  5 Jul 2024 14:49:15 +0200
Message-ID: <20240705125058.1564001-3-bigeasy@linutronix.de>
In-Reply-To: <20240705125058.1564001-1-bigeasy@linutronix.de>
References: <20240705125058.1564001-1-bigeasy@linutronix.de>
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

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zram_drv.c | 11 ++---------
 drivers/block/zram/zram_drv.h |  4 +---
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 72006e6e34883..e683a9fc68b6c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -65,23 +65,16 @@ static void zram_meta_init_table_locks(struct zram *zra=
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
@@ -1297,7 +1290,7 @@ static void zram_free_page(struct zram *zram, size_t =
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

