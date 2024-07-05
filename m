Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12879149C4C;
	Fri,  5 Jul 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183865; cv=none; b=roWCDqe2ktIwai6Xs0YHlAA661jvQCdXVGzg0cyWdp2XspdKbZBeFSWUvYUeUtSyNSM6HJ2x4E4mwA7ZTcV3QnirSuibW2Grt/dCPjECnRdZUdrWZh6FQQO0Zz7iSj/yiTjWuRZNcwXV8Z24C7U8+Ks+vQgou/iZcYhfaHxr8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183865; c=relaxed/simple;
	bh=Tg+HfrYUbcTf4m66IXzTHsNS/XoVI55Nli/4Xak15iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6Am0C0hStCkuHgXfDrVwADrkpBgqOqIeRi7tj7ufxN0W4PMNPEE1Gl3zYuFZHtLfsKGvO5LF/UbbZ9g2NnX68buqtQrLetG/FA8G/ewUACoA70m0dFN0FxaMnkWEwN7gpy3pFkVaaciM7OEGpXElzpRkDR1xxJjBBNMVr+O2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fDxWzmg3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PQxtIIzm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fDxWzmg3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PQxtIIzm"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720183861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsG//7rYWfTYC6on5Th6BnejVdtNYOCn5Z8HIMJ/YeQ=;
	b=fDxWzmg3YY81rEeuzXL27xU06qWVtKUxjjFZrGY1Dbf0zv0PI7gQ3eRupdJdEuICO4NXVZ
	PK/nTwT9PD0bcSbaRMmx19CNqP6LqfqsJjMKh4B6zXmEgHRtAghA+4XkDvrlpSanZN5zDY
	oAIUvXXYG8T6fafDYuIu2tlnEiUeGSYgXfioylQJARJdZlNk4hGERYhSP8RRPChXOIg1R6
	VrOPGW+vHA3tbqFRcPSLFBPOD/hQNOjxD+TC/Ltg5r4r4/8RSSYIWoAO518HKxuWWzhsRZ
	cTuWtgXsbs/rSNm40iogbtsvoBb+lAY5qAhyXxzzBB+PQfkqmqUWY9jGliKitg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720183861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsG//7rYWfTYC6on5Th6BnejVdtNYOCn5Z8HIMJ/YeQ=;
	b=PQxtIIzmgXyoxV6rzhzILNTiKI1nRtHPWw2n1dzhwBCg+lF4R1TY1YNZwCNz1uEHbBxqmc
	FGfu9sfhQMomfZBQ==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 3/3] zram: Shrink zram_table_entry::flags.
Date: Fri,  5 Jul 2024 14:49:16 +0200
Message-ID: <20240705125058.1564001-4-bigeasy@linutronix.de>
In-Reply-To: <20240705125058.1564001-1-bigeasy@linutronix.de>
References: <20240705125058.1564001-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The zram_table_entry::flags member is of type long and uses 8 bytes on a
64bit architecture. With a PAGE_SIZE of 256KiB we have PAGE_SHIFT of 18
which in turn leads to __NR_ZRAM_PAGEFLAGS =3D 27. This still fits in an
ordinary integer.
By reducing it the size of `flags' to four bytes, the size of the struct
goes back to 16 bytes. The padding between the lock and ac_time (if
enabled) is also gone.

Make zram_table_entry::flags an unsigned int and update the build test
to reflect the change.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zram_drv.c | 3 ++-
 drivers/block/zram/zram_drv.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e683a9fc68b6c..dde45a084733f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2410,9 +2410,10 @@ static void destroy_devices(void)
=20
 static int __init zram_init(void)
 {
+	struct zram_table_entry zram_te;
 	int ret;
=20
-	BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > BITS_PER_LONG);
+	BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > sizeof(zram_te.flags) * 8);
=20
 	ret =3D cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
 				      zcomp_cpu_up_prepare, zcomp_cpu_dead);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 262fa960a0783..531cefc666682 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -66,7 +66,7 @@ struct zram_table_entry {
 		unsigned long handle;
 		unsigned long element;
 	};
-	unsigned long flags;
+	unsigned int flags;
 	spinlock_t lock;
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	ktime_t ac_time;
--=20
2.45.2

