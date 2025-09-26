Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE091B0420
	for <linux-block@vger.kernel.org>; Fri, 26 Sep 2025 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846580; cv=none; b=nudo27eWWoYYAmzzMBfeTS37p15ls+8mxsv/4+oDySk+DUHvtZl/ewXc5z8rjCMADgQp3gqhljBvQVeVNmWmXPOZGSzwz2BTYuO1mosB0LGsEa19qhG3qcWPLSw43Uz+e/MjE7PXoF1IhKd6qcTaRCxOgrU5OdE5Rbj9nB8CeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846580; c=relaxed/simple;
	bh=C6U83VEYSG/nf0iVBKW4dK4jfu0KJiEa+HZsT26LBYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew6asVXIs1X7BKK5RGSkX5/WjSwfjapo3Yh9pcHVgzFCIZ7AAzXmA1LBIdmOaN4aLqmqmde6Jd3ECwu9ALiiL8fhuq3No6cVE/Q5ExK5jn+2ziqs7HIHNYf2n1TNA8+1pFRqlYaczB15BWJRs9DEoGDLmwUH93opjzPwXYjF81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7uhXbxn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7uhXbxn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-273a0aeed57so32233875ad.1
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 17:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846577; x=1759451377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nulppb3Fi7XzxQvs4wndp69uE/z4zY5omf8b0JzfU50=;
        b=X7uhXbxnfFWSHAgORStdGCzaM5iGnSvF9UbnnXLf1cTk+IGF9gVTgSjStyxNCs3Yew
         aFWm8gQbTvg6yEMfk0afbQs00ioFGu0HURWaFssdzI80qV76gQpOhQ7R2KDp2WwFPxok
         ZsyABTveuZK0RIXWDzjjPnsQZVFS6f6sHH7PoIcGdMyhKTHxQNKRCUKwxw2W4d8zCL93
         vvq+xMUuH88WUQlGG/xaT2/8ZHXcPE7aXKxBrqpbGRRdpJRB6EsuB5IScgvDOZ0Zdn4W
         jZjktlQtdT6MJrYRLqqz6vQ4UfhfmLU/G0yUQQjemIY8xvDgaBHUhy2ljKf93AH2MCn/
         RaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846577; x=1759451377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nulppb3Fi7XzxQvs4wndp69uE/z4zY5omf8b0JzfU50=;
        b=J1LgoOXaHUUtMrv3HD+IY4WS6omiPSXi5DCl1IdYQAUeDx29QU/oT0WH9Zs+S4RBK4
         XIVeDSr5xVFFhLfi8+FGAjK2B332CbdecrW2vuMNslmlOVWSzt8aJpnVGsGbRFjQJ6xB
         cdrzoZffcBE720MBEW2LKFS1fw03gxGAqKMNRwU9KONIna2Zgh9cWlwexG/OSJ0Lw8AD
         EPUezlDCXDog97CsfiE+3c/WS+pghUt4f1FaDTt/CHieZnYp7gO051SwGgBFEyG+8XXS
         BIuAKiPJWbBheGeAgJ+994BnBDOrHKFHtsyUrfCdnVnHH7qsMO5Ad2kMXxsjdSzAoywb
         9cHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+n02sy4lSfso6AwDQfMNp06fr7hMloBFQx00D4v/VrcbO64fBiCt+JNQPrliJ49JfYb8S+5rTMOlDEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZ1lZa4ABkLI9g4n/du9awbc9fJKTorBSF4+uu1GqAWwCUp3X
	8/xdkiKglWRFTnAe9vCpX4vLZrDHBLqwnPRlZKJgqmwEjuNC0MshfhUd
X-Gm-Gg: ASbGncttw37Ao0J6X45L5jCL/MlkNjSSJKfNwSbi+40V8MDmvLc8r4bXlsXCPRXtSkU
	sqJ96jA31n9sR2TXHFXwRN9PmcRy7hWefs4gDkjo9bqR8Z+u8tQafs8oTkPAQFYgHis7p9lPCd9
	SVX+GRg7Vm7OKnshfOQ+fk55UAt2VGVYdE2CDmLj2WkjRMlWYUrlMeSIeLsdd+044vqZdPExzMW
	/TeTT5gMpGJ3agsYbcF5i1djq5CBD+JbX0AyHkF0QoNE2AZCYmNTOQajnnvcoZEdEngJBkigTXv
	FhrUtzOj5po4ho5TpiR8InPpoRNkPfxABlkhc6e4Q1i+TdxFk4Q4ePqBK485ETNe8XFo9Ub+9HS
	6FcDXGvo6NBIJKotmllgxGmPkQ2VJCf4Q7bb92FP0DUdsSIWF
X-Google-Smtp-Source: AGHT+IHaOiCcNeqvYIRT0C5rvKbkak1Uwjw+eScH/ni7itDdwd8uftP18tKx1Ss8wB6a4YBQSmVuJA==
X-Received: by 2002:a17:903:1a07:b0:26c:4280:4860 with SMTP id d9443c01a7336-27ed6bdf53emr46606545ad.8.1758846577537;
        Thu, 25 Sep 2025 17:29:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882210sm36174305ad.79.2025.09.25.17.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:37 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 08/14] iomap: set accurate iter->pos when reading folio ranges
Date: Thu, 25 Sep 2025 17:26:03 -0700
Message-ID: <20250926002609.1302233-9-joannelkoong@gmail.com>
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

Advance iter to the correct position before calling an IO helper to read
in a folio range. This allows the helper to reliably use iter->pos to
determine the starting offset for reading.

This will simplify the interface for reading in folio ranges when iomap
read/readahead supports caller-provided callbacks.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e6258fdb915..82bdf7c5e03c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -375,10 +375,11 @@ static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 }
 
 static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
+		struct iomap_read_folio_ctx *ctx, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos;
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
@@ -470,7 +471,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
-	loff_t count;
+	loff_t pos_diff;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -488,12 +489,16 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
 				&plen);
 
-		count = pos - iter->pos + plen;
-		if (WARN_ON_ONCE(count > length))
+		pos_diff = pos - iter->pos;
+		if (WARN_ON_ONCE(pos_diff + plen > length))
 			return -EIO;
 
+		ret = iomap_iter_advance(iter, pos_diff);
+		if (ret)
+			return ret;
+
 		if (plen == 0)
-			return iomap_iter_advance(iter, count);
+			return 0;
 
 		/* zero post-eof blocks as the page may be mapped */
 		if (iomap_block_needs_zeroing(iter, pos)) {
@@ -503,13 +508,13 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			if (!*bytes_pending)
 				iomap_read_init(folio);
 			*bytes_pending += plen;
-			iomap_bio_read_folio_range(iter, ctx, pos, plen);
+			iomap_bio_read_folio_range(iter, ctx, plen);
 		}
 
-		ret = iomap_iter_advance(iter, count);
+		ret = iomap_iter_advance(iter, plen);
 		if (ret)
 			return ret;
-		length -= count;
+		length -= pos_diff + plen;
 		pos = iter->pos;
 	}
 	return 0;
-- 
2.47.3

