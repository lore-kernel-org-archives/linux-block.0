Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9B21DE4CA
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587640; cv=none; b=NbEYHbx477AZ86CiibFkPvIWVJHunFAjgqnhcmCfJpaiIl2gXwaeamaRGC4ub+dUuqUWxFlj3J5lgIn64czKdFozlJsTt/3e6ltRSoQhD75I6fC28/rByUeHUEjkhfbx4/XNkzk1wxLJeYdiFbA6MQvRT+JZlxRcJ6PKMOr0VCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587640; c=relaxed/simple;
	bh=a/zyIEvLQc/XUbs4Regz+PNxwhBjl1k4o/jZih5gfXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4k7FxSUtXonKhbx9bm9eMOwwM+2VBE2vaHqFFz84/iJI4ar51mR04RiWY3LJIh5wOgOOb6sFiNtS+vZTKYmntu+j1vq7L9ml4hoXCwSAhwPTkH/wOaBfMugcFPtSpHragHvewfiUtz0ypzb2Z1OnDhs82bOTbQurnGW2+0qFo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXhkpGQL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXhkpGQL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-271d1305ad7so28282985ad.2
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 17:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587638; x=1759192438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt8zIXCwfRruji0SsRLpuIon4IqvB5IR8pbhHdgxKmc=;
        b=FXhkpGQL/gTgFwPNnUREcfYZCX98ZU4B5pvjzfspzeKJjPRi5wEBrLufkZ8GGkDC1b
         IWPSwuF6ts5wTUYZZ0uF/U3wnn831Ub9BuobGeiTYduIDCzoNLgsz0hnQRQ/gynJmm7X
         Sf/7q65mOmKhWOb08nabUs72CrYfQl4GuQV33CEMHZhZqWojZR9IUQPU3Z0JBiO9hPmY
         yDxpIXlYthNOUO4gNxE0WChEBP/wyC0IVfUD1cARmdYnn/Q1lfG1v8DqCMriLl+f4i6r
         59xE/3NTb2fZQHpoF2Suj440KEqZQtHdr1qapR/T6inl5mJPkceM+821tr3Q17JlEUAF
         ajBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587638; x=1759192438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt8zIXCwfRruji0SsRLpuIon4IqvB5IR8pbhHdgxKmc=;
        b=nXc6pJFiv3axrMBNshusSAn7FgknHo+cMJH7/AG8W0FqGrom8OoygpW5/n4J5uR63I
         k3VpADGQgxKz9bvJl9t165qQPKsC5aeB3cF1Zznu1VuqFV9qcti/wUmm/Sip/KehoVGp
         UYWZXog1hk5hdjE0wbhlRy1WdEojgjKNp/20iiymR64w0ba3+DuZ/iHOknY5vdauJBbW
         ushRIrKTzXiAQp9mPzOy+IKbEeL/gdrMOsLE95KItbUYCJ8jI12HxcZLJcrfNphhg9h1
         e+tSrHuueNMbibrrFhpckNMvmrOHNYfAOHbWNKLENCDYpN+dOElpu+PdwkBw0VnnevJM
         xS5A==
X-Forwarded-Encrypted: i=1; AJvYcCVXJ/+/dP7wqKLBgxLeZSmZ1VYrD1uznTAdaPbL8mqTsVCO6smtfg32vjO1NzI9b9r6iuBrUlHNLLkahw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1/N7Z94HzoTtbwW9F01cnkerDMww8EyvOm/18HJ9Xb09MNT1
	T4/0SaKmL92yGNYGnyPc5JyRrJ+UFjGyMmzsx9Qd/lOwKTCKsj/HIVk/
X-Gm-Gg: ASbGnctq2cjcx6XzECh7fYtTjjrQFyYudUUFlE5KuSer401EOAn1t06Ik4YYjIQAYFv
	eSxBHzphwXaYD7dLrCyqm9Dez0wq8gb0Kna2KH6e0r1VG+2g6NaXprv0bCdSPehTJzXRwcdIdTQ
	pyYVm7KlYbh6mXxyjisU0CqQ7Y197rHgeh7DTMRBkxZXTLDtPn1CIBnTu+MDmQl9mQy64xsNmVn
	1HoWw3NPl6k0AL3s53/cnktdDhyn1A1f90EUYW6Jk2Yrx+BuHFp0xRXfZggIxyXjnzEcIWQBD/N
	DmguO50DIk/bmLAS83xuAZS+qJnUeXmmV1rGf2+HEu+szE+doIK8GN3mtIytnwV1MZpWLpe3N63
	A+p3JMidM8H2yaMuQ3oXK3Ver9IPNSeb5zm/woqaSDH0pusqeBw==
X-Google-Smtp-Source: AGHT+IGQISl64Y5Qz4l069Hr+dg6JwXOBP5WOcZIs2GDXy1YtKD9sDPga2/FeznyhaigCtWuIUSimw==
X-Received: by 2002:a17:903:46c4:b0:267:cd93:cba9 with SMTP id d9443c01a7336-27cc696e79cmr8418715ad.35.1758587638366;
        Mon, 22 Sep 2025 17:33:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053dd5sm145263185ad.26.2025.09.22.17.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:58 -0700 (PDT)
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
Subject: [PATCH v4 04/15] iomap: iterate over folio mapping in iomap_readpage_iter()
Date: Mon, 22 Sep 2025 17:23:42 -0700
Message-ID: <20250923002353.2961514-5-joannelkoong@gmail.com>
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

Iterate over all non-uptodate ranges of a folio mapping in a single call
to iomap_readpage_iter() instead of leaving the partial iteration to the
caller.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 53 ++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b06b532033ad..dbe5783ee68c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -430,6 +430,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
+	loff_t count;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -439,41 +440,35 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		return iomap_iter_advance(iter, length);
 	}
 
-	/* zero post-eof blocks as the page may be mapped */
 	ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
 
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-	} else {
-		iomap_bio_read_folio_range(iter, ctx, pos, plen);
-	}
+	length = min_t(loff_t, length,
+			folio_size(folio) - offset_in_folio(folio, pos));
+	while (length) {
+		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
+				&plen);
 
-done:
-	/*
-	 * Move the caller beyond our range so that it keeps making progress.
-	 * For that, we have to include any leading non-uptodate ranges, but
-	 * we can skip trailing ones as they will be handled in the next
-	 * iteration.
-	 */
-	length = pos - iter->pos + plen;
-	return iomap_iter_advance(iter, length);
-}
+		count = pos - iter->pos + plen;
+		if (WARN_ON_ONCE(count > length))
+			return -EIO;
 
-static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
-{
-	int ret;
+		if (plen == 0)
+			return iomap_iter_advance(iter, count);
 
-	while (iomap_length(iter)) {
-		ret = iomap_readpage_iter(iter, ctx);
+		/* zero post-eof blocks as the page may be mapped */
+		if (iomap_block_needs_zeroing(iter, pos)) {
+			folio_zero_range(folio, poff, plen);
+			iomap_set_range_uptodate(folio, poff, plen);
+		} else {
+			iomap_bio_read_folio_range(iter, ctx, pos, plen);
+		}
+
+		ret = iomap_iter_advance(iter, count);
 		if (ret)
 			return ret;
+		length -= count;
+		pos = iter->pos;
 	}
-
 	return 0;
 }
 
@@ -492,7 +487,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_readpage_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -522,6 +517,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		}
 		if (!ctx->cur_folio) {
 			ctx->cur_folio = readahead_folio(ctx->rac);
+			if (WARN_ON_ONCE(!ctx->cur_folio))
+				return -EINVAL;
 			ctx->cur_folio_in_bio = false;
 		}
 		ret = iomap_readpage_iter(iter, ctx);
-- 
2.47.3

