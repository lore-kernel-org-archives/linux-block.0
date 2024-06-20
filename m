Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B791AF697;
	Thu, 20 Jun 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897773; cv=none; b=AFiUmjcu8lhowQTA9ZpjudZtos8CbGH0GxhdMd+7B8UR7iKNV28mMkM9VkBQzBsfwhuDL2M57jdB+rn5sLb9DCNrVZ/1NbwXiIGWW3kHW2SarujEpVEaiiGRyCiSjwA5Y/wFB3GDdfhjmNNvsAcvO7jfEAiVrolLu4cxToyML90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897773; c=relaxed/simple;
	bh=G86ZpOCbQel56zil7HXk/BgfDvuf7fbDP5Y1Y0ZjcSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnbpE8d2yr4WUfTTopE1K2UCDX8ZXQM+qxfDEE71HXqoyKm4d1d6mBwbJtKI2RCuEKrCmezJhyvbE0E4XccoZ6elAX8x6Em91bbJzzt5yATDISqO06v3EzQw1u/tlQd/OT/g39Uq9AlP8n45+Jg11G9Lxznf4jDUP51ad8LWGRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kil7NbsQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a5ejUb4N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kil7NbsQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a5ejUb4N"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718897763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXGSH918z06aphcGtDz/mGBYt1ti++St5iUsrCgtWaU=;
	b=kil7NbsQH7jdwnMwRQ2mC2ylka48gdZL9tpAv4FRBrjvfMadVogEM1/+WTiQ5+0827VZYf
	c87nD8aISnp4+va3ls/l3QT4JUHUmDGdZ1asJOWL4kPFTTnTJRVP5Q2pRkALWgamO1+Bn8
	Y1fTlTo5oicQavQkXt1U/Fb+N+fTagGTI6/BWxaW9iIYjlYZG3iR5PmTDJPTWI2bapYfnN
	6/I1GWEVy59eJYLHRjt4BUifRIWL9g4077CT2sMjFnpEE+9s/GMWbp572xsNjbd6myuUEk
	PtVtO85IRdsD7oxfcX2ZOVNgVrryj5061zRuWhrX9hEHVyCYCtMknXO0qgM5DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718897763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXGSH918z06aphcGtDz/mGBYt1ti++St5iUsrCgtWaU=;
	b=a5ejUb4NDgy+H/Z5dRXG/oqwib78j7B/Vohrw7KQ3ygD0UP4FgUax97LjpcaGMfAOiPRLp
	4bsmjqshnDFWC0Dg==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/3] zram: Shrink zram_table_entry::flags.
Date: Thu, 20 Jun 2024 17:28:52 +0200
Message-ID: <20240620153556.777272-4-bigeasy@linutronix.de>
In-Reply-To: <20240620153556.777272-1-bigeasy@linutronix.de>
References: <20240620153556.777272-1-bigeasy@linutronix.de>
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zram_drv.c | 3 ++-
 drivers/block/zram/zram_drv.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 659966e00c300..a35d4bd2e60ef 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2412,9 +2412,10 @@ static void destroy_devices(void)
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

