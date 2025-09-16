Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712182F3C08
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066648; cv=none; b=FeIk4ol0NnFOHJNC6jbV2cIYKPP17DtqTJ0yGXLSb5imMsd509RFVu6svySibDSSR/T4VA0Q7SsxrehJXu+VF5CEm414mokvhXRw15wdW+ZqBa3m4nR1EuhsePqGDxqM9oGqt/BZzkYGyndmFfqo0ETN6xJZfWi1ooeb3nhE2P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066648; c=relaxed/simple;
	bh=LyOsg2Bu1m9/Q4KGCsDW7iDLciMuCVOGZhuLWbBDsng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfWUYeod1JayoGc65SQOhHv7H4ampJdtwk/5PjdLhGsH9+l1QnzRr9DHBvDf681+mGcI1kyKpyFE6wqAc/B8ikmgQzMjaxjvqni1ePwT2XcV8WoZTPgtoA8hPvKnEL3f4vOyXFymNEwWr4bNiFCMdPbjxj0FZAJitPRpHffijzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkVuVp4v; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkVuVp4v"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244580523a0so61760285ad.1
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066647; x=1758671447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=bkVuVp4vM9nZkstX93tbmtvmp8fmXylyozjHXX+nfwo7jlhWbc+O2joE8gayybxBRX
         v2arqopH7u1Ob+GfUuGPm5vLyVfoE/B0WRSZdKFZ+Z5WIW0utF1SArFDT0j/iCqAtybK
         deVuD+1tT62Bf7nq/BFrZykP4jYN6MF2GnUmKfjsE7M5zLO3K9fipa8jnzSW1y+l0Haz
         8k2HBZ1+x3kBA+Ja194Sxy345waPZbFG/BO0siMkPJV9zvufHfFLA3f9GRO4T5gm96rr
         27eZHvm71fcUG3r4QH2l7M2eNR6sRUZc9sRKIE+gKvsuBV/t4Cy8aErO259zJJXh8Xdu
         0dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066647; x=1758671447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=vYNF9+lWk2+9nrz3Z8MBjXAbaGG1H60NseOx8CjesRrP4UeBrQEg5ERePz3kBsUDs9
         WTeOwjXJWRoymkYj59O0eX2QD2ZSt7IHqcT7D661TtnEjIvianFwzlJjWi6HI47lmO+6
         gbvdYYVA37C4o1+QIlvDP+5FTEtK93gNZM9NlO590QtOdTUFMM/xoVlt5V+IeqYANGvY
         buGuryPC0K4F7w9pDM2Rln4Zim7tnPRoBNFXsMTUkILpFw3cZZhitVJYCXB9++QMzsGw
         Sz1nd54avSMXJnU0ap+R3qlM/yjZpXqqv7IdGkh/7Qm/dOgt+xTmH7XHtNP46TLQzV6g
         xR8w==
X-Forwarded-Encrypted: i=1; AJvYcCWCcc5KNU7+xrBnhLh42RF6/OSFK9CKkOGn5r8j+XGA/VQLsVsDoe3dj2mSxI4/yCuu713UwIh+p+mnog==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2Tv39hPHwfPRnvMmuHsecXU64L1hIDygQZKvBzejT6SFeTae
	hFvSMb+kXhmVLjpxUi+90LPcbwh69RWpkdN18LDpQvsWLrhCE71iH85V
X-Gm-Gg: ASbGncsQ0JDcftrcMHGBWvKEkeO9jhbp86MIb1BOcyEnVdNrTKWT3R7P708qvyd7a4Y
	qgHrQaomHpc302Tkvis7oyQDukVFvIhoVf1fJX4oQaXRmhGkaanl4u2S3v/zKEN/Jnbo0RLVaeY
	ku2/GJqf2Qrf79t77mbP1ZrUXNaRyMGtkIgY/VHA/5tCEmC2iqFm6gVqq7hv1Pr+8Yz+SCVvZpM
	ZPQVI2MVvWdvgvLLbWLfNDuX//D4evnSHPXcGdQb1tLMikLyDCdzCCNZMXQDU1so5nEyIa2HFQX
	oHNejE6AN2KY4rI8xE66ZDNAGiyWuBOuQPQWuxmW6y+qihen1T7Cy28YnQYIet+HC/W1g+XbbsF
	VoCYEo4hpu/zZ4uJCfxI55YlL/9YaaYHskRnYkg9S3MZhVlhRMw==
X-Google-Smtp-Source: AGHT+IEDsgdnT7+nNQrDhXR5m+p9OqwQpqgyiqsnD7pJqTnVO6zC/tJ8dk2Wmo0J+/77Bc7uR5fcOA==
X-Received: by 2002:a17:903:1a68:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-268121808e6mr1290225ad.23.1758066646820;
        Tue, 16 Sep 2025 16:50:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267e52d1621sm22110075ad.40.2025.09.16.16.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:46 -0700 (PDT)
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
Subject: [PATCH v3 13/15] fuse: use iomap for read_folio
Date: Tue, 16 Sep 2025 16:44:23 -0700
Message-ID: <20250916234425.1274735-14-joannelkoong@gmail.com>
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

Read folio data into the page cache using iomap. This gives us granular
uptodate tracking for large folios, which optimizes how much data needs
to be read in. If some portions of the folio are already uptodate (eg
through a prior write), we only need to read in the non-uptodate
portions.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c | 81 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4adcf09d4b01..4f27a3b0c20a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -828,23 +828,70 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio,
 	return 0;
 }
 
+static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+			    unsigned int flags, struct iomap *iomap,
+			    struct iomap *srcmap)
+{
+	iomap->type = IOMAP_MAPPED;
+	iomap->length = length;
+	iomap->offset = offset;
+	return 0;
+}
+
+static const struct iomap_ops fuse_iomap_ops = {
+	.iomap_begin	= fuse_iomap_begin,
+};
+
+struct fuse_fill_read_data {
+	struct file *file;
+};
+
+static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
+					     struct iomap_read_folio_ctx *ctx,
+					     size_t len)
+{
+	struct fuse_fill_read_data *data = ctx->read_ctx;
+	struct folio *folio = ctx->cur_folio;
+	loff_t pos =  iter->pos;
+	size_t off = offset_in_folio(folio, pos);
+	struct file *file = data->file;
+	int ret;
+
+	/*
+	 *  for non-readahead read requests, do reads synchronously since
+	 *  it's not guaranteed that the server can handle out-of-order reads
+	 */
+	iomap_start_folio_read(folio, len);
+	ret = fuse_do_readfolio(file, folio, off, len);
+	iomap_finish_folio_read(folio, off, len, ret);
+	return ret;
+}
+
+static const struct iomap_read_ops fuse_iomap_read_ops = {
+	.read_folio_range = fuse_iomap_read_folio_range_async,
+};
+
 static int fuse_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *inode = folio->mapping->host;
-	int err;
+	struct fuse_fill_read_data data = {
+		.file = file,
+	};
+	struct iomap_read_folio_ctx ctx = {
+		.cur_folio = folio,
+		.ops = &fuse_iomap_read_ops,
+		.read_ctx = &data,
 
-	err = -EIO;
-	if (fuse_is_bad(inode))
-		goto out;
+	};
 
-	err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
-	if (!err)
-		folio_mark_uptodate(folio);
+	if (fuse_is_bad(inode)) {
+		folio_unlock(folio);
+		return -EIO;
+	}
 
+	iomap_read_folio(&fuse_iomap_ops, &ctx);
 	fuse_invalidate_atime(inode);
- out:
-	folio_unlock(folio);
-	return err;
+	return 0;
 }
 
 static int fuse_iomap_read_folio_range(const struct iomap_iter *iter,
@@ -1394,20 +1441,6 @@ static const struct iomap_write_ops fuse_iomap_write_ops = {
 	.read_folio_range = fuse_iomap_read_folio_range,
 };
 
-static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-			    unsigned int flags, struct iomap *iomap,
-			    struct iomap *srcmap)
-{
-	iomap->type = IOMAP_MAPPED;
-	iomap->length = length;
-	iomap->offset = offset;
-	return 0;
-}
-
-static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin	= fuse_iomap_begin,
-};
-
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-- 
2.47.3

