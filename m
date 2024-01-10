Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA91D683
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zxTEOKvd"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-360412acf3fso1733125ab.0
        for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 07:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704900741; x=1705505541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG7PWoitXlaGNdhJUptnqdH5K92EdOT7uIVeUMjSfPA=;
        b=zxTEOKvdi7MXZCQ1lEVc3XGcxDMU5gP47TXAUfuGrwniZbRYrWEyW8zOLNURjMo4l8
         j3M+6Ogpmol1bzaK7x0cVQ00WBOy2ViXg2L3pdkWz6nJB/jsMorGnQKZCbjRAc0BbHgl
         z3JW7QDlD/7Fi2wQAtZtcv3TnicQ3HII7UQdqKHeDUWT/ThPuoVMkcD04cTPfRVOI0c4
         yTaCoQmukG2HgZtU1KOu9jmdNvt92rCDp40ZhZLBwbjFNZ8a/jpNMh4Y1+YX41DF1tY7
         wc2HxMSKv48xZUYJYkG0/DGPkQsVlvf2LCLv924ewu12Srronwlk8UzglyTMCoJwuNvc
         4ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704900741; x=1705505541;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HG7PWoitXlaGNdhJUptnqdH5K92EdOT7uIVeUMjSfPA=;
        b=qrQwkKVVGvEMY+uhZDxw2S/43dA8LLgcHDgWaOI0JXPqjOrMyMKWASqeso0dzJDPKl
         f+c16Qpa9EQ9ZvJ+qCd/8/H4E0+KYNkxxjYDdzhBdYYdFMlFarCDtyOvMQsgt+geoW6D
         qA5D/RQ2PoA5P62Xe3s3qvJrApKvF5qcNzagY7TTMh6pgWLYzDmPiw13ihBldI5w1IdQ
         T0lhCSi6nIH0UbYJHYifopBHQ8DfjuQZ/v0eNP1bVbqvEGl8S8fhGr8X0MUA6ZJXODw8
         GJ+qTjBNby0v6H9RCgg+jfOWFNOzYDjF1DU/+S7iFSbra1mXbnMYXgYZNZgzMe007yL0
         347g==
X-Gm-Message-State: AOJu0YyLxV5g37LYM5xzC2sP2jH+tB5eQcwqeN5JcnKoE9dS1w2WaH5S
	aKKg5mAUGiI/xyZEVb8JLyENnYsDOQYmZ29Hhx7nphs3mIC+dg==
X-Google-Smtp-Source: AGHT+IH8MYpIwMww3DVkAo3fdCmPILr9wcBYPvYrBTQKXRMhYrqGmBd64QFHBttnMTFSghtTc+lGsw==
X-Received: by 2002:a6b:e318:0:b0:7bc:2c5:4f6a with SMTP id u24-20020a6be318000000b007bc02c54f6amr2726098ioc.1.1704900740810;
        Wed, 10 Jan 2024 07:32:20 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gt11-20020a0566382dcb00b0046e258abce0sm1346012jab.117.2024.01.10.07.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 07:32:20 -0800 (PST)
Message-ID: <06a7b6da-f3de-43cb-8ac5-bdd090a7d33b@kernel.dk>
Date: Wed, 10 Jan 2024 08:32:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block/iocost: silence warning on 'last_period' potentially
 being unused
Cc: Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

If CONFIG_TRACEPOINTS isn't enabled, we assign this variable but then
never use it. This can cause the compiler to complain about that:

block/blk-iocost.c:1264:6: warning: variable 'last_period' set but not used [-Wunused-but-set-variable]
 1264 |         u64 last_period, cur_period;
      |             ^

Rather than add ifdefs to guard this, just mark it __maybe_unused.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401102335.GiWdeIo9-lkp@intel.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 089fcb9cfce3..c8beec6d7df0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1261,7 +1261,7 @@ static void weight_updated(struct ioc_gq *iocg, struct ioc_now *now)
 static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
-	u64 last_period, cur_period;
+	u64 __maybe_unused last_period, cur_period;
 	u64 vtime, vtarget;
 	int i;
 
-- 
Jens Axboe

