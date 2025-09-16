Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9992D3EDB
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066634; cv=none; b=InCelMUGFF3xDYmghlN6rhxtSJIlsIgv9WS6+osgopAnFInJkwlLemdpeIc5xCMLg2G06G3YhjbsWsj3mFt/YUgzuXyC140eTgIqOwg3RZs1VJaQZxG6Y/bZCAa3fInG0PW2o2yQqszN40imS1WHNTZskkOvUToaT0HV6cTvRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066634; c=relaxed/simple;
	bh=oQMvt3x5Q2N+uSt74k4pmpTEp6W00XYhfBugSskMdWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZdlMP32w17ihvgzQq9XOnM49ddeDFZuTOf8URw+oP9bDOd0PrQtUdG3bJ/O7GwqzEXxzSJhrNmAjynvvAc6XRFpeebOOae5NyT42ewg1VqdztWjbf6rlhD/fOMs3fhPnIwMZemJJMinC/EZAKJIQ/QmE1Yyx9wKBi0cezQcXvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibE84cvN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibE84cvN"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-776b0100de0so307174b3a.0
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 16:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066630; x=1758671430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ad09+MQKPROP4xJOPPVDT/APdYePwOoTN3n11YylRQ=;
        b=ibE84cvNHpHe2yOPUS1s1jKOO+ztjpBHw/t3qKGb2i1FzRB1waAMhUFT1SggEHkxf4
         EKWJl7/5ye/RqcSI14hRRqYW4cG2Xgr7OtkEa17eOCyzfRR7PczlbmRdCP1juLsJSJzJ
         5ubYiHkijurimBzyN2CDTVgehM1UgE9YeglNwC3VeqAzHceAPkQ/PWi6BRIGSbK+3zPj
         PzJIF4ld81KLW5UzcugTztVyRwsidwkABVfxXKlY+33fNfiZAeTiMZ+H+HXh62SXm8IY
         jGxLLF3/tCjs7dtgkZfAx/dufr3wJ2DUKw66JZRaFUu2BU2XTbIIEfNQlgwYrxnEBp7C
         Haew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066630; x=1758671430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ad09+MQKPROP4xJOPPVDT/APdYePwOoTN3n11YylRQ=;
        b=tRXvrMpGn8ZzFJ+QMKz2oFbEvPVAKFiE03G9/xRHrKMiOhHKphANlgyve+WnsTsY+8
         OG5CBJ8uCj6BHqjCazGJjnFpI21Le+PA4giRYYgWTN3xtG0m2LBxaB1hZrOV2tukZvic
         SwitzdKnaljHgbKT7GDqR6A/nU0yqjo/QYJsgOaIn8/e5858z2XztvPvSuL/bjR5tUWg
         otoex6QSEU5eZ1OJTWq8L1lJSyi/h/d5IkLfhG+2FJZj1J0sjd4GuS2U7SxNAoYsHsfR
         +Eex1nnin9y+td3fPQifnCjGpTYqyIpK4Hv6LOI6spnPAH5unjt6GWnbn6LwY3hQ1pOE
         AOvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxJiqu4kNAY6uNFF0FTJTGxRBameLRkGtCr4NgYQ2F4wOYjDYcSmThJPT6SMtFTxy6V19kApZ9vSG0gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8PeueYM5rG3SQhMLIpon8C7bU4ayOFcsPa3RMgzu6QEQaX/h
	ptvnvPtTlWIK4WP/9nudpXSmUesF3aCbaCAxtLJFGHEBF5nMcTw4PCrj
X-Gm-Gg: ASbGncsNuqWnJo9U69R5ymjgsrU1Tg78i5+M7aEwOr7uSJoGnTVvSJUsfProUtK4D2T
	AKoOhAF9JpfacaB20BLr6ljqxCSDE7vok5yr/h8aNE9lOhy4Abm12v97g+yweVR+0JKQ/hX8R6l
	ogkA5x7N7aMCKw2LCgqLQfoQKEORGi3e1Q2vhITa6QUoGwMzR0E7ZXUDs8/Wn28qB5KmzgcajV6
	c1HAia94ZHlS1aMyQfa2d4ZK6t676UDN343560Ip3dfp6LkIv6FrUkxtjoVOPFNKO2j+lfSk8U5
	jkuqytFfzeXnhCIFcn0WObpe1yI2nGCtht7pHCf5QltRZqJhlGgC9KZONVC1O6+gjTLkMzualM2
	biosOrr8dKX9wgicWP+hZvdSDJxLrrEhx0Vew/ccUbJKMrcPU
X-Google-Smtp-Source: AGHT+IEBXsoPFEqPmLi3eim0ez8AD7ra+R5wqscn78wj7CppFc2BDvERHIUoydzeJ3XEBjfYKljMBg==
X-Received: by 2002:a05:6a20:3ca6:b0:261:ed47:c9b5 with SMTP id adf61e73a8af0-266e5bf9c68mr6068804637.13.1758066630224;
        Tue, 16 Sep 2025 16:50:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a398aa76sm15413902a12.44.2025.09.16.16.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:29 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 02/15] iomap: move read/readahead bio submission logic into helper function
Date: Tue, 16 Sep 2025 16:44:12 -0700
Message-ID: <20250916234425.1274735-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the read/readahead bio submission logic into a separate helper.
This is needed to make iomap read/readahead more generically usable,
especially for filesystems that do not require CONFIG_BLOCK.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 05399aaa1361..ee96558b6d99 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -357,6 +357,14 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
+static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
+{
+	struct bio *bio = ctx->bio;
+
+	if (bio)
+		submit_bio(bio);
+}
+
 static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
 {
@@ -382,8 +390,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
-		if (ctx->bio)
-			submit_bio(ctx->bio);
+		iomap_bio_submit_read(ctx);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
@@ -478,13 +485,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
-	if (ctx.bio) {
-		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
-	} else {
-		WARN_ON_ONCE(ctx.cur_folio_in_bio);
+	iomap_bio_submit_read(&ctx);
+
+	if (!ctx.cur_folio_in_bio)
 		folio_unlock(folio);
-	}
 
 	/*
 	 * Just like mpage_readahead and block_read_full_folio, we always
@@ -550,12 +554,10 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, &ctx);
 
-	if (ctx.bio)
-		submit_bio(ctx.bio);
-	if (ctx.cur_folio) {
-		if (!ctx.cur_folio_in_bio)
-			folio_unlock(ctx.cur_folio);
-	}
+	iomap_bio_submit_read(&ctx);
+
+	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
+		folio_unlock(ctx.cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3

