Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE91DF97F
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673638; cv=none; b=lK7dYNQ/Z0TiUngJfUkmdoV2I5YmUU30vi7bGOO1pb2SIY1h2+xhIJQ78zjQ/43OONpuked33u/6m/1iy9/iUHDDMsIMTB2mXEs9qvqTYYdCAkNM6w36DEzvmEAYybWGv7DIHgLKpxkmbtYWg5tMr4Gpc8NOEuEtaoLhT6XKobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673638; c=relaxed/simple;
	bh=AyEYnFn6MXnJyfR42LoNmclURq4hzJqQu7YpzXlgmfE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nY0aUE7yAz0G3vOZ9Sg3AJ5EqDKIkNr2+bXfIrgDQI3jEIuOFTsmyxX1A7OlqOUdwDX5qvPXNrHUSSOvS4aZmndDOPmsjbILcuvqUK9FSPmR7zHDrgrC3jCqhBfx2Xhgf98hXgpht6hTiWPJIlCRaUBwrsgMqwc9IgX3DzELERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hV+b7azC; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hV+b7azC"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e406ca2d22so11560755ab.1
        for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754673635; x=1755278435; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjWEHV+aTRzk3h1duw/mzD0viGRoiEC3DH+jZmSSz1s=;
        b=hV+b7azCeeCZ3Xj3rOzpuAgWyIhK0UbTVeiZ5T2FyJoUX9RCR7PR4xo0z8a+mXBoXU
         DnFeUdTSsfqfYSD4MSFcCs9UaVO+ieudgrWA0I/r7iwBhpGi1ufcZJoJy9B0MuxgLD/A
         p9Nq6uyDEaGpISx9TjLJJkSQmxR923qPIaAFLMSsdSVcjn8ilN5Bl0NoaLeHsmck+BeU
         luEFLMC12/5RFuliQrcXQkKIk8Ol/s8asebITXtKc6XJhvBRh03PB9sCtaJioNczpoVz
         s063V6iGCIx4HcAuEM3buFJPMT2wksjeZy34O6EMWIlbLkx937EDqEw3ZRiXOpmUd+Ur
         tLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754673635; x=1755278435;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjWEHV+aTRzk3h1duw/mzD0viGRoiEC3DH+jZmSSz1s=;
        b=e8PuOfX9xwTI+ahnlRG1VQUj6924BjRPSI2ex2SZVSO14A2mc0X0Cy/ivteSNCXjQ+
         ig7oGRYBbid1hvjiqR69H1PoZnT/NIHBlflv5Pzk9FiBRto84/pitrSjJnX2N5XN1Bwq
         jJ/Y0tL/sAAHwrwHv+des8bcYr0/izkWRE3kJQSYFvNFD0l635EqjqF9cm6/4vlhoOZI
         Nj/IjdSOkIDdAkE7ob2ADYpQo06g8w4m3FKwqDY1NEVTLfxtlSPHWNV/mHpNFZcJxCqT
         4K6xzGHWgUY26BFJ8HcJVnrwHvd5MLsd+2wIg962TBbWpC/7ydSSLl9xz3hqfECAXtvT
         hFKA==
X-Gm-Message-State: AOJu0YzhNVti096/IDcmHRKPwDn1OLU975oNBus7HJfgwm/guzlK+JQT
	OP2/y3zsmKtzJOcodl/0fcuP4UBOgrGFZbZzKMpoOv+ADPxk5+2o9KiEk0JHQsj6CRfhwgfZCQS
	up4ca
X-Gm-Gg: ASbGncvccwbNNBJnuwsaM+Q8bgYMLtoHLgviDNaWjGTVmP6odXVXc+DdrJVloL1SyMO
	OlmhqMFv4dfLf/G9KAOsdc258weNvuiDgeWyTVqFCRmW4WXvP1ZdHq01olGGlaTQDRH5N26vLQr
	od9kwQfTgdqLcQaDHIXuU9ol8f3cbrRPyn/d9H4baQ/Jvs6xElNNO4tXWeuIaaloxhzntWi3W+k
	I10RR0L+vqfVmnj19uTkN9evrjD+KfY+BCtux7lXy+YeUv1hFTF4OXd/TpW91L+5H6XV7vYkYuh
	Xnt6hmVjbCOr9Bd7mW+Bz+MNXauH+3DjZMzkwxEay9vT/7n/xE75dP6DzT/tUztjX+WkOWYlpZp
	TWDboUE0LheU6rGaH/8vI/izKOsYXtg==
X-Google-Smtp-Source: AGHT+IHPLUXjGDjqL5oaUIQGavB62UuZm1CFPYVAm1JQk/sXpHwTX7etknT+UEUGjLaC0IBo63ONSA==
X-Received: by 2002:a05:6e02:1fc4:b0:3e5:2ad8:32d with SMTP id e9e14a558f8ab-3e5330aae2cmr67049165ab.8.1754673634695;
        Fri, 08 Aug 2025 10:20:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e533bfe753sm9325825ab.17.2025.08.08.10.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 10:20:33 -0700 (PDT)
Message-ID: <3c66a9e3-ed41-4f9a-bf19-e6e5a6a38693@kernel.dk>
Date: Fri, 8 Aug 2025 11:20:33 -0600
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
Subject: [GIT PULL] Block changes for 6.17-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of changes and fixes that should go into the 6.17-rc1 release. Some
are straight up fixes, few are just a bit delayed and hence missed the
initial pull request when the merge window opens. However, nothing major
or alarming in here. This pull request contains:

- MD pull request via Yu
	- mddev null-ptr-dereference fix, by Erkun
	- md-cluster fail to remove the faulty disk regression fix,
	  by Heming
	- minor cleanup, by Li Nan and Jinchao
	- mdadm lifetime regression fix reported by syzkaller,
	  by Yu Kuai

- MD pull request via Christoph
	- add support for getting the FDP featuee in fabrics passthru
	  path (Nitesh Shetty)
	- add capability to connect to an administrative controller
	  (Kamaljit Singh)
	- fix a leak on sgl setup error (Keith Busch)
	- initialize discovery subsys after debugfs is initialized
	  (Mohamed Khalfella)
	- fix various comment typos (Bjorn Helgaas)
	- remove unneeded semicolons (Jiapeng Chong)

- nvmet debugfs ordering issue fix

- Fix UAF in the tag_set in zloop 

- Ensure sbitmap shallow depth covers entire set

- Reduce lock roundtrips in io context lookup

- Move scheduler tags alloc/free out of elevator and freeze lock, to fix
  some lockdep found issues

- Improve robustness of queue limits checking

- Fix a regression with IO priorities, if no io context exists

Please pull!


The following changes since commit 86aa721820952b793a12fc6e5a01734186c0c238:

  Merge tag 'chrome-platform-v6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux (2025-07-28 23:26:07 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.17-20250808

for you to fetch changes up to 45fa9f97e65231a9fd4f9429489cb74c10ccd0fd:

  lib/sbitmap: make sbitmap_get_shallow() internal (2025-08-07 06:30:17 -0600)

----------------------------------------------------------------
block-6.17-20250808

----------------------------------------------------------------
Bjorn Helgaas (1):
      nvme: fix various comment typos

Christoph Hellwig (1):
      block: ensure discard_granularity is zero when discard is not supported

Christophe JAILLET (1):
      block, bfq: Reorder struct bfq_iocq_bfqq_data

Damien Le Moal (1):
      block: Improve read ahead size for rotational devices

Guenter Roeck (1):
      block: Fix default IO priority if there is no IO context

Heming Zhao (1):
      md/md-cluster: handle REMOVE message earlier

Jens Axboe (2):
      Merge tag 'nvme-6.17-2025-07-31' of git://git.infradead.org/nvme into block-6.17
      Merge tag 'md-6.17-20250803' of gitolite.kernel.org:pub/scm/linux/kernel/git/mdraid/linux into block-6.17

Jiapeng Chong (1):
      nvme-auth: remove unneeded semicolon

John Garry (2):
      block: avoid possible overflow for chunk_sectors check in blk_stack_limits()
      block: Enforce power-of-2 physical block size

Kamaljit Singh (1):
      nvme: add capability to connect to an administrative controller

Keith Busch (1):
      nvme-pci: fix leak on sgl setup error

Li Nan (1):
      md: rename recovery_cp to resync_offset

Mohamed Khalfella (2):
      nvmet: initialize discovery subsys after debugfs is initialized
      nvmet: exit debugfs after discovery subsystem exits

Nilay Shroff (3):
      block: move elevator queue allocation logic into blk_mq_init_sched
      block: fix lockdep warning caused by lock dependency in elv_iosched_store
      block: fix potential deadlock while running nr_hw_queue update

Nitesh Shetty (1):
      nvmet: add support for FDP in fabrics passthru path

Shin'ichiro Kawasaki (1):
      zloop: fix KASAN use-after-free of tag set

Wang Jinchao (2):
      md/raid1: change r1conf->r1bio_pool to a pointer type
      md/raid1: remove struct pool_info and related code

Yang Erkun (1):
      md: make rdev_addable usable for rcu mode

Yu Kuai (4):
      blk-ioc: don't hold queue_lock for ioc_lookup_icq()
      md: fix create on open mddev lifetime regression
      lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
      lib/sbitmap: make sbitmap_get_shallow() internal

 block/bfq-iosched.c            |  66 ++++--------
 block/bfq-iosched.h            |  13 ++-
 block/blk-ioc.c                |  16 ++-
 block/blk-mq-sched.c           | 223 ++++++++++++++++++++++++++++-------------
 block/blk-mq-sched.h           |  12 ++-
 block/blk-mq.c                 |  16 ++-
 block/blk-settings.c           |  33 ++++--
 block/blk.h                    |   4 +-
 block/elevator.c               |  38 +++++--
 block/elevator.h               |  16 ++-
 block/kyber-iosched.c          |  20 +---
 block/mq-deadline.c            |  30 +-----
 drivers/block/zloop.c          |   3 +-
 drivers/md/dm-raid.c           |  42 ++++----
 drivers/md/md-bitmap.c         |   8 +-
 drivers/md/md-cluster.c        |  16 +--
 drivers/md/md.c                |  73 ++++++++------
 drivers/md/md.h                |   2 +-
 drivers/md/raid0.c             |   6 +-
 drivers/md/raid1-10.c          |   2 +-
 drivers/md/raid1.c             |  94 +++++++----------
 drivers/md/raid1.h             |  22 +---
 drivers/md/raid10.c            |  16 +--
 drivers/md/raid5-ppl.c         |   6 +-
 drivers/md/raid5.c             |  30 +++---
 drivers/nvme/host/auth.c       |   4 +-
 drivers/nvme/host/core.c       |  16 +++
 drivers/nvme/host/fc.c         |   4 +-
 drivers/nvme/host/pci.c        |   2 +-
 drivers/nvme/host/tcp.c        |   2 +-
 drivers/nvme/target/core.c     |  14 +--
 drivers/nvme/target/fc.c       |   6 +-
 drivers/nvme/target/passthru.c |   2 +
 drivers/nvme/target/rdma.c     |   6 +-
 include/linux/ioprio.h         |   3 +-
 include/linux/sbitmap.h        |  19 +---
 include/uapi/linux/raid/md_p.h |   2 +-
 lib/sbitmap.c                  |  74 ++++++++------
 38 files changed, 519 insertions(+), 442 deletions(-)

-- 
Jens Axboe

