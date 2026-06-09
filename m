Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEC4369D51
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042819; cv=none; b=DSFwESdvBPYNr1YUQTJUWcItfFinR43jofXE8MLPdZCs5ileqFHxB/JzGqq3bqe4zNJ5HplYx8L0gwT0kKd3YYimebJ4k3EhRlmKPe+HeKNSNbmuDbYUaHBx6y3HWcGpkdeqB4hz1tTKRqrjCS5WiDM8BkH6QD9uMCVUeQaKoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042819; c=relaxed/simple;
	bh=7jcivG/gKJTgEmP1/NvCUK/Z//1zFgjzrDpjpT3ubdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJyfo1VEZCvaTlSnL8H4KMBDlzV9qT+OoMvGHtKqKKxWWBKFvJLlRdwpfxeQlQm8GAzcNczJl2KhTM/H0DdTQQSlVD7NOTDdmJ9OHLZTGwYwAwK1ULDTSR6g0MKoD4FuZgL8KiL7htkqIgQl9Ah7dXThviVGyr/tGd+syMCA+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Y4T4DvPo; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Y4T4DvPo"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjgQ3qBszlffvQ;
	Tue,  9 Jun 2026 22:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042813; x=1783634814; bh=mcb2a
	LK8aOI5cBQ1mtULZH7MqnDQ4yCrAXl+29BtYN4=; b=Y4T4DvPo+IIy2mDrzRvzk
	s/UO5AWaQYbJFIy6jGfsmiQwYNsARtXekBz8buC1DvOExux82gSq3+he13mKO0ol
	gY2QOH9mMZQz9PgYKC9FVlwNs5CSYg5BTZaOgQvyjXPslbDb+5jI3PBh252Ey4s7
	rIJ9XTZjBZD6tsYJCNo/PTfLhArwdVzQXwrB/ffac59uPcAGme1ZHkP13y1jq8Vk
	gANAqjsAEguQQoFF3h1u4+gFS5eNjyqYjvbRnwS75WGDt2R5YNxm0Fx1ERvTQAU5
	/USQyU73bY/QeAzJ/fR2CcOsrvZD8G8hzoJ0FeII1uj9oCRJGttEniMTuLJO1K+r
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jDzq1DDSJwd8; Tue,  9 Jun 2026 22:06:53 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjgJ0DM0zlfpM6;
	Tue,  9 Jun 2026 22:06:51 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 25/27] zram: Enable lock context analysis
Date: Tue,  9 Jun 2026 15:05:12 -0700
Message-ID: <dedce2d47b5bcba9c61f917a54107fb7d52f2d17.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
References: <cover.1781042470.git.bvanassche@acm.org>
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
