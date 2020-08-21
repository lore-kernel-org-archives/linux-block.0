Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0572BC433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD92920724
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="n5wCqOmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgHUUv1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgHUUvZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 16:51:25 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110ADC061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 13:51:25 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 77so2514725ilc.5
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 13:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vxXe+aAQ2LX4X7MMumyucucau5qpBLeA49z8U/uUCLg=;
        b=n5wCqOmUaN3PvlmbrEaOV79NVdJBfd2z8NIUKAtxC4PMEhIsI6XFONaydl0RMWjb/O
         I1K8gKccm2BuqsEUtzrDm3JyjNFWGX/w3RK/56dXeIV45pWp64Y2s92PISOEfkQ7VtCz
         k1Te2zSOCXXFNgA99AFiTCH2/kLWLxD8F+n6Q6Jy8iSmCfXCSbxeYoWpFufwT+3Sr8cL
         a2FWaOddnaT8VHtxWWm12PLi/618ZwRpwKad7KYLiNs1TEDRRzSQtV/ARbpE+2WIgywC
         e/WIugvZMGyS4O2X4ql6Ho1HhVY5RwdHyVMqZFkKe+yoVv/JJvUJw8u+7nzfAdnoip7+
         eItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=vxXe+aAQ2LX4X7MMumyucucau5qpBLeA49z8U/uUCLg=;
        b=m3mt+hX9mj0+21iEFmaQFMCJqkCVygrZJcJM6fxo3uAENpYmcsZP1lGZnyDHP0976f
         CFOV6T3Xc8kd1/MiGrR1KZWxLYmknvBnLWmFwV+6z3NDqjgMawZVc1b2m49eGKkKwTfG
         X/I1No9D8E1ZVmoCxmdNzzvb4l7x/M47jQgTp2mvCYRxOtoKY7lkujNVEp/F4SixJKBV
         bPm00YKgAuSds5Zt8DJEGS/1/5rdbpkKYNVJ1Onui+dEhjNzBW6yqNO2h8swdTY3+2r5
         dd1xAZvKO0Qg0hHUbm2Q43xZ11P2F91jR3cmnENphOD1PXnhjdgZXOslJ4pskGQJrphT
         DvAA==
X-Gm-Message-State: AOAM5331dLElLsIgXGA2bS8Sk2BAYESOEKJoGA84y87gwNTQBpnFdGeT
        wejZNCpDTl0ZyPedmk8w9lH1xV05Q1Nlz4Mp
X-Google-Smtp-Source: ABdhPJxnKCSMlNdz4raIJDtmiqWrpjKOkKM1AZrS+KFzFJK61YHhcT94FZusRWowiT1jyYb+d9eO1g==
X-Received: by 2002:a92:c80f:: with SMTP id v15mr4128944iln.112.1598043083767;
        Fri, 21 Aug 2020 13:51:23 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 13sm1861923ilj.49.2020.08.21.13.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 13:51:23 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.9-rc2
Message-ID: <2e213354-a1f8-cdb6-0f3c-24473a2a2ef8@kernel.dk>
Date:   Fri, 21 Aug 2020 14:51:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Some general fixes, and a bit of late stragglers that missed -rc1 and
really should have been there. Nothing major, though. In detail:

- NVMe pull request from Sagi:
	- nvme completion rework from Christoph and Chao that mostly
	  came from a bit of divergence of how we classify errors related
	  to pathing/retry etc.
	- nvmet passthru fixes from Chaitanya
	- minor nvmet fixes from Amit and I
	- mpath round-robin path selection fix from Martin
	- ignore noiob for zoned devices from Keith
	- minor nvme-fc fix from Tianjia"

- Deprecate /dev/raw*, we've been using O_DIRECT on the block device
  for almost two decades at this point (Christoph).

- BFQ cgroup leak fix (Dmitry)

- Block layer MAINTAINERS addition (Geert)

- Cleanup rpm_status non-enum status (Geert)

- Fix null_blk FUA checking (Hou)

- get_max_io_size() size fix (Keith)

- Fix block page_is_mergeable() for compound pages (Matthew)

- Discard granularity fixes (Ming)

- IO scheduler ordering fix (Ming)

- Misc fixes

Please pull!



The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.9-2020-08-21

for you to fetch changes up to 2113d4f63da33fb960c4e276101a06c1a06c6e5e:

  virtio-blk: Use kobj_to_dev() instead of container_of() (2020-08-21 08:44:51 -0600)

----------------------------------------------------------------
block-5.9-2020-08-21

----------------------------------------------------------------
Amit Engel (1):
      nvmet: Disable keep-alive timer when kato is cleared to 0h

Chaitanya Kulkarni (3):
      nvmet: add ns tear down label for pt-cmd handling
      nvmet: fix oops in pt cmd execution
      nvmet: call blk_mq_free_request() directly

Chao Leng (1):
      nvme: redirect commands on dying queue

Christoph Hellwig (5):
      raw: deprecate the raw driver
      nvme-pci: fix PRP pool size
      nvme: rename and document nvme_end_request
      nvme: refactor command completion
      nvme: just check the status code type in nvme_is_path_error

Dmitry Monakhov (1):
      bfq: fix blkio cgroup leakage v4

Geert Uytterhoeven (2):
      MAINTAINERS: Add missing header files to BLOCK LAYER section
      block: Make request_queue.rpm_status an enum

Hou Pu (1):
      null_blk: fix passing of REQ_FUA flag in null_handle_rq

Jens Axboe (1):
      Merge branch 'nvme-5.9-rc' of git://git.infradead.org/nvme into block-5.9

John Garry (1):
      nvme-pci: Use u32 for nvme_dev.q_depth and nvme_queue.q_depth

Keith Busch (2):
      block: fix get_max_io_size()
      nvme: skip noiob for zoned devices

Logan Gunthorpe (2):
      nvmet-passthru: Reject commands with non-sgl flags set
      nvme: Use spin_lock_irq() when taking the ctrl->lock

Martin Wilck (2):
      nvme: multipath: round-robin: fix single non-optimized path case
      nvme: multipath: round-robin: eliminate "fallback" variable

Matthew Wilcox (Oracle) (1):
      block: Fix page_is_mergeable() for compound pages

Miaohe Lin (1):
      block: Convert to use the preferred fallthrough macro

Ming Lei (5):
      blk-mq: order adding requests to hctx->dispatch and checking SCHED_RESTART
      block: loop: set discard granularity and alignment for block device backed loop
      block: respect queue limit of max discard segment
      block: virtio_blk: fix handling single range discard request
      blk-mq: insert request not through ->queue_rq into sw/scheduler queue

Nathan Chancellor (1):
      block/rnbd: Ensure err is always initialized in process_rdma

Randy Dunlap (1):
      block: blk-mq.c: fix @at_head kernel-doc warning

Sagi Grimberg (1):
      nvmet: fix a memory leak

Tian Tao (1):
      virtio-blk: Use kobj_to_dev() instead of container_of()

Tianjia Zhang (1):
      nvme-fc: Fix wrong return value in __nvme_fc_init_request()

Xu Wang (1):
      bsg-lib: convert comma to semicolon

Yufen Yu (1):
      blkcg: fix memleak for iolatency

 .../fault-injection/nvme-fault-injection.rst       |  2 +-
 MAINTAINERS                                        |  1 +
 block/badblocks.c                                  |  2 +-
 block/bfq-cgroup.c                                 |  2 +-
 block/bfq-iosched.c                                |  4 +-
 block/bfq-iosched.h                                |  1 -
 block/bfq-wf2q.c                                   | 12 +--
 block/bio.c                                        | 10 +--
 block/blk-cgroup.c                                 |  8 +-
 block/blk-merge.c                                  | 13 +++-
 block/blk-mq-sched.c                               |  9 +++
 block/blk-mq.c                                     | 13 +++-
 block/blk-wbt.c                                    |  2 +-
 block/bsg-lib.c                                    |  2 +-
 block/ioprio.c                                     |  2 +-
 drivers/block/loop.c                               | 33 +++++----
 drivers/block/null_blk_main.c                      |  2 +-
 drivers/block/rnbd/rnbd-srv.c                      |  3 +-
 drivers/block/virtio_blk.c                         | 33 ++++++---
 drivers/char/raw.c                                 |  5 ++
 drivers/nvme/host/core.c                           | 86 ++++++++++++++--------
 drivers/nvme/host/fc.c                             |  6 +-
 drivers/nvme/host/multipath.c                      | 69 +++++++----------
 drivers/nvme/host/nvme.h                           | 31 +++++++-
 drivers/nvme/host/pci.c                            | 17 +++--
 drivers/nvme/host/rdma.c                           |  2 +-
 drivers/nvme/host/tcp.c                            |  4 +-
 drivers/nvme/target/configfs.c                     |  1 +
 drivers/nvme/target/core.c                         |  6 ++
 drivers/nvme/target/loop.c                         |  2 +-
 drivers/nvme/target/passthru.c                     | 25 +++++--
 include/linux/blkdev.h                             |  3 +-
 32 files changed, 251 insertions(+), 160 deletions(-)

-- 
Jens Axboe

