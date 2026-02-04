Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57326D4DD;
	Wed,  4 Feb 2026 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212938; cv=none; b=kB4fEmjlEfwTBCA5yfeBJtwSVZofYATbAv9oU+Jwk37S74x89j+xL3ykW2B72oKMN2fwsPTVaM79L0D1GuzCopdTYPMyy5UmW0FKM5NDBTWTs4UpKLSWpCC8c8v+8GQS4PYN17n3R8K8InccbYyPL1+Eo/dPjKgCGNFFqZ62RZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212938; c=relaxed/simple;
	bh=vDs9ina9bo1CrzxqSRvBldxga3JQ1cDiGOE8LB06p4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cwr1zxpQ/Vt4ffNR9uh9csF4PdoUXzCJ1nXBTBuRDjgX0u3+0cYj2WJE4U0sRf9fBjgRgUDHeCn7+kr67KzAywgUMCrSbQgscc38s1kSuOptjXpeKT1IM/VWF62SZrmfTzM4B79udBYA1f6CP9aJb1KMNH4D1GKp10I4q7Dgpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+uNDLb9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+uNDLb9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17CE8C2BC87;
	Wed,  4 Feb 2026 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770212938;
	bh=vDs9ina9bo1CrzxqSRvBldxga3JQ1cDiGOE8LB06p4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G+uNDLb9AgyEuqhafL2GYiSJbn/wJL99jPx1Vund3/Kb9i5lTuIto2H75I06O9SMM
	 JIzHCgoYO3LG+XtrSGG651GSBPhaDoBWxhTtJxnEAFxKU7Wb8ro9P7igcqjoyUx4UN
	 Mqnr6X74ltnktho/woYk2lnmOV3fZXgynHO++QL8pZ84GIWZkaHHU8rO4O4j1IAcbZ
	 iXA5e+XTeA4oHDITJoFbo3iYpEzyDKlEGy4swRtDbY3jkP9SWKAULflnD048SeJPQU
	 iXmKYuHCVv7Rn0wuHvY17ejMONdvW/WpeKrEaNf4mAAI2CFkQ0++hZwhJasrImUkYj
	 sXI06DYMkvK8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1C0E83F11;
	Wed,  4 Feb 2026 13:48:58 +0000 (UTC)
From: Jihan LIN via B4 Relay <devnull+linjh22s.gmail.com@kernel.org>
Date: Wed, 04 Feb 2026 13:48:53 +0000
Subject: [PATCH RFC 3/3] zram: Use zcomp-managed streams for async write
 requests
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-b4_zcomp_stream-v1-3-35c06ce1d332@gmail.com>
References: <20260204-b4_zcomp_stream-v1-0-35c06ce1d332@gmail.com>
In-Reply-To: <20260204-b4_zcomp_stream-v1-0-35c06ce1d332@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Jihan LIN <linjh22s@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770212935; l=3979;
 i=linjh22s@gmail.com; s=linjh22s_machine; h=from:subject:message-id;
 bh=n49FebibsqQERts1+tv3yx6Io3Tg7uusMwfFkfvmBE0=;
 b=5iP6q2XsN0scmSU6Ct+S9QgF8jXHJZbhYOQbAjtLTaT/vAif6+MCwR5Xhd6WJvre35Tz3Q7/K
 EdRzKxAK6D8D/uHscoEyVFhM60tKllsrv3+l1/a+wBi1wR4fG/cmVZh
X-Developer-Key: i=linjh22s@gmail.com; a=ed25519;
 pk=MnRQAVFy1t4tiGb8ce7ohJwrN2YFXd+dA7XmzR6GmUc=
X-Endpoint-Received: by B4 Relay for linjh22s@gmail.com/linjh22s_machine
 with auth_id=592
X-Original-From: Jihan LIN <linjh22s@gmail.com>
Reply-To: linjh22s@gmail.com

From: Jihan LIN <linjh22s@gmail.com>

Crrent per-CPU streams limit write concurrency to the number of online
CPUs. For zcomp backends that support zcomp-managed streams, we can
utilize them for async write requests to get better parallelism.

Modify zram_write_page() to accept a flag indicating the request is
asynchronous. If the bio request is considered as non-synchronous and
the backend supports zcomp-managed streams, attempt to acquire a
zcomp-managed stream.

Although zram_write_page() currently waits for compression to complete,
making the operation appear synchronous, using zcomp-managed streams
has the potential to improve parallelism for async write requests,
provided the backend utilizes efficient streams management or
specialized implementations.

zcomp_stream_get() handles the fallback to per-CPU streams.
zram_read_page() remains using the generic per-CPU streams, since reads
are always treated as synchronous in op_is_sync().

Support multiple pages within a single bio request is deferred to keep
simple and focused.

Signed-off-by: Jihan LIN <linjh22s@gmail.com>
---
 drivers/block/zram/zram_drv.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2e5a1415e9034674e14e619f486052cd21098f50..655d0e141c621ca38ca1059780c1a8a00258c868 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1966,6 +1966,7 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
 	size = zram_get_obj_size(zram, index);
 	prio = zram_get_priority(zram, index);
 
+	/* Reads are treated as synchronous, see op_is_sync(). */
 	zstrm = zcomp_stream_get(zram->comps[prio], ZSTRM_DEFAULT);
 	src = zs_obj_read_begin(zram->mem_pool, handle, zstrm->local_copy);
 	dst = kmap_local_page(page);
@@ -2105,7 +2106,8 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	return 0;
 }
 
-static int zram_write_page(struct zram *zram, struct page *page, u32 index)
+static int zram_write_page(struct zram *zram, struct page *page, u32 index,
+			   bool is_async)
 {
 	int ret = 0;
 	unsigned long handle;
@@ -2121,7 +2123,19 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (same_filled)
 		return write_same_filled_page(zram, element, index);
 
-	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP], ZSTRM_DEFAULT);
+	/*
+	 * Using zcomp-managed stream and waiting for compress done makes
+	 * this appear synchronous.
+	 *
+	 * At this time, zram_bio_write handles pages one by one.
+	 * However, zcomp-managed streams allow threads to submit jobs
+	 * to zcomp without the lock contention in per-cpu streams.
+	 * This might give us better parallelism than the generic per-cpu
+	 * streams could, assuming zcomp uses efficient streams management
+	 * or utilizes the specialized implementations.
+	 */
+	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP],
+				 is_async ? ZSTRM_PREFER_MGMT : ZSTRM_DEFAULT);
 	mem = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
 			     mem, &comp_len);
@@ -2183,7 +2197,8 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 	ret = zram_read_page(zram, page, index, bio);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
-		ret = zram_write_page(zram, page, index);
+		ret = zram_write_page(zram, page, index,
+				      !op_is_sync(bio->bi_opf));
 	}
 	__free_page(page);
 	return ret;
@@ -2194,7 +2209,8 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 {
 	if (is_partial_io(bvec))
 		return zram_bvec_write_partial(zram, bvec, index, offset, bio);
-	return zram_write_page(zram, bvec->bv_page, index);
+	return zram_write_page(zram, bvec->bv_page, index,
+			       !op_is_sync(bio->bi_opf));
 }
 
 #ifdef CONFIG_ZRAM_MULTI_COMP

-- 
2.51.0


