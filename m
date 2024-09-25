Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC21D520
	for <linux-block@vger.kernel.org>; Wed, 25 Sep 2024 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287534; cv=none; b=GGRSy3rYRDOjAEqxNhut2yKywjcFgVZ2b7KyRK1r5jfRM5Yx+Znk2qfLeFbVNIP5K8ITgExrqYsnkzKHtiMntFsEe/U4w9ns1xUBOrhKZyKRLLj0v1rDOpOZCTt7WIg5qoi0VXLHxlJrTv8EQiGyu9XybSDxrfqvQOF+gqLNVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287534; c=relaxed/simple;
	bh=2MHve0IeOxhzOxRySS5wLvx2aGWmXWXIMXvvawp0p5A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gvgUKymdAVlATwCpzHynndjXBbJl37ftzGwnw5tyfGlYAn/+EVdBqlB/gUuD3DK39oIPfvzMV0Hs0cZjitvLeRz+NGfvHM0UjN2hQpyI/TkdbxzQPc2g3z8Ib98NATmUvuHRx/n50Jf0/aLDCOmqvJs2ciqzglU8Dp84POqDjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JuAfE6Ip; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JuAfE6Ip"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cc8782869so622055e9.2
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2024 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727287530; x=1727892330; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KT0YUSPAQkK42xmsmxuABtFmcbyV2t1+fgEu8r7jc0=;
        b=JuAfE6IpZO0AEEykzf9nQDuX0RlB0yhHsouLwOECzaCdzl2pBySttCPkVUNMtA+gKa
         Fxr4IP8pEonrVQH6s2xpPUauD9lhWGdCyrRL1PNZmKQcZbjt9ddVn3jdz7XWOWQw23rs
         33DI0XHGUMsnttI8j92arOACOz6swVOLrDHLpaCCTABGVKn+eixrP+dg6OlyV7KbuYbb
         O0fr7n8Sp9A6Z+lP9NSvVpikjcmmiFoYhcVV+GCHc/ZNUtg69EDHbW1fgtgaAb2+rLRq
         +MX9bLG7T7bZQfr3JPh3+lRw2PTSWxDYmGYtrpZPOretPythGR5KP7b5pWkxbpPoS0RT
         qQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727287530; x=1727892330;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9KT0YUSPAQkK42xmsmxuABtFmcbyV2t1+fgEu8r7jc0=;
        b=GrHr1ksvH9IOgbwoAPDDNdEWz5XNVMPWstiYzxqdEvguRg07speWsswqeJv5wQG1I6
         ZJKcTiME2oL5CMtU6t7wp4jfwiYBkfKNIDjFJEAoIpOKAI5keFWihR9GxS1u0OAyH0u1
         SFy14LDLsDOd6yjqHPILgzHqep1pIv6Ckq2Cg2KB8M3UdCvaR7+CO9xUmYiffhcPLeVe
         uBCkFxUFBmSrd9t6mvdwf1IJixVYDS7Ir0hsEA0CU1rIzGQUB5wLElPUbR/73ds65LF4
         hFnmt1CoFUoJ2BuI9ABJE7IsvIeVsOIjqxxZ/DpGs9Zs3bLGDR7JlqH7e92FMHdzgR0c
         EcVQ==
X-Gm-Message-State: AOJu0YxRCzMlPQGPbQviU+hSNYEhCy1tuaLfoQGan/bsaMKTj9qVWzT+
	nrYzQhP97tzBeSq9uVcPgZEoBoRqAUPg/AqdeiBinA+ZrsKcWW+1P5J1MwKnvHKIfOjL5uhQAa3
	SpBWgxA==
X-Google-Smtp-Source: AGHT+IHt2/vdb4w3+iPS7lp7zSDHrVB1Q1rRHZJJn+Bh2UGhukiLjRteKe8wuai+hUiBRdxL8CDXbA==
X-Received: by 2002:a05:600c:45d0:b0:42c:e0da:f155 with SMTP id 5b1f17b1804b1-42e96109f23mr30635095e9.11.1727287530111;
        Wed, 25 Sep 2024 11:05:30 -0700 (PDT)
Received: from [172.20.13.161] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a1f2aasm25030795e9.45.2024.09.25.11.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 11:05:29 -0700 (PDT)
Message-ID: <fb8ac999-d7d3-4037-a7d7-c13a1400a820@kernel.dk>
Date: Wed, 25 Sep 2024 12:05:28 -0600
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
Subject: [GIT PULL] Followup block changes for 6.12-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Some followup fixes and changes for the block area that should go into
the 6.12-rc1 release. This pull request contains:

- Series from Keith improving blk-integrity segment counting and merging

- NVMe pull request via Keith
	- Multipath fixes (Hannes)
	- Sysfs attribute list NULL terminate fix (Shin'ichiro)
	- Remove problematic read-back (Keith)

- Fix for a regression with the IO scheduler switching freezing from
  6.11 (Damien)

- Use a raw spinlock for sbitmap, as it may get called from preempt
  disabled context (Ming)

- Cleanup for bd_claiming waiting, using var_waitqueue() rather than the
  bit waitqueues, as that more accurately describes that it does (Neil)

- Various cleanups (Kanchan, Qiu-ji, David)

Note that due to the regression fix from Damien, 6.11 was merged into
this branch as the fix would otherwise not apply.

Please pull!


The following changes since commit 98f7e32f20d28ec452afb208f9cffc08448a2652:

  Linux 6.11 (2024-09-15 16:57:56 +0200)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.12/block-20240925

for you to fetch changes up to a045553362b53fb8f34bb1c3e5de5e020af79550:

  Merge tag 'nvme-6.12-2024-09-25' of git://git.infradead.org/nvme into for-6.12/block (2024-09-25 03:29:17 -0600)

----------------------------------------------------------------
for-6.12/block-20240925

----------------------------------------------------------------
Damien Le Moal (1):
      block: Fix elv_iosched_local_module handling of "none" scheduler

Dr. David Alan Gilbert (1):
      block: Remove unused blk_limits_io_{min,opt}

Hannes Reinecke (2):
      nvme-multipath: system fails to create generic nvme device
      nvme-multipath: avoid hang on inaccessible namespaces

Jens Axboe (2):
      Merge tag 'v6.11' into for-6.12/block
      Merge tag 'nvme-6.12-2024-09-25' of git://git.infradead.org/nvme into for-6.12/block

Kanchan Joshi (1):
      block: remove bogus union

Keith Busch (10):
      blk-mq: unconditional nr_integrity_segments
      blk-mq: set the nr_integrity_segments from bio
      blk-integrity: properly account for segments
      blk-integrity: consider entire bio list for merging
      block: provide a request helper for user integrity segments
      scsi: use request to get integrity segments
      nvme-rdma: use request to get integrity segments
      block: unexport blk_rq_count_integrity_sg
      blk-integrity: improved sg segment mapping
      nvme: remove CC register read-back during enabling

Ming Lei (1):
      lib/sbitmap: define swap_lock as raw_spinlock_t

NeilBrown (1):
      block: change wait on bd_claiming to use a var_waitqueue

Qiu-ji Chen (1):
      drbd: Fix atomicity violation in drbd_uuid_set_bm()

Shin'ichiro Kawasaki (1):
      nvme: null terminate nvme_tls_attrs

 block/bdev.c                   |  4 ++--
 block/bio-integrity.c          |  1 -
 block/blk-integrity.c          | 36 ++++++++++++++++++++---------
 block/blk-merge.c              |  4 ++++
 block/blk-mq.c                 |  5 ++--
 block/blk-settings.c           | 42 ----------------------------------
 block/elevator.c               |  4 +++-
 drivers/block/drbd/drbd_main.c |  6 +++--
 drivers/nvme/host/core.c       |  5 ----
 drivers/nvme/host/ioctl.c      |  6 ++---
 drivers/nvme/host/multipath.c  | 14 +++++++++---
 drivers/nvme/host/rdma.c       |  6 ++---
 drivers/nvme/host/sysfs.c      |  1 +
 drivers/scsi/scsi_lib.c        | 12 +++-------
 include/linux/blk-integrity.h  | 15 ++++++++----
 include/linux/blk-mq.h         |  3 ---
 include/linux/blk_types.h      |  4 +---
 include/linux/blkdev.h         |  2 --
 include/linux/sbitmap.h        |  2 +-
 lib/sbitmap.c                  |  4 ++--
 20 files changed, 76 insertions(+), 100 deletions(-)

-- 
Jens Axboe

