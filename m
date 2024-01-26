Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A2D24B22
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305116; cv=none; b=EbF1cLTXdS2uGyBW1PELXy7tT3iwIoAa+cec5IksiLQiXqbkk5uEbjb+pC9euFMZRe723nAK150+xqKit0+SZ2rwDzHE2fUunr9AV9o0gOthPs+7zP8uz4Dmo6tPnbyBGFes6K5w17wKFv9Pc7xiLA7+pve2s5hQTEP0pCkmc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305116; c=relaxed/simple;
	bh=HTudIpIK3itWqyWfjVO8Z8AkQ80u4AkYJtn0qK5Tv5I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gWd7ONoTuoqZ/LvN2JsdX6cisoyJHlb63b3dGrsAun7lTdDhFLzxpGE7kSCfrIy+HvTye0UzF7K3z2Cf6OAX3bd515BAKyS6N0nDSSDQw4nPPiNl+ERikVU/QISZWkcnrT5MTbP4+SnDYvXBVbQpjej8KfGsELIYIBDUv8tmd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ysikK6ly; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ysikK6ly"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bed82030faso13777439f.1
        for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 13:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706305110; x=1706909910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/DMMNlbmMmqxjGZVJqpmzEfSeq0xvTGdSlKRMr9Y5Q=;
        b=ysikK6lyx5JkpCX6bWhuW0GzUPaVlLEMBNbwvoL6cvJI0p1keV4IWgnii6MqppHgWp
         dB9sF4M2NCRIjkIeVWQ88K3oKh+ehSlCjrFsy4LKmnZaSpRsbuCmGfp0t8A+AHVXssmR
         Sylypi+ypdV0eCdDEGjFU/i68arcVLgmHtNtLG+j4ytZOSn1KcEV0AqxoKmH12Msev5L
         wbD6l2WXBfV6ZqNNAaiviQVTUeEOWYLjLBC1i/hvg+BwwjJigunQgxNhiHIeKxPwin6G
         LRJuQmdKrgcdYAjdhmnlIZNq8ooEOQzQERN3lFq8vPYEaALuHOjqBHwMtWMd0BVOjGc9
         qTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305110; x=1706909910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/DMMNlbmMmqxjGZVJqpmzEfSeq0xvTGdSlKRMr9Y5Q=;
        b=vIv+KoQ8Jds0iZDaNjTdo3xXi14kSVM2glsh6Ph/skKk3cavvcnggoiu2aCH8cTDih
         9ZFvjRyiH1sjM2gTQO/u3WJUAJ/U0btJG2CIdHUqzzUX371nnbJxoogpuoxqtJd7pQuP
         ddocJZco2AHiTz3pW7Fqw/sZXklf6sUk1f4sBjBsMY63bDFunq9ZQjodOwCdCnopy7ol
         s6HPMJ/Im2n6t18hNuLgZUXDQyIiAsCMJl0zVpn2qNWKTbCMwdqy8M/JCKSdGku0VbdV
         eW9RPYRiZPafUPDpyuEwTpURVL6+XBSmDcjYRLrqeCjdr+D6+OqFhPcSJ+w09gmI2hWa
         7TXw==
X-Gm-Message-State: AOJu0YwzbTQwTPM6+XYB9kOawtQ9LNRsTRuy/rZnFuWKK5OO+hdyZbxL
	28V9/xX0YYbmKxZRE3u9u3nEf4BlUc712SS7xFsHtJNNRHxZu+LzsdxVoYfzncRRoUNg3B43Z4+
	TZD4=
X-Google-Smtp-Source: AGHT+IGLpbmb9MGCMoKrTt2xoFEN9wBokpS7dvujUc+xEVO/e7rp2sLGYIHsb5r3vjlV5PNuhzIePA==
X-Received: by 2002:a6b:a02:0:b0:7bf:b9e0:c7c3 with SMTP id z2-20020a6b0a02000000b007bfb9e0c7c3mr915188ioi.2.1706305110554;
        Fri, 26 Jan 2024 13:38:30 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b4-20020a029a04000000b0046f34484578sm471788jal.126.2024.01.26.13.38.29
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:38:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET v5 0/4] Cache issue side time querying
Date: Fri, 26 Jan 2024 14:30:30 -0700
Message-ID: <20240126213827.2757115-1-axboe@kernel.dk>
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

 block/bfq-cgroup.c        | 14 ++++----
 block/bfq-iosched.c       | 28 ++++++++--------
 block/blk-cgroup.c        |  2 +-
 block/blk-cgroup.h        |  1 +
 block/blk-core.c          |  3 ++
 block/blk-flush.c         |  2 +-
 block/blk-iocost.c        |  8 ++---
 block/blk-iolatency.c     |  6 ++--
 block/blk-mq.c            | 16 +++++-----
 block/blk-throttle.c      |  6 ++--
 block/blk-wbt.c           |  6 ++--
 block/blk.h               | 67 +++++++++++++++++++++++++++++++++++++++
 include/linux/blk_types.h | 42 ------------------------
 include/linux/blkdev.h    | 17 ++++++++++
 include/linux/sched.h     |  2 +-
 kernel/sched/core.c       |  6 ++--
 16 files changed, 137 insertions(+), 89 deletions(-)

Since v4:
	- Move time related code to blk.h. This includes both the
	  previous cgroup related time code, but also the new code.
	- Drop last two patches
	- Ensure sched callback only calls io_wq_worker_running()
	  when PF_IO_WORKER is set.

-- 
Jens Axboe

