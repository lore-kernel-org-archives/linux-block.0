Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CDC2E3F5
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605832; cv=none; b=vFOrCmcLq1yyOeozWBVlcq8Q7gTUEvWltWZ82jY+ngrMPhvT+WQGfIU2EZKDJ6eaeJD9JlipjPGvpdzR2aAYjKRqM7YF4kuMsib4/BiP7AczSIrrOSiVYJUdoNu27247E6Ndbb0ZaOcGobjp8MOYLQwraOyWiSs6q/bXAAWobkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605832; c=relaxed/simple;
	bh=Yp0E2AgSbasub0nPNig18BzWpbGNPiHp5vfLLAGw0Eg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=M/n6c5KfHntGTFT9tkqQyUy3fM7+Ry1LAWchby7gBymMD3nzcMMJPcX8xlsR05b1+LW+01IoDd2Il1oELgt9XeOlqeQm7tLqt0A/Dndmw7KWWBlecWO3SFFa7NRCkxaS6D/t6J9Z/nul3ZxVwc9vHtwM6E8/hjVISCrhWjifHRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FtntKtuF; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FtntKtuF"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bee01886baso50331239f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 11:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705605828; x=1706210628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw/EBgf3QFgrXF9/RJBSlupid0w7/Gbvv5V64k+/wBY=;
        b=FtntKtuFExYeeCi/O24QB2U48ZKxxyGudT2LMIllGgz9wZetpcM8O2aa3FXUyOpSnA
         x5dZh201sNcfuEEI6kDDorbyJxXpLpNK9QPKk9UX3ZAt4h9nq4kmD3HuX7VRD73acu37
         mS1kwyImCFUz5XDzLSv7ILDtrdXIvMjFu9F33kcrgBB6f220g49DqzmT0/5BUEEkRroI
         tS8FoJKF7CXexU+PN8ELTLvUT8AuBkQZcfbm0no8m91kWja9Mr29OfGmPhzxIjiKPYvS
         uwYP4diXM9oKt4nQg7Vm4rfRWEdMkhWsCzwuH058d8y0wS/Hsm4vBie4m8moc0aVNJ8n
         tVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605828; x=1706210628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw/EBgf3QFgrXF9/RJBSlupid0w7/Gbvv5V64k+/wBY=;
        b=KemSyRmRDA01b4ITdyB8szN7mFzfZ3++O/DnPI8aGPVvPXyDtTdpzgLpoPQlmJFHc7
         2JjuAngK0pfmgXPfS3rvoY0+phtHz8hQuSlv0rLthuHQ81vDeTidBUQWRtmh9ZQnWXfr
         pXika/ABHCNKEnqSl70Uc1U97r9QWLvdiAv4/hjFjHeeuzEDADRSCqv63Lq1r/kLeBhw
         vwT1phsmaKnLoX75d0FHL+AHfTxq3+mJe31W+VJRYTWyuLWRyTalWNohqOCLtA+ZORsZ
         0MNTtYQkKDoswVg02wsOedcGHOISg3oOapo39Ta/WkF4nGsjwUyNcT6SLwdQWPsTYM1n
         +viQ==
X-Gm-Message-State: AOJu0Yyfc7QKeAahnGDt4IHoDSqZae3cH3ondqpWXu7pPEervh6fSR07
	LkX4LbfiCMuxlrj17JGWhohnzpW0PYx6MBDUKXj2M4PyeX6BgTQQPmEIbM6b1d6qccdwe5vOQhD
	qo3s=
X-Google-Smtp-Source: AGHT+IH4S1mpxXN35s35RC65Kcbl7r9DKsdPn/OAxVzhOF/3VxZCHT451dq8UnNMr44qkbRtiCj/2g==
X-Received: by 2002:a5d:8b50:0:b0:7bf:7374:edd2 with SMTP id c16-20020a5d8b50000000b007bf7374edd2mr396050iot.0.1705605827788;
        Thu, 18 Jan 2024 11:23:47 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gc18-20020a056638671200b0046e5c69376asm1155588jab.40.2024.01.18.11.23.47
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:23:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET RFC v3 0/6] Cache issue side time querying
Date: Thu, 18 Jan 2024 12:20:51 -0700
Message-ID: <20240118192343.953539-1-axboe@kernel.dk>
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

Results in patch 2, but tldr is a more than 9% improvement (108M -> 118M
IOPS) for my test case, which doesn't even enable most of the costly
block layer items that you'd typically find in a distro and which would
further increase the number of issue side time calls. This brings iostats
enabled _almost_ to the level of turning it off.

Can also be found in my block-issue-ts branch:

https://git.kernel.dk/cgit/linux/log/?h=block-issue-ts

 block/bfq-cgroup.c        | 14 +++---
 block/bfq-iosched.c       | 22 +++++-----
 block/blk-cgroup.c        |  2 +-
 block/blk-core.c          | 33 ++++++++------
 block/blk-flush.c         |  2 +-
 block/blk-iocost.c        |  6 +--
 block/blk-iolatency.c     |  6 +--
 block/blk-mq.c            | 18 ++++----
 block/blk-throttle.c      |  6 +--
 block/blk-wbt.c           |  5 +--
 drivers/md/raid1-10.c     |  2 +-
 include/linux/blk_types.h | 42 ------------------
 include/linux/blkdev.h    | 92 ++++++++++++++++++++++++++++++++++++---
 include/linux/sched.h     |  2 +-
 kernel/sched/core.c       |  4 +-
 15 files changed, 151 insertions(+), 105 deletions(-)

Changes since v2:
	- Ensure PF_BLOCK_TS is cleared when plug is flushed or
	  invalidated
	- Fix missing raid1-10 conversion
	- Fix missing cgroup timestamp

-- 
Jens Axboe

