Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E42D3A9E
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066631; cv=none; b=g5cAtpmen2m13kcjBBvojqT93rqJtijBHl04V+E6/bpHNXeuOkUMoSHEZ5arNtfSenMjFfx8AaP0kqqPUClF39k05QGZ5e6pXybkrtPHV8QukTDhQ6RqdAzdI4tNR6NEIW4JURCvWv8HhjydKSx693p9OMXo3Gex5Iy5UkklIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066631; c=relaxed/simple;
	bh=w7oHmQ9XFnwraqw2yEaSdByUgxP5t881lYwL3uOQXDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0JAp3Pdcvha01uP5hLSH/ACivoNYIhwIk+tBeCA/3tObT1aEFqjIVt8lwlMXbcH6oEZX2mB4WgdzHwNdC7YAEldHksfq1GTJDf6Ik5aICaut+WGR4At599Bk1fwFdzNpcFk4vMjzVxZJ+nvNcIQSHMHjJl37+tynou9fv7V4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOGKUWqM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOGKUWqM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7761e1fc3faso3536349b3a.1
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066629; x=1758671429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igl0szEKM52u4N7LjkG17Yn1ot1jDVlccs4WBeJ3GIU=;
        b=JOGKUWqM6hmg8NbRBW8fKEvclPVuamXSEsrc3Vq8RX4Y6rL4ut7srCj3Ymj9DmOKtQ
         gfF/c65n88R1WHXKGRiXbsLBNOnNo6/wnr5UNaei5t47oue3dL52cK7ovdEobS/AZVKP
         nXupuxq6FG/pY7lVe+4c3Rol+kLx5+3huLIFXfnjtlSpGNIbm5miis1wQKox0FRAgbH3
         BoOxIGJ8k6D8bnIYxP0eh65g9Gp4d5OJ0Tzu/yj6FsyKGXEyPD10C584QKY+MTdn2IRT
         TBkBNphNrcFzDIo1Macncf1cwpjgLft3w5WsNQD8C/dm6IdcrRJ+f+JA4xImJ3r4B6Q4
         Zlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066629; x=1758671429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igl0szEKM52u4N7LjkG17Yn1ot1jDVlccs4WBeJ3GIU=;
        b=UroBLXJ0nFsNCIaKhwcxCd+KHaw1bhGAyXjL0rQBJjwmCMjhBY+tx+Nhx2r3DspDwq
         NHVqlcjq7L6y+FgBNkPRZ+Db+NO+vJVeKErhw80Fr5WlZk3MZKpkcasPvSf+5JtizKLS
         rR57CArI+fvRIHpnO7an8XQOHyzu5Kj1IVYqCTBHtHhpwFtXtAT/jeG2U/+1tV+XwQrD
         i05B8S20Pq57kYLYaWjDl1r2CdLta7c3VjPbcPViN9t3Kk6+ZHGDN48T0p7a5k4uxzMC
         tHqoooYsAo4p1TjdXiW/OJmqDe2xiaUw6r8L2GG6XYeHCwh9fDJ7xkoaczHNgCVQcsD2
         Bg5w==
X-Forwarded-Encrypted: i=1; AJvYcCWiboADCwbqH2P0HaMZDGp5kJ5/xHQ5LzKui5sNnUOWnTb4zA1mbiuhvrbpy/ivPa1hj06Su1gLsb2KuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKaWSfEysAZIUhDfr1GUJfwea7UrwLcNnQcH6t1WVnvg8yvcxX
	Zsirs2wyhe/SWRKwZFhVC1Atf/GSEE7r/Cqqfi/Km+UtTE1qFuGcVd9u
X-Gm-Gg: ASbGncuXSTNVQ0J4go4FpOU1uRXXktLqwAWfuc2yQQRSTFkJ32nuxYQqFd+uLB62i9K
	du9l2fVHgTollZbAEDyR8uu0x4RvewfnYzN0jbHMvUZ5iewAYz/ksjbsO4YpcEpqCT2Lr8HjTzW
	wSXUH/r2wTKb5zguH8RD0UtXwd0ug8qkP/qgpry5i9v7yeXbhI+95tAickpb9lagAPOXKkbNy/R
	j5HLP4BDs+kuxsPY1QAsRSZ+75sM2JHT93LFs/QPH5THvZfe9af6V5Wtptc6ZSnTPzbzr5Ki9YX
	4Btwo+h7r/+Ay+G9oHUw6L+G39DbjtSEdbF0zQRe7/Z7ej1e+8oDn+gTSkY1XiUtLkN208dM5ZK
	LoyqI7nDmWEmqI1rb7dVh1FFECpCmrtE9q7ltCL+cTEYonl9t3w==
X-Google-Smtp-Source: AGHT+IEwM37n6OeuEIlANEEpCI0EjMz/gqdNYw7ssUAAFOa4ZLo8dnWTZo/sk9QfoO9n62XpLdWOZw==
X-Received: by 2002:a17:902:db0d:b0:265:c476:9a53 with SMTP id d9443c01a7336-26813cf234fmr721615ad.41.1758066628820;
        Tue, 16 Sep 2025 16:50:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2680889f486sm3438975ad.137.2025.09.16.16.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:28 -0700 (PDT)
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
Subject: [PATCH v3 01/15] iomap: move bio read logic into helper function
Date: Tue, 16 Sep 2025 16:44:11 -0700
Message-ID: <20250916234425.1274735-2-joannelkoong@gmail.com>
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

Move the iomap_readpage_iter() bio read logic into a separate helper
function, iomap_bio_read_folio_range(). This is needed to make iomap
read/readahead more generically usable, especially for filesystems that
do not require CONFIG_BLOCK.

Additionally rename buffered write's iomap_read_folio_range() function
to iomap_bio_read_folio_range_sync() to better describe its synchronous
behavior.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..05399aaa1361 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -357,36 +357,15 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
 {
+	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
+	struct iomap_folio_state *ifs = folio->private;
+	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
-	struct folio *folio = ctx->cur_folio;
-	struct iomap_folio_state *ifs;
-	size_t poff, plen;
 	sector_t sector;
-	int ret;
-
-	if (iomap->type == IOMAP_INLINE) {
-		ret = iomap_read_inline_data(iter, folio);
-		if (ret)
-			return ret;
-		return iomap_iter_advance(iter, &length);
-	}
-
-	/* zero post-eof blocks as the page may be mapped */
-	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
-
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-		goto done;
-	}
 
 	ctx->cur_folio_in_bio = true;
 	if (ifs) {
@@ -425,6 +404,37 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		ctx->bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
 	}
+}
+
+static int iomap_readpage_iter(struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx)
+{
+	const struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos;
+	loff_t length = iomap_length(iter);
+	struct folio *folio = ctx->cur_folio;
+	size_t poff, plen;
+	int ret;
+
+	if (iomap->type == IOMAP_INLINE) {
+		ret = iomap_read_inline_data(iter, folio);
+		if (ret)
+			return ret;
+		return iomap_iter_advance(iter, &length);
+	}
+
+	/* zero post-eof blocks as the page may be mapped */
+	ifs_alloc(iter->inode, folio, iter->flags);
+	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
+	if (plen == 0)
+		goto done;
+
+	if (iomap_block_needs_zeroing(iter, pos)) {
+		folio_zero_range(folio, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
+	} else {
+		iomap_bio_read_folio_range(iter, ctx, pos, plen);
+	}
 
 done:
 	/*
@@ -549,7 +559,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -562,7 +572,7 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
 	return submit_bio_wait(&bio);
 }
 #else
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	WARN_ON_ONCE(1);
@@ -739,7 +749,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 				status = write_ops->read_folio_range(iter,
 						folio, block_start, plen);
 			else
-				status = iomap_read_folio_range(iter,
+				status = iomap_bio_read_folio_range_sync(iter,
 						folio, block_start, plen);
 			if (status)
 				return status;
-- 
2.47.3

