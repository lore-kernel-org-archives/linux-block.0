Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B87212FB0
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441184; cv=none; b=YOmGEfsAU9NMCGtWZS5BGvGiW0tR53UXJpF75Wab+ub+DXUlcdy6Zz5sP1PhuYEUqhlj+NFwiHIyzMi+HUpByDOADInjiAhwR/X8eHy3fHy6rgKQIpSLtOcmn9RxkgQ4Xsl22QkKKEMk7WfyIOF6hhwv2EUjoK5ZBYGDv9Aj/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441184; c=relaxed/simple;
	bh=DJxCcTIvgxvkOcXrsiG+p2ey37S3EWiB9CRHiiel0eU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fZptIAYmxyMQMBqffHB9Z5aVVUmB3j3oqizGGxZzkNkJ5Kgaq+Y+oILZELQslSIWcbV2K+hgkR8qalxV8j5nwVaYeP36K67I7ZsrnxpPENRrPQeTaATShkmvhPktrGAlBxWQKsdvYHGv0MNxyyVPH31O1lk6++Fyt9yvg/1iamc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=NdysdoV7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="NdysdoV7"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220bff984a0so11249375ad.3
        for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 02:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1739441181; x=1740045981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+m8QAd9uSlaB0HjndrS8KytyCEE/0f9gjFGlCPLPPrM=;
        b=NdysdoV7NvU0DhnyJLWRI7mPN+6KTckiiGcSARvMDkMgdbMI/m+z/qBHEvWcZg5PQ+
         ruBZQOU3v5w/OgIcpm8CL+yXGCPmZ7HaMCDPVdG54si9pRzVPTHo/MEy+VQvr4G+SoRl
         ZPIHqJT+MsjDEirR/8dZOrXyB2Ei9j/Zy/9nXHey5KGfBXGTblAFm4Kiu/nOguEl/Mvs
         CFYcAs3tA2hvBrWIreBUQDY4ys8aWy8A/qNH3wacmTLAV+wa5y4fFujU/2obOSTu8k7w
         w2FHjLqThW8LrZqfytAI9+LBzV3rSEzzFeyGvHjAOS6HrT96QqlTcQd4nDxP0wMJLChA
         coEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441181; x=1740045981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+m8QAd9uSlaB0HjndrS8KytyCEE/0f9gjFGlCPLPPrM=;
        b=ivyeZBux6q6rndEb372NQy5AFRxNWFa2cCEPuWGGz/aIiG3W1UpgnWflpKArGYedkk
         IPhacHTltvM5K+ykoVbOYgTC6nCGDWNGs/2R8GEdhoXKvcZHqPEpxXns60EcYoT5jvax
         CwssKjwT3gi64WV8KB3n8tZMnLbdV84SQ8gpMQggiN5MRb9krCwvjvoP91QP+CV//gTx
         C3l2VOMyBSFM516Fdm+jW5aTuNseUrfxfeh8IPbvK3H5ShVAi+WUr6s5Wgmty4hSqqsW
         Bo9b2LTM2fj6ece6EnwpBbSVKbHm2GzJRsQdWCi6Hhg9a3tK961nT2/Ugv5eSp/M4Lvc
         0aVw==
X-Gm-Message-State: AOJu0YybH/YQEQRUWaW3GtifAH9HMEI1eO/nuRrngikNF4ZI0qJ3wtd8
	UioF3um6rAZvYDb/68jhKqIdtlMSPaYWTjeAU00xm+f5it4YKTovB4ZEiVHyrP6HyOCM/nyydM9
	m
X-Gm-Gg: ASbGncv0/CYhH/nKQXAsQu+BJakCvSt2OKwMZeLRpPN7E1RYmOpqmcryGYLOa8jUtM0
	flCOQcivBq+dfZVz0ijQFcWqxR460sXClAgzTv6/ZAKjxOLrvwyJKIoxhp9qwSGNZ4RZtE4DpH4
	WwKEAn4dGqNyRE5y23u8gEH20z4T47FSLTKKzj9s30u/STwSPozhqZLax43Sna1c2HLZAV6SdL6
	DEgauJXwXohpYMNI/PhObsMTz85g6/IeSjzL+dYxtqrF2s0MbBOsMysUzEJJTJ2mSjHqTpMb6b2
X-Google-Smtp-Source: AGHT+IGxuPtgToDHNMzvTl6E3kE57/3yPxyNqRc8cQvsoejoYG+WaIRNLunOFh4IquzPAb8kiixx+g==
X-Received: by 2002:aa7:8881:0:b0:732:2b64:1021 with SMTP id d2e1a72fcca58-7323c1056c9mr3558957b3a.1.1739441181368;
        Thu, 13 Feb 2025 02:06:21 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242761569sm937442b3a.130.2025.02.13.02.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:06:20 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: yukuai1@huaweicloud.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 1/2] blk-wbt: Fix some comments
Date: Thu, 13 Feb 2025 18:06:10 +0800
Message-Id: <20250213100611.209997-2-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213100611.209997-1-yizhou.tang@shopee.com>
References: <20250213100611.209997-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

wbt_wait() no longer uses a spinlock as a parameter. Update the function
comments accordingly.

RWB_UNKNOWN_BUMP is used when we gradually adjust scale_steps toward the
center state, which is a value of 0.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-wbt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 6dfc659d22e2..8b73c0c11aec 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -136,8 +136,9 @@ enum {
 	RWB_MIN_WRITE_SAMPLES	= 3,
 
 	/*
-	 * If we have this number of consecutive windows with not enough
-	 * information to scale up or down, scale up.
+	 * If we have this number of consecutive windows without enough
+	 * information to scale up or down, slowly return to center state
+	 * (step == 0).
 	 */
 	RWB_UNKNOWN_BUMP	= 5,
 };
@@ -638,11 +639,7 @@ static void wbt_cleanup(struct rq_qos *rqos, struct bio *bio)
 	__wbt_done(rqos, flags);
 }
 
-/*
- * May sleep, if we have exceeded the writeback limits. Caller can pass
- * in an irq held spinlock, if it holds one when calling this function.
- * If we do sleep, we'll release and re-grab it.
- */
+/* May sleep, if we have exceeded the writeback limits. */
 static void wbt_wait(struct rq_qos *rqos, struct bio *bio)
 {
 	struct rq_wb *rwb = RQWB(rqos);
-- 
2.25.1

