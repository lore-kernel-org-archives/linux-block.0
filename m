Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205888;
	b=LNGBfLxHHERHYaxVuvlEAgLFF/xjWi6WiEzk7pEKyItDn1OAqyXfVIoPVMZntKbQI1W7
	 RY+gnZZLT+7NhTEfD3qMstkpXU0grxbTqmBRLt1jYD+S4W0iSmp3w3m6baiKSOrcsHd/q
	 KMzqvUnpAqCHQBUngTYTzAEpYNPscz0ORHBRPE/MsSqs/VgAUQ736a8k74RQFs0K3OZ1l
	 cGyHXL5Sz9G87of7vEKI0DjM4tqGWTzrcf2LzaUiuNGhvc9qG99FOo5IiROZjhU9tYHfB
	 S1e1TAxBoShbAvjkzdTiaULaKnwVWpueD8Ghp3kekPhrexpOEUw1V3+0nsFSzlMWIeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MlOx18N0Xy3f33RrPdYyR/r1PXzRx55uTP+f8KinAhQ=;
	b=OmWwTIBJXFxCZzoEvL1gjuhB1qvpU7XStpTcSTqtiLAmXhF1buKN5Q08T0TRH75aRTlm
	 s2a3t6lqHqgRf2+SyXJe/BYHw+nbDfNlcIjD+bEqk0GXuReJ9/Amys3mIv0zTbi5OB9rU
	 Us6lXkyT2H/5oYfcgxrcRRlki5I0OI6E2Xi0QXOP352WknKZ4kavN4UwNXj78N0r/3pV3
	 HjYW5Ubg3BagGFMBQC+8plVXhHBGEAuZZCZ5+pWHxeFLpOGawa9zIfmXo+RDV67Lpw++r
	 FV+asxJuK+hhAkOTmLJImp1JaYgmrmSd1BVlznoESXoGNhXlnDFz3HPKQtlP2DH8wJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G+KeBXPN;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDD606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33DDD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G+KeBXPN
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-85c1135c286so71882a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205887; x=1793810687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlOx18N0Xy3f33RrPdYyR/r1PXzRx55uTP+f8KinAhQ=;
        b=G+KeBXPNwbEbteniXQDJ2FRq59kJIgp1vA6LJiZfUtj/SVujgSAscbclUoAhJhFPED
         SphYOoXCtyHC70ajyh6qSbIlfuMtj108/DFlEmbSJNnw6wyMSQei2vnyvbdVvvPbh+/y
         uE9OSRcCQA8W20zsEJzyh08o0JZKZeuHIi2RMmQwb3BGy8OPuQ0YsuCoyQ3INeyEGY7r
         p3cPihREzO7mtA3bh0k3Td7E3C7K1/zpVPRESvpFzT/lrZYsE42/OwsZv/aLIAqGruNq
         QtERc/ClfZWeCt29s0Rh3b0icnDxcCU0w+odd8p/dvyXGH8LcKff4RiQZLC9o5i41CqZ
         6XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205887; x=1793810687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MlOx18N0Xy3f33RrPdYyR/r1PXzRx55uTP+f8KinAhQ=;
        b=BvI4oNobnkqtakNjS+c0+AsKqune0zBqFhyHor79Qeyj+S+Mu1GHGowFRbT7EoJo+C
         NY68Jv/SMkjBcfwEUm+WWM3pi5dzYuWXBnYa65RjiTU+sZcPI3fVRwkpkM2P7HHmP+Ua
         V5RxBub2GVInyo+OPqsA514xd3sM8zo9/RDvj4sYA8/QS976at4stUhM8N0So9PC7552
         uCwdwLTbmqAMXamqA34GiSqbRZjiR4Yanr5/YQFxhcod6EpW/9Onxoutcvc1tQPP0WW3
         NZ3CKXQwcfWyH0Ew7aggMitI7ON6tI2rMtbIvjy8zVV77Yvmme9vILK0fE+TpdUIPTRC
         c9pw==
X-Gm-Message-State: AFq9FYLddK8esh64stQeIrEmPa6qcxqU//7jHuixbxKqAA7f7C2s7sF+
	jfGzIcLMn+c4WWwjSCmmKMPvmfeddZ8sVRyaVYF46AaBDjSl8AGiwCsN8N3OrYunWDPfFpmzLA2
	k2yHAFQU=
X-Gm-Gg: AYBFou3pQ23rWgesXsuACSSNlkLzvzrX80ghyk7GES2oJBEd9xI8onwT/hFWRuPxlyR
	rtXKxFm0ZftkBOEMQB6B2pX5xPjk3QlKDl1+mNsBkHEhy8LHsWAZxErn8dhrXshCy0vv2BFd6R+
	9fJkqhTtgAPG3RWrpaFh+YxgA6NRrqNnPHaFg6kPsW+Enf/zkY8FYy0WyLRRexOUrJElbDf7Ipm
	hI41RcMEcL/oPItTWDGclBfdTmfSM1yB5eY5zLRDMFUb+avvrEvADcZ8BOuCQ4IRhIHmQ3O2J2L
	aPip3ovDe7cy2PlTgQbivTKZwWUMSOz4m8I+RFDAR3sglxBkxRhwPzIdYcTTTAPeVkg4A2M9qWa
	vir65qtlCN2zqx3EhfbhiJJN+KEscBLl84eGzshDVLPmc6w4E1u/fEHkQRekxM1pLujIObm/09l
	ygXtVXaSEJv+lDd9fk9mM5uOFcgaMt7iUfTiG+Nw97U+6hqh6A7yk8EygyVMvXoVM5m1nfz8bQc
	SEqe3/CQUyR9NXcA14HY+Bws8IFLCjwQ5tJ9ExLRkVXFjYiTQxQ49sMt2HuiIpzsTFp1s7VU7mi
	RighfNlumiwLYUmfW5O0ViySFrT8q0iJ7nswPa1xzdUcIcdjRA9Qlktq2IFfrG2hYoABuDd0wg=
	=
X-Received: by 2002:a05:6830:67fc:b0:80c:d30f:97e with SMTP id 46e09a7af769-85abecb3cfcmr2460657a34.31.1793205887211;
        Wed, 28 Oct 2026 09:44:47 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/98] blk-iolatency: flush enable_work after going offline
Date: Wed, 28 Oct 2026 10:41:26 -0600
Message-ID: <20261028164415.1262013-24-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

blkcg_iolatency_exit() flushes enable_work before it deactivates the
policy, but iolatency_pd_offline() schedules it again for the last group
with a target, so the blk_iolatency is freed with the work queued. Flush
it after the deactivation.

Fixes: 8a177a36da6c ("blk-iolatency: Fix inflight count imbalances and IO hangs on offline")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-iolatency.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 2caa79a008ad..c15b1aba606c 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -637,8 +637,9 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
 
 	timer_shutdown_sync(&blkiolat->timer);
-	flush_work(&blkiolat->enable_work);
 	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iolatency);
+	/* iolatency_pd_offline() schedules it for the last group with a target */
+	flush_work(&blkiolat->enable_work);
 	kfree(blkiolat);
 }
 
-- 
2.56.0

