Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568714F9F9
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738338587; cv=none; b=GPneI71lbvsCgjUV4444b0B+4kgMPtkXycEUBDm6wMzpFvXQRMqvrS0Y8wcBukdxA6Wxx3SHIS+PJuIE4GO4y7GFf9huTAFFsehdbs7fwVcbTgjxn0ICW9mvoIQOcsUUHxPhRIU2+SzxFbo1S3ESmWbbWhi13CfxGan/t5gJG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738338587; c=relaxed/simple;
	bh=QcXLQ6QkuOa5j4rni40LWaWIs59DK9dodGyJ2NV5iQU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EmK+ktClQJK2lxZIWhY/PBT4AhLXV8dRowRW5WnmCzo/xj0LClBobP48507mwBQUBRwHMVx3M9k0drrUKharX3lD/gb2JjTcJFru5oUWCCUtTNNqCbMtkI49xFVLa0TAV3fVVsbZDw+3HQ7IHQ9ZDPTCQWJuZwSMhnxnKWSU1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RNODFtH8; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RNODFtH8"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso133053339f.0
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 07:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738338583; x=1738943383; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEX9s5Tj0cN5OKKTSEBZczG9iFoKIjx+3cotBGxiwaU=;
        b=RNODFtH8xt/xhJJKQAN/7aqxIdHvjx+oci58IZJ0HfWCkSTOS0UjO4EGrX2jc/tL6h
         CVn32RONERYJKr0jNYPVE3M7kuVQg6W/j9E8ps182N2rra6oD9cTmshhNB4VsTGXIMJD
         1CSqBRpXg7NzY9agUhx59ukLaXwnLqlc2cMYZo5UurHcs7bNUCeJltulWuMdmXm4FgfM
         4utdznhBNwKx/F45KgKWACTa2uBJbt8rQV8uo18yOrTIQAfQl3h5cgxXIaSqF5Yga0uC
         o+By/ag5mn33b2EA1tAz9zVMDV1YMbZ8xcjPjvsfp2Z6WqHMgY/664nvh9pXhbO7mJeX
         NofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738338583; x=1738943383;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XEX9s5Tj0cN5OKKTSEBZczG9iFoKIjx+3cotBGxiwaU=;
        b=qF5sEor34g1+UlqBVhA+s5PHZ5KTgdD/K+5TThdBEtvEtxo2HqAe2kXIWkrhr9ksIV
         n8xqK2Yj8vnGBEgk126Ehs+p1dRs8VbdX0Kd2LcoswMYZOz6YmO+JYC6VpQYIyRmhbDi
         Nk+DvLyGhVGE6T+9OWVyUV2TZ7h5CPAyTtBGwY6GWuyGfA7Ua4BhVuo80x3iKGLlgO4g
         5WhxmkASL5taBXVnG6oFk0aCvBrg0rChVMK8VaVEbV+zhNF+TMWf2lyPa0pl0ocO7Na/
         4dPsUpbEjjcVdouS8jPKpZ2Qd35mcAdmWhJZpD4KePvY83KglgAUPGxMVzOOq2b8QwT9
         5edg==
X-Gm-Message-State: AOJu0YxBRDr4eIiMF3SN3Wz1wzfziZml4fGOB4yFscvZ9xvAAFkt5swi
	YdqdxkfV/Kdgo8isat7Goles7wjTal4Iahe2FKPML9FR9ELANGJEZjDpxqOVdcwxO0FDcyIx6jj
	R
X-Gm-Gg: ASbGncu+IlDe75V7M1DKBAedPiXLnwuESYRNSvpx1eQHq/v2ouGBCofngtXR8/v2SBJ
	GEalXrPL6fKqi3d70mduHqty45+kfoPJEf061Qy49uJ9DsPPqkw3oHC+wWzlGbhV0uSGs1iQJZw
	UWBqzcAgOYW2dhU+Li2ktP1HoDkyP40qsnLbXxa34NlaiEbJgOFQZ1LKM6FV7t/k5fwrzHtj+0W
	bwEjzM4MNEGE3vbAkf/K/LP7Dhks8G53UUfTrQ6RQzUcH2tR61ofR9/K1+MKrNEvW+yW2bWO/zR
	4+PkcxTY1qA=
X-Google-Smtp-Source: AGHT+IG0OBgehopelAW8piPXHhzFNTr99VpQ2rR2zJiF3DkPtkjkLDkpZ3ejo2jMHRUEq/7zStjjfA==
X-Received: by 2002:a05:6e02:1fc3:b0:3cf:bb7d:ac13 with SMTP id e9e14a558f8ab-3cffe3a6eb6mr107515525ab.1.1738338582890;
        Fri, 31 Jan 2025 07:49:42 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746e2efesm872571173.134.2025.01.31.07.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 07:49:42 -0800 (PST)
Message-ID: <a86c3ab3-831e-44c3-acda-66f6fc4f5912@kernel.dk>
Date: Fri, 31 Jan 2025 08:49:41 -0700
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
Subject: [GIT PULL] Final block updates for 6.14-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Small collection of fixes and updates that should go into the 6.14-rc1
kernel release. This pull request contains:

- MD pull request via Song
	- Fix a md-cluster regression introduced
	
- More sysfs race fixes.

- Mark anything inside queue freezing as not being able to do IO for
  memory allocations.

- Fix for a regression introduced in loop in this merge window.

- Fix for a regression in queue mapping setups introduced in this merge
  window.

- Fix for the block dio fops attempting an iov_iter revert upton getting
  -EIOCBQUEUED on the read side. This one is going to stable as well.

Please pull!


The following changes since commit 7004a2e46d1693848370809aa3d9c340a209edbb:

  Merge tag 'linux_kselftest-nolibc-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2025-01-22 12:36:16 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.14-20250131

for you to fetch changes up to 1e1a9cecfab3f22ebef0a976f849c87be8d03c1c:

  block: force noio scope in blk_mq_freeze_queue (2025-01-31 07:20:08 -0700)

----------------------------------------------------------------
block-6.14-20250131

----------------------------------------------------------------
Christoph Hellwig (2):
      loop: don't clear LO_FLAGS_PARTSCAN on LOOP_SET_STATUS{,64}
      block: force noio scope in blk_mq_freeze_queue

Daniel Wagner (1):
      blk-mq: create correct map for fallback case

Jens Axboe (2):
      block: don't revert iter for -EIOCBQUEUED
      Merge tag 'md-6.14-20250124' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-6.14

Nilay Shroff (2):
      block: get rid of request queue ->sysfs_dir_lock
      block: fix nr_hw_queue update racing with disk addition/removal

Yu Kuai (1):
      md/md-bitmap: Synchronize bitmap_get_stats() with bitmap lifetime

 block/blk-cgroup.c            | 10 ++++++----
 block/blk-core.c              |  1 -
 block/blk-ia-ranges.c         |  4 ----
 block/blk-iocost.c            | 14 ++++++++------
 block/blk-iolatency.c         |  6 ++++--
 block/blk-mq-cpumap.c         |  3 +--
 block/blk-mq-sysfs.c          | 40 ++++++++++++++--------------------------
 block/blk-mq.c                | 21 +++++++++++++--------
 block/blk-pm.c                |  2 +-
 block/blk-rq-qos.c            | 12 +++++++-----
 block/blk-settings.c          |  5 +++--
 block/blk-sysfs.c             | 13 +++----------
 block/blk-throttle.c          |  5 +++--
 block/blk-zoned.c             |  5 +++--
 block/elevator.c              | 16 ++++++++++------
 block/fops.c                  |  5 +++--
 drivers/block/aoe/aoedev.c    |  5 +++--
 drivers/block/ataflop.c       |  5 +++--
 drivers/block/loop.c          | 23 +++++++++++++----------
 drivers/block/nbd.c           |  7 ++++---
 drivers/block/rbd.c           |  5 +++--
 drivers/block/sunvdc.c        |  5 +++--
 drivers/block/swim3.c         |  5 +++--
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/md/md-bitmap.c        |  5 ++++-
 drivers/md/md.c               |  5 +++++
 drivers/mtd/mtd_blkdevs.c     |  5 +++--
 drivers/nvme/host/core.c      | 17 ++++++++++-------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/scsi/scsi_lib.c       |  5 +++--
 drivers/scsi/scsi_scan.c      |  5 +++--
 drivers/ufs/core/ufs-sysfs.c  |  7 +++++--
 include/linux/blk-mq.h        | 18 ++++++++++++++++--
 include/linux/blkdev.h        |  3 ---
 34 files changed, 164 insertions(+), 130 deletions(-)

-- 
Jens Axboe

