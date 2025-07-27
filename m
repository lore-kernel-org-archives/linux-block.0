Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93235222594
	for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638015; cv=none; b=OI6PuWdHiXgS2Xg3eU3LDsjffZL53h/rLg1J9PWxMk/nZ410+37Ow4hBtHfoqCHJNHF73b9OnnXHwdFRGKjo0cEPXj2SosqW/UflaWwYIroay6WcYa5N1aAA2rx+SmY7TeOJjwf0sEyow8T+3d/tjC+ZVQOeadML2EuO766irHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638015; c=relaxed/simple;
	bh=I3xew8je8GRIx1/aB/St3V1iUJkyLvLXJlWO4o8KLoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MFyrsJgDPx7YvZ1uaAKe6Xl1whekwV8agi+26Di7s80ye77pAjeV37BHxXb3kqSXa7qyEESlQK8H8h1pIdqbJjzkX5rnfjQzKHMvppvCXAYWAk2mGiMpGgVMxiv8ziJ8paAe8NLuviWa5hOS/kc4LdyHeZHO9POFGKS9GxXhpgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=lxFlbycy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="lxFlbycy"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso4644263a12.2
        for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753638012; x=1754242812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWYCKfy27tzmCzfyC4JZHP6ASajzBlmmh8Lqhq4+b6w=;
        b=lxFlbycyswdGpqoDnPZPmOsjsvoeQGvgNzxax9g4mnfl+UMgVHDalOOILEt6AddsRz
         JmIhqV/5tlTPAC1zza/saSaGC1f0JbLpydX1Rk8xFpMRmOeUvRZYYqMhJyT5zDaOfiQN
         0eoYkVjz+sKU94+ULjM4TbV+qlJBJljif4Uk+4OwE8+SD6eFC/Ms6/02pplppeSmF24K
         eRmmqlII5Xi0PgySKm5KREB3dXKMSGmG6HFu81YLn1ctXxt6TYq2Y1zDiZbI7ZKu1ObZ
         1JGdVQSP0sbqC2GEWx/DL6LYrBkCmmTynv4s2deaNBgTqUg4HOiYOytg+9g/rrrzjS/U
         kvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638012; x=1754242812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWYCKfy27tzmCzfyC4JZHP6ASajzBlmmh8Lqhq4+b6w=;
        b=QayrBulgmRukAxfcgbkRAVzbX9wwZWB4PWg66+dpLXpNHXme6H9vEZtnIyONibGcHR
         NudDyu+WDQcgaqcrRhfu8PEniztTt/y0WsZ+7li5jaEMoYAXdujrUelBJG4LLWqQcO97
         eetHNgloo2Vh7PSAWmR5mfg88g6BGaKEQYpASWiddFYvhZsDbQYfYHmSOaUv/j88t+Vd
         8cyyxPOyZi+YVZze4hKrHxpTo/55mTL4OqKka23nHhDRWQ5TFMQBkHgsPCW/4zMBleDd
         xgVAxDCxW77XweIgjE+jDz/aptVpC7SJZc5xsvJZ5lE0H5wJcFHJyATwlEXUo31MQY8L
         3b/Q==
X-Gm-Message-State: AOJu0Yz36+oPhTIO9tjMWu3RzCx5cN7NJs6b8Hv4FZpxgOg6RkZJbE6H
	ZxQj5MCzP4+asi0hIwvyDJREGFxqNeCREmVcZHI/0BnpqNRSBpAzIshgf6KT0ec2mRk=
X-Gm-Gg: ASbGncs0sR3stse+fwJ6zVqzNrXq5V9e9W2Q8bWMo8+QopYtDKxHRhXolTGJP2FGAdP
	f3gQwylAs3N2qFXB9aIG/7jJhpuGrKiWMkwgcQOv4XfuZuzpJ3ixMj2Wo6r9OPAdTcW4J3Wd7Yq
	IRnydfl5bqFWqHOJM7h6RfCR5ZysmEvNO22zvVD2ML4EVu2tXkgJqOM1C91cAF1YO7O2lbKAlib
	6uMML10wpayXZcgQK6llSpCg+Afl9g+VVJfJT03oXtAWb/Z2eVitmuZ5ZUWq2fepy+4y6dASaYV
	w4cGoASEgPvqJcSbFWXsBZab8zcc2+INrKFwcV2B0DtX45b73l3QuSDkzWgiyVh4Wdgx9/HC7pa
	02IJAx1w=
X-Google-Smtp-Source: AGHT+IGDb43ROyBpxntRgNLuY/5vvT4SEpSM2eziMLcTMsmIiZVG0+L6EZVmEl313ywHGdOopIdS/Q==
X-Received: by 2002:a17:90b:5865:b0:312:1d2d:18e2 with SMTP id 98e67ed59e1d1-31e77a00959mr13499760a91.20.1753638011909;
        Sun, 27 Jul 2025 10:40:11 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8350b724sm3924224a91.23.2025.07.27.10.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 10:40:10 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v3 2/3] blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
Date: Mon, 28 Jul 2025 01:39:58 +0800
Message-Id: <20250727173959.160835-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727173959.160835-1-yizhou.tang@shopee.com>
References: <20250727173959.160835-1-yizhou.tang@shopee.com>
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
Reviewed-by: Jan Kara <jack@suse.cz>
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

