Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A938645C
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653786; cv=none; b=EcpN59h9cOoYW/ACjomTAecv6VWgkY8S7eK+X+sFSA+dA1IQqL8Lxcl8o4JxGheRsE+U73g9bKb501CZb6Jp/PNIo/lBoG+6TVVLN/g/ImKwMgSyk6ffRnNW6yyqpxug3EoIkWycBzvfZOWEInrXwHvFHPRYpjX88bKheaJg600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653786; c=relaxed/simple;
	bh=Qgy1eF8k4+oqExrZfuXGM7L0GL0eb36fijAwjR8CZYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhTb/2ldcMtG3Eserxn5eWr1VZla9IlhYJo8sD2WSCt4z5E9Edc9mD8PPLweV6hwScEXs3IbhJqiKVKG9J+LcW/Y5pFGV+RzE/9GmECyzLs1jp6YhKu9Dp0zbWWPL0GDcoZtY2dIZ3sxKT9Hmq26+z/jhCNMZ0Q94LU1lvQ85fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=m2+SzPQb; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="m2+SzPQb"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3Cs2cQqz1XM5kt;
	Wed,  4 Mar 2026 19:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653779; x=1775245780; bh=WfwjF
	m4sszYGHMswfpD4n7WVY9eFLsgBiM6LDLmbW38=; b=m2+SzPQbm9xltvCrzyPRH
	je7gv9pcXu/XcEzuLQqHf/uRWwdbedzMZdfgNYcf2dKDJ1kZS/FXT3s4AnTQ+NF6
	rMdbaGv4moRB6HB1j2yCiYtMOaHdt7kFxhiank4/FmoofrAFN1d+OclXFJP5E71B
	FXmkAeYBHQ9KM5cHlxpFXBF9tjEX99TUfLFv0S205mhQJqO9vp91YuHDdDWMXuQG
	2oUQnlbmsG1+Zjf3HIeYqiFGF5WbDsZ/Bh96pPED05WQOTYzb3Shj75Yy1rwFpbN
	MC4pjT1NROpqtqfJx3e1ZMfkgfPF+sVwgQHi6UOVv+2mIBpTCAMJATM7Grn5jR1T
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uje1QDvfH1uO; Wed,  4 Mar 2026 19:49:39 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3Cj3TMWz1XM6Ht;
	Wed,  4 Mar 2026 19:49:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 13/14] zram: Add lock context annotations
Date: Wed,  4 Mar 2026 11:48:32 -0800
Message-ID: <20260304194843.760669-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling lock context analysis by adding the lock context
annotations that are required by Clang.

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
index bca33403fc8b..41d3d2a2752d 100644
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
