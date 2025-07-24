Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194C275110
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345816; cv=none; b=MT/Byn+8Oo631b6agKdUPSm9equdjXLoY5UkzdnPtFmVlGWFG1aJmuuty4ykh3MSiLYtju8u8QS9+L0AsSk2j4rcnfM1x11JQxpWPE9hDVylOZqFpLp6sOm4LtgGM5NTEklWkdQ3tYTIWNdTe6AbZu+UFXZvPJn6rDd+KQcVTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345816; c=relaxed/simple;
	bh=wX3hUu32u7lGHcNd7gLv9+3UgLhJdjlTWOAubBO5LyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MAyBgHRmDYE4HRFMyJ5rFN1FwozkKPFNgbVBIURTfTH4yrQtiaVzrGomZUpqzFH1EHl6SJptHMt+iVqbP8kiRt0GiZa8dVPPnT/XOPXMLFzJujczGVQwm3vteR2GaaRyBnpuE4ATH3yBY9MttJMUWtjjHcXvSL4QvwRJtvQcLyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=d4U4rZ4r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="d4U4rZ4r"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234f17910d8so6295455ad.3
        for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753345814; x=1753950614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQFZq13tOuleJXxHEz9Q8dIk2BEfa9yC4GGz5ESDHjA=;
        b=d4U4rZ4rFV4bEz9sixA6bcl+U0npTltPW6CZhsVs3J/Jo+SAkwr1O6AJ1dU7lT6zGB
         txr1h1PKu03J8XOoc6bnMgWsvylSbRUQzCq6dsEzquHv1cY0T5JuEytzpAM96rX37sZ3
         MsuN58y1Qhp9mcwDC+Qt/DmW8KH/KoTvhLovf5WOF81BtV1DaZjWrsRxWa/33X4QtxYT
         stIitOgBjvfatxm3WOSQtf8PI5wiiLuF0/d2feDNCnWW+bg0l5coa3Ufm18fSKEok4eH
         wfsA/zX05juInR+LdaDNKtNVmdzFM+nftleHDigNiP/LLyLNSpGQMTckPxDFjkkCgYpP
         1eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345814; x=1753950614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQFZq13tOuleJXxHEz9Q8dIk2BEfa9yC4GGz5ESDHjA=;
        b=kidN791JHuMTQhid70nHzrOk3JIjCjoD+6d0bd4JvoR0+mKvXgwqlcQqCIWZaKZ/AK
         okuKF7PykTaFZJ4PyeAdeaB/Ok7eBIslXZl7y9gBwm5p6ttCuo2eoaxNeJpfXbUTh9j5
         oPa8HsfQujKB+UdOMmnXYtYIIqxnLE4fXmKnGcnGyncV6ELs9LhEpTA0Un65eqbOHQZ3
         azsaX7IbsGCUVHiGGBdFFxplcYD6O1lpLH/mSU7s6sXVEVByECv8m8X4hpil0GB9Rd2L
         e1rE7eT8//oJ2kRsgs7YuO4UF0KdIeJo1Cl22eGeVGQM/wnHqf7vWXDZwMiG7kmwHsmU
         lcxw==
X-Gm-Message-State: AOJu0Yw4wdtJbIuNd3GSkLzDaNcnieAqch+DQvLaXGKInrCVo1suUEsM
	Yj4FApvA0hWiKxFrGslz8ccmWen5gkbo6HvtSzBVIweuiW3hfarox/Ya6fe52bobs1o=
X-Gm-Gg: ASbGncvUZ72or5ibXhq7UP+q9CPTpkg+hC+kE5R8FpiENouPmIRYKMaYN1/gV6qk06C
	9R7o3rSjvITUgCOMvATb1EPtbZwZD5Do33BSTrBZGZuJVmPN9lqDsA4lSWQmcxqEpz+jkDibsHE
	pzoFDRdoOZDBEDJaCe9Eq3TFtlEvG8MutIzHVzugkYH54r0gdlHMbtAs5mRj/72ziZstT0ALvb5
	oK7b4fnPbYmhdOZ52vCjyBjhtDHgjyJ3a80Wn8SbcEnMM7nS674PiNXIvBZpBfCDTT/hhT+wztE
	D69OHgBWeZN0E8WDAc+by4e38dLnE3y1cZeZl1fT9QHgUGESDJL/e5xCoxC08wzZnRvV3kw1JF6
	ApCu93B0=
X-Google-Smtp-Source: AGHT+IGUlU8FNBEl8GSu8PYnsHMBzzSLnvCJOILYTMcEzWyLF/ddhbSopgXoLnuJrimSdJaMtZNChA==
X-Received: by 2002:a17:902:d48f:b0:236:7050:74af with SMTP id d9443c01a7336-23f98161975mr79953295ad.9.1753345813698;
        Thu, 24 Jul 2025 01:30:13 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa490683fsm10037115ad.195.2025.07.24.01.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:30:12 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 2/3] blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
Date: Thu, 24 Jul 2025 16:30:00 +0800
Message-Id: <20250724083001.362882-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250724083001.362882-1-yizhou.tang@shopee.com>
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In the current implementation, the last_issue and last_comp members of
struct rq_wb are used only by read requests and not by non-throttled write
requests. Therefore, eliminate the ambiguity here.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 30886d44f6cd..eb8037bae0bd 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -85,8 +85,8 @@ struct rq_wb {
 	u64 sync_issue;
 	void *sync_cookie;
 
-	unsigned long last_issue;		/* last non-throttled issue */
-	unsigned long last_comp;		/* last non-throttled comp */
+	unsigned long last_issue;	/* issue time of last read rq */
+	unsigned long last_comp;	/* completion time of last read rq */
 	unsigned long min_lat_nsec;
 	struct rq_qos rqos;
 	struct rq_wait rq_wait[WBT_NUM_RWQ];
-- 
2.25.1

