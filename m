Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94A3A7848;
	Mon,  9 Mar 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058987; cv=none; b=OtVieZQ1n+tNiCbBcxXB6hGpNjhmqjKkqw3VPwEAjMt6fWcBgvFVL74jdRIQDj7pxnrEBUzZnTjjz4jlpuocc3s1eHyvzo/mhbYEBnEnOK2u9MMj/3tvdZnN1/b62P+SZsxB4Yjh8qgECjx9EnJkX2JjbLVygz277gPVWR+lisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058987; c=relaxed/simple;
	bh=6bCovHxNhPnngnBhcdFKTFyFYSTQCtrOJGDsZlVv1hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VYgb8gCaKqKImN2Jeq5tckf1zrchE2YiXfTX53Q0OY/9Pt1IZ4L0FrLLI8yyX16EorBYxebW/fVcABAwlYqpYAfmtCBQLUvtwTblLqgrq7QLtPSEDmUYZ0DmC6Siq/jQIGzAEl/57Kq5th59SquUBfp4kHJueSIbKc+Vtw3mZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poo/2el8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poo/2el8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A418C2BCB1;
	Mon,  9 Mar 2026 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773058987;
	bh=6bCovHxNhPnngnBhcdFKTFyFYSTQCtrOJGDsZlVv1hs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=poo/2el8/wjy6eJ3xHpHslaH7yLU6gPqHFARnpZN2EnfSF22x08NAkqILuphn+RFq
	 rCSZrXpbQhlAUXu0sguEnAccvdi3wx/EgXl3EiQixjJIx1hY65/p74XKA6Oxg4AMmu
	 56p1cTe6+dn5Zq5bsNdz952xggOUQnMJA7IScsGZfJOf5YNxTY5DwhK5VObpRe15pr
	 hRTpPP+Li2kW6FOyTXpqjFC0PxqPno8M702WwMwwE/hUHMdbSywvSl1RfPphDAEx/k
	 uYcTC+cj8+QbL+cCr8K6ljkgyaspC9T/oOOVwUGm11DAOPj9ZpeQ636g7AaStbnU2w
	 dXcbSaQcH7G2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73598F3C249;
	Mon,  9 Mar 2026 12:23:07 +0000 (UTC)
From: Jihan LIN via B4 Relay <devnull+linjh22s.gmail.com@kernel.org>
Date: Mon, 09 Mar 2026 12:23:07 +0000
Subject: [PATCH RFC v2 4/5] zram: Use zcomp-managed streams for async write
 requests
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-b4_zcomp_stream-v2-4-7148622326eb@gmail.com>
References: <20260309-b4_zcomp_stream-v2-0-7148622326eb@gmail.com>
In-Reply-To: <20260309-b4_zcomp_stream-v2-0-7148622326eb@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Jihan LIN <linjh22s@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773058983; l=3798;
 i=linjh22s@gmail.com; s=linjh22s_machine; h=from:subject:message-id;
 bh=v0DGgSS+E5bgvt8cBKnXuZ6r8eM9BVP7bcdiMehO2N4=;
 b=zwljVfG1zncWfD57mFttrzMqxef6yb2k6deJ19Qm8qYfJy3u8QDJK3byb+yduxIK6Tvk0LF7w
 N5PKY/tv4cBAJG1Rg5GthxCscul2Qk0o6fzkDouOpzjWoEkEIh/GK1/
X-Developer-Key: i=linjh22s@gmail.com; a=ed25519;
 pk=MnRQAVFy1t4tiGb8ce7ohJwrN2YFXd+dA7XmzR6GmUc=
X-Endpoint-Received: by B4 Relay for linjh22s@gmail.com/linjh22s_machine
 with auth_id=592
X-Original-From: Jihan LIN <linjh22s@gmail.com>
Reply-To: linjh22s@gmail.com

From: Jihan LIN <linjh22s@gmail.com>

Current per-CPU streams limit write concurrency to the number of online
CPUs. Hardware accelerators with deep submission queues can handle far
more concurrent requests. Use zcomp-managed streams for async write
requests to take advantage of this.

Modify zram_write_page() to accept a flag indicating the request is
asynchronous. If the bio request is considered non-synchronous and the
backend supports zcomp-managed streams, attempt to acquire one.
zcomp_stream_get() handles the fallback to per-CPU streams.

Sync writes block waiting for completion (e.g., blk_wait_io() in
submit_bio_wait() from callers), and remain on per-CPU streams for
per-request latency. Reads are unchanged since they are treated as
synchronous operations. Recompression also remains unchanged as it
prioritizes compression ratio.

Although zram_write_page() currently waits for compression to complete,
using zcomp-managed streams allows write concurrency to exceed the
number of CPUs.

Supporting multiple pages within a single bio request is deferred to
keep it simple and focused.

Signed-off-by: Jihan LIN <linjh22s@gmail.com>
---
 drivers/block/zram/zram_drv.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7be88cfb56adb12fcc1edc6b4d42271044ef71b5..3db4579776f758c16006fd3108b4f778b84fea30 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2083,6 +2083,7 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
 	size = get_slot_size(zram, index);
 	prio = get_slot_comp_priority(zram, index);
 
+	/* Reads are treated as synchronous, see op_is_sync(). */
 	zstrm = zcomp_stream_get(zram->comps[prio], ZSTRM_DEFAULT);
 	src = zs_obj_read_begin(zram->mem_pool, handle, size,
 				zstrm->local_copy);
@@ -2249,7 +2250,8 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	return 0;
 }
 
-static int zram_write_page(struct zram *zram, struct page *page, u32 index)
+static int zram_write_page(struct zram *zram, struct page *page, u32 index,
+			   bool is_async)
 {
 	int ret = 0;
 	unsigned long handle;
@@ -2265,7 +2267,16 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (same_filled)
 		return write_same_filled_page(zram, element, index);
 
-	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP], ZSTRM_DEFAULT);
+	/*
+	 * Using a zcomp-managed stream and waiting for compression makes this
+	 * appear synchronous.
+	 *
+	 * At this time, zram_bio_write handles pages one by one.
+	 * However, preferring zcomp-managed streams allows backends to utilize
+	 * their own resources.
+	 */
+	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP],
+				 is_async ? ZSTRM_PREFER_MGMT : ZSTRM_DEFAULT);
 	mem = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
 			     mem, &comp_len);
@@ -2327,7 +2338,8 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 	ret = zram_read_page(zram, page, index, bio);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
-		ret = zram_write_page(zram, page, index);
+		ret = zram_write_page(zram, page, index,
+				      !op_is_sync(bio->bi_opf));
 	}
 	__free_page(page);
 	return ret;
@@ -2338,7 +2350,8 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
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


