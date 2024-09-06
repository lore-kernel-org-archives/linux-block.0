Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843EB14A4D4;
	Fri,  6 Sep 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632130; cv=none; b=FydvHNUVPd4gKJpG1XJ5b/ZKn7OQFm7Q1dmXZVMBQlurfYIgF6DXYJARbtwBYLOLBneEQE/XiJeoMigFG6Vdl5/XywF/XM4YpXPX5plorNjOYues1rnrTMaRRgsbEboZqIqtc9MqykolZptwhybhI7ZMaBnGtUSE2g2TqM1qyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632130; c=relaxed/simple;
	bh=QjBFR8Cv45PIRbG0Fj79uwa3syvnxEr+tQxCT2GeG8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJFNFYQZjk/tc4KTrdn7GOYJHy9Z5Km51+tIvQX4Z4QNc7ykBptWb1qWQUdiiD9JJnIDVhEFVSmIKKnU25EJoYpUlavxmAWFgGBl2+rwZDJ2IJ2sEpceOr2TjcSUGYo21ILOhnlTKkLpA3o0pcD7VjJTePXyJwzGOCbeu/BYCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ts8d8diM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uo9g46lb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ts8d8diM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uo9g46lb"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725632126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HB9XvqsdsFhVzFD1qVrKi/1/vC+PA6yeOC9ealVuGUA=;
	b=ts8d8diMapn60eme3T4BVIkDKcnuLn2VwEzAPcAhep8CEc3yqIWMDTAYm4qU6NCi+HcKjz
	rQk0cBYrhuqrf+MimJb7HEGscNSW/37zX1TDLulPgOcOsJFq+MxcztktVX07qjCMdvH9/h
	7N5u6GrSSf67I74q4wkpI3N5XvGUP1PBiYA8oRdv85yVyY0cFxldi8qZ8+qVaH7ncHjdAN
	A1lfPPuqFfyU67FDJyha9fPkgEfiw1VISp/Xa5u2L5y2yKjGICujqg/JyorhoaZ8VpjVLe
	H5itrxZQUYbC6/8A1StREvRorN32+h1glpp4a7JNpjhXIMD3Fbg+rNSh9FJgIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725632126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HB9XvqsdsFhVzFD1qVrKi/1/vC+PA6yeOC9ealVuGUA=;
	b=uo9g46lb0zjj3RdVI0LVIIoLySNz74MCbZ0lKqpsgS07QqUO7QnMvw1iptsqGDQjlNXSxL
	hp/6Pdh23xDEB+DA==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 3/3] zram: Shrink zram_table_entry::flags.
Date: Fri,  6 Sep 2024 16:14:45 +0200
Message-ID: <20240906141520.730009-4-bigeasy@linutronix.de>
In-Reply-To: <20240906141520.730009-1-bigeasy@linutronix.de>
References: <20240906141520.730009-1-bigeasy@linutronix.de>
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
By reducing the size of `flags' to four bytes, the size of the struct
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
index 812d4e7a6b7f0..f8206ba6cbbba 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2532,9 +2532,10 @@ static void destroy_devices(void)
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
index d5eef65870380..cfc8c059db636 100644
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

