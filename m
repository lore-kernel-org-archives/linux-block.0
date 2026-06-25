Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A13DE441
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389583; cv=none; b=aXV/Hi60J2R33DOyNiISrc3ojDMF0kQXL1pAmbU9QcRxAmHeYjTSFg1D/O7IBrxf2rsY9dK0I0AX8rk8IXBrH6+CYGD9ZV+/FjPQkqdnzxK67bfoiKc0OO4UL7DQUAMYzICm9IbAMXcICXgPPl9pkRjRJIrClL7xDcrXKY8ovC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389583; c=relaxed/simple;
	bh=piyhvVRF2o5qkWdv9VHrw7KH971unzy1EizWAFScplc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aU2pn/1I+ya+G9qU5BBL3ZAZuDHSGtlDwIHsuObSwUxHb0gp2rEWYxztGW0F7GZRThjqqsyFLHRFqAniWIk6h3Oj/9zeUJzMJP3LedODIzyHekmur3OD7y0NiJUkdOmzTC/N9ElM0SswngDwsSHM0lEqaWOLUSYNjl8PwOU2trs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=0AYx4mg+; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="0AYx4mg+"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69ed219d3ecso1804020eaf.2
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782389580; x=1782994380; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X83ZKO5ToGT8Mms8qw+hG9bge2Vx2dZqTdYISy8g4Vc=;
        b=0AYx4mg++rY2oJVwlLC5ig3nvfqcYpNBleI7gK4sOUmqEbQQ4OtlmgIx9kE/lG4KO3
         Fkzy9BphsXmaNpBc6rEzh9rLRq+/HQ5pysX0Ht1b9Aygw9vMbfzaKwjInUUHwncydDz+
         r0Ta/lWL0jcQzJF3o34NnuErSiJwUga3p74ZQTO8LJMeCbioT6xXoRlSe+Q8z74KFCrJ
         YBp6XdWTZRUBz8Mn/GkVJqpn5a6i4ZiDURF1SYzd0y3/wZOTOTjQsQwRr3c88bLpclAM
         YQBDdKrJUnWp7768uOBKDjRAARnjRxmYujPHzHkk9q2nYXiUgwKuspcn9Kwk8hPNkIZS
         /8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389580; x=1782994380;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X83ZKO5ToGT8Mms8qw+hG9bge2Vx2dZqTdYISy8g4Vc=;
        b=opl5U2yFsmwIqtCwdyECgxo85lD/Pfr19c8qnodMsmwRyFidKB0Ynuh8+z/KlQjpIw
         HaOFtkxxeF9lXNl00GtdkCkUcxTJUe4Edjk81CjgTWYI7ZmPrF3/cWuQH3dKwiDs1nvc
         mz3L1Bsk0gUwawCrz9LdgudUwSrsRmgHqmAx4mAo/LwkO1y4GB/N25AG1e/1xn9scHlF
         dYxwVIGltgBt0VCb0t3hIHgosviZCtjFRqFiSdR6guaXuA8rn4nfscrhgoGx/w7212cC
         8DcgNkbDi83zte3GG0GrN04SQ8hnmNrnyRbT+yBYp6Hg1jnvh9ej3FY5iEqlTlpXCD0P
         OnPA==
X-Gm-Message-State: AOJu0Yzq/vzJJg6tTElEJwZxRh5nAXeEAkpNWxQN+MjtEPEzHjSr+7sK
	jMO3xBdffqddaoaw4StT3HtSlt7H+59JZbLiR42vcE4/YtIsPTZs+4SROW6TC4ScYUZ6KGD4HIv
	651SGNPs=
X-Gm-Gg: AfdE7cl9ZnkDTLVcqSY9sGSwbtqmNAbXNE8pdC+2N1eLVQ9xDmMAAjn8xAIpGzrBV6l
	lJnvf9VilpaHvzQItk5+yx06K5uVU3HssRHNw4FNvGQPk43oTU4wNzXgpEn/bHKb3nyAchY1h23
	ueSoxotVAgsw2hH7ECsFdzwaZCmyK0njLVCpfEMELsxlCfzLxqX/rfMAuCeTgx2YYub3+iuVKQj
	a9Y6tOu+TJBiOLcIi23eLkYEvZyjr6YKCLg+wVun6TjpMSNoF1kz5BpcODGlZ2EWcQysdx39/u1
	iLN/o8wxV0Ly4k8dnnfSSd/DA+64RUqVux6JJl5lF16CFpQ6HwlNqbMpHQYV7F6GlH99UcDRqTe
	j8rGna3iSpqFV2dQ/z83v2ci9DyEZC5Sxcbt5Kg3xfoJtSHojQNo/uCpNWyh/ha7C5Yuy/cCrG5
	AY5NEkMwE7cI/sXBq33FCQxMbYcVqObCpfJ04xtj1+ZnaMGgdy71DXoW13DQfUrue2ZTgZIW0=
X-Received: by 2002:a05:6820:808:b0:6a1:17f6:d790 with SMTP id 006d021491bc7-6a13518837fmr1891560eaf.20.1782389580344;
        Thu, 25 Jun 2026 05:13:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9f2a4e9sm10606571eaf.2.2026.06.25.05.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 05:12:59 -0700 (PDT)
Message-ID: <824a5290-065f-4e38-ab38-2a4ac86f020f@kernel.dk>
Date: Thu, 25 Jun 2026 06:12:58 -0600
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
Subject: [GIT PULL] block fixes for 7.2-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

A set of changes queued up after the initial merge window PR, and fixes
etc that came in during the merge window. This pull request contains:

- blk-cgroup locking rework and fixes: fix a use-after-free in
  __blkcg_rstat_flush(), defer freeing policy data until after an RCU
  grace period, defer the blkcg css_put until the blkg is unlinked from
  the queue, and a series unwinding the queue_lock nesting under RCU /
  blkcg->lock across the lookup, create, associate and destroy paths.

- NVMe fixes via Keith:
	- Fix a crash and memory leak during invalid cdev teardown, and
	  related cdev cleanups (Maurizio, John)
	- nvmet fixes: handle TCP_CLOSING in the tcp state_change
	  handler, reject short AUTH_RECEIVE buffers, handle inline data
	  with a nonzero offset in rdma, fix an sq refcount leak, and
	  allocate ana_state with the port
	  (Maurizio, Michael, Bryam, Wentao, Rosen)
	- nvme-fc fix to not cancel requests on an IO target before it is
	  initialized (Mohamed)
	- nvme-apple fix to prevent shared tags across queues on Apple A11
	  (Nick)
	- Various smaller fixes and cleanups (John)

- MD fixes via Yu Kuai:
	- raid1/raid10 fixes for writes_pending and barrier reference
	  leaks on write and discard failures, plus REQ_NOWAIT handling
	  fixes (Abd-Alrhman)
	- raid5 discard accounting and validation, and a batch of fixes
	  for stripe batch races (Yu Kuai, Chen)
	- Protect raid1 head_position during read balancing (Chen)

- block bio-integrity fixes: correct an error injection static key
  decrement, fix GFP flag confusion in bio_integrity_alloc_buf(), and
  handle REQ_OP_ZONE_APPEND in __bio_integrity_action() (Christoph)

- Fixes for bio_iov_iter_bounce_write(): revert the iov_iter after a
  short copy, and respect the iov_iter nofault flag (Qu)

- Invalidate the cached plug timestamp after a task switch, and clear
  PF_BLOCK_TS in copy_process() (Usama)

- Fix the IORING_URING_CMD_REISSUE flags check in blkdev_uring_cmd()
  (Yitang)

- Remove a redundant plug in __submit_bio() (Wen)

- Don't warn when reclassifying a busy socket lock in nbd (Deepanshu)

Please pull!


The following changes since commit 6b5a2b7d9bc156e505f09e698d85d6a1547c1206:

  Merge tag 'trace-tools-v7.2' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace (2026-06-16 17:50:34 +0530)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260625

for you to fetch changes up to a1c8bdbbd72564cebb0d02948c1ed57b80b2e773:

  block: handle REQ_OP_ZONE_APPEND in __bio_integrity_action (2026-06-24 06:53:25 -0600)

----------------------------------------------------------------
Abd-Alrhman Masalkhi (6):
      md/raid1: fix writes_pending and barrier reference leaks on write failures
      md/raid10: fix writes_pending leak on write request failures
      md/raid10: fix writes_pending and barrier reference leaks on discard failures
      md/raid1: simplify raid1_write_request() error handling
      md/raid1: honor REQ_NOWAIT when waiting for behind writes
      md/raid1: free r1_bio when REQ_NOWAIT is set and read would block on retry

Bryam Vargas (1):
      nvmet-rdma: handle inline data with a nonzero offset

Cen Zhang (1):
      block, bfq: protect async queue reset with blkcg locks

Chen Cheng (4):
      md/raid1: protect head_position for read balance
      md/raid5: let stripe batch bm_seq comparison wrap-safe
      md/raid5: use stripe state snapshot in break_stripe_batch_list()
      md/raid5: avoid R5_Overlap races while breaking stripe batches

Christoph Hellwig (3):
      block: fix incorrect error injection static key decrement
      block: fix GFP_ flags confusion in bio_integrity_alloc_buf
      block: handle REQ_OP_ZONE_APPEND in __bio_integrity_action

Deepanshu Kartikey (1):
      nbd: don't warn when reclassifying a busy socket lock

Jens Axboe (2):
      Merge tag 'nvme-7.2-2026-06-23' of git://git.infradead.org/nvme into block-7.2
      Merge branch 'md-7.2' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-7.2

John Garry (3):
      nvme: quieten sparse warning in valid LBA size check
      nvme: make some sysfs diagnostic structures static
      nvme: make nvme_add_ns{_head}_cdev return void

Maurizio Lombardi (2):
      nvme: fix crash and memory leak during invalid cdev teardown
      nvmet-tcp: handle TCP_CLOSING state in nvmet_tcp_state_change

Michael Bommarito (1):
      nvmet-auth: reject short AUTH_RECEIVE buffers

Michal Koutný (1):
      blk-cgroup: fix UAF in __blkcg_rstat_flush()

Mohamed Khalfella (1):
      nvme-fc: Do not cancel requests in io target before it is initialized

Nick Chan (1):
      nvme-apple: Prevent shared tags across queues on Apple A11

Qu Wenruo (2):
      block: revert the iov_iter after a short copy in bio_iov_iter_bounce_write()
      block: respect iov_iter::nofault flag in bio_iov_iter_bounce_write()

Rosen Penev (1):
      nvme: target: allocate ana_state with port

Usama Arif (2):
      kernel/fork: clear PF_BLOCK_TS in copy_process()
      block: invalidate cached plug timestamp after task switch

Wen Xiong (1):
      block: Remove redundant plug in __submit_bio()

Wentao Liang (1):
      nvmet: fix refcount leak in nvmet_sq_create()

Yitang Yang (1):
      block: fix IORING_URING_CMD_REISSUE flags check in blkdev_uring_cmd

Yu Kuai (11):
      md/raid5: account discard IO
      md/raid5: validate discard support at request time
      md/raid5: always convert llbitmap bits for discard
      blk-cgroup: protect iterating blkgs with blkcg->lock in blkcg_print_stat()
      blk-cgroup: delay freeing policy data after rcu grace period
      blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()
      blk-cgroup: don't nest queue_lock under rcu in blkg_lookup_create()
      blk-cgroup: don't nest queue_lock under rcu in bio_associate_blkg()
      blk-cgroup: don't nest queue_lock under blkcg->lock in blkcg_destroy_blkgs()
      mm/page_io: don't nest queue_lock under rcu in bio_associate_blkg_from_page()
      block, bfq: don't grab queue_lock to initialize bfq

Zizhi Wo (1):
      blk-cgroup: defer blkcg css_put until blkg is unlinked from queue

 block/bfq-cgroup.c                     |  30 ++++-
 block/bfq-iosched.c                    |   8 +-
 block/bio-integrity-auto.c             |   2 +-
 block/bio-integrity-fs.c               |   4 +-
 block/bio-integrity.c                  |   9 +-
 block/bio.c                            |  21 +++-
 block/blk-cgroup-rwstat.c              |  15 ++-
 block/blk-cgroup.c                     | 196 +++++++++++++++++++--------------
 block/blk-cgroup.h                     |   8 +-
 block/blk-core.c                       |   7 --
 block/blk-iocost.c                     |  22 +++-
 block/blk-iolatency.c                  |  10 +-
 block/blk-throttle.c                   |  13 ++-
 block/error-injection.c                |   4 +-
 block/ioctl.c                          |   2 +-
 drivers/block/nbd.c                    |   2 +-
 drivers/md/md-bitmap.c                 |   9 +-
 drivers/md/md-bitmap.h                 |   2 +-
 drivers/md/md-llbitmap.c               |  13 ++-
 drivers/md/md.c                        |   2 +-
 drivers/md/raid1.c                     |  99 ++++++++++-------
 drivers/md/raid10.c                    |  28 +++--
 drivers/md/raid5.c                     | 131 +++++++++++++---------
 drivers/md/raid5.h                     |   1 +
 drivers/nvme/host/apple.c              |  12 +-
 drivers/nvme/host/core.c               |  45 +++++---
 drivers/nvme/host/fc.c                 |   7 +-
 drivers/nvme/host/multipath.c          |  24 ++--
 drivers/nvme/host/nvme.h               |   5 +-
 drivers/nvme/host/sysfs.c              |   6 +-
 drivers/nvme/target/configfs.c         |   9 +-
 drivers/nvme/target/core.c             |   2 +-
 drivers/nvme/target/fabrics-cmd-auth.c |  26 ++++-
 drivers/nvme/target/nvmet.h            |   2 +-
 drivers/nvme/target/rdma.c             |  18 +--
 drivers/nvme/target/tcp.c              |   1 +
 include/linux/bio-integrity.h          |   2 +-
 include/linux/blkdev.h                 |  16 +--
 kernel/fork.c                          |   1 +
 kernel/sched/core.c                    |  12 +-
 mm/page_io.c                           |   7 +-
 41 files changed, 518 insertions(+), 315 deletions(-)

-- 
Jens Axboe

