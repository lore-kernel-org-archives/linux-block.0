Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA5C289355
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749217926; cv=none; b=hNM3/tMv4YAznHVWaQK+EQ2vUOUIhg5EbvYz073+ywYNErkbuS3NLve09uSEOH01XeUZrICGSiJ9+USsqBtUF4AJui1ZIZk+gkawiYyNwZo6LSS5jZTT/IvfSXRUUJyKniUFZKgsd+JBqvly2GPi8tJI6lYSA6Bd7nLjpQVJQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749217926; c=relaxed/simple;
	bh=sJyQOcZD9jyiphNEekewzIyEc9sev7utdVU2MGBwKZw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QYKhAepMEohUuPJbjdUwp75/aaRnsf3yiC6CNduk0feY5POyI/jlRWTsidaAFjSqqeGwsevhS0P7mm8bzse1UFUYuFJCnGOcWfZ2+2iEje5VOJeKsuEuFr5cuGUnl6/U32otKFKRYO/BEc1E53uLO44h+QdQFcVATRmvxyyRYQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eFYIOekX; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eFYIOekX"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ddca4ce408so6421755ab.0
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749217922; x=1749822722; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwKx9wzaRm/XpHdjhbWtug59YbXuNcmdcBG+KjNSQT0=;
        b=eFYIOekXFAS6wT2iIQRImHXnVhTrpHi2rRFlNZ8ychpEoHArhQLExvYlatUsp3LWjq
         lQlJqmT11WkBlxl/dYOFZrPYkrHVWtC9C+VjdZypDkBYC3D13j27BJKOi4aVQiQmz8Le
         F2rPAXSMXFBrB01fjs1SItPrndoWgfNdMBMXbDw7DYZ6tGQ1iTYiKmWflQd6THBjmGIM
         Qay1bEN/JicC7fHoVxGmCN8wSqrmuYRD6WDmjoIviEqGg9BcK3PHYTHHZFxQB9q2vvbF
         QHnz8FV+REkXYoGo3x/GmoopNnROYndAMPVSmeZBCrvwYW9kUg6olTzb90oN82tY4PX0
         Znhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749217922; x=1749822722;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cwKx9wzaRm/XpHdjhbWtug59YbXuNcmdcBG+KjNSQT0=;
        b=Z4alCfrWmfC+SDETBPnwXWJdZV5aUWLk9+X7184Djqo/s5w4amKtL32C92X+dIKOTJ
         stjsE4ozKhVIabX0L4fI5LJj+n+QhqVYl1pwUzj0oNfrqbAEvLvvtTJk81yA5T6gMQ7q
         s5sasO06b4zBsJU6bFrJ8+qfZmrgIfVcq4T1UJsxC0q0Udesc+KEumELZe/ZpKoGSDLq
         HkP0ZnQw9XIUVu3lhHVuoWH4hgjjoVEgRJzbQBRt3UfM/N/d18x/0jaIBvIR7+QMH171
         4Rqr0rwU/k2C7///2TWgh4hsgQo39DTYkkD5/rgXTLc/PpRDAo4RxFr1TzcC8FzanykK
         eEFw==
X-Gm-Message-State: AOJu0YzgK+GUFADL+9VUqSnQFXLvxBjRVuYTW7O2+e0EKbrLpWvto/Ty
	BCgSwqwskW+rkYD/urQbtkFGODNPK0vz4GP1X/lMs2O4+zRYLPuMl+MBEBSd0raJ6aq4R6IbEPM
	eWCEa
X-Gm-Gg: ASbGncsJaasaLLfjUux9A5x7TdWSjH4eLCmOGfvHQ8wFQsWefQG8plq1Y62zccaODt4
	4SDJuq20GJIgvAuCxgM5mBrGhPDDtvZObvezWjL6i+kHSTq8CrIuFp2Z62zSQ/0YyAd/q3DpkyX
	zpb6r8WMaf6nEl5W5Ro+o7DzTyuF7bQgfnluHqH8psXU3Z6unyUsRgFc/tA+rOd79fK+MiW8JMe
	ILOJLpPe+crp/DkwVW4UuJceCk1y/JZ5pI1CkvFfKXpVxR0zvgtYs90HaIFfFiKT1zmIVm0KU7h
	MMS6bWrY+Sbv5RWNKlElJKJAFcDSraVzCDvW0Z5TYM0a/bY=
X-Google-Smtp-Source: AGHT+IHCuO17/l6dhzKLw732cYPbG/qZ20qAd96OC6OvLwv8sjbGLfzseMCB921oHiAH7C9ggGYBgQ==
X-Received: by 2002:a05:6e02:144d:b0:3dc:8423:545c with SMTP id e9e14a558f8ab-3ddce35c750mr37810805ab.0.1749217922327;
        Fri, 06 Jun 2025 06:52:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-500df421bc8sm449001173.35.2025.06.06.06.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 06:52:01 -0700 (PDT)
Message-ID: <0c5db2c6-2e28-47f6-ac57-8b9a21415191@kernel.dk>
Date: Fri, 6 Jun 2025 07:52:00 -0600
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
Subject: [GIT PULL] Block fixes and updates for 6.16-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes and updates for block that should go into the 6.16-rc1
kernel release. This pull request contains:

- NVMe pull request via Christoph
	- TCP error handling fix (Shin'ichiro Kawasaki)
	- TCP I/O stall handling fixes (Hannes Reinecke)
	- fix command limits status code (Keith Busch)
	- support vectored buffers also for passthrough (Pavel Begunkov)
	- spelling fixes (Yi Zhang)

- MD pull request via Yu
	- fix REQ_RAHEAD and REQ_NOWAIT IO err handling for raid1/10
	- fix max_write_behind setting for dm-raid
	- some minor cleanups

- Integrity data direction fix and cleanup

- bcache NULL pointer fix

- Fix for loop missing write start/end handling

- Decouple hardware queues and IO threads in ublk

- Slew of ublk selftests additions and updates

Please pull!


The following changes since commit 914873bc7df913db988284876c16257e6ab772c6:

  Merge tag 'x86-build-2025-05-25' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2025-05-26 21:41:14 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.16-20250606

for you to fetch changes up to 6f65947a1e684db28b9407ea51927ed5157caf41:

  Merge tag 'nvme-6.16-2025-06-05' of git://git.infradead.org/nvme into block-6.16 (2025-06-05 07:40:38 -0600)

----------------------------------------------------------------
block-6.16-20250606

----------------------------------------------------------------
Caleb Sander Mateos (2):
      block: drop direction param from bio_integrity_copy_user()
      block: flip iter directions in blk_rq_integrity_map_user()

Hannes Reinecke (2):
      nvme-tcp: sanitize request list handling
      nvme-tcp: fix I/O stalls on congested sockets

Jens Axboe (2):
      Merge tag 'md-6.16-20250530' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-6.16
      Merge tag 'nvme-6.16-2025-06-05' of git://git.infradead.org/nvme into block-6.16

Keith Busch (1):
      nvme: fix command limits status code

Linggang Zeng (1):
      bcache: fix NULL pointer in cache_set_flush()

Ming Lei (2):
      loop: add file_start_write() and file_end_write()
      selftests: ublk: cover PER_IO_DAEMON in more stress tests

Mingzhe Zou (1):
      bcache: reserve more RESERVE_BTREE buckets to prevent allocator hang

Pavel Begunkov (2):
      nvme: fix implicit bool to flags conversion
      nvme: enable vectored registered bufs for passthrough cmds

Robert Pang (1):
      bcache: remove unused constants

Shin'ichiro Kawasaki (1):
      nvme-tcp: remove tag set when second admin queue config fails

Uday Shankar (10):
      ublk: have a per-io daemon instead of a per-queue daemon
      selftests: ublk: kublk: plumb q_id in io_uring user_data
      selftests: ublk: kublk: tie sqe allocation to io instead of queue
      selftests: ublk: kublk: lift queue initialization out of thread
      selftests: ublk: kublk: move per-thread data out of ublk_queue
      selftests: ublk: kublk: decouple ublk_queues from ublk server threads
      selftests: ublk: add functional test for per io daemons
      selftests: ublk: add stress test for per io daemons
      Documentation: ublk: document UBLK_F_PER_IO_DAEMON
      selftests: ublk: kublk: improve behavior on init failure

Yi Zhang (1):
      nvme: spelling fixes

Yu Kuai (5):
      md/raid1,raid10: don't handle IO error for REQ_RAHEAD and REQ_NOWAIT
      md/md-bitmap: fix dm-raid max_write_behind setting
      md/dm-raid: remove max_write_behind setting limit
      md/md-bitmap: cleanup bitmap_ops->startwrite()
      md/md-bitmap: remove parameter slot from bitmap_create()

 Documentation/block/ublk.rst                       |  35 +-
 block/bio-integrity.c                              |  17 +-
 block/blk-integrity.c                              |   7 +-
 drivers/block/loop.c                               |   8 +-
 drivers/block/ublk_drv.c                           | 111 +++---
 drivers/md/bcache/btree.c                          |   2 -
 drivers/md/bcache/super.c                          |  55 ++-
 drivers/md/dm-raid.c                               |   6 +-
 drivers/md/md-bitmap.c                             |  35 +-
 drivers/md/md-bitmap.h                             |  17 +-
 drivers/md/md.c                                    |  14 +-
 drivers/md/raid1-10.c                              |  10 +
 drivers/md/raid1.c                                 |  19 +-
 drivers/md/raid10.c                                |  11 +-
 drivers/nvme/common/auth.c                         |   6 +-
 drivers/nvme/host/Kconfig                          |   2 +-
 drivers/nvme/host/constants.c                      |   2 +-
 drivers/nvme/host/core.c                           |   3 +-
 drivers/nvme/host/fabrics.c                        |   2 +-
 drivers/nvme/host/fabrics.h                        |   6 +-
 drivers/nvme/host/fc.c                             |   4 +-
 drivers/nvme/host/ioctl.c                          |  18 +-
 drivers/nvme/host/multipath.c                      |   2 +-
 drivers/nvme/host/nvme.h                           |   2 +-
 drivers/nvme/host/pci.c                            |   4 +-
 drivers/nvme/host/pr.c                             |   2 -
 drivers/nvme/host/rdma.c                           |   4 +-
 drivers/nvme/host/tcp.c                            |  24 +-
 drivers/nvme/target/admin-cmd.c                    |   2 +-
 drivers/nvme/target/core.c                         |  11 +-
 drivers/nvme/target/fc.c                           |   2 +-
 drivers/nvme/target/io-cmd-bdev.c                  |  11 +-
 drivers/nvme/target/passthru.c                     |   2 +-
 include/linux/nvme.h                               |   2 +-
 include/uapi/linux/ublk_cmd.h                      |   9 +
 tools/testing/selftests/ublk/Makefile              |   1 +
 tools/testing/selftests/ublk/fault_inject.c        |   4 +-
 tools/testing/selftests/ublk/file_backed.c         |  20 +-
 tools/testing/selftests/ublk/kublk.c               | 374 ++++++++++++++-------
 tools/testing/selftests/ublk/kublk.h               |  73 ++--
 tools/testing/selftests/ublk/null.c                |  22 +-
 tools/testing/selftests/ublk/stripe.c              |  17 +-
 tools/testing/selftests/ublk/test_common.sh        |   5 +
 tools/testing/selftests/ublk/test_generic_12.sh    |  55 +++
 tools/testing/selftests/ublk/test_stress_03.sh     |   8 +
 tools/testing/selftests/ublk/test_stress_04.sh     |   7 +
 tools/testing/selftests/ublk/test_stress_05.sh     |   7 +
 .../selftests/ublk/trace/count_ios_per_tid.bt      |  11 +
 48 files changed, 693 insertions(+), 378 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_12.sh
 create mode 100644 tools/testing/selftests/ublk/trace/count_ios_per_tid.bt

-- 
Jens Axboe

