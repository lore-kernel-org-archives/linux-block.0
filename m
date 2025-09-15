Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2DC211460
	for <linux-block@vger.kernel.org>; Mon, 15 Sep 2025 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939596; cv=none; b=VWb3w7aU1aamI/MG90SRdcNOd1B7YNIL4NDifLzHwCam1UrgxGyAHU7rSBj6yzcsOzEyWaviGjYI7FXIY8VkMPpFJXLUfz/lHUQZEuA1VmF+rowN1nJ33UBELwexwL4mHuaCoGAv44lmPZYkkX278v/HmuNqV/T7KgPtLxbtNPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939596; c=relaxed/simple;
	bh=ka4FueWz0Un+jHqDZVdsex6ys5suckZYq6W+FIQx+Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bhFiZokx+AfB9RxzwwvbN491gKGOTSumkX/gAemlpkA2Kb+VUsjcPZaL7HwT42HRr8wk3gROQPjTpMViuJvfbFD39hTc+H6CL5MXHrcCzAWYsVeKgq+Tye1Udcgl/czSYjhqTWEWkcrVJUMPDxdsXIQBTUASVubhBarVlbAwMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2GW5hSu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2GW5hSu"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-327f87275d4so3971492a91.1
        for <linux-block@vger.kernel.org>; Mon, 15 Sep 2025 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757939594; x=1758544394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICbjoiLsYOok1c81flKhzX2Dr5LZXmq+Z/dcfqb5QA0=;
        b=T2GW5hSuYjeCSPKG4uahEZzPreVaiOtEDqUpmvm5rk6dEubX6+yP0XM/nhjJrrrVUf
         c4Exzm7JF4Zw2loI8NezZSKeFG/c3iiVVsDba3Ez2RBduLITvlVscJKw2LVd6rkZSl4w
         AJcSPCjT7H6OIAuHXHReRg2zWPQeS70tKgYG8B3JlaQYCYBPcLj7o9Mr9RmQa5jwNNdw
         g0itH4p2mKF1KORp7uodbw5zFm6HgiIsBSMPhPkyYyXo/762KYxLmFTZBgwCR2z9b76v
         vtpDs8LMPlf1LOvgiBhSTDt+03szq3SA+tBbItgxzzFkOmFmfyUUMN9p8l3LuNl+4uNX
         4XCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757939594; x=1758544394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICbjoiLsYOok1c81flKhzX2Dr5LZXmq+Z/dcfqb5QA0=;
        b=QNPm73ph5oDcRer5jLrDVZ8MgBvEPGWQHn0/xjtZ9xHchqG58nkTnIGYOPdJf/W/q4
         SSkPkMLbVsLr9KDYCWKNGbGZ+8FvyThwu//R8lS3xbVKBvkoqn2KGpiuvwnMx6Dp+sCE
         u6Er8QAbUDcCjceuL/E4djVG3MjnMJK/RU/LSr1sPgVvKMhdSdTve6pEUMUIM9O3H6vh
         guw4jHTiORSjQsV3doMBTo3QNiJepwFFRYGBpzHtmuyZWUWyL9+lMPWiHbjrepnba+MN
         93UaxtyD8In9mDf23H5mWM/QLzSX/SwUhmnzhcgvyfhSnFA1VVtszCI7KLBze+/2NuUH
         cxRg==
X-Gm-Message-State: AOJu0YyLE5Q4ZLyM7l5G2ggm98M5t3bAP3U41XbFWTD4HIf9QPGoCl11
	ftLwy/bAttbA3C4+XPElqhM2hHps4n4z53vhOAykEpoM00Wqkgug8GmpHmFSJDnUEuIegQ==
X-Gm-Gg: ASbGncuLbRFUJXg6waBZjq9tgdETTau+z2RP83G0DP0VzGH5QdI21GhuIFDwSA1yaM0
	DBRitec2uOII0Z5GU5UMfy29mF7vsmlt4LXRsgR5hcLzRlIytSpuNUh2x4N1r6nPgXMoDtGIy6b
	hGMBA4OYtYXzWkhDue6CydusFQ9dVqWvzFZq7AjEQFxbtMD4t47s1fakMAq/bTY9NMpqcGd+/gO
	Cp4psTGjfzQhvN91Wgew4WeOyXcFrkDv1a5kmco0pRMDLxmhPYP8JAgaqLDcUT8W6YYt+cIjNVb
	AXRv7Bf9d+j7V0S4l8Rz3EPdWn9/u51MWPcTXBSxVi6RJ91eSUeEdBa5nTe5D/AdkjrqFgVE958
	XRtuQhZgt3luZSCgsxmB8I7gc7lzEqIHEug2/o8bmOtDblhFXayB25yguObQ=
X-Google-Smtp-Source: AGHT+IGejX8mFgf07YiMaFVmYLT41CYD7SaPHvbYCUMkBuErliPIRTYGZ2dSA/aTiLTYcgLAHiZL/g==
X-Received: by 2002:a17:903:1b25:b0:246:d70e:ea82 with SMTP id d9443c01a7336-25d2528da26mr148679175ad.5.1757939594159;
        Mon, 15 Sep 2025 05:33:14 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-265819a6212sm37858845ad.57.2025.09.15.05.33.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Sep 2025 05:33:13 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengkaitao <chengkaitao@kylinos.cn>,
	Bart Van Assche <bvanassche@acm.org>,
	Li Nan <linan122@huawei.com>
Subject: [PATCH RESEND v2] block/mq-deadline: Remove the redundant rb_entry_rq in the deadline_from_pos().
Date: Mon, 15 Sep 2025 20:33:07 +0800
Message-Id: <20250915123307.96964-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chengkaitao <chengkaitao@kylinos.cn>

In commit(fde02699c242), the "if (blk_rq_is_seq_zoned_write(rq))"
was removed, but the "rb_entry_rq(node)" and some other code were
inadvertently left behind. This patch fixed it.

Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Li Nan <linan122@huawei.com>
---
 block/mq-deadline.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1a031922c447..63145cc9825f 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -133,10 +133,6 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
 	struct request *rq, *res = NULL;
 
-	if (!node)
-		return NULL;
-
-	rq = rb_entry_rq(node);
 	while (node) {
 		rq = rb_entry_rq(node);
 		if (blk_rq_pos(rq) >= pos) {
-- 
2.39.5 (Apple Git-154)

