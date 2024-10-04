Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4057814A0B3;
	Fri,  4 Oct 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036546; cv=none; b=IaOdOgPkp6b/NOiu8bcGi8Bf6IxM5nO+CmbnCOfu4YwgqDCpRfnbMMkhVs3PgFoxFdcbUP7awiJ2UCE1EaTu40ekWamxNkdTLp+rAOXQAvxUTyPw3gbYJWo0Qzq11/XvgRzvV05OVP1tsjfM4SnQ3nDzYtKeqMT5nruHlHIvssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036546; c=relaxed/simple;
	bh=j6qXLKpDGQeRpCfNbico8g5BsY6cHlUnTlu09Fb0fbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RqAxBVUS7ADrwDyeIW/oABCmWZ0+sU5h6RGoAK2eBWoPiEFlejADMmrHvq9Gpj4A+TeAyVA5xXBun17BTWvSK7v+WGf8Rx0jDNYA/ad566EoSWuMI5j+3enAg7eumSjtpf8rcmoyCkxRTy9O2mGBKIgxjEhNPwbOa8XQF1X7D4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzwWe9J7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzwWe9J7"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e07b031da3so1457855a91.3;
        Fri, 04 Oct 2024 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728036544; x=1728641344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9pWViwr4+F82iHmSuij8u/lyZyDWYC8oeY1h2VZpYSw=;
        b=hzwWe9J78SlBLtE5CAX0j7xN0R3vv2LOGIqnLjWGSfee1oNlzc3sd4kNEsLKXjS4Nh
         RBIfUEdSdSCZ7bBVCUYfk1lcoOtEL5j5mE9+EUo8wdRP8P/B4d0RI2UEQ5qZNL+DYx2N
         H8lO+uQOUNEYbLr+mu/M9Vvg+D/JLNOkapV7V/2tnY8dP40Yg57iY9BhOTIarUsWUi3x
         pRmDojfX20pvkIX3XHwbLplk9dRMGXtiAeRSwn+/LeYXuz53dCvqeCJbt10lW6DdaYW2
         JWWIbj5pGEv3Mn6AO8mGgRXpnVxL37n4u2KWaLm72XxZOInuaW94bQyO5MPzSgLnmcBt
         04Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728036544; x=1728641344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pWViwr4+F82iHmSuij8u/lyZyDWYC8oeY1h2VZpYSw=;
        b=UHHsku22+xK1DQxeop8wFPX3GXvUrqrIYy5R5nz6g1xkk2kdKBa9KTjrSfkdMdFuL7
         WpCItfPYfESreXNWUMKP/vwnRlMEONEafs+xRPVnkQWlfyDswM7H9uMgMZOzClQzeK36
         K8Z3nMT7/YyOEdQRuDbFwfkJ16m7VhkDvLkM1kTdQgMHl+5u37VhQ4mwRovy1xnHgukY
         KrC9o3WNNf0v0dci9zAjJQ746Tj2G7RibXXUCB2jFk9YjhSECkMJhrlwlxA4XiuzApHF
         rC3Nvvz9fTXiqnnIgKminTvPHMjynuAdjrDHR3qBLLzSTStZjvH1Gggabix1bUzRE31N
         rB7g==
X-Forwarded-Encrypted: i=1; AJvYcCVENamFgTioQurI6ig1d6XV/g/gB2Ru0sAV1vFygUNqLkveIwxWBVnO9UzPcC1aN9zwclmoSRmccQIuSyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmVwfymsLHyFD8FCC1K0UmP1Dki82rlFElqFq7SMIBVMqh9QP
	7wko6aBW6sdOGrLXYT6M7K9TNezAelMAVL17rotNKZw7ce/aEVZU
X-Google-Smtp-Source: AGHT+IEkp2Toit4P5rBU4WuD7W0gKQXlVhYCwnzITODhq8yhnVn6zo0z/FANWWNOC2mNiYtd72ErRQ==
X-Received: by 2002:a17:90b:3145:b0:2d3:dca0:89b7 with SMTP id 98e67ed59e1d1-2e1e620f0ffmr2396491a91.3.1728036544448;
        Fri, 04 Oct 2024 03:09:04 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2405:204:20:6275:2654:2317:92c7:7b80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e86652edsm1159221a91.36.2024.10.04.03.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:09:04 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: [PATCH] block: Fix uninitialized symbol 'bio' in blk_rq_prep_clone
Date: Fri,  4 Oct 2024 15:38:42 +0530
Message-Id: <20241004100842.9052-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the uninitialized symbol 'bio' in the function blk_rq_prep_clone
to resolve the following error:
block/blk-mq.c:3199 blk_rq_prep_clone() error: uninitialized symbol 'bio'.

Initialize 'bio' to NULL to prevent undefined behavior from uninitialized
access and safe cleanup in case of failure.

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940..b2087bdd9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3156,7 +3156,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		      int (*bio_ctr)(struct bio *, struct bio *, void *),
 		      void *data)
 {
-	struct bio *bio, *bio_src;
+	struct bio *bio = NULL, *bio_src;
 
 	if (!bs)
 		bs = &fs_bio_set;
-- 
2.34.1
