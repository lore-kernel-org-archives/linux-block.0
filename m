Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748A71E51D;
	Thu, 31 Jul 2025 04:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753937400; cv=none; b=mgl7Bpwuk6A2DRoCmqwPeCXGjsXYunk0kjejZjNzZP1A4xZ7092hGdJYNIEOaGSqKV8HWNPiL/Cfg8f5SgnUrlS6sE++N/8Bf/f45SAIszcNKmztMVekZa/QG6U41vVUKS8OF/z9VvxCLCkT2G8I2San+9d4XVID2OnJVMFgkaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753937400; c=relaxed/simple;
	bh=+fB2bkRNyGcxN9GP3zXyYARl26p+USWz+4knIanRIrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pWoBVUI/asS2K9E0kRorjlBLFlygI/XrQOFfg95U2Mfuq8hnSZGtCifOricrk5EXFbvAacODoMotPjYk74jD4GLFMz48sDjx5v8XU3YM5c6/9aAS8dFA5d5M7EupEqWR6mDSs8wPVej1oOsByBKydepIkd2GAHG7cbCrB+HUI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRFowMqp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRFowMqp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-240418cbb8bso3448165ad.2;
        Wed, 30 Jul 2025 21:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753937398; x=1754542198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D1ha4mmeDP2q/s+7aUvqW50Enu5gjrDWFFR76rsmpUU=;
        b=lRFowMqpZxP9UMTETAGZ9m5a6FBU41uzh1F2ycuiLqQOt5MaBR6tQDELG6w+01jSLd
         WqErOf30YTtYrD7wqhGpYq60Mutt2UR4NfBlabh+QJFfddUCYRODlxBH4Y2odBThbgV3
         eaG/l00pSV66uBpp8FMVHQ/ejn8BFVbXPY4EHzOIR2LS6I6hBWHEmzK1LUAZA91gZKOI
         CscvmXeFR/dSr8wZouCnPkI+CICvifQqArWowtUONNn7/bSBSs2yxokqoc1B7zGUDDIh
         v8aTJH54guZMacD6i86JBe6nScpLASM4fUViRmgp2lg2lZIOOdM4fKPdzWJ5VqHgFLH1
         U3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753937398; x=1754542198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1ha4mmeDP2q/s+7aUvqW50Enu5gjrDWFFR76rsmpUU=;
        b=DZjj2nHGhSKEyvevV1P3Bklcn4M42S09IHzOA2Z2kFReOgxvy2VA1zD/TTPBGKmDuM
         hiRhwFLGrlJ4m5NvqIMayR2wACph1N2KDE+lj6BTTJ3TNgqK7hbuuLJSKz1bQfRGW2fx
         Qy7hvKVlaMGugu2slzAU9cLdd7KzabLyOKxLGDZ65KiDFtXraIiBCY5/Jyh4b8Pceqv6
         Tmrpheio9fnLeP3UssSVfz1QK94zQpUQZLfmZ0Uisz9HLiG+RPRowiB2LKr1+0punVmz
         aNT70umM5+rtDhTc8EQMBwjzlw6mETM0HStsrQIU4JOiM0pf6KLWZYhFdT5H9+sMhlnm
         nAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI6dCw1IMsajTOqPPIGSI0xNaHX5GQ4I6tL+a0Fs91jkCZUg28WCSOYYyTaruyV6NNV6bHPAg7LwfEWWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoaZPYHMNIuO8bzbV2rE7LSoilhFw9gnyEq0qtCRVpcKz9gBe
	dV/NFvnbkdkWUBDpMBVo6boIIKw7E/2CSmswr4vLHV8Me5jOdDaXD0xU
X-Gm-Gg: ASbGncvA/TzP9b5l4KHFT1OOi5c72XcEMCS8PJB4c/KToiczOHN7HBZgyZjmfartzGt
	eJLm8MAnPYH+XaLRj0XWHzojv2VliOrt2WdHiNsXJaTg7d47p9oRseIQJFhtc8Xj46lmuva0VGv
	Nzrwrvc1MWH0LNB9QVCUxKQPdkBf002mMofkn5XwR5/WrNuaB1I8xdSsw8aH+x7U/YAeAypSC55
	0MVIk61aIF1ZsM+CcUcx7Wieipy2zayt30332MF7LXpDDLIMjCUyfTAyInUzPpxFoqkg5b0wzwJ
	dMRY8JiQTyllB2oyadQYCTZFeripxF9v/KxQP+8hB55CF0FG+0PrEsvvWM8xrONfW+EuxlT1gLN
	qrRC03yYHCAN49sUJ74flqXlAnqx2AWvSf/8=
X-Google-Smtp-Source: AGHT+IGxB2+bcuxEBY18lgz5yA1ek3N9WgWuKxCg0dIYKvxtrf/5t3904j31rDji9XOJbwDs3V+KtQ==
X-Received: by 2002:a17:903:3b8b:b0:23f:cf96:3071 with SMTP id d9443c01a7336-24096b48bfcmr88683325ad.49.1753937397497;
        Wed, 30 Jul 2025 21:49:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976cbdsm6305425ad.75.2025.07.30.21.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 21:49:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block: Fix default IO priority if there is no IO context
Date: Wed, 30 Jul 2025 21:49:53 -0700
Message-ID: <20250731044953.1852690-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upstream commit 53889bcaf536 ("block: make __get_task_ioprio() easier to
read") changes the IO priority returned to the caller if no IO context
is defined for the task. Prior to this commit, the returned IO priority
was determined by task_nice_ioclass() and task_nice_ioprio(). Now it is
always IOPRIO_DEFAULT, which translates to IOPRIO_CLASS_NONE with priority
0. However, task_nice_ioclass() returns IOPRIO_CLASS_IDLE, IOPRIO_CLASS_RT,
or IOPRIO_CLASS_BE depending on the task scheduling policy, and
task_nice_ioprio() returns a value determined by task_nice(). This causes
regressions in test code checking the IO priority and class of IO
operations on tasks with no IO context.

Fix the problem by returning the IO priority calculated from
task_nice_ioclass() and task_nice_ioprio() if no IO context is defined
to match earlier behavior.

Fixes: 53889bcaf536 ("block: make __get_task_ioprio() easier to read")
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/ioprio.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index b25377b6ea98..5210e8371238 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -60,7 +60,8 @@ static inline int __get_task_ioprio(struct task_struct *p)
 	int prio;
 
 	if (!ioc)
-		return IOPRIO_DEFAULT;
+		return IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
+					 task_nice_ioprio(p));
 
 	if (p != current)
 		lockdep_assert_held(&p->alloc_lock);
-- 
2.45.2

