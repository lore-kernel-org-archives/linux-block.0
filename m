Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74E3EF64A
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151535; cv=none; b=gKztZv3Kef85mhOMuJDduioKVElu47fYJT0d5d3Adi5BlJrv1woxkXCuKkRlitvuXeyGfdSlxwon92pPB1qTaaExmhJwZqYzM0L4Lm9/QLrrz785XygSx8lFMHB34MDTCTRkVuL8GdGyWkUuKMbDZABdo8zRDvvwlE1WIXk9AnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151535; c=relaxed/simple;
	bh=sgQoqsmV7FIHt7R0XO8WcOhuroAmG39AXY6DAA6uVqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brWdhXwj+Df3B67xkLPYD/MuSPHOlYDR+yxFykjcxJmRsde4ZlYFItca1mtUh9uljG/vaCGPgCyeJsGaItv+K5xWWGsmJaJaQXGrVKqpQQWbu0aCryMLnTtG5uxvvejZM2vFsrOZSRuiKp61aTMy4V9kOwtwdKgPDRpOatwC68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTE0EH73; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTE0EH73"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59dcdf60427so688832e87.3
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151518; x=1778756318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FRtmBqG1UNY7ECXKGcgrl50BUliZteWLx+oKcKMFAHY=;
        b=FTE0EH733ZosqWhZFt/CopfpJrqfz4jXBK4lDrkT4houXNh3TE/1WEJCLwYkEGRY7S
         E02Iqq2P/7XBmSiOJriY4cjWgzc+BhWk/xMuLQwUgwyXdXXFL9oSooTCBjOTyTT1OrTd
         kxN7xMAH5KjR0T30uxe2qcD8MlTRsooSBA/AcIOlPVhH4OxrhJC1Q6w6/SS1C2pZAcOr
         pIPG0EptyGYWEIAlW5YNWG9NvXRASGhM66vqzhE3Y2iS+XgfTuKeak8d3YecoxaLNgUZ
         nGt11csG0VtvG0FWc+CCGqZaWNBjAl10ywXYH/vI2ILMnS4tAtB2jRKgjY8z/nR827Qp
         Gd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151518; x=1778756318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRtmBqG1UNY7ECXKGcgrl50BUliZteWLx+oKcKMFAHY=;
        b=DYMREGG3xFHgJ8yP11Axr1q8ZKzdZEBG8107Bn4wY1GS/gj38DLRpbls6JN9ifv6Hn
         fm5oyosJS7UnCtlVgx/P6oSLSnAQY3eVcrJYmvWSByJV94EneUMcF4l3kej8EKglEEgX
         AMbJgmDy0SA+CHbyFq2UBoH3/C6zq7x9pZ3z6cFo6Ur2yV6/8eAhrk705MzZd5i/xTBo
         Oq2z77WqaKKAn9iRls7/7tXng8bQUMYokuGv1LLpOMTHYCdmcJ82azecDLe7V2qMwuIJ
         zGLzjp80GGTut7LHP3mwseitSIgoQAqexYx3IRc6O7RinDtVgCfZesD+sP295J9QBn9W
         sGjA==
X-Gm-Message-State: AOJu0YwWyyekqKtI0yBfJEFLRyfUjV60+g8nAkHo6JtwCKm2K0aRPihN
	rJaOT5hDZ+AL8dh56SsofJMzWexb1zF+SegWP+BHuwvT06MgTxAILc6l
X-Gm-Gg: AeBDieuKmTJt1MeyieB13rouy3rx7yI3JRM/ocssqWheu95nClBNW8umByjZ4g1SuE6
	qTGa1toIMEaE2U2yjHss5tssweHRfe9CW4RyM5nLK3aO9kV6dgluQ0+8+6vgSTGgAlkstftM1RE
	5ihyqC334ygGQyJVnkEfRug2TMgtwkzskGnzngmsEoyjGMnjiT6/hegLMRMzStdISPKbrYOTzr9
	LJ4B0YHWmVLixnKJuvcB7O9cAnqo5kPsi51X0OO0M/rwnIFFdWV9OXlxJTkj+IW1uy9XRY6W5AT
	obQwyR9XRY7SJtgpn+KS20yFcY/QLztgbmabXqsv7+Oajv9uTMT3WCtX5gmiib0auhAy4cjryJ3
	w7ckqRBZUNbrK7W6wdnCIdDiEaEGq0bRs66MylPYu2jmXB9cDnnGd8scCYh86S3hMO/znRXnqow
	p4bn5CxFdJFgJXnDeLJ4jUHgURkwj1ZdaeGNuPkHNDhLxQjGbcrY1iCKcImmJI6YzbfRs4KwBUX
	FLsik7hL6SXaA==
X-Received: by 2002:a05:6512:61dc:10b0:5a8:881f:fb51 with SMTP id 2adb3069b0e04-5a8881ffbc9mr1825377e87.1.1778151518181;
        Thu, 07 May 2026 03:58:38 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8683ff452sm4619753e87.63.2026.05.07.03.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:58:37 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] block: Fix typo in comment
Date: Thu,  7 May 2026 13:58:36 +0300
Message-ID: <20260507105836.25757-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in a comment in bio_split_alignment(): "occured" should
be "occurred".

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 block/blk-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index fcf09325b2..395b23ed95 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -403,7 +403,7 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 	 * there may either be too many discontiguous vectors for the max
 	 * segments limit, or contain virtual boundary gaps without having a
 	 * valid block sized split. A zero byte result means one of those
-	 * conditions occured.
+	 * conditions occurred.
 	 */
 	bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
 	if (!bytes)
-- 
2.54.0.windows.1

