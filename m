Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3377E105
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766434586; cv=none; b=DSa90qYGKHNUJ7RrYFrmn6blWnn7qRvOOkWaxjQeed4Oe2Y/v9/n5Ud7suw7wYDtowz8G8D0oDsVShWiPd9NrE90D+sLt4bZr8APlUodyHpvg4666ay8QaMrfg1iJx1oYIZ1W2ntD27hjnNa1uE+I9DCKeeVvfe5P/Wz54zMris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766434586; c=relaxed/simple;
	bh=3x2Lp7T3cj30BgxZkRxFd7fJ+xGEmQsAhJosfnJWiuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOFF2a+4YrJi4xtmkj96QK3i4kbntYtlH48r7VE//sRPjxJA9fzVTen/GeX/KnNgNRIxL14eAefh9QuDiwvH+0T6+dazdWNnhrcagToWJTLKYah68P4bqStFatmFyqDqWyBDjOMREDDM2/m9Exx/pbB2SnJ8fLF9+LDkHqLV+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJEg+tDL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJEg+tDL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a2ea96930cso48667005ad.2
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 12:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766434585; x=1767039385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMa3wSdMVGXj95ioxBEETokGr7K3zu5ogl1WC04RcvM=;
        b=bJEg+tDLBFTO7opn1G4RGReec6Azmzxr8iBknbErFPZXfCNBLPUMluBhvS85bNb71z
         NWM2SF4qmAETCuEeZrBcFU4Z/C+Vwah7HAhAPTvy7Yqik+YEmUcMtYzK04F5UL+0gy90
         bDC1f+6bAbbgYYWl6ZtIdjmzWvXfHDEEHkPeohbx10u+yQT9Btw97q+jsOjGFXbKZwO6
         PNVIJLv/EP0hHPV+u8mC4V7KBfnUsOBk6zX6jyj5q2KQuxbi3d8vJyZpth9Up+HSiak/
         556Z/F3KWEEfl4XxSi22at7SAOFwiqvCf8NULOmFWL18yBF8Nz+iN3WsPwwU18QWhjmr
         Go+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766434585; x=1767039385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BMa3wSdMVGXj95ioxBEETokGr7K3zu5ogl1WC04RcvM=;
        b=BEFGCcP4L2mfQ59N15D6VRP1SJjTseu3gCgWh4shgUDUbM7b5zxqEV0ivkoMMkBPVT
         8Rk4SBZbwMMuj3n1vMqrtsULLAjZJYpr1qUWVXZIxOGyCYQog4LB86FYWIDHwygEvHwh
         5zynGCzdIjGEnwbC6WE7J5K+Kd8Qe4Uvc1mS0pDfs9uJNJW5kMxzK4SYu0B8dHeeWz3d
         IuLzn1D2zY0NhVQ7xhOdXN5kLHCokFljX9PgCQqHrjBPSG/P7FSLB0n3fhEEiuqI7Wfe
         1abjwbO4xvzZbEXQX5j4Se4mMOjwwFP+vNqwIwibgpV3RqWRRGrllDtA16p36XjsBNbb
         m/vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtqI+qZYDtaI4VgL7IyZNRRn0dZ7/1fRJOddOOX1zSrdWXBJryovqzaVFTk9pBnjS+0EYZiKcHY2fIBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9h9cVtpR9ecjYCJHNp4PrKK/wImppc7iY6l3JpsgM6Uk1PqLv
	SsnO/c/EP808baMhdqqtBtZBV4ELGi2qr/wS7yl4ibrbvGRmBT3srduK
X-Gm-Gg: AY/fxX7JgWmQw2c1r/LjXDNVoJMm+RJB9Apjxvn/N2ZZWP3k1NaZbcnzyVM+TtTTser
	jWnEdJIn+EVep7zsF8oaUh+aXmndFwqWIJTv2xf/QBEFEhCF0JljDvl3dw7NeB2im5gZf6gAlUP
	3E/VrbBGOjN1mQQpwyhW/m6X8aYMLPCMgzu9mxJv+qJjQyGaDQL+3eOXFVQQNGrr5e3nkoVREfJ
	YyZ9aHytTgcpUlSJj42XAlgEuvQNEuKQkQ5AmZXGtqOnRXWhvWDPhV6Yq/mLamXeAEGAEM09udI
	rZM1Ay9jAfLLrCbe73Ew2QYr8zLQsdBQgx9UPALzj8EjpKUZWNSqud7UiiIlP/PWxk69aqtCMrd
	G4DztTi7K/IMRAm5WAgSLTOejowHAMnNt7NSgX/OfwuTBM+Ws05xFTpYsAagpLvEfU4XNtYfS1Y
	hV1a94y+Vkcc6P0pBcM+4Nf/eE9TOEtg5nCHv6ylFofFuo
X-Google-Smtp-Source: AGHT+IEuB211eJrtXYRtnAbPwZHFAJ3Laogx7YmJ49X41eVrFL8nNlqqmkk/chtEKcpdAsKs+c3xJw==
X-Received: by 2002:a17:903:2a8b:b0:2a0:823f:4da6 with SMTP id d9443c01a7336-2a2f2a34f28mr112442415ad.50.1766434584602;
        Mon, 22 Dec 2025 12:16:24 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f07:6016:fa00:48f6:1551:3b44:fd83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f330d25esm104358905ad.0.2025.12.22.12.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 12:16:24 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] block: Fix WARN_ON in blk_mq_run_hw_queue when called from interrupt context
Date: Mon, 22 Dec 2025 22:15:41 +0200
Message-ID: <20251222201541.11961-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222201541.11961-1-ionut.nechita@windriver.com>
References: <20251222201541.11961-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

Fix warning "WARN_ON_ONCE(!async && in_interrupt())" that occurs during
SCSI device scanning when blk_freeze_queue_start() calls blk_mq_run_hw_queues()
synchronously from interrupt context.

The issue happens during device removal/scanning when:
1. blk_mq_destroy_queue() -> blk_queue_start_drain()
2. blk_freeze_queue_start() calls blk_mq_run_hw_queues(q, false)
3. This triggers the warning in blk_mq_run_hw_queue() when in interrupt context

Change the synchronous call to asynchronous to avoid running in interrupt context.

Fixes: Warning in blk_mq_run_hw_queue+0x1fa/0x260
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5fb8da4958d0..ae152f7a6933 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -128,7 +128,7 @@ void blk_freeze_queue_start(struct request_queue *q)
 		percpu_ref_kill(&q->q_usage_counter);
 		mutex_unlock(&q->mq_freeze_lock);
 		if (queue_is_mq(q))
-			blk_mq_run_hw_queues(q, false);
+			blk_mq_run_hw_queues(q, true);
 	} else {
 		mutex_unlock(&q->mq_freeze_lock);
 	}
-- 
2.52.0

