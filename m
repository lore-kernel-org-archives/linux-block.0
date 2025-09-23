Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D521FF38
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587652; cv=none; b=QzsmaWYOthKrOWqmUBMcWk++DV3pGaXS9804rMRcUU2CiJlAOu7JbPiD3rNmXFSTfmh3Fsua15W7erVR+F/criuNm2oBlfWwV+BnL+loWXV4Wwi3rOlcz58C1Jdzs98Qi+RzH21+gHG01Ek1jfh0ad1nHOrSNEnHjySPgRFM+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587652; c=relaxed/simple;
	bh=LyOsg2Bu1m9/Q4KGCsDW7iDLciMuCVOGZhuLWbBDsng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkfvMpzsJEE2sc9dI+zyjd8tSSR9sFiD5EMvgd4v7qEzVBCTDjEj6gTPkwR67f39abCO2PJlBE55v8sLQMDsslt/+d7gOyoOeyJcfc9K0Sg5x3jk1GcpUDYu2kDalnlaNi51qjrka6jakhCRGmsQTnvuyDMwsaGebsQAgMs1aIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNyewmMu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNyewmMu"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77e6495c999so3557073b3a.3
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587650; x=1759192450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=nNyewmMubgRg/htQHWcoavsVoAEtwnHksZchXXcjCh8pGiO6/RA/jhA95xj28ze9ti
         ha7PXccL8GJc1KpuE7wJtBUQzRcuTRqJsw4Q3W+aMGjLPnPqWJhlGd2uidjWQDOibyqd
         R9s0L2wL7P6diNmseMM5ataaEeG3aGPKvbsDT9+TIHUgg1PfUfv1pWOXZZ6zWkplstj+
         91WDVQbeLw/5wF1FECC5FbakEnRa4/4Z8Q5TTlYeXlVQyJ+wrquxMC4WY8KC0wCXaqtR
         R9b7YIbqpX5leriFdiNvyIT9Ot6LOg1ZTZ/SC1LPShsg41EDtTU/SrRddcABgXuwAos1
         RPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587650; x=1759192450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=ugE6csswBWtNujbyotdmEvb+DGUrVbPQLUZDQPiHFrRAW+XfdefmSQcPQjfbvmflPJ
         49e1xgOIDaYuP5QyWwoB8bBFgmGJ33zjajtwpxSn+sk2CTMBM1wRyBtsjhchRNa3dvpP
         ky51Y4J0tSi5efOAOPabuxKu2wNF6L35q5sZnt4RTJuCVmzlAJFvlyajBZ6uOoKrVSk/
         Khn2aXYOZtNvtEhDd1Cbdhjh+v56MI3zBrwnkRBLBuJJm6GZqo8HV+xos79u1v8KFEpG
         +eW+ahwJqqwOQr6BxOIRd89DAi7UP1ozpbCWsTUqLCcNfcD5u8u+27QeMWcwpddYGuOv
         a7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVXIOJ2rFz0C3dyVEgdLR7dPRRPyJh+kpQC9o16KmHunNONx2hUQGKC4zJ0R9hGFfO5YCrghH8tCXf7zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2J3deo6WmQnEhHWBDP2+gee0Wnygp3bGMeCqvh93rdZt2Dwb0
	99pgCYpn3aHx4d0DyMbmGWXyu0FeVLF3fBEvX/di283S4BkEr4HUoGCd
X-Gm-Gg: ASbGnctC9RoI90TRD3XRPP56wtw0FdKGxMsadEFjb69RUuhifQr2NwvHUYQG1cWnFRD
	GtMJybthYkQcrj4h+PvA8F/Q3RN5AZoTgW2RnewHCF1T3/tXfUre7Rt0B6UUGYC0ydfDmh+ZiCK
	9wVHnpDzj+WWEidu8DasO6hfcTXbiE/ITnvphGFnwPDirc9yHOGUjJUcAKnGKjT37WvbHQ5uxZv
	kBGdGYpCx+5tstdcSRREYCm1PzArBHB3HhpXXzNJDZp9+3eKHoP7zB7XnkWNvydWKCNGvJUuFkm
	ecl/KXVKzY5eoWWNvdxiHze/gyvqjNT3RbgEiclcgArfDdiXPN24tqyeQEyz9DaJT1VFe2jK2Xw
	06wK5/VhNI846xemXS1FUxssXUeneYFkpYxS/r+eMxeV636xR
X-Google-Smtp-Source: AGHT+IFDRYIdyBl04iBYoDUtSI9mRjhTN7zVi/dDiSEIGK216VfDG1RkUSAPcnJWtf4ohk7umhb2Jg==
X-Received: by 2002:a05:6a00:a93:b0:77f:4306:d248 with SMTP id d2e1a72fcca58-77f53ab8044mr872603b3a.22.1758587650623;
        Mon, 22 Sep 2025 17:34:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0ef2db80sm9374730b3a.24.2025.09.22.17.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:10 -0700 (PDT)
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
Subject: [PATCH v4 13/15] fuse: use iomap for read_folio
Date: Mon, 22 Sep 2025 17:23:51 -0700
Message-ID: <20250923002353.2961514-14-joannelkoong@gmail.com>
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

