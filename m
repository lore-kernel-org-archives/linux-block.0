Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913E1EA7DF
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587643; cv=none; b=HpjCb+KPMeY3KqqnPvrQw6pklA1KSPJd7TYEEMOt5GxrA1jn1ZooBLOGsnQti12hdvb9JmlfCf7cLd0fw2HU6SKJNrLin9y+qzMhqL8BAjN0wPP/xJM4SerDr8yPva/sDpjPj/VS7c+yVTKl1Zo4+eplnhcYmq9BXr4ESJfOdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587643; c=relaxed/simple;
	bh=vIAY62bPonaFy7vGVNyvqO/mtaIvl07zVQLoOf2yQSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GP0p616GcYJsfx85HuMp3gyWcRW3YhMaiCGBeKjE4v1DUjkzA8LxwAj43JYBDlQKnSPjsDqSwTRfieiSv3Ox1W/z/gEk/5rYWyJUBLoJsFQti+sp/8ZvtTo6c4fI4UMch6Mt9ottc3qSvmZfG9UbP6zyEiVsnukFufxL5Pto268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEWacAz+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEWacAz+"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5506b28c98so3087286a12.1
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587641; x=1759192441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5+CvxTz0as+KK3qYoCdGCPxNBywOK1cIFwpk87cxKA=;
        b=FEWacAz+TzaAoR23MprISMWa/YYtoB6UqG0ltNJeol5EJy7I57pGWkQG2OFd29a28T
         pc+BmZFhySuus3qx2yfkC80uitS4LInaTzLJMoFYOZ/nU6ifHdV5J2cvoFO0Io0SFxnR
         foh0r5YpOzP9m3TcefmaPzZ1ZCVlesMjUvGNLxr/OFsVxdum5v87N8PguQSH/6lsnUPZ
         18krXn13eESq726MmDIrkCEtoKDpInztdYDpySR9tiBZUOImGEy9RSmT+KRim7GVPwtA
         Jkj1Do+gZFyujBrJB1iF84Ftw21RpXHnoTAVj7ZOysCpCYDGDEgbFfYUIrtg+Xd3wIFC
         yHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587641; x=1759192441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5+CvxTz0as+KK3qYoCdGCPxNBywOK1cIFwpk87cxKA=;
        b=HhWSCjU4ZMRYc8+Yxoq2Pk7SRB4eBE9IOPx7qOXXI4Ziwsbzt57F4TV2h/xgIP+VKm
         Qe7ZTtH3G8+RzFTuq6w3XgmuM8SBameYFDV4viNo/IJ8ibT2T/s+k2g/fr8p7fIbbqu3
         /VCkTvtXym4gLCHiYC+VAG28XyMkWFZRzj7PbE47iH1squw/72S/z0Jcr0O2/31fZ9aG
         b4s1yb8Y5QeYt3lVZRaB1xG4CAv5rfdKl/W4VTme6D1Uni5JBuTG9M0wv/JGENsqcvLr
         LOd4Y/DNs2Tt7mit2z4MWDjSqDLTerT0wnLDbaqeMtTZ6hLkt6NZhUqAa+0vo2PbFr8u
         xK+A==
X-Forwarded-Encrypted: i=1; AJvYcCXMwpUsEYCLbnp9ve3W2u7nHQemtQTIfLyd/CMoHXGJCq7aFsttDLVPQ0S0rxQTJ26q7NddUC5l+7ixPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKBkL3799JvQEzqZ7xZLGWOrDFMVjWbXtHIipoz4RTS8WQcV4
	PWPhwC7d0qyI6PYcRMHImzZ3HCOdPXL7SBwcJlpqb5JQeX76NYvbJ7zi
X-Gm-Gg: ASbGncs8zNAvmyeepV8Wc5HFzkXXH/xj1xp0PCKXijzotKMqvx5pUVOD2Bo8O2zeSyS
	QrNww6PrlQ/b2WvXuVMIJER7eRQlJ8gwKJriFEKug8VPelUmRv7l7m4v2ObKwGgBJFG4iTLQbbr
	5llmDZqHJqK0njD9ie7k8gTwmXgjXmiejC42k10MEJ3Jd9+kK8Ic2DeWvBXiu83B0MCPAR8CKpe
	XiGnLMNEU9aDsER/TvrvBlG0lq9AytlFPqIZy5ASnSYZEVeSnbqm6fzTXg/fEslwE5iFL1aqWSs
	PIwevUj2/4pldrdSowxCY8Rc3z4kRgLPqTlscm+3ygaY76r9m0K001JpSMzXR8H79zSd7Q/1/RX
	wmA4OICql4KCeJk/14yM+c6L5mj0ZaqfjGJ527t0NABc6WTtK
X-Google-Smtp-Source: AGHT+IF5uyA51QP5B/v0aEpZwjC0gnuJm8CE+r/VEqv2kg+QAhCE4gI4DiBuU/4bl7VHU9GQ+zierw==
X-Received: by 2002:a17:902:f70b:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-27cc5431730mr8985485ad.38.1758587641125;
        Mon, 22 Sep 2025 17:34:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698019821dsm144543225ad.64.2025.09.22.17.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:00 -0700 (PDT)
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
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 06/15] iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
Date: Mon, 22 Sep 2025 17:23:44 -0700
Message-ID: <20250923002353.2961514-7-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 23601373573e..09e65771a947 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -360,14 +360,14 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
+struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
 	void			*read_ctx;
 	struct readahead_control *rac;
 };
 
-static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
+static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->read_ctx;
 
@@ -376,7 +376,7 @@ static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
 }
 
 static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
+		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
@@ -423,7 +423,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -479,7 +479,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
 	int ret;
@@ -504,7 +504,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	int ret;
 
@@ -551,7 +551,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
 
-- 
2.47.3

