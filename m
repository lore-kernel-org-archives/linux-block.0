Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C62DE71E
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066636; cv=none; b=IK7LOrXwgwa/8vJrTbwPlboOSyVhuP9wnLAopMuJhZHL45SGKTpkXLllR9iTwLYPvuycSsk1ANKVr5PkirmEup4vwOZv3SilLrQT7luE510e8tbErnA6qfUPWmjOjpHxKnoSqwNC+goQ6UyP658XHn5aylscTxtJwRNAfwvgA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066636; c=relaxed/simple;
	bh=98GkOjzNEJqwvQK/4lUwfHNtYdVVuLzxJ15LQCdn1IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8r2AsmWKU5ymnoQAjyIg8N0/6waKjzsW/s4riBgp/bg+BY+WCz5L5YE0HTPpd3uED3CI3IdsbKhf4YuEQx8F0PDtrpO1H33FYObp1W18HKQ997KFm9JTpWuLjHTyWFO4sAXorKzoYnvFkResvG9bVkvn+E0uXtoHkIB4JHgbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlnT5olf; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlnT5olf"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32e74ae0306so311206a91.1
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066634; x=1758671434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG6E+B3mjTcSPZ6yVzAJALw0H8+ndYKaxBlvC8laKf4=;
        b=GlnT5olf53BRTZ4BIemxBvWFHgfqTpKqU2Ab80yQNnCiC/EMGB/Wh/PzU8z6kaeVF3
         /OHnctV0IfoXhqtMlsZ64wWjta7KwKZ7hBJGozMkecIPlQS+w6helKXdADof79BweY0o
         KDl814ionrLz9rVLGCqdJoverD1rjGGnFFxg3OoubtXTqk/7AIQ3thkChnPOnftXnA0g
         HFqq7Fgztoq0KHeflo/CB7eGuy2MYOPK402zl9pEpZ2daSCz7BRALlWZsAPLdbD2z8dU
         yUhrYHzH88wB1Pn0T2J6HWfey4oSNLj5uxI7pRrn6MUJx9TEUV4zTYMG7pwruxsKpD8E
         58dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066634; x=1758671434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG6E+B3mjTcSPZ6yVzAJALw0H8+ndYKaxBlvC8laKf4=;
        b=KF2rSWz9KpCTp0c5ALWegsIcI3s6yEMhT3n3QV9/IhTed2OUR0a31ejb9yVwx2y9pD
         yPxIc3qmoYqkCoYIqViqw9vGlvftPbd0XOlf2fyg82bENPPU3L/3kya6D/M46u8qvTbz
         8azt23RbEHIEOV6LlOE7hR7qU8VcvGD6+Cx1CcNwiRzsJ136zT3MssEJPs7blPdks/rs
         9R3+PJ4PtaM5XURvuREeHbUgJ7DZnLE2135WfbkLZcPj+9nFi21mMtYC0T80nHU4+Qhe
         Ja3iFLh4Nnc8iCIMhN5mrW+9wmX9rUJorSuez+xH1jSjfwZDWrHAkMiH1+t6o5V/rMzc
         1wFg==
X-Forwarded-Encrypted: i=1; AJvYcCV72lcPamSe3ITX7KvSlqfTELcLMbIrdf8dcNCQ6NpeunQ5ikTn8u/yKJvkBZKkhcc1HlPOe7FT9QJtJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0nddZazyAOtivoFyugxZL220uSTbOrMwPJbDTRnxG/RD6zqkb
	z13eNjzU/aqA+jBWV0m0SbdVlKspAmK84lq+TpR6BS9ssUhQM6inTa4e
X-Gm-Gg: ASbGncvSevpaFm54hFUJ5SFobUq28L7kwg7sbYOm6NMpAPklbV7bLMyCudmjfhqpVzf
	xlfMUEhTwhHkPmqsEeQrish+3ZdOt8+sdhvtbVu5ntzoGi8HrCmWgTNDhyTgXoXC9rU+lqNmtG7
	xfcI0rbCME4FWKOiorgWLrAE6IQxhokNfEGQ4QBHWTzelLNWLaoM6Lzb8OHSIu7H9hit7UPoZL/
	JJb2qm2oLrmsIFc71zNYF41o2s5KA6Nih7VU+Ryv1cmi66c7RmHMT04PTSfyxBCPMXRWqvVhsEA
	tUeYJYYqMEXglVH4Bpjeg3wNthl2FCb5NuHXARK9Xtxse7UkWe8ROLUhGOkL6ci5d66N7DL6jT5
	3Hm8FaOjd4y+r9e2NUovg4vbE7/KTBiYV9HQi2mqfdaAoYZMa3SBurEm3v92h7iaQrP8TPMn4gb
	OTL78ZadpmDeU60X5rL0ZxtTwB
X-Google-Smtp-Source: AGHT+IGDxK1TSJHJMfjQoDefaoarnOiH5p2F5ClNqiomMKUWzK7J0G8impfhFApU6S2QB8fO6tB6Vw==
X-Received: by 2002:a17:90b:33cd:b0:32b:d8a9:8725 with SMTP id 98e67ed59e1d1-32ea631cd58mr4496407a91.18.1758066634546;
        Tue, 16 Sep 2025 16:50:34 -0700 (PDT)
Received: from localhost (fwdproxy-prn-054.fbsv.net. [66.220.149.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea101ef2fsm1520309a91.5.2025.09.16.16.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:34 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 05/15] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
Date: Tue, 16 Sep 2025 16:44:15 -0700
Message-ID: <20250916234425.1274735-6-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0c4ba2a63490..d6266cb702e3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -412,7 +412,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 }
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -477,7 +477,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -509,7 +509,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		if (WARN_ON_ONCE(!ctx->cur_folio))
 			return -EINVAL;
 		ctx->cur_folio_in_bio = false;
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3

