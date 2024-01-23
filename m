Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B237FBBF
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031198; cv=none; b=PK+QG6mmwpN3JX6b4tsNanBbHkQUEUPAYG5piW4aC+WXpC7eR40gU3rbazlWugNHtXLOP3rG71egJl4ACOzl+Yq+o+Qa+Qpthpx1TbymtIZlWO5OxKlsc93MWUr+PjgRvsabxdaUmOP5BgBKGUHUvb0oZErriGa7MgLFKhBqsu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031198; c=relaxed/simple;
	bh=dsgE1JNb3FnS9DgBHcr6EwMErVliqj5DqfjRcupawec=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KKOWeyMcFUrdGgjSTyxSOwy/4F2Zz2B6O4ojCaYXmABS/ZwICBT/VVLLdOZ1v63/pUyAVLC/3IlrwIFkRMD8aefsuFDf441CIx6la44NYSQV91nj2AcKQTYrchSGtW3/ZQlV7kKtboGaWA2d9Mz3soZS0Ak5qAuivhJ7y/LUqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w7t5BOpz; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w7t5BOpz"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bed82030faso59608139f.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031193; x=1706635993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8wHG/Shl23JE+9OjWqcgWkV68Z55K9I4Rj2rtgUyJs=;
        b=w7t5BOpzNmkH1wEQoueZnGU2Gy84Ijm5Dbpi75Oo5RWHACJh/12PXALcvW8Tk077Vs
         CCqyZ+L/rFhZ73hjKs9Y/BaZjPgNu2ZoTDcPJ2Vx9ICSzYlyUYFmtkwVslzZP7DIVvxT
         Lb4aSpt1lOOHjLZT+msrG8dVVyjZP4lYhEpNW3NqbBoPKz9i0v4I1tPepLeYpv23McLc
         Ig5W95G00a7weQAPVYUst2IFcAzMEKVHxeOWIZKTDI+vh05y1i8MBzn5bUAbT3WndB0f
         8ibzvWqE51ORlA70znU5sjIH/0Icfv134+/PTAecLUn57zstVC2+q3YyzeuAxzSyQG7F
         bRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031193; x=1706635993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8wHG/Shl23JE+9OjWqcgWkV68Z55K9I4Rj2rtgUyJs=;
        b=J5zfXPWvdyuYIh2h6GsvF45wJjKoOfsNnOEsnaOtLQtEW9nOmo9UlHvfaCkDJ/7eU9
         k0EWtDJFxBhZRN7QyCS1OeqZdN0h2dRYkjstn2VxQBfeyZbvvRMqBBb+7t5RkHoN/A2e
         QuMbMe225e8Z7xrW/IoBE1DuxghnlWoSm6FlviuBPrgiAJ9klSECZPfW9Rhch33c3L1P
         2cABY+37ltiZdwgbFnV2lvkYs+rfAU6wye89RIydxQWlsB524PPbrn1lUIHDFH2Q4PxL
         w9eXtBayIwpgMwjAhTtA9a2VtBDvZL2dvMeKnTKayuaeYP84sRl6+2El0h1n6MQDoGwA
         Z6+A==
X-Gm-Message-State: AOJu0YwpthRnDmpAZ2n9ldPSNMd7MIwLMJKP9TQAF6XFXT/JpTM2WfYl
	Rj5CZt8iVp7RTkgagWSyI6y7w3F+f5G91UcO5g9fY53tiEgaJhtfJwBjkx96VEdtJ+JQOPLGJU8
	mueY=
X-Google-Smtp-Source: AGHT+IG2OV/SS1QqfduJlf5u2DvUi8e3VftNAAk9QO+0irJxkohiuoApZEj5sEqypodvzzXJyQvUxw==
X-Received: by 2002:a05:6e02:1c4b:b0:35f:bc09:c56b with SMTP id d11-20020a056e021c4b00b0035fbc09c56bmr10733842ilg.2.1706031193559;
        Tue, 23 Jan 2024 09:33:13 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gu12-20020a0566382e0c00b0046df4450843sm3640708jab.50.2024.01.23.09.33.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:33:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET v4 0/6] Cache issue side time querying
Date: Tue, 23 Jan 2024 10:30:32 -0700
Message-ID: <20240123173310.1966157-1-axboe@kernel.dk>
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

	echo 0 > /sys/block/$DEV/queue/iostats
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

Results in patch 3, but tldr is a more than 9% improvement (108M -> 118M
IOPS) for my test case, which doesn't even enable most of the costly
block layer items that you'd typically find in a distro and which would
further increase the number of issue side time calls. This brings iostats
enabled _almost_ to the level of turning it off.

Can also be found in my block-issue-ts branch:

https://git.kernel.dk/cgit/linux/log/?h=block-issue-ts

 block/bfq-cgroup.c        | 14 +++---
 block/bfq-iosched.c       | 28 +++++------
 block/blk-cgroup.c        |  2 +-
 block/blk-core.c          | 33 +++++++------
 block/blk-flush.c         |  2 +-
 block/blk-iocost.c        |  8 ++--
 block/blk-iolatency.c     |  6 +--
 block/blk-mq.c            | 18 ++++----
 block/blk-throttle.c      |  6 +--
 block/blk-wbt.c           |  5 +-
 drivers/md/raid1-10.c     |  2 +-
 include/linux/blk_types.h | 42 -----------------
 include/linux/blkdev.h    | 97 ++++++++++++++++++++++++++++++++++++---
 include/linux/sched.h     |  2 +-
 kernel/sched/core.c       |  4 +-
 15 files changed, 160 insertions(+), 109 deletions(-)

Changes since v3:
	- Include a ktime_get() variant, and use that to convert the
	  remaining ktime user (BFQ)
	- Remove RFC label, I think this is ready to go
	- Rebase on 6.8-rc1

-- 
Jens Axboe

