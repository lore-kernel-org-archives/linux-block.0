Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A21EEF9;
	Fri,  6 Sep 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632130; cv=none; b=RiWE+SVI7IUrtkTUj7uEn11CKzzGGFfmlEcMJccYDd1V8R/+cezmMC/cbkpg/cY5DeM18y/qEUBHG8CK/EAVwggGRbokHEQqLAZ9dJdX6MCfkjCZYZWuJacq5jPBnViepNvphU4qghkrWCdUJehsI02739cjT8pO/L2WovQV+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632130; c=relaxed/simple;
	bh=8/zwkS1rxYN1diseW44JSveH37dGY5RFGGhuvR7gT8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQC5eyWrTJ0x/2qtmsuqbrGvozcsxvVDkqQ1NfWGmtSnQs0hxIf1dR1LSNU44W+HltLHMeNrrTpj8vwond/y0SL/gCRIzbE7jczF9wSMb6fExfDxTij/H6+MezhaFtnaUnUHsK2vbBZE/sB7+YVVq23eqdj2Ap6VlHJpIxje4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d/2GEqtO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QRqBVOXy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d/2GEqtO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QRqBVOXy"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725632126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=umJapnkXBR6kFECASvWK2vZ+TNTWobwp/1YzsGOxZzI=;
	b=d/2GEqtO01UVV116bf8k+jkc0cqkwRQiVZ1eIpwrbgdo9H8zGuA8o4fh8eCXnDUugRlBgn
	MXPsfNT0xDK+f95mENCAenFookwst3syJpWPPuhpRg0E5cjlzACg45UwomWpIrQoGfDPsc
	fiC69q67vYAXIve3vKY34fNJmCDYvqaqXMTYXSpKED1KC4vhiM+XM+EXN4HO+w7lyZ+LFE
	jruER2ow7soU4zi0B5uzeQuZzzFbMSQbCSy3JBDX7pOe9mUy0I9iuCADI04RpkPXavLg31
	Y7yRCG1Iy/0SU9nE8+GiXHflhcIP4oNZ9iepGfni954vWYWSgl+9ObIsHHzo+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725632126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=umJapnkXBR6kFECASvWK2vZ+TNTWobwp/1YzsGOxZzI=;
	b=QRqBVOXyD9Is/gBtihRrPNuybgwUgzKNXtFUiisyuISsFNeSKxp7Z6sWQne0ajLg4OGjkD
	CgLdiNiW2uStTnDg==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 2/3] zram: Remove ZRAM_LOCK
Date: Fri,  6 Sep 2024 16:14:44 +0200
Message-ID: <20240906141520.730009-3-bigeasy@linutronix.de>
In-Reply-To: <20240906141520.730009-1-bigeasy@linutronix.de>
References: <20240906141520.730009-1-bigeasy@linutronix.de>
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
index 0f35e1f20b18e..812d4e7a6b7f0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -60,23 +60,16 @@ static int zram_read_page(struct zram *zram, struct pag=
e *page, u32 index,
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
@@ -1391,7 +1384,7 @@ static void zram_free_page(struct zram *zram, size_t =
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
index 7aeff672b96f1..d5eef65870380 100644
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

