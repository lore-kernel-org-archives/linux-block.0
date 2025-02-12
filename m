Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F57E107
	for <linux-block@vger.kernel.org>; Wed, 12 Feb 2025 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739329265; cv=none; b=mMdS5q3D5QE5B8T3oqsjcSzyU6FVMwnvBqYML3wtdzMJvcdbKi2v57X2r9lPz4QRVBoh/0cObcH5oEcFFlSzcgFfwhEwi8Sd0bxFdaiXpyWp/szEt8AKZsMbxb1PXMn4GmQ6qLVx0qLVqH7+yXxV4MErhfzaHBI/eaRh6AFtJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739329265; c=relaxed/simple;
	bh=XPP9kRN6kzoAOAZHknQN2SY3BFA8CtzNYCTu5ea1JwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s6HHvB/3vfCiCqhZxfDKKDz7b1xxYdxPLpmJB6O3Abx9Ppy5hTpCwzePowTFIfu48HdXnbD/hh+8SF6WjoKZIxnplYj80l81d6ib1i6rj0sUVqenlDXDLsiPWPpzwp/hVSsDbV7xtiPewekKkC9Fu5i3IblFaVy9ypy2zjNQO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=PbqxVD2w; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="PbqxVD2w"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f6022c2c3so6299715ad.0
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 19:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1739329263; x=1739934063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rX+yii2dh/Nt6iZHfj27+NPFJKvRakVXL3zR3FNiPnU=;
        b=PbqxVD2wnGV9Y/QVtFTK3JnnIfruORn4vsmvKQSubIWNrrKEQbi4yLFGDkS6QbD/OA
         mxBZhfmi+pPyJojoveR+T8BPtveesaPGJ0Qr74fbBn/Kdb1EerP4Q9p9B64FNZjNmLLF
         SHXz684PWl4z5AikVtEEEoKlB7kUIVzQCNMIU/qMMTC3gN4JRWPeRBFR4Bj8L/7r9bgg
         Pojby8vN7Gg/CBwNeHqyhK2pzXGZ4pyE/5C1Ow8oqzR9SEE5BYCFcA9WN7AUUiStY0XO
         0aN673blVklybvKn5iTAGo4HeaDOq4Obr/bi3IwjnEa1eHqdJqzCqHjv6UBGUpIUKuEk
         bFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739329263; x=1739934063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rX+yii2dh/Nt6iZHfj27+NPFJKvRakVXL3zR3FNiPnU=;
        b=v8C3ZCjf0XrrW8J0YqJCkQV1DRvxmY+J5OvOZ5/JlsBOYQh7/DtiUCeu6i6n6b2q/Q
         IVLYefoDT91cayku91Fdb5jutakamfSXv9DjVluriRgtNhnFgwAtPwNumAcEuF5/zamj
         eIm+VvA4tv7BfwWU6GngFyZNpTsP5RL4E3x4jki42aT+r9mbycyhwuFJOqMsUFqiCToL
         gERPztdsoTfr4jgHL8fyV4sZImMVTd96b1V/s5qcCAB/hev8FSWGukah/oLnNV3v8FlY
         ZOVOZ03yvY6oC9ePA1Uy2ObysjK/cnGLeprYP1niHW74oQHsFA9MGr+s/ugInuQB6Skq
         fLJw==
X-Gm-Message-State: AOJu0Yyi7qD0euVWH/9OrCPUHGMsir4o7iQ9EWTTUAxj2ERFhMgSInsN
	/ffVZ725NB03VYOMO4/4TBhz+aSqVUqdULE0epCihzaRkmLB0hFGik42alxljhw=
X-Gm-Gg: ASbGncvEY0DE74q5nR17y2vO70WrfrJzOTTcrkX1RnmyGDqQF3gf6leTxO9bQ56tY49
	/F/VDV3hv7O/vXJjlnemi8HP+YoVk6ixcS5BGzbgo0wv6mzUlvEX/qq4awkWGxF+qAWxRja1gi7
	Ypg2g11bzfnsy1HdilQRB/hSIK0csEH0hwS8gyoQXsFVqBXdy2WeBLBG95xnTnw3nZ4AcvLin0z
	vLJLT7uu6szFcBosHcJ/oQjrYvnYfdfE06A7YLnVDrVjmQt/rIOg+vpzm43nQCMO9Ffo2jB8uQ5
X-Google-Smtp-Source: AGHT+IHYiD5282yAI56S5u6sv+uNijoJoeBldjyAL4y6gsfbUi6PiXik3/CCecp77O4OY+bdxO9OlA==
X-Received: by 2002:a05:6a00:3d03:b0:730:84e7:cc with SMTP id d2e1a72fcca58-7322bdc4f48mr2719774b3a.0.1739329262552;
        Tue, 11 Feb 2025 19:01:02 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73091f94bf9sm4170337b3a.20.2025.02.11.19.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:01:00 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH] blk-wbt: Cleanup some comments
Date: Wed, 12 Feb 2025 11:00:55 +0800
Message-Id: <20250212030055.407090-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

wbt_wait() no longer uses a spinlock as a parameter. Update the
function comments accordingly.

Additionally, revise other comments to ensure they align with the
actual implementation.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-wbt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 6dfc659d22e2..f1754d07f7e0 100644
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
@@ -446,9 +447,9 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
 		break;
 	case LAT_UNKNOWN_WRITES:
 		/*
-		 * We started a the center step, but don't have a valid
-		 * read/write sample, but we do have writes going on.
-		 * Allow step to go negative, to increase write perf.
+		 * We don't have a valid read/write sample, but we do have
+		 * writes going on. Allow step to go negative, to increase
+		 * write performance.
 		 */
 		scale_up(rwb);
 		break;
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

