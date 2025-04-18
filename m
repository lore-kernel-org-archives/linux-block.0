Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAEF6BFC0
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987576; cv=none; b=YDgkSLVwHtT/KTY17P9ogr5VrENS4Ma5aMb7Z0/dcG8gBB3zr5DBs/0k4ou7Af2Vxr3Vj3ktWUqQ560BTpCcaK8lA87MC8K/KdJcd8PGk8yKrNorO8Mb7SL3BVbs14HmcviFxeqQC4meUX0BQYdZPQ4kCLt6z4sDKg0NrVHrH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987576; c=relaxed/simple;
	bh=fkgEP82sL36Bu8aaBQzYl5A3DPm247dW8LN+3zwqGi4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cw1aizKVpN0NrANcNl250a1MpyIfiLj8JTnE0WBIPjsmv6tnFRalL5W4cnP7ko/FWgH2Y+x+G70Ak8arixh84TPeJY9Umy2Pb/GW7SjxJMNZml5cCyWNGonCudKCgHMkHjaAX9UfpejwfAAeO9ONpgqYXOvcG2DiSccgiv2UnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=T423JlTs; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="T423JlTs"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso29297339f.1
        for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744987573; x=1745592373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1v9dYbC10aYDB5Oides3qJLDSYw1vqTQG3xIkm5XB8=;
        b=T423JlTs6D03mvBPlN4rrnTwKyssV86ZBLeHt60wphOofgNmdROHWDz4Iz8Dfw9pnn
         2LKP+m0IS1OpN10NtJ6FsjMVHgLEECyRG3xgqthrMyURqy+wyGL8X+HXGlJpzlyZZLzr
         E63+iCqrVcqw72x28LBAyGFrSuVX1E+2/yyTQAE1QRy0YennWuZlax8r9oSSH0ZvXr0z
         uROTH2VbuenyV9wfY1dL2pkZ36ujSHy2io4ySj8YrbxPtOb69i3RXXFAUaHjoL0xwT7+
         TzcLCXqzHhEzGsO77Q+pLPhLHDBMnT640KIPqr6dRLsQPToUUbm4M33yyix1qaX2JIW1
         BEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744987573; x=1745592373;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r1v9dYbC10aYDB5Oides3qJLDSYw1vqTQG3xIkm5XB8=;
        b=GfO2f9/BeQX/DanT3oxfsJa+BV243U9xGJLHCu3tmKmaD/Zmfj6Xp167LEfzcyjqmV
         XqOlSIia5XRwIELUxYw0MD1cRgQOJCHLzwNKNjoYEgN/8NpeJJSRK+6u+O4dcorBzZ7X
         zVjisxanDj7Utld+uR7EBzl0asBfnfEWjPJ45dzukxjEBc0/VqDdWWMeEHepmJiV3FZq
         VwbsAAESCSf8oEZYD8rWO817crYeUMk5YgAcO38gGP3obgMp/GLz771/0xIDVxn5ixyS
         9akBZZKemEgzbg5borKsxhkb8SnT0Z6KroMtpjcMNuArLgWx8cpVz5WVvwczOOvzX7tB
         lqiw==
X-Gm-Message-State: AOJu0Yy17Z5jJDBCbsdrcWc9dTPXlMebnkl06tnH5wXuvmtkEgwIg8Zc
	XZA9P9l2DGY7cvp2YG8TmJh6TDLSEqw6xXKFFkBBWW62Lvj93z/0vUfA7y3JoFFHMwIgkYs+v+1
	Y
X-Gm-Gg: ASbGncuFBbqT+FrpLnI9gjOJPz1gOz1phl+kn32iPQmfS0ALWQB3DK8zMz7dSAnmDUF
	TR3iyVTAtVXgP2h1SUuSMv+aaWcM9igD5m0VVetqJu2rNalO2M1/JQ9j902ThIYdobO9JLli9Pl
	eD2pIyAV+O47eJABNVI6FpMCzXS7WA8Kbkfu0lAFegl8tBzH05gVYgups8B+HQUNkNYty3URjPn
	mfGoq84EvlwkBCYtKW4jUD7HDzc0MJJ+CcQd7EuWJ+yeQ0NUNWWMcTxB5PTe5VTqz8FHt7VRTqx
	hqdoPJQQTkoNfH2vwhGAQ+Idr3Nz7V5nTkDF
X-Google-Smtp-Source: AGHT+IEuEUQoOEdqE53CjWsw7A596YL8mnP2YWKQ/a+aCCdL1QVWook+SFvhpPwU7568YBUskNWtjA==
X-Received: by 2002:a05:6602:3789:b0:85b:3885:159e with SMTP id ca18e2360f4ac-861dbdc71e1mr309429139f.3.1744987572700;
        Fri, 18 Apr 2025 07:46:12 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861d95f7ae0sm39366739f.16.2025.04.18.07.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 07:46:12 -0700 (PDT)
Message-ID: <441e0e5d-a493-4197-b64c-29c407c67bfb@kernel.dk>
Date: Fri, 18 Apr 2025 08:46:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.15-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Set of fixes for block that should go into the 6.15 kernel release. This
pull request contains:

- MD pull via Yu
	- fix raid10 missing discard IO accounting (Yu Kuai)
	- fix bitmap stats for bitmap file (Zheng Qixing)
	- fix oops while reading all member disks failed during
	  check/repair (Meir Elisha)

- NVMe pull via Christoph
	- fix scan failure for non-ANA multipath controllers
	  (Hannes Reinecke)
	- fix multipath sysfs links creation for some cases
	  (Hannes Reinecke)
	- PCIe endpoint fixes (Damien Le Moal)
	- use NULL instead of 0 in the auth code (Damien Le Moal)

- Various ublk fixes
	- Slew of selftest additions
	- Improvements and fixes for IO cancelation
	- Tweak to Kconfig verbiage

- Fix for page dirtying for blk integrity mapped pages

- loop buffered IO fix

- loop uevent fixe

- loop request priority inheritance fix

- Various little fixes

Please pull!


The following changes since commit 3b607b75a345b1d808031bf1bb1038e4dac8d521:

  null_blk: Use strscpy() instead of strscpy_pad() in null_add_dev() (2025-04-11 07:10:46 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.15-20250417

for you to fetch changes up to 81dd1feb19c7a812e51fa6e2f988f4def5e6ae39:

  Merge tag 'nvme-6.15-2025-04-17' of git://git.infradead.org/nvme into block-6.15 (2025-04-17 06:18:49 -0600)

----------------------------------------------------------------
block-6.15-20250417

----------------------------------------------------------------
Bird, Tim (1):
      block: add SPDX header line to blk-throttle.h

Caleb Sander Mateos (1):
      ublk: don't suggest CONFIG_BLK_DEV_UBLK=Y

Christoph Hellwig (1):
      loop: stop using vfs_iter_{read,write} for buffered I/O

Damien Le Moal (4):
      nvmet: auth: use NULL to clear a pointer in nvmet_auth_sq_free()
      nvmet: pci-epf: always fully initialize completion entries
      nvmet: pci-epf: clear CC and CSTS when disabling the controller
      nvmet: pci-epf: cleanup link state management

Hannes Reinecke (2):
      nvme: fixup scan failure for non-ANA multipath controllers
      nvme-multipath: sysfs links may not be created for devices

Jens Axboe (2):
      Merge tag 'md-6.15-20250416' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-6.15
      Merge tag 'nvme-6.15-2025-04-17' of git://git.infradead.org/nvme into block-6.15

Martin K. Petersen (1):
      block: integrity: Do not call set_page_dirty_lock()

Meir Elisha (1):
      md/raid1: Add check for missing source disk in process_checks()

Ming Lei (18):
      selftests: ublk: fix ublk_find_tgt()
      selftests: ublk: add io_uring uapi header
      selftests: ublk: cleanup backfile automatically
      selftests: ublk: make sure _add_ublk_dev can return in sub-shell
      selftests: ublk: run stress tests in parallel
      selftests: ublk: add two stress tests for zero copy feature
      selftests: ublk: setup ring with IORING_SETUP_SINGLE_ISSUER/IORING_SETUP_DEFER_TASKRUN
      selftests: ublk: set queue pthread's cpu affinity
      selftests: ublk: increase max nr_queues and queue depth
      selftests: ublk: support target specific command line
      selftests: ublk: support user recovery
      selftests: ublk: add test_stress_05.sh
      selftests: ublk: move creating UBLK_TMP into _prep_test()
      ublk: add ublk_force_abort_dev()
      ublk: rely on ->canceling for dealing with ublk_nosrv_dev_should_queue_io
      ublk: move device reset into ublk_ch_release()
      ublk: remove __ublk_quiesce_dev()
      ublk: simplify aborting ublk request

Thomas Weißschuh (2):
      loop: properly send KOBJ_CHANGED uevent for disk device
      loop: LOOP_SET_FD: send uevents for partitions

Uday Shankar (3):
      ublk: properly serialize all FETCH_REQs
      ublk: improve detection and handling of ublk server exit
      selftests: ublk: add generic_06 for covering fault inject

Yu Kuai (1):
      md/raid10: fix missing discard IO accounting

Yunlong Xing (1):
      loop: aio inherit the ioprio of original request

Zheng Qixing (2):
      md/md-bitmap: fix stats collection for external bitmaps
      block: fix resource leak in blk_register_queue() error path

 block/bio-integrity.c                           |  17 +-
 block/blk-sysfs.c                               |   2 +
 block/blk-throttle.h                            |   1 +
 drivers/block/Kconfig                           |   6 -
 drivers/block/loop.c                            | 121 +-----
 drivers/block/ublk_drv.c                        | 532 ++++++++++++------------
 drivers/md/md-bitmap.c                          |   5 +-
 drivers/md/raid1.c                              |  26 +-
 drivers/md/raid10.c                             |   1 +
 drivers/nvme/host/core.c                        |   2 +-
 drivers/nvme/host/multipath.c                   |  14 +-
 drivers/nvme/target/auth.c                      |   2 +-
 drivers/nvme/target/pci-epf.c                   |  88 ++--
 tools/testing/selftests/ublk/Makefile           |   9 +-
 tools/testing/selftests/ublk/fault_inject.c     |  98 +++++
 tools/testing/selftests/ublk/kublk.c            | 343 +++++++++++++--
 tools/testing/selftests/ublk/kublk.h            |  47 ++-
 tools/testing/selftests/ublk/stripe.c           |  28 +-
 tools/testing/selftests/ublk/test_common.sh     | 142 ++++++-
 tools/testing/selftests/ublk/test_generic_04.sh |  40 ++
 tools/testing/selftests/ublk/test_generic_05.sh |  44 ++
 tools/testing/selftests/ublk/test_generic_06.sh |  41 ++
 tools/testing/selftests/ublk/test_loop_01.sh    |   8 +-
 tools/testing/selftests/ublk/test_loop_02.sh    |   8 +-
 tools/testing/selftests/ublk/test_loop_03.sh    |   8 +-
 tools/testing/selftests/ublk/test_loop_04.sh    |   9 +-
 tools/testing/selftests/ublk/test_loop_05.sh    |   8 +-
 tools/testing/selftests/ublk/test_stress_01.sh  |  45 +-
 tools/testing/selftests/ublk/test_stress_02.sh  |  45 +-
 tools/testing/selftests/ublk/test_stress_03.sh  |  38 ++
 tools/testing/selftests/ublk/test_stress_04.sh  |  37 ++
 tools/testing/selftests/ublk/test_stress_05.sh  |  64 +++
 tools/testing/selftests/ublk/test_stripe_01.sh  |  12 +-
 tools/testing/selftests/ublk/test_stripe_02.sh  |  13 +-
 tools/testing/selftests/ublk/test_stripe_03.sh  |  12 +-
 tools/testing/selftests/ublk/test_stripe_04.sh  |  13 +-
 36 files changed, 1325 insertions(+), 604 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/fault_inject.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_04.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_05.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_04.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_05.sh

-- 
Jens Axboe

