Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ADB42F710
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441586; cv=none; b=eBpcs6PuOhkjooZrQ9kQb7wUWjd8Wc5RO0nNzsEMn5GcWV5BzGxp0j2ZoIMi7JrCb9zCT4/a480U9h6szDMwNIDsUBqy/tKrsEciiDi84WzCg1geOJ+Y2uwmto4K0TuUNNKdi57Sss5cvXOpTLH58sDUJxJRi+WWStaMy1wzzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441586; c=relaxed/simple;
	bh=7jcivG/gKJTgEmP1/NvCUK/Z//1zFgjzrDpjpT3ubdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx9MbzcyNXMmMrgoCsIn5Raw5Z3AYLByBb/DEFXdQL5vQRVZdnHEY7FzJrN0dNZomiSh0WZkg3kefF367gRYtESMt2JtT4W7bVdcr9zswC8wm5L8XJ0Z4DQhF2opll3KjyYm3cAbTZTt6mvRZu4BP1yQQ+Cp+yGnjrfuJ1MF87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dJHcIqbW; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dJHcIqbW"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0Qz5k1PzlfpLv;
	Thu, 30 Jul 2026 19:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441574; x=1788033575; bh=mcb2a
	LK8aOI5cBQ1mtULZH7MqnDQ4yCrAXl+29BtYN4=; b=dJHcIqbW+XPV+zrKhDk/U
	9J1EWO3Cf9wGZ2OErVbGYIUS0VjCjo5Cuts+ttVtFCWDuQq8lV3+TuUHcPuzwMJD
	nGBba3ZWhambyPpp3N8XgZ3QtAUNhzz9xCC9XKitIpkJksHIkYQh3c6nsBXpYNaw
	JTvORRXaEzQsbxD+hBgZ+asOaUd6LIP17nVgvLP3gjgfGW2Fkym15psUtsJ/nmxJ
	kD4Ydh7aH0cw2fuJW4wgLwRKBKnfum+R+O4I6TGOlhSI0vFmT/NQ5bBgx8/lCF7t
	RCT9nZD5bPX6hr/nDtV2dEMNUQGTSsMV6T4toW1z20h4o7afbJIJVn5MP5/S0I+D
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jJngY16YY8db; Thu, 30 Jul 2026 19:59:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0Qq1gsnzlfvpx;
	Thu, 30 Jul 2026 19:59:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 10/12] zram: Enable lock context analysis
Date: Thu, 30 Jul 2026 12:58:33 -0700
Message-ID: <1ce7d73b5c6dd6f0e2a0611262bec1dbc910fa32.1785440858.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <cover.1785440858.git.bvanassche@acm.org>
References: <cover.1785440858.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the lock context annotations that are required by Clang. Enable lock
context analysis in the Makefile.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/zram/Makefile | 2 ++
 drivers/block/zram/zcomp.c  | 3 ++-
 drivers/block/zram/zcomp.h  | 6 ++++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 0fdefd576691..a5663ab01653 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
+CONTEXT_ANALYSIS :=3D y
+
 zram-y	:=3D	zcomp.o zram_drv.o
=20
 zram-$(CONFIG_ZRAM_BACKEND_LZO)		+=3D backend_lzorle.o backend_lzo.o
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 974c4691887e..155dbeacab1b 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -112,7 +112,8 @@ ssize_t zcomp_available_show(const char *comp, char *=
buf, ssize_t at)
 	return at;
 }
=20
-struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
+struct zcomp_strm *__zcomp_stream_get(struct zcomp *comp)
+	__context_unsafe(uses raw_cpu_ptr())
 {
 	for (;;) {
 		struct zcomp_strm *zstrm =3D raw_cpu_ptr(comp->stream);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 81a0f3f6ff48..afe0c1bf348d 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -85,8 +85,10 @@ const char *zcomp_lookup_backend_name(const char *comp=
);
 struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params)=
;
 void zcomp_destroy(struct zcomp *comp);
=20
-struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
-void zcomp_stream_put(struct zcomp_strm *zstrm);
+#define zcomp_stream_get(...) __acquire_ret(__zcomp_stream_get(__VA_ARGS=
__), &__ret->lock)
+struct zcomp_strm *__zcomp_stream_get(struct zcomp *comp);
+void zcomp_stream_put(struct zcomp_strm *zstrm)
+	__releases(&zstrm->lock);
=20
 int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		   const void *src, unsigned int *dst_len);
