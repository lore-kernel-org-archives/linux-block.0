Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F21126C02
	for <linux-block@vger.kernel.org>; Fri, 26 Sep 2025 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846575; cv=none; b=K2L8L+bypFwhDkWHhECrU4f04sljxV/libL6t4H46vUPH54qNjzlQOpHypDSoSsCdvaRNJ5Djn+HjY6PIQLPUQvnFv+Q3MI9ZCysImL5UxOQYX7gmoNZ5R7yaK5UCnJtU6Zv4n4bOdfGSwWg6Fk3ri1oVlydfgJ3YMTtPdfJHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846575; c=relaxed/simple;
	bh=s6mhJfy1wLr9wwae+98XWped88EO8RR6Rj9hVh2fPUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwV0gwzOQl3PfUGJdv645Ga+WMgNIWpyDTzhFO9UrNmWl/x1IyutmMW1/x1ODVJCMYkQ0x8+dTJ5zZXhSDboyzedFGZgSj4S9h2E+UqPF8PaIXzrpDnwuLUjdk/0Olj+BRzzN26yoik46ceXY0nEBU/fDpjHRxHwVf1n/T3g2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM2AkNDj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM2AkNDj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-279e2554b5fso13910725ad.1
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 17:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846573; x=1759451373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=LM2AkNDj6wNzRUiWXRrGj8H72x5v9FO2ZH47PZW7DoFbxWYb91OQBPRIfx64+WnGPO
         Wmdn+UiUT9dWBUS21y1ZK0+8q5FEUjpBQZEhWo+7nTw+q9lC1mHu8Q866MKSO/UDFYVo
         sF7oEU3/iXz5W2MH83TusynjOgnUEn16cN9QWCd156ZorxKMOJL3tIDhvJLCRZuuGKt1
         WQVA87hChY+VIvQaKOEymRaH9jWzNHnjqruFWod6Qzeib8NfAdFvdhHqXm3dewazpz4L
         K0DzqofrbMBdkBH4nW9zex6hFic7B8zKK0EIX1WAprjTMeFj8FdSV9VOzc0t75iuU8fK
         10aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846573; x=1759451373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=cQuNg/r53jjeov2o5YLNChnY7TnX7C0O06PVNqIvuO/j/aCgCy1Nwvc1MvV2ZGooLj
         k/tcDpHLIRuGPuE5KPy90QZ8TNlc5nPINLsyWLvqUo2BgP/HoC5/8PK6x5Ng9Q2wpTdr
         f4XprGOP29t35FMhaWQJRG5RNo+xRODGY+4OnUMIHC92kJGWve317Z8nQ/mrWKtLSh6f
         1ZcF9BqdNVs7Bb+xoBKc8UkndKoJhtocOPoUjL1wBwiKpWmEVdnLzv6pv2P5k7P9MxNs
         CiGS3eg+uNid6jVD61Tf5H1fx5zotuy3q0nzgwz87Cir7hfeVRLWxlsDeFANcvar3ydl
         bZGw==
X-Forwarded-Encrypted: i=1; AJvYcCUo5nSjBMI9ubvmxbXheSnirP6TrJyLzelywRDoPw4GWtOKSgRZaf4IqbO2PrT9V4Yhwb/SD7GMzdLK0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIM7NNoMIqpW/jFmUuaE19aR064Px0cmithRNQAb3Otk3hp4++
	RMRgcbwQPupTfoiKl43qWQbnVJZQyk1AVaZGPDIdwPC9LAm3Xqb6LZNB
X-Gm-Gg: ASbGncvF2CYvjFxZgMYSrMSXnwbIbYN/MBQoVKmZISzqh+gu9Gwr/PulXMGPL3lyZ7B
	5OvlUb+ZCmpRtjbk2mEv+5LtVpUN7QXASS8RTawvYlvONJvBfY0Urm5Jz4Sd3/pPjqhh2e4P2+Z
	OKGB+/yD4gh/hOj1LupjN6u1v9qDGDtsB3ZOqehr684nuAx9l03Wu0dg97oFUHPOKoc/Fv0CsMh
	UaVLIlXNUbZyBRLj3la2vOJ+3RCLCXYO+Gh6RoDQmZOcdR/cd0MCGvWuVecyOlQcGb/UFjXbEB3
	gq2aIaxtgMs0nmarI7KS4fdBTN5sKdeJ7F3TJgY4QALmI8xy6Zc0NF2DPNu5U8o3rMC0Z3YiQbT
	Fpp4JgspJUFE1iUAxEAj1VGwlm/lWAfmI5/30Y74kA6fVhbEg
X-Google-Smtp-Source: AGHT+IEHIVx4kLA4F6aUCgGEHZ0YDmnSl35bmhbet6WjaurCHoQfC42jLR71Pq42gzogAiSpCmWQBg==
X-Received: by 2002:a17:902:db0e:b0:26b:3cb5:a906 with SMTP id d9443c01a7336-27ed722bb32mr50893315ad.16.1758846573101;
        Thu, 25 Sep 2025 17:29:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad1d45sm36470675ad.141.2025.09.25.17.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:32 -0700 (PDT)
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
Subject: [PATCH v5 05/14] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
Date: Thu, 25 Sep 2025 17:26:00 -0700
Message-ID: <20250926002609.1302233-6-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dbe5783ee68c..23601373573e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -422,7 +422,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 }
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -487,7 +487,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -521,7 +521,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 				return -EINVAL;
 			ctx->cur_folio_in_bio = false;
 		}
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3

