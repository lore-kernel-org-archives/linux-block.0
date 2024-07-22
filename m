Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D57716D9C6
	for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656633; cv=none; b=rkXm+vQ+Ql/hW83jWZmEzzczAVPtLdXeswimwZ0mehDAFbkZ46/IVltmEZ/gyfgtzbdWMv73bO/ZmsG/dNBHCgy+Ei68w5OxyKIWW27dqv2lkjCMKoUbj3pp+BhaxVgmd4RT4ngA22oHTgfaz+f1JvikbK0b8QAWCDN9VVan0G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656633; c=relaxed/simple;
	bh=eYSh8jI4hweP8NnvZkr/LQy4UID6pERkGFTbGnYC9GM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=egvb42i1odaKvX9/FvXZ6d2LHeLONubPZMxzhiZHMQ1IjeWP6Hvq0/iIyrpa9o7C6ihRoN5Y4IzcJXFoczfoJZYPzj2xqYCIwxpr/lq4/onkbiPk7vmABRkj6EXnCp2TpLT8mZYMevjO8dgWJMwHlVvDmM6QPDOkU9NSEY3vg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Wx+0d5E+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Wx+0d5E+"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70378348d59so210866a34.1
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721656629; x=1722261429; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvI3GQ4C89Lan7kG6Dr+E3WKZclgag45bdH3FgwbtcY=;
        b=Wx+0d5E+t+YfOOojyKo33KU/qMydoTf7j6KMR2gjMlVL9Jq+d0saiadln2yz4sUePY
         W61oGo/b3t1zfWDsriFDpjVVzWszjie4Fei9tYhLHt23sYWz/hUcjF4oQb6BF94UQMUo
         ESWtPTqUb7HEzuHzAXm2KROz903Y2ps9EnaFbQ+OwVhvWAJPaE4k5p4LiFzwcuNIbfJA
         Rv2fRSr3qAVNaSqv1oCqN5G12/S3tV3a5QQNYvH22CIjBMpDJSLKcyjNgw5VWMU0maQm
         zsQxuafaNGBIU5zKJs2rKQZ1GdMWpUzhTUpbn3h9q5ixJVQStV4SCI+mUgbTzePlvXHm
         UARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721656629; x=1722261429;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MvI3GQ4C89Lan7kG6Dr+E3WKZclgag45bdH3FgwbtcY=;
        b=kLuzeqPT/2xxjU2b7zX3V4gxWiHlpIQWdvhCoFLIp0kaaHaNBcFUYg5w8YuawxmzAH
         nDYKQsoko9R43OvVvr/nhfKpV3lwpq9jOAjoDB5Wtk8ZgnJn+WXnK2K9HMXDTBU5QV8C
         8DFKNiovGDQxoDQphxw7WbeBnfxEb8p5M31cTs/y/wfm3EyytUrXKMsv363PEp/5d5IQ
         M6nquUDiSsUqfAZSkGeYmMRBfv82BaDe8MTvG5x8LhNSQh9ToWblZtyJq7E+ViOg8U9H
         NO3ABlrgjhTWmB6Denrc03nwVMExeylo6FN6ibZnK8pNvn1RewXBxU1WGWm0dO3ZKpvE
         cPVQ==
X-Gm-Message-State: AOJu0YyAZtiGlhrcqC9+lFZKnfaLsERbjXGegSJGTjLdWg9rulljoMXf
	PShz6wQOn6tpsHGYTh+3hyW08QoADYNK5BHt4Q4uPwJ9vA+6Re8qaxto8QhttiIg3yE1XOOlszF
	TJEM=
X-Google-Smtp-Source: AGHT+IE61axABVzr1TpBY10aSHTIdhBacRTtSjX5onvj35gWtniCuAyztaowfEeRN62QzRvAII5Tow==
X-Received: by 2002:a05:6871:295:b0:25e:14d9:da27 with SMTP id 586e51a60fabf-261210889c2mr4333290fac.0.1721656628985;
        Mon, 22 Jul 2024 06:57:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff49159bsm5347733b3a.21.2024.07.22.06.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 06:57:08 -0700 (PDT)
Message-ID: <505fe3f1-27bb-4791-b4c2-12c99d0da624@kernel.dk>
Date: Mon, 22 Jul 2024 07:57:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Follow-up block changes for 6.11-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Set of updates for the block side that weren't ready by the time I had
to close up the initial 6.11-rc pull request, due to being away on
vacation. This pull request contains:

- MD fixes via Song
	- md-cluster fixes (Heming Zhao)
	- raid1 fix (Mateusz Jończyk)

- s390/dasd module description (Jeff) 

- Series cleaning up and hardening the blk-mq debugfs flag handling
  (John, Christoph)

- blk-cgroup cleanup (Xiu)

- Error polled IO attempts if backend doesn't support it (hexue)

- Fix for an sbitmap hang (Yang)

Please pull!


The following changes since commit 3c1743a685b19bc17cf65af4a2eb149fd3b15c50:

  floppy: add missing MODULE_DESCRIPTION() macro (2024-07-10 00:22:03 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git for-6.11/block

for you to fetch changes up to 89ed6c9ac69ec398ccb648f5f675b43e8ca679ca:

  blk-cgroup: move congestion_count to struct blkcg (2024-07-19 09:40:07 -0600)

----------------------------------------------------------------
Carlos López (1):
      s390/dasd: fix error checks in dasd_copy_pair_store()

Christoph Hellwig (1):
      block: remove QUEUE_FLAG_STOPPED

Heming Zhao (2):
      md-cluster: fix hanging issue while a new disk adding
      md-cluster: fix no recovery job when adding/re-adding a disk

Jeff Johnson (1):
      s390/dasd: add missing MODULE_DESCRIPTION() macros

Jens Axboe (1):
      Merge tag 'md-6.11-20240712' of git://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.11/block

John Garry (14):
      block: Add missing entries from cmd_flag_name[]
      block: Add zone write plugging entry to rqf_name[]
      block: Add missing entry to hctx_flag_name[]
      block: Relocate BLK_MQ_CPU_WORK_BATCH
      block: Relocate BLK_MQ_MAX_DEPTH
      block: Make QUEUE_FLAG_x as an enum
      block: Catch possible entries missing from blk_queue_flag_name[]
      block: Catch possible entries missing from hctx_state_name[]
      block: Catch possible entries missing from hctx_flag_name[]
      block: Catch possible entries missing from alloc_policy_name[]
      block: Catch possible entries missing from cmd_flag_name[]
      block: Use enum to define RQF_x bit indexes
      block: Simplify definition of RQF_NAME()
      block: Catch possible entries missing from rqf_name[]

Mateusz Jończyk (1):
      md/raid1: set max_sectors during early return from choose_slow_rdev()

Xiu Jianfeng (1):
      blk-cgroup: move congestion_count to struct blkcg

Yang Yang (1):
      sbitmap: fix io hung due to race on sbitmap_word::cleared

hexue (1):
      block: avoid polling configuration errors

 block/blk-cgroup.c               |   7 ++-
 block/blk-cgroup.h               |  10 +--
 block/blk-core.c                 |   5 +-
 block/blk-mq-debugfs.c           |  26 ++++++--
 block/blk-mq.h                   |   2 +
 drivers/md/md-cluster.c          |  49 ++++++++++++---
 drivers/md/md-cluster.h          |   2 +
 drivers/md/md.c                  |  17 +++++-
 drivers/md/raid1.c               |   1 +
 drivers/s390/block/dasd_devmap.c |  10 ++-
 drivers/s390/block/dasd_diag.c   |   1 +
 drivers/s390/block/dasd_eckd.c   |   1 +
 drivers/s390/block/dasd_fba.c    |   1 +
 include/linux/blk-mq.h           | 127 ++++++++++++++++++++++++---------------
 include/linux/blk_types.h        |   1 +
 include/linux/blkdev.h           |  31 +++++-----
 include/linux/cgroup-defs.h      |   3 -
 include/linux/sbitmap.h          |   5 ++
 lib/sbitmap.c                    |  36 ++++++++---
 19 files changed, 233 insertions(+), 102 deletions(-)

-- 
Jens Axboe

