Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F2399031
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475207; cv=none; b=Fn9f56W9x8wm+1Ya78RNpyqeF/o9O925xlHNcOE1138OD2iF12SwD3/eVA+/mNf4j8SxR/laOPJphcOHjnbkmrSLk6IUP3fpS5Q5x/Ciaj+NUzbca91ZY9iyKDEyAMLYt5TjEvHaOOmOlDJ/1VzMXYlHWgH2BTHSGktUPk56mAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475207; c=relaxed/simple;
	bh=Sl3oRDO3qux1k7Xxvwv6IFein1H+it33X1xnTdmUJ84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szlc+2dA5Y6EhRSwGQaH1hYghZvB2hVZ1zlhyQPqtMrvsK/sV3qv8XMYx0+9EgBl1SZAovjQdqBiDsObUryePzssmnUKXJ/7HA960U8ch+IWyHF5jR7bo51dTtMX7uJAI67Evh7uOjssFn3QtE1rDRx0q+mp7us0+wFWc8nXJl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JsE+lblY; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JsE+lblY"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0q76sv9zlgyGm;
	Wed, 25 Mar 2026 21:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475194; x=1777067195; bh=KG9Gg
	nYt9ixb0YydX6fbgVhBW1FbkPVX39RBYjsgJZE=; b=JsE+lblYovWemdy/6XVdj
	cTEjjy2TAOCWrTGY3/kWwRaIMpgnJMDmnNawZlbppOKnYPes7RCxH3/x+r9MT25N
	kxxA8gRyEV+O7xzBqrMCjnK6AyeowUS868nSFdXJh2MAYvz7l2IhWMxO5ksPRKzc
	VMONSyOp/LMDIxbtc3wEr+A7Uv8XT9Adpi7AjPzpymwEeVLpVU8reEri1KFu/8OX
	8BR3lT8T+smYmhNRzL2dqmLS33or2CmGpE86Ee3pdlxHBXfzOWbV6oAmzx1TV2ZY
	jM+DqO/ZEENy+WkQokcqNRBuIJId/71WtY43PrXeGd8FXCI/xVtrghOgh1aFcuTB
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GVcp2-93RjEo; Wed, 25 Mar 2026 21:46:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pw1VNNzlgy4t;
	Wed, 25 Mar 2026 21:46:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 24/26] zram: Enable lock context analysis
Date: Wed, 25 Mar 2026 14:45:05 -0700
Message-ID: <20260325214518.2854494-25-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
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
 drivers/block/zram/Makefile   | 2 ++
 drivers/block/zram/zcomp.c    | 3 ++-
 drivers/block/zram/zcomp.h    | 6 ++++--
 drivers/block/zram/zram_drv.c | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

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
index a771a8ecc540..5f431596f3b5 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -107,7 +107,8 @@ ssize_t zcomp_available_show(const char *comp, char *=
buf, ssize_t at)
 	return at;
 }
=20
-struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
+struct zcomp_strm *__zcomp_stream_get(struct zcomp *comp)
+	__no_context_analysis /* __acquires(&raw_cpu_ptr(comp->stream)->lock) *=
/
 {
 	for (;;) {
 		struct zcomp_strm *zstrm =3D raw_cpu_ptr(comp->stream);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index eacfd3f7d61d..4814087e8ac9 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -85,8 +85,10 @@ bool zcomp_available_algorithm(const char *comp);
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
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
index a324ede6206d..e0f716d80369 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2395,6 +2395,7 @@ static int scan_slots_for_recompress(struct zram *z=
ram, u32 mode, u32 prio_max,
 static int recompress_slot(struct zram *zram, u32 index, struct page *pa=
ge,
 			   u64 *num_recomp_pages, u32 threshold, u32 prio,
 			   u32 prio_max)
+	__no_context_analysis /* too complex for Clang */
 {
 	struct zcomp_strm *zstrm =3D NULL;
 	unsigned long handle_old;
