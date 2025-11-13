Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C65B3321B8
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024058; cv=none; b=ia2hU7jWpDp7iAeRf+Xt8HEDGkk+qp9DTPJHNe/txE3x2vRsgdFHLBg5sErFlBDxR9Q2ApAqIRBHgs8k3OibmPxwwadqNX/F88q3mPPou72aEzo4LfTZhVEsq1PSnXxNtK4b4CNUOZ2MPKMUG24CRRQqkDlk0XXwW3+ZGSZJ3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024058; c=relaxed/simple;
	bh=Cy9k5PTF2jHawTbczSDqjkd6lnnaXLzDfsP+BCHK13g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkg/tolloKRIJMwM+apyda1BW57dcNTtkdIT24KdaodqTJVBVjCmyv1EFO2aMMvqF+r6FE0ABK8iZsrbrkl9Q4yhhP0/sl6FlspEjf2KlRlZNIw6EV9HgplEl8pUKwPVOR2zB5X6Ts9Kim2t10yNHZpNie2L8diDTALog8XxHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BIWJUEyo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BIWJUEyo"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso352855a12.0
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 00:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763024056; x=1763628856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpTnA2MUAj836lGOlG7UmadHMuhVvcz41++jJ9KkuhM=;
        b=BIWJUEyog4nkC7sB3MSt3OiOQ+PE9/ncxPH4Wqp5zmcfF7aBPD0ngPrjTgfydfqGt8
         i5Vyq3lqr2guYorcBhZC9pZRcIOieZ4bnZ54iqhsQ3BfCeWAAGtXhmfExKuuJk5wKxnP
         LKaYK92TP2NmRVDFz7oLcCFi64rvfQRM37uYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024056; x=1763628856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpTnA2MUAj836lGOlG7UmadHMuhVvcz41++jJ9KkuhM=;
        b=WIYzVPBFaczgw1gVeDa5yHWO9MbbOjoEZ9dxpKiZKcg5Gdr7Y7O0bDvFnSJpWMT3mo
         a1o9jXup8U81ubxqU+UCbdhU2b18WP2pAcZr7JuU9DMihNHqwcomjAL/Jk4aqClC8nXk
         ZFJehmujWmRGlGy6eIzYSdozkv+Vy726kf6Ss4LobwsGAKUx9kAbA7/BDAu6mS4f5lt2
         xcOfR3lfk26jKA3hQezdNd4QMZbUdGkn/Xc5XSwuZpxGBL3Ig9WXc5dW7O+LhhGi547t
         5TLiV+Lb969lmGX9gdp97f+ZTshYXZ+0oamUsSfdU9nVPoXzDODt1zqt9K5Sx0k7EAbE
         AioQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPxE5+LuOXsQO5vily3hxw1o0cWd3jXjB4PISP98ZZEl6SlsUZntFApLU6WvxfKe5RrOES+PlOpvnEjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxllEQCTLxml3xiaSluZ9bpU98Sj2d/eEtsAdgOkzLkRx6PspLn
	O/LHLZ6ZhBXvp+nV8vScNquQYq/mm6XCPtWBh95yla2KTnxN16i1R9g/gJF0Ai5r/Q==
X-Gm-Gg: ASbGncsoYzBUAty+/dFubYxndlET+3vUqo04RpDlQtdeRgCKVYJfaudddmk9m0ZkLQs
	lK8l5DWuGZ6G19Zu7QV0hi7D37dO1eNGsZddEEfVQaf3SPF+BQyiJeKvEkEYjKISjp0i4pvNSE4
	i+cSboNAl/putZGeRt+5EfwcJVR9MtnHdEBGpO9B8W2y1cP9LSDlTq9pmYjSWCy8aPf4ANQcSh7
	S+1Qbd26i8/YKywDXP+NMfZSFzs18+KkUPGfUPIl3i7cZQOOUonYdEpDXfcKOx5qqrRx5TG1S0N
	IeZAsh/kQcEbwjexWwTNorkuDib7qybEa5MirkK/3Wmm0xY3iMRfTMjdMsuQyCk6EcT14Q/OS5f
	P0MoKxGv0obSCEYTns7KzZbLSjPGZ8cHQtFRZrrWvGLp3R8bKRH9FAst1duN43mWwA/n1wLRqcP
	e4S6uLaoNakareNcyaOl4RMGu7Iho=
X-Google-Smtp-Source: AGHT+IGlRYtrFj/4YjKWjf1OzOHSeLUgv3Uc7+FXohdQ3S1q8hcdNvpoDApiTwcA0/LloW0V+MPPWw==
X-Received: by 2002:a17:903:19cf:b0:294:fcae:826 with SMTP id d9443c01a7336-2984edeedffmr89237465ad.59.1763024056517;
        Thu, 13 Nov 2025 00:54:16 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346f3sm17486465ad.18.2025.11.13.00.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:54:15 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/4] zram: introduce writeback bio batching
Date: Thu, 13 Nov 2025 17:53:58 +0900
Message-ID: <20251113085402.1811522-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a rework of Yuwen's patch [1] that adds writeback bio
batching support to zram, which can improve throughput of
writeback operation.

v1->v2:
- moved pp-slot ownership to req before submission (pp_ctl doesn't own it
  anymore after it's assigned to the req)
- do not take spin-lock in bach_limit handler
- dropped wb_limit_lock
- moved wb_limt accounting to pre-submit and completion stages
- introduced simple wb_limit helpers
- more comments and cleanups

[1] https://lore.kernel.org/linux-block/tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com/

Sergey Senozhatsky (3):
  zram: add writeback batch size device attr
  zram: take write lock in wb limit store handlers
  zram: drop wb_limit_lock

Yuwen Chen (1):
  zram: introduce writeback bio batching support

 drivers/block/zram/zram_drv.c | 410 +++++++++++++++++++++++++++-------
 drivers/block/zram/zram_drv.h |   2 +-
 2 files changed, 326 insertions(+), 86 deletions(-)

-- 
2.51.2.1041.gc1ab5b90ca-goog

