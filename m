Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34DC14600C
	for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898110; cv=none; b=mZIjl2oVFCcDSNpD2Cy+vO//WZdXLdP+Fo28gQtDXtF2TZrz+2QxiWl8vOenQBhHfnsj7mDJgHudW2bA+Mf6zCDi0eM0zh2g6B8e8eS4LVyylYqK1fpyXKtfRCrDEqcurErQYTIDpSTBzgdR2buah5WQFDdx66f4yR8zRi9ZD/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898110; c=relaxed/simple;
	bh=mTzNN7ZcZl3mRzgOWqewlKxuKHi0oxhQ+6XhGGM4t4s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=k/7nTr8taBsvxFSk03df+3QU5gHLgtsekE95xSZPxDEJGGM8sPm3BLRyRiTW1rL/dcHLPbgdjKtQ/OAT+0YcSJynH6UEaivabO7Ksh5bk1BzNTml1Ozsz/73Pp70e8ByYBV1JLOe5S0pnZYIgOcW9X1PTt+FI0wcBEZBkAJrrhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gVpXlFMt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gVpXlFMt"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-724f41d550cso1268324b3a.2
        for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 08:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732898108; x=1733502908; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOp8ZBI0Cd+fO30MTHmt7+c6xC8xfAdAPY6JJUNkdLc=;
        b=gVpXlFMtuQc2ApUrLNcNN0/ksRyoV7ZtzKlC6k3em17XQ1NClvoxaxsBIA/vTqHesO
         vZ64Ab16rumQSgxyU5MbaIsHyai1mf/N1cVAnrb2RFnAVHeMDtLdnPHP8m8yMxg7ufRe
         cFjhqOJo6bQbcvpE5FNPG6tRjmdKDLyo2HZG8QYJbBMozT0LU7Zw6WBVw5EXy4am/Lhy
         Zi2AkQUVac3og4QqcgqucsL9Fp9n/kXofTlAXfrdWiyjNYYF40OwJ8HIhxPw7kX9n0r+
         9HEzEpplNOXW289/0j5DAdH/Pp0R3hMMShf5P/VW1ysnGogpfnIIm4lhhGKjb7I1/oRy
         Hw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732898108; x=1733502908;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AOp8ZBI0Cd+fO30MTHmt7+c6xC8xfAdAPY6JJUNkdLc=;
        b=dmUq79dyi4hMYas0VFkdH8urG1HOEIMsJrGhiQQweS7eCEPGpCnhnADrE9m2o/fU2P
         o5MN5GQFgSAURqfRkRRbATcANqUQl7NV58xBSWUN0Vlf5jGtEXb5pv1HxDsa1cHu+5jq
         s2LUOAmB6qYWqVHZNpsThR0ybCWKIjoz9Qw52v30V7KbxH1pu2fjfuB2WTNTC9aVosgU
         ci5zlWn/COKMzn6OYnkEVLyQ6A+eAUS+ub5Z8esEEoyNMoiwrzMyGs9Iz3tL0l2IDfLL
         VdFh6fSpkvSDzDHq7/jmRi5dfCineUe0o+qd9vTAI/OQTMWLe4PqIlLDrnz1tuAH9PPn
         /TRw==
X-Gm-Message-State: AOJu0Yw9sDePi6BxHXr+o9d6agutBKdGZbIgOE38HOOhrTVCegOOsEF1
	KSZB2Auk8OylhQ49h7tmCBuzfZn3WdazfGRWfGGIX7cWUXTPhQdrGBTi2t8NMkxlpJGJqwe+rbw
	K
X-Gm-Gg: ASbGncvwbwFyXlvoPP6lME+/hjzARLT5sNexGgYCW7qVWA3Cp4dYynGTPaCJHg09sqc
	/Z+JQIgZVKWuaS2nqHyXpjYQP023v3neStvYRJX7BtvrwoRigwbLXSprN3PWX4e5DqHt9fpeyQ1
	00pRZFH2OlDotghOVrxi/18iXjtwW+dsDQcXkkNEHNe6Ht/sJjAVC915R/4tkSyUDbv8TbfIozC
	em53pOxfAFq0ZKb6Ky9NKng1ScsZI26hNr+mj8kJOBWFnM=
X-Google-Smtp-Source: AGHT+IHDAmkC0GNi/lFG1RELYI5DsdoWJn6UY6abc4w+ZjH0Osf7tZ+mAHVOmjyWGND4fJu7h0675w==
X-Received: by 2002:a05:6a00:a04:b0:724:5c66:ecbd with SMTP id d2e1a72fcca58-72530163af6mr18363974b3a.23.1732898107948;
        Fri, 29 Nov 2024 08:35:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725416bc0c7sm3687425b3a.0.2024.11.29.08.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 08:35:07 -0800 (PST)
Message-ID: <3ffcb344-2ff2-47e4-8c53-a5b6d6b9a0f1@kernel.dk>
Date: Fri, 29 Nov 2024 09:35:06 -0700
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
Subject: [GIT PULL] Final block changes for 6.13-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Changes for this merge window that weren't included in the initial pull.
This pull request contains:

- NVMe pull request via Keith
	- Use correct srcu list traversal (Breno)
	- Scatter-gather support for metadata (Keith)
	- Fabrics shutdown race condition fix (Nilay)
	- Persistent reservations updates (Guixin)

- Add the required bits for MD atomic write support for raid0/1/10.

- Correct return value for unknown opcode in ublk.

- Fix deadlock with zone revalidation.

- Fix for the io priority request vs bio cleanups.

- Use the correct unsigned int type for various limit helpers.

- Fix for a race in loop.

- Cleanup blk_rq_prep_clone() to prevent uninit-value warning and make
  it easier for actual humans to read.

- Fix potential UAF when iterating tags.

- A few fixes for bfq-iosched UAF issues.

- Fix for brd discard not decrementing the allocated page count.

- Various little fixes and cleanups.

Please pull!


The following changes since commit 88d47f629313730f26a3b00224d1e1a5e3b7bb79:

  Merge tag 'md-6.13-20241115' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-6.13/block (2024-11-15 12:37:33 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.13-20242901

for you to fetch changes up to 82734209bedd65a8b508844bab652b464379bfdd:

  brd: decrease the number of allocated pages which discarded (2024-11-29 08:43:52 -0700)

----------------------------------------------------------------
block-6.13-20242901

----------------------------------------------------------------
Breno Leitao (1):
      nvme/multipath: Fix RCU list traversal to use SRCU primitive

Christoph Hellwig (10):
      block: return unsigned int from bdev_io_min
      block: don't bother checking the data direction for merges
      block: req->bio is always set in the merge code
      block: return unsigned int from bdev_io_opt
      block: return unsigned int from queue_dma_alignment
      block: return unsigned int from blk_lim_dma_alignment_and_pad
      block: return bool from blk_rq_aligned
      block: remove a duplicate definition for bdev_read_only
      block: return bool from get_disk_ro and bdev_read_only
      mq-deadline: don't call req_get_ioprio from the I/O completion handler

Damien Le Moal (1):
      block: Prevent potential deadlock in blk_revalidate_disk_zones()

Guixin Liu (2):
      nvme: introduce change ptpl and iekey definition
      nvme: tuning pr code by using defined structs and macros

Jens Axboe (1):
      Merge tag 'nvme-6.13-2024-11-21' of git://git.infradead.org/nvme into for-6.13/block

John Garry (8):
      block: Drop granularity check in queue_limit_discard_alignment()
      block: Add extra checks in blk_validate_atomic_write_limits()
      block: Support atomic writes limits for stacked devices
      md/raid0: Atomic write support
      md/raid1: Atomic write support
      md/raid10: Atomic write support
      block: Remove extra part pointer NULLify in blk_rq_init()
      block: Don't allow an atomic write be truncated in blkdev_write_iter()

Keith Busch (3):
      nvme-pci: add support for sgl metadata
      nvme: define the remaining used sgls constants
      nvme-pci: use sgls for all user requests if possible

Manas (1):
      rust: block: simplify Result<()> in validate_block_size return

Mikulas Patocka (1):
      blk-settings: round down io_opt to physical_block_size

Ming Lei (1):
      ublk: fix error code for unsupported command

Nilay Shroff (2):
      Revert "nvme: make keep-alive synchronous operation"
      nvme-fabrics: fix kernel crash while shutting down controller

OGAWA Hirofumi (1):
      loop: Fix ABBA locking race

Suraj Sonawane (1):
      block: blk-mq: fix uninit-value in blk_rq_prep_clone and refactor

Yu Kuai (2):
      block: fix uaf for flush rq while iterating tags
      block, bfq: fix bfqq uaf in bfq_limit_depth()

Zach Wade (1):
      Revert "block, bfq: merge bfq_release_process_ref() into bfq_put_cooperator()"

Zhang Xianwei (1):
      brd: decrease the number of allocated pages which discarded

 block/bfq-cgroup.c               |   1 +
 block/bfq-iosched.c              |  43 ++++++++----
 block/blk-merge.c                |  35 ++--------
 block/blk-mq.c                   |  14 ++--
 block/blk-settings.c             | 141 ++++++++++++++++++++++++++++++++++++-
 block/blk-sysfs.c                |   6 +-
 block/blk-zoned.c                |  14 ++--
 block/fops.c                     |   5 +-
 block/genhd.c                    |   9 +--
 block/mq-deadline.c              |  13 ++--
 drivers/block/brd.c              |   4 +-
 drivers/block/loop.c             |  30 ++++----
 drivers/block/ublk_drv.c         |   2 +-
 drivers/md/raid0.c               |   1 +
 drivers/md/raid1.c               |  20 +++++-
 drivers/md/raid10.c              |  20 +++++-
 drivers/nvme/host/core.c         |  22 ++++--
 drivers/nvme/host/ioctl.c        |  12 +++-
 drivers/nvme/host/multipath.c    |  21 ++++--
 drivers/nvme/host/nvme.h         |  10 ++-
 drivers/nvme/host/pci.c          | 147 ++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/pr.c           | 122 +++++++++++++++++++-------------
 drivers/nvme/host/rdma.c         |   4 +-
 drivers/nvme/target/admin-cmd.c  |   7 +-
 include/linux/blkdev.h           |  20 +++---
 include/linux/nvme.h             |  14 ++++
 rust/kernel/block/mq/gen_disk.rs |   2 +-
 27 files changed, 547 insertions(+), 192 deletions(-)

-- 
Jens Axboe

