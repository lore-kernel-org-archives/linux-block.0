Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE7175A5
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786886154; cv=none; b=cc62AmrPVSV6k50fbvSgeieAZzkcjcXDt5oI6UWLaiuT5wuEb+oR3zfuINMzQ3e8q2Jyzu5eMRTyBWTGYn5Kcl+jGrGMQNuap0oYViFcgukLt/cW6oOuxiZ1uS2YNojTsEXFugFBcHF5lRe0/QdX3tbun6qFKr3ghNLTiyXQCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786886154; c=relaxed/simple;
	bh=SXwcc6wU3Fbmvo5fCXIMJbPx2OeDA/b5+lepK2dVpFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dkuz+px7S+y1MYNdtTjvnaR4IuwL60PRApDk6UezYUxQWVQfoW4p2BVbNM21seiI/8rVHEPEWOB+c5mGh8675PaVfoyA3OoYoYTY2FMo3OxYohNDxHofswnAfnOYdwCM9qEffja2awRgcxlxI3I5eT/77Y9uHKRLD8o2+P+xqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eextGSR3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eextGSR3"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1570085f8f.0
        for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786886152; x=1787490952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mRIowMI6uQjCzFm50OiGoln3J1co3Pj4cxbC9/mQPCg=;
        b=eextGSR3u+24B3aRGIrvwES/9MdjpFBjXQQ7Y2vzpkEMniMZQao8X/sWL7AfQ9uyEc
         YVyq0/rVy2RJGdCJCsdggs6C5Hl0LBYZqXa5WNXhzwnYfFoWw9zq9OksMKs27LJbU9MG
         1SCtvHwdA5H5K5Nga662CRFyS4HyACDA9JbFqQRD53kmUYgaT2mN2Mn/ZFNRu49g1MWd
         jWPiA/EqQ5r22RoKjRbWE71xrVEwvXGmNQaHw1EVLYR3RJDXmxnaV57A+5CHraVHhDBO
         Hqvh+ptUGVcTqLjom+Yljyh/7kUlkQgMSKYomU4Rh4uY/D4mq14tU48S5OF8rfUWmEL8
         MPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786886152; x=1787490952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mRIowMI6uQjCzFm50OiGoln3J1co3Pj4cxbC9/mQPCg=;
        b=KNgrBBinkl3NTtVbrbgznarqWrUY/svq4VBJ1bgVxlEdyg6KZStTb/UzJbqjcrZgwj
         LSILZLz0i9ICKqDPb53TDhUPX2BX2v37JV7u2jEsRKJafEJLp1dQ6Q2yCtBxyWnecTTE
         pd29vmgFYgzyjG68CAu5DW6uBSFVblpf8msIKn2d6WQauDB+A31uypy6rWWcONw3JkUn
         3d3U1hUYFSmXZH0t9l2E/TvnwyzJy1cF7ixVXEzkU19xSI/ogiJds9Gcl0CE+qKlCAk0
         MFvNd517V4T/Ijw6hzgU+tVZMesonUwWFU4d7dp2acz9lXCZ5mxGcvl1fVY7ZdXWSD/S
         4KFA==
X-Gm-Message-State: AOJu0YwjUWcp58q9F8QDPHfaXktKesJEoJTO5ECKBDXXgn+lC8Vz+u+y
	28RHIAlQmaLNZTy2YYo78+VAtvcdYOEQxYqAH3qzGUTfv9c8the+7gh4FBga80qG
X-Gm-Gg: AR+sD13w2lmEalzW8ErPfak/sQY1WWWV/EnpjV0YSc9T5YSubuSwBg6c7YEubaPSnu9
	zw6lt6HWE8/kwFbOXHbdc3X5f/W0AlZR9SJsbkOe1IXIaibjQ/udiwL8YeXUqLd/YxBQTCW6HFF
	WDgVNf7PRreg3nb0lQim12xR9oUCSagc4A9vrNRBaPOlkw+9J+ZIesfl/bHOigC7YAWvUMwxqtI
	2os7gTYugaDKtRTw9AFymDiKeMcBG/4oRjnYAtZobBvP7+tzNlna8Ntopd44CLld31LwWmTBEJM
	QMf80v0cF5pGcbRM8KsWW4yKGfPSFECicB4QAyVW2ZBd54QT2znTOqvDSkqazPLKL6CQUUll6dS
	zzVceSZvZkV3lpWf0ZaVpY3D60qqaYy91UvYXDrV+dptX/n6++9c3j8CzjrKDldpQ+lPYhLg/mD
	4C9upSFk0otuwl2HcldaImEud02Beia2NLUwOlXBSHc7ma+Gsq0y9v3P5B6mhMqJPb3SoCrDdPv
	Rm6yiXGVWayP9epC4UZukNdLUkccocseBGWiVGKWPJoH9p7utU1jHQuM6wO9xzApiriRmY3w9HY
	peS0ofuFYw==
X-Received: by 2002:a5d:638f:0:b0:47f:9d0e:f8f with SMTP id ffacd0b85a97d-481607bcab5mr21796166f8f.26.1786886151544;
        Sun, 16 Aug 2026 06:15:51 -0700 (PDT)
Received: from macbook-pro-de-bryan.home ([2a01:e0a:d7f:f4f0:306b:5f99:5378:73e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cc81csm24721295f8f.34.2026.08.16.06.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 06:15:51 -0700 (PDT)
From: Bryan Boquel <boquelbryan6@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bryan Boquel <boquelbryan6@gmail.com>
Subject: [PATCH 2/2] blk-mq-dma: fix typo in DMA iterator kernel-doc
Date: Sun, 16 Aug 2026 15:14:56 +0200
Message-Id: <20260816131456.16374-3-boquelbryan6@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260816131456.16374-1-boquelbryan6@gmail.com>
References: <20260816131456.16374-1-boquelbryan6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_rq_dma_map_iter_start() and blk_rq_dma_map_iter_next() both
document their return value as "%true ft it did map a segment", where
"ft" should read "if".  The two integrity variants further down spell
it correctly.

No functional change.

Fixes: 858299dc6160 ("block: add scatterlist-less DMA mapping helpers")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Bryan Boquel <boquelbryan6@gmail.com>
---
 block/blk-mq-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index fca7ac01e73..4a4ae2f806a 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -213,7 +213,7 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
  * at unmap time, @iter is only needed at map time.
  *
  * Returns %false if there is no segment to map, including due to an error, or
- * %true ft it did map a segment.
+ * %true if it did map a segment.
  *
  * If a segment was mapped, the DMA address for it is returned in @iter.addr and
  * the length in @iter.len.  If no segment was mapped the status code is
@@ -243,7 +243,7 @@ EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
  * arguments.
  *
  * Returns %false if there is no segment to map, including due to an error, or
- * %true ft it did map a segment.
+ * %true if it did map a segment.
  *
  * If a segment was mapped, the DMA address for it is returned in @iter.addr and
  * the length in @iter.len.  If no segment was mapped the status code is
-- 
2.39.2 (Apple Git-143)

