Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF561B592
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r85/Rjue"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9bd8adb9aso1276415b3a.0
        for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 13:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705355924; x=1705960724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsPJ0Pbz+SWubeOI00LlXhtiW5HQ2K/NFgwKhiC8gwU=;
        b=r85/Rjue25HAvmLWvH5of3ouwVJV9tZyk/1Ui7DCNBPgshatofD2Z4Mp5WYaiqN23C
         oHsY5gSVnXkriTtCIDic+QJMj+DJCctyUFuAaoSqwMl/fH+rNBo8wN3hdfRrMPArQtz/
         jcDW6fWzCkcUweP97QJSfONzXneXSft+UtThEHaLik1bTcXjnvQ3uHqxllbk4MKEETtn
         E39V5khg2xp6v3ogz+aFso6Fe1o2uRP4TWFV24dHQNjkXyk7OAulYReJ77DDKsQvMuzI
         yxdZ1Y4lO416jZH4CxFRH+CszI6ENlbHplKYzmp4z51MZqEycNUpMBxOVnGqBYZ9aECF
         FpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705355924; x=1705960724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsPJ0Pbz+SWubeOI00LlXhtiW5HQ2K/NFgwKhiC8gwU=;
        b=COis0QAg9yoWo5am/TKAD/z+twTRqXFXYvNjIoRip/C4BOdhfeDPZcyLeJiQGNgrKp
         3c7Mnrldt8z4aOjBug8I6tQSdIKqxU4yB0KrmsEPuiD375c6EjsCC+G3xyZeXyMw0OQQ
         Fw1vVwX9a3FUTmuMFXlCvvirMJrvODUfiUBxKRnRg/Vk5m9fOUwAq8LULaX0DL2K7S1C
         3xrFrlynxudSfyv4ot3ChVva4bc3vj7bHqklQurc2HDYKwg19wGltu4CcBXoi7o5dGBo
         esf15g4d5tPm0tihmUV/a66t0r7xF22B6/ToqzRmOtE1D1bNmav7Ub5oV6/3M3yDOH1h
         E8kg==
X-Gm-Message-State: AOJu0YyDURllRkp97vWo4PGhYoz3h6xgLlOkVVncAKXO9Xunh3WsX8b1
	AweR4K9FN7ezw+oYKMJjH7ZAjQN/RWC1Wv09Gd/a3Ch429PWdg==
X-Google-Smtp-Source: AGHT+IHdgsJCqI71bANJgLmTzpayHQAJXWwCp2L9jMMI3lwK8bg+YAoqf4GY5UYn7TDsn0U85dhLjw==
X-Received: by 2002:a05:6a00:2d94:b0:6da:83a2:1d5e with SMTP id fb20-20020a056a002d9400b006da83a21d5emr14274689pfb.2.1705355924131;
        Mon, 15 Jan 2024 13:58:44 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id o6-20020a056a001b4600b006d98505dacasm8072764pfv.132.2024.01.15.13.58.43
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 13:58:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET RFC 0/2] Cache issue side time querying
Date: Mon, 15 Jan 2024 14:53:53 -0700
Message-ID: <20240115215840.54432-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

When I run my peak testing to see if we've regressed, my test script
always does:

	echo 1 > /sys/block/$DEV/queue/iostats
	echo 2 > /sys/block/$DEV/queue/nomerges

for each device being used. It's unfortunate that we need to disable
iostats, but without doing that, I lose about 12% performance. The main
reason for that is the time querying we need to do, when iostats are
enabled. As it turns out, lots of other block code is quite trigger
happy with querying time as well. We do have some nice batching in place
which helps ammortize that, but it's not perfect.

This trivial patchset simply caches the current time in struct blk_plug,
on the premise that any issue side time querying can get adequate
granularity through that. Nobody really needs nsec granularity on the
timestamp.

Results in patch 2, but tldr is a more than 6% improvement (108M -> 115M
IOPS) for my test case, which doesn't even enable most of the costly
block layer items that you'd typically find in a distro and which would
further increase the number of issue side time calls.

-- 
Jens Axboe

