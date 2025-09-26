Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3EB15CD7E
	for <linux-block@vger.kernel.org>; Fri, 26 Sep 2025 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846570; cv=none; b=sDa4hOG3PU9iuppiAFZ4yhVw/8NnjgKVVeXsS3sAm4aLgX7MHcSWdmcfv/MpNQ05bPodSlbcV/QSIMsQhgSDMaBaj76Tqrf4oDPa0Lc91O9/farsFstHDCqhPVutK+q1LZBbpzdjnakb3pbP4htn8b1mlbddLnr/ysJoih7ZANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846570; c=relaxed/simple;
	bh=EIuqb+bEXzHKheYSg8/gT99wnpLEGYyBUdzthx12unM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avfv1PXpcyl6l7aTpW8Fbly29jfwX0vNylIZkdU8A+UIjwhlnefKyEbA+rPbjDD8VWz/KMl2c0Waez2EKmObpdKXkrto/Zq4K/sE8JY6AjFLm7PBBQkhtjat1rWUaznjB3uuqodPTpUNcsl5IqkyFOfnWC7uwlPj3o/Qyf/Tt64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKmmG5T6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKmmG5T6"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77db1bcf4d3so1197588b3a.1
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 17:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846568; x=1759451368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vApv1A8U/+p+Slbx14eQKwBqtf6JexlqDhpDLkVD4XQ=;
        b=VKmmG5T6vkrGY2k7DgKj3GuReAhB2ZFCsDa3KUZ8TFL7rFaKQuyrHXDz8mbPBOt6Jf
         03BGyi+O5o6AE5Iwqa0kIp8WT0biZHlMveNf/DC0IpYObOlTwvWFfpzOZugLqC8pgl62
         3bgUKf7AFU6s0doBeOgvgXMY15rcc/m4Bn8C3rYKXDmEqqxheTJdfnlxStA8WKnxcp88
         kiS1h2c4xpArrG2eUJf+jYOXegskASvhokggGr71e7sBJmA9TLjgWeQgdud0IUbAZJSo
         0R4AHa1vucuaIRvyeo0JDBMGhB8Bjd3K958lRZtA8/RZ2i6WGmkMGsXFVYmN8BdcqPUP
         3/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846568; x=1759451368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vApv1A8U/+p+Slbx14eQKwBqtf6JexlqDhpDLkVD4XQ=;
        b=ibMaXXLzjuQVZPPJO+Rhg3nhvBxbLR0JCPjDR/VM+DrR3XMvn3EKhsipZienO7dQoq
         o8jljYR6jDXITA7KeIyoxbpR9GoOdXZC+NW2EXHVNfQ8KL1irUh+Wa189im50sLez7d7
         ex8Lmf20qtHVUtvKDmz1U4jLF9fWmJNQu1Uf9OolW8AnGSZhYNIXuLebTUxATGZQ2PR4
         7fCMc4cqKnnkfvR8v97a4MX2iiwUCoGzXbOh6+CLWmXS7fUFBNqlkzc1XSBAIfBus2My
         TrETiAvcMcFrpx1o3RBzd4P6eu61C9uemfml1lYCg7sjPp2Dub91LAupRfU2pjn+Y3PL
         Lujw==
X-Forwarded-Encrypted: i=1; AJvYcCUpPgr39LdOMvriq2RbWGxpBgx5q9CsWz6qxfUq4stvoE1Y1od1wdzra9Dy9nh69malD/mxt6UaPCeH3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze714xC064zlpYYl3rb46eDwFwa8NyduCXT69RpAywiAWgW+t4
	x+BolWVkNaDunvxUQEr09vCv1BmJWyLMcMQW4gStj5izo7UumGCw8XKY
X-Gm-Gg: ASbGncsjdMVhAqDG3iGxx2Hls7woO9X5nWPh9VAlOEWojW1H9nXgQZLJSmnGrwhwNHj
	ylWPsEwaF6SqLEhUrtiuHCNxLohZfIeJRRDu1yrvPZvywWszVoRRsMMJIVM5tEJiaN+Eby1j0Jz
	gaIkAtraN1EKyzVjZ8kChTUvkca5uEfPP7N9gxrJcd08pNsEutn5dd2A12+x6qWOxUc6EHsXFQ9
	cyB6nWpfljIfXgPXfD75OmKtMKET57nX8TqPHmCLbZLYXo9Rin1161H96RJcP2BbutUpKcc/nPC
	q6nAfp2l1SK5KXsipV1aTn/B1M1XRYwm3bWqpCNu3RLV4nEuYnLQ/r8gvn3QspPw8tfajbY/tZ4
	uWDF0FICbO3TLG13UIjsQT+q5IeV0Op2dAlzM2NxAi+A2mXZa2Q==
X-Google-Smtp-Source: AGHT+IH23dwF1NgLX5PleNnijXd7QbsowqYTMDXXK2Av0KZS7klqMtWV6FrRS8eSIiqXbBxh0MCuvg==
X-Received: by 2002:a17:902:d4c2:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-27ed49fbd2fmr63113575ad.18.1758846568053;
        Thu, 25 Sep 2025 17:29:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cdfafsm36331395ad.30.2025.09.25.17.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:27 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 02/14] iomap: move read/readahead bio submission logic into helper function
Date: Thu, 25 Sep 2025 17:25:57 -0700
Message-ID: <20250926002609.1302233-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7e65075b6345..f8b985bb5a6b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -367,6 +367,14 @@ struct iomap_readpage_ctx {
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
@@ -392,8 +400,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
-		if (ctx->bio)
-			submit_bio(ctx->bio);
+		iomap_bio_submit_read(ctx);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
@@ -488,13 +495,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
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
@@ -560,12 +564,10 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
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

