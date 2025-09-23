Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C81D5CEA
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587639; cv=none; b=OxW+aKSev6m3zjTYX0HzGy19v/XMCsBcFFF9k0LCAxsJZd+rz4bcCrlWg8TkzGDb2jzPgwVap6sp4vWfOOTjf6DtGB5u0OgUuYpAeFypa77gHCUCcl/vzjt9tzr4wS9e8PL5dmqZDxV5IOBBGI0qrBmBHQJB6lvWd2ZdnsXQgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587639; c=relaxed/simple;
	bh=Bb9XHeMlSIhgxocJi7zMkwUhCzQElY81IHbj2qnvjQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chvJloXIN9d+2EJWACK8uWBAqvKkZjEDz8jEG/vFxwczYaBX+VfpoXm6xP1MvE+fwW2nQ9U2OcYhs5HTeo359kPnCJ/Hlt+WVSlRxX76JNTp4DXwN0X8BDAFTsjf9hlX3n+gRFy33S3TaJDBre5m6yMErJXqQlz8Ogg7Zj0zarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnNm45/r; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnNm45/r"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-269639879c3so50144865ad.2
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 17:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587637; x=1759192437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcpVeAYougECMqYDjv+WTibeO0LuSWTiGkan9JcZFA0=;
        b=CnNm45/rYKBe2cFGbfrdHfEbrBLtkTehOjWd+YtbwYbKTms4+8PDfZidHWDv6DVD8c
         /JTco8yI0leuSEFrwhZl2C9vJZ1qrFSg24iTG3/W0VglCyFP7EG8Rv/ujMumVudNvtiP
         9OXqNq43++2UudwvJ6FknS48KVPHcDmGrBMLiTpNta1g4eFYlRqMVt94yF6JnUP7mraC
         b8YxvSVStYdlbJyGrtZHxdpZLnp+0WNv9jTTDIGGZHJZO4DNgi+Aguq5v/6nzZXCynTE
         Op4m7oiIMF32baJkv6Lyo119+CpOjoypPDDihBa5MFW9MRmOACo/nYIM7020EXmn4CAw
         jMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587637; x=1759192437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcpVeAYougECMqYDjv+WTibeO0LuSWTiGkan9JcZFA0=;
        b=NeLMbI8fyHIsNS55Rgpgnxm1eX+vMFgO3IA+TUFiUFjfermv0wbvvaRmtKbKMeiONv
         uKMNVQOIqF/OrgK+SJT2lgfaOSXtFKNNFUkoIwCn5m/M/OleMMPhTyCvgtKx7ztPajON
         o/Vh3OSnE+IRrXzNpaRhXNqOiO5a71l8cOidyzvVgmLfhz0fHj1IKXq8EBGRcEpq8bgi
         nCaRuQ+PwxtA0DVXUMrcBbsSDhHWQauTY/djANO8GPNWvL6spUI67pz06DEQtiaDXEjp
         HxOmOe2Ur5M0XlPExdJjKD4Tih/zbkaLgAvkdnlSZupwdEOQVLSb1QuLP1uyFoshukhM
         dBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFlzmt1qDkxX2mLE1UbIr+szXr0dY6CkLoeeOjAfeLvkat29S45C8z5YlXMYrOq7ngaDxIKHPmDU1meg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjNu83PrJxZyuXAaPsEWEM8NvtqB0TfP5NKVUDHN6N4mzLK0z
	SGq1Vd49m910OuKri9MBSu0f+caV5J07/zso3mCeHu5A5R1ndS6imfey
X-Gm-Gg: ASbGnctzpH/JmS0Hwe66A5xngt+xHGydUdjfhwmNy9O/24dWePWn//rEZ7Adu+VDX1B
	gaGs6sBCbCXa/vV+UHnekDpA9U6ANdkwcXFBp6JQ2uIR68K6EKgRrEZnjfEz84zR9JTWs9k1Lxb
	d5KM/0UfkrXCIrxxTxhm4Od9toc8CNXIlk2/73Ymo7cSz/ycpyDd70CkkivDMAKr99yWXiD4I+g
	w8TZwfSY1oL/wRMweLyshUGA+ewGTEt0/jc5g0eaNBB3gtUTpbtSxKTcfoxfCc9QU7v6GLW/gg3
	PjqzAVvCtwV0wXtB5Y4FV9WwHpBMkOmNVaHjr/1G31Owj+nm/KaIu+RrsiHmjYgAve7g2bajmKm
	U/UDAwdcKJyXErkKw40wG84ujGAXIz1wUEZpkCbx+OQY1CaDRQunE2qm74Bg=
X-Google-Smtp-Source: AGHT+IHVFfzg8x4eRcM+QJ3isKvKIKmIsBBStLAEhVGVKIoSb3CxXZfaFZoSTi2VN706ZbNtC20t5w==
X-Received: by 2002:a17:903:11c3:b0:270:ba81:14d9 with SMTP id d9443c01a7336-27cc5434ee4mr9156995ad.36.1758587636816;
        Mon, 22 Sep 2025 17:33:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802deea6sm141157835ad.75.2025.09.22.17.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:56 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 03/15] iomap: store read/readahead bio generically
Date: Mon, 22 Sep 2025 17:23:41 -0700
Message-ID: <20250923002353.2961514-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the iomap_readpage_ctx bio generically as a "void *read_ctx".
This makes the read/readahead interface more generic, which allows it to
be used by filesystems that may not be block-based and may not have
CONFIG_BLOCK set.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f8b985bb5a6b..b06b532033ad 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -363,13 +363,13 @@ static void iomap_read_end_io(struct bio *bio)
 struct iomap_readpage_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
-	struct bio		*bio;
+	void			*read_ctx;
 	struct readahead_control *rac;
 };
 
 static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
 {
-	struct bio *bio = ctx->bio;
+	struct bio *bio = ctx->read_ctx;
 
 	if (bio)
 		submit_bio(bio);
@@ -384,6 +384,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
+	struct bio *bio = ctx->read_ctx;
 
 	ctx->cur_folio_in_bio = true;
 	if (ifs) {
@@ -393,9 +394,8 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 
 	sector = iomap_sector(iomap, pos);
-	if (!ctx->bio ||
-	    bio_end_sector(ctx->bio) != sector ||
-	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
+	if (!bio || bio_end_sector(bio) != sector ||
+	    !bio_add_folio(bio, folio, plen, poff)) {
 		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
@@ -404,22 +404,21 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
+		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
+				     gfp);
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
 		 * what do_mpage_read_folio does.
 		 */
-		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
-					     orig_gfp);
-		}
+		if (!bio)
+			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
 		if (ctx->rac)
-			ctx->bio->bi_opf |= REQ_RAHEAD;
-		ctx->bio->bi_iter.bi_sector = sector;
-		ctx->bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
+			bio->bi_opf |= REQ_RAHEAD;
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_end_io = iomap_read_end_io;
+		bio_add_folio_nofail(bio, folio, plen, poff);
+		ctx->read_ctx = bio;
 	}
 }
 
-- 
2.47.3

