Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4D328A6
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705615964; cv=none; b=hoiXAGzDuKrRhFpMGqbQ08pQ/ADCJ7rEMIfq4BanI+A04oTnN6rvnCEH8qAYTLFacSq2+MBA2CCRAyH8r9RMg+2fqnucXyOdFepyVsjP9ducb2t/8Qn/+dh/e07Vfv0kPjhIjEMP9p3KNt7Q1gBTJZYGwzstlwdsUFkdJqQ2Hqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705615964; c=relaxed/simple;
	bh=ejweAmopLqoa2UVc0ci17Mp0d1XwB9wFhl/XZR2f5/o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XbgIMQc8Of+XZOLeUOW7AXuGt/71gaR7c4yZHS524q0RwJrwZrNWvAyRhN3Fz7s/oEn4L3yMWZ/2d6zbU+rpQVlLnZU5UTixQUozmzdelLin38tCn5XE+u5SesVSKLtcGI60pzXbZp/zkYUSFugF01wHePT20oCr5rO3kL6celU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DKet2m30; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DKet2m30"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28bae84fc2eso41801a91.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 14:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705615960; x=1706220760; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EL1up2cUHWie6P3xALGmZXjLIsbl9Z9q5zJDI/pgN8=;
        b=DKet2m30OGLd8haRSHkmvizv1NvzQiuse6Y1Gfs/Jq9w9arl+JCKphvnh+8Ae+/8Me
         bFzwqWfiuCgIBQjpGSiF3UvtXJQYHIHQEy6wGmEbELMlfXHmRjIbu/i9UXqcA4KofdG+
         qzldM9sVXtjG4X1HeGlprWzadcestm10BFa2BRLg7XnOFdCu628JXVvKAExVm1XiU6ta
         25ZpDHUEhT3o/iYYZPkAN2t10F8oJkg/eP02Dp+zeVULVD6VibNaZ2bCe9/AgZ9F3iF4
         F2INsYURmgeLJEm57df8eArBwUAKP5naKtAD9Kadr5TFA2yAHm2op/mwJPom2QLLW2Zt
         FZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705615960; x=1706220760;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/EL1up2cUHWie6P3xALGmZXjLIsbl9Z9q5zJDI/pgN8=;
        b=NIZQE5LAN+7Od1mKznhJDU8sZSb6LEBudV3F2A71Xdr6dYtZ0PYYY2wpEuaNye79s+
         Dsb3FMYv7VgXG2tFmVnvNm7LhHYeG/mz6hkTWuNVAmv+/ka5VNqYLprB+PIboru1OmPe
         wOWLc5L/hyUNlWyAGds4jLkHCNS5zgq0oavqWjDNY60jTPVwLpRhpIiuTAzXk3v/bm2A
         9MKZWTOkOI8/JWfnogDAAGWgEg4p+IDRiz5Ajrjhfyp+CgS/q0N3GwLd9d4hHy/gMYdh
         BPd85aJQAVhWqnQdMhirceZz74KA5PSKLIRq14PgB3rpvQ9LrXjlUvvzKdipb6rrg6nP
         0HGg==
X-Gm-Message-State: AOJu0YzBnsbiF1wRr3/pLnyRkQPzMqI/GNNsDhBv5TFnhdTpCdkZsyRh
	n4qIQRtLs0WWHb77eZ5TvxnxYSYGnlu4LDjEcX8/nb2lQpti3WZQphLP/Rzaq+HkcuvqImMroic
	n
X-Google-Smtp-Source: AGHT+IE+g9mR7HagoY30npykMl1fe764dZmSfojkTp2EbTs7Vkv36FZhRdpxTm4MunugEfCszDLU9g==
X-Received: by 2002:a17:90b:238d:b0:290:172f:3b1a with SMTP id mr13-20020a17090b238d00b00290172f3b1amr473578pjb.3.1705615960448;
        Thu, 18 Jan 2024 14:12:40 -0800 (PST)
Received: from ?IPV6:2600:380:4a42:5ed:5773:6488:5dc:8499? ([2600:380:4a42:5ed:5773:6488:5dc:8499])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090b004e00b0029020be4298sm2209264pjt.0.2024.01.18.14.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 14:12:39 -0800 (PST)
Message-ID: <78f34b79-cdf9-4240-a25b-90a948490e36@kernel.dk>
Date: Thu, 18 Jan 2024 15:12:38 -0700
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
Subject: [GIT PULL] Followup block fixes for 6.8-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes 

- NVMe pull request via Keith
	- tcp, fc, and rdma target fixes (Maurizio, Daniel, Hannes,
	  Christoph)
	- discard fixes and improvements (Christoph)
	- timeout debug improvements (Keith, Max)
	- various cleanups (Daniel, Max, Giuxen)
	- trace event string fixes (Arnd)
	- shadow doorbell setup on reset fix (William)
	- a write zeroes quirk for SK Hynix (Jim)

- MD pull request via Song
	- Sparse warning since v6.0 (Bart)
	- /proc/mdstat regression since v6.7 (Yu Kuai)

- Use symbolic error value (Christian)

- IO Priority documentation update (Christian)

- Fix for accessing queue limits without having entered the queue
  (Christoph, me)

- Fix for loop dio support (Christoph)

- Move null_blk off deprecated ida interface (Christophe)

- Ensure nbd initializes full msghdr (Eric)

- Fix for a regression with the folio conversion, which is now easier to
  hit because of an unrelated change (Matthew)

- Remove redundant check in virtio-blk (Li)

- Fix for a potential hang in sbitmap (Ming)

- Fix for partial zone appending (Damien)

- Misc changes and fixes (Bart, me, Kemeng, Dmitry)

Please pull!

https://www.bobvila.com/articles/best-generator-brand/

The following changes since commit 587371ed783b046f22ba7a5e1cc9a19ae35123b4:

  block: Treat sequential write preferred zone type as invalid (2024-01-08 08:34:24 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.8/block-2024-01-18

for you to fetch changes up to b2e792ae883a0aa976d4176dfa7dc933263440ea:

  Documentation: block: ioprio: Update schedulers (2024-01-18 08:21:14 -0700)

----------------------------------------------------------------
for-6.8/block-2024-01-18

----------------------------------------------------------------
Arnd Bergmann (2):
      nvmet: re-fix tracing strncpy() warning
      nvme: trace: avoid memcpy overflow warning

Bart Van Assche (2):
      md/raid1: Use blk_opf_t for read and write operations
      blk-mq: Remove the hctx 'run' debugfs attribute

Christian Heusel (1):
      block: print symbolic error name instead of error code

Christian Loehle (1):
      Documentation: block: ioprio: Update schedulers

Christoph Hellwig (8):
      nvme-common: mark nvme_tls_psk_prio static
      nvmet-tcp: fix a missing endianess conversion in nvmet_tcp_try_peek_pdu
      nvme: update the explanation for not updating the limits in nvme_config_discard
      nvme: also skip discard granularity updates in nvme_config_discard
      nvme: fix max_discard_sectors calculation
      nvme: simplify the max_discard_segments calculation
      blk-mq: rename blk_mq_can_use_cached_rq
      loop: fix the the direct I/O support check when used on top of block devices

Christophe JAILLET (1):
      null_blk: Remove usage of the deprecated ida_simple_xx() API

Damien Le Moal (1):
      block: fix partial zone append completion handling in req_bio_endio()

Daniel Wagner (3):
      nvmet-fc: remove unnecessary bracket
      nvmet-trace: avoid dereferencing pointer too early
      nvmet-fcloop: Remove remote port from list when unlinking

Dmitry Antipov (1):
      block: bio-integrity: fix kcalloc() arguments order

Eric Dumazet (1):
      nbd: always initialize struct msghdr completely

Guixin Liu (2):
      nvme: tcp: remove unnecessary goto statement
      nvme: introduce nvme_disk_is_ns_head helper

Hannes Reinecke (2):
      nvmet-tcp: avoid circular locking dependency on install_queue()
      nvmet-rdma: avoid circular locking dependency on install_queue()

Jens Axboe (6):
      block: move __get_task_ioprio() into header file
      block: make __get_task_ioprio() easier to read
      Merge tag 'md-6.8-20240109' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.8/block
      block/iocost: silence warning on 'last_period' potentially being unused
      Merge tag 'nvme-6.8-2024-1-10' of git://git.infradead.org/nvme into for-6.8/block
      block: ensure we hold a queue reference when using queue limits

Jim.Lin (1):
      nvme-pci: disable write zeroes for SK Hynix BC901

Keith Busch (1):
      nvme-pci: enhance timeout kernel log

Kemeng Shi (1):
      sbitmap: remove stale comment in sbq_calc_wake_batch

Li RongQing (1):
      virtio_blk: remove duplicate check if queue is broken in virtblk_done

Matthew Wilcox (Oracle) (1):
      block: Fix iterating over an empty bio with bio_for_each_folio_all

Maurizio Lombardi (4):
      nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length
      nvmet-tcp: fix a crash in nvmet_req_complete()
      nvmet-tcp: remove boilerplate code
      nvmet-tcp: Fix the H2C expected PDU len calculation

Max Gurtovoy (3):
      nvme: remove unused definition
      nvme-rdma: enhance timeout kernel log
      nvme-tcp: enhance timeout kernel log

Ming Lei (1):
      blk-mq: fix IO hang from sbitmap wakeup race

Nicky Chorley (1):
      block: Correct a documentation comment in blk-cgroup.c

William Butler (1):
      nvme-pci: set doorbell config before unquiescing

Yu Kuai (1):
      md: Fix md_seq_ops() regressions

 Documentation/block/ioprio.rst | 13 +++++------
 block/bio-integrity.c          |  2 +-
 block/blk-cgroup.c             |  2 +-
 block/blk-iocost.c             |  2 +-
 block/blk-mq-debugfs.c         | 18 ---------------
 block/blk-mq-sched.c           |  2 --
 block/blk-mq.c                 | 50 +++++++++++++++++++++++++++++++---------
 block/ioprio.c                 | 26 ---------------------
 block/partitions/core.c        |  4 ++--
 drivers/block/loop.c           | 52 ++++++++++++++++++++----------------------
 drivers/block/nbd.c            |  6 +----
 drivers/block/null_blk/main.c  |  4 ++--
 drivers/block/virtio_blk.c     |  2 --
 drivers/md/md.c                | 40 +++++++++++++++++++++-----------
 drivers/md/raid1.c             | 12 +++++-----
 drivers/nvme/common/keyring.c  |  2 +-
 drivers/nvme/host/core.c       | 41 ++++++++++++++++-----------------
 drivers/nvme/host/nvme.h       | 16 ++++++++++---
 drivers/nvme/host/pci.c        | 27 +++++++++++++---------
 drivers/nvme/host/pr.c         |  2 +-
 drivers/nvme/host/rdma.c       | 11 ++++++---
 drivers/nvme/host/sysfs.c      |  8 +++----
 drivers/nvme/host/tcp.c        | 11 ++++-----
 drivers/nvme/target/fc.c       |  2 +-
 drivers/nvme/target/fcloop.c   |  7 ++----
 drivers/nvme/target/rdma.c     | 19 ++++++++++++---
 drivers/nvme/target/tcp.c      | 48 +++++++++++++++++++++++++++++---------
 drivers/nvme/target/trace.c    |  6 ++---
 drivers/nvme/target/trace.h    | 33 +++++++++++++++------------
 include/linux/bio.h            |  9 +++++---
 include/linux/blk-mq.h         |  3 ---
 include/linux/ioprio.h         | 25 +++++++++++++++++++-
 include/linux/nvme.h           |  1 -
 lib/sbitmap.c                  |  5 ----
 34 files changed, 287 insertions(+), 224 deletions(-)

-- 
Jens Axboe

