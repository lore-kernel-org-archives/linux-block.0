Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5843254A9
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691828; cv=none; b=D8V0jRGnHQKUhAbZV/MTl5LO71k6TW4RnfdHBMvRaLUJHC0dsOgz9dM2IzLr2NZt+XIKbrAmiKmUulWLp3GIxOeG9AG3euNHlNqbePUYL1lMUwpRpNFRTlSrcSdHaGqtBdM8VdmnKtFxJ1AO88ckrduNwco+7htWwNaUCwaFTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691828; c=relaxed/simple;
	bh=DlZHiOUNkdeGuYEIVfvDuzh11ftg/C7BtJckI17RWno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTqYsFnt8FgwjpstSDtH3aZVG9nNenR/9JiJ3HxgtniZexV/zJZsFtY6EjDJTmGKLP0awSNWqiFjhpTVYUHWlu4ZgbocYYCKGFV2xRD2TsG7ONtV3DPIjDnvpAgmN4WgcAp6oBGLjXSNBk8SuXIogqaIKfze/oJ5Mx2IerIsB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WVD/vRFy; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WVD/vRFy"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR6C1nQYzlgyGV;
	Mon, 16 Mar 2026 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773691822; x=1776283823; bh=OcmkY
	xM/GwB0vqDOtw7yLiKiTatZk9DSroY8JAebN6w=; b=WVD/vRFy3fxiBjI3PlbQK
	gWxOtAuH8WN7FA1Nl+oIPTj7TvmSX05b+CaODSSRabsqm2y5cvpmb755QEcVI5H4
	njmxa8pplOlfX0cC9mNdHIbJ+1oVXTjDhcufsAYvG9zPs1GzXbQ8e0d6i7V98GHm
	cEqVai7t/kc8jXTJ9P8iPupQqLlNIrxMfpcy87ZgstgJ/uWqyEzbZSfwrxlFUZjI
	aJ3TyXtQmxVcShhfz2re/OUnQfAuGfX8WhImpaqO8LXqKMXmHxdzpRTz++YC00gd
	Gob32hNgDQ1PWeX5Yka3T++2iEkxvCmcfD7cCMXjBt0+ZHAFbxEJMalnAapi35ob
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1p5eZx45X8F7; Mon, 16 Mar 2026 20:10:22 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR635vWGzlgyG9;
	Mon, 16 Mar 2026 20:10:19 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 11/12] zram: Add lock context annotations
Date: Mon, 16 Mar 2026 13:08:48 -0700
Message-ID: <20260316200901.4111651-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316200901.4111651-1-bvanassche@acm.org>
References: <20260316200901.4111651-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling lock context analysis by adding the lock context
annotations that are required by Clang.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/zram/zcomp.c    | 3 ++-
 drivers/block/zram/zcomp.h    | 6 ++++--
 drivers/block/zram/zram_drv.c | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index a771a8ecc540..c5dc9bb7046d 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -107,7 +107,8 @@ ssize_t zcomp_available_show(const char *comp, char *=
buf, ssize_t at)
 	return at;
 }
=20
-struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
+struct zcomp_strm *__zcomp_stream_get(struct zcomp *comp)
+	__no_context_analysis /* acquire related to return value */
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
