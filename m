Return-Path: <SRS0=Vt9R=CB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4433BC433DF
	for <linux-block@archiver.kernel.org>; Sun, 23 Aug 2020 19:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC9D20656
	for <linux-block@archiver.kernel.org>; Sun, 23 Aug 2020 19:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tKkrIaR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgHWT1x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Aug 2020 15:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHWT1w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Aug 2020 15:27:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617BC061573
        for <linux-block@vger.kernel.org>; Sun, 23 Aug 2020 12:27:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so3697162pfn.0
        for <linux-block@vger.kernel.org>; Sun, 23 Aug 2020 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LEEXHCAXKMYgmwhcZCxvMPkGXWMscuNK2wQdObRXpjM=;
        b=tKkrIaR1qjmzeSJsPEnUTWwvHaihOs3guuVFc2LZgqIjmZ8vhHMg3lGSjpZMJq02Fm
         nDEDjC7hYaSH50wn8GGOFVO3Y5qHl8ligQ23huJZbKKOY1HvfzfEPRb//u75Rq9EpKoG
         F47gNhoSQ5T0bTgJcLk0jWvLZJVJJHNynhh3dz0N4pQHtZUnmzMYg4xasZXAnNSDjhRx
         MAzV5kbn499/o9Eb4zjKT/2UfFtCdrdsRng0Ht/ypM+zdm/aVLx90nNaQ9f1ZH2X2LPW
         2H3a7OQSy2Ktv6YAk3dHJI1eyeex2Thg4Z2vij0bRjP9tpIOlTYh87JNsCKBAEp9Gvzv
         5crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LEEXHCAXKMYgmwhcZCxvMPkGXWMscuNK2wQdObRXpjM=;
        b=IHAUGnzIjqUv9/757WpuU7So/DQ7n6fKCK/xJvYhuYB0sl0Dpc9Fhwahu36bokyUz6
         9AQOInbO+iViNnU5jfL1Zf947kqzsxLt0d4emjG/ZglnUpM1xf2OuteolBIaOhoLfsBo
         pxhjg+NkDrcc5XvGAbFMIWsMwbHf0IuExHiTItekq2iCE1Ikkm5gtiZDy1eHSDndGkRf
         whp1gGAkfiB7uQv9Xq0ofaO+jIsWWcvBlZwWXXWMwLL1IWa1mEDJovuz3rgAkwPjxg85
         MgNYcAWbemMHG3qB6Y9YzNmMOkoUEYFC+uU7fACZtgomzIu7u3xS8IZ5W+wZxDh2wWdg
         aCMw==
X-Gm-Message-State: AOAM532k4zLq6WNrYmzHl9jNdmdUFNUeMwJqLYKQ7/RznC7mBrdPNPIc
        qZckBLKWrBoDnKFMuLAP4I4OWqstaHtn/8sG
X-Google-Smtp-Source: ABdhPJzM/x1QC3YfLPU/xLb4Tuleo0cAM3rFdH8yjrD9Jx9GrKskxJCeG3LssjgyVNdRShDQuMPPGA==
X-Received: by 2002:a63:ec18:: with SMTP id j24mr1381927pgh.74.1598210869764;
        Sun, 23 Aug 2020 12:27:49 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z6sm8931946pfg.68.2020.08.23.12.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 12:27:49 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.9-rc2
Message-ID: <4945e1c2-a6dd-2827-e7ff-db7aa7ee3bec@kernel.dk>
Date:   Sun, 23 Aug 2020 13:27:48 -0600
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

- NVMe pull request from Sagi:
	- nvme completion rework from Christoph and Chao that mostly
	  came from a bit of divergence of how we classify errors related
	  to pathing/retry etc.
	- nvmet passthru fixes from Chaitanya
	- minor nvmet fixes from Amit and I
	- mpath round-robin path selection fix from Martin
	- ignore noiob for zoned devices from Keith
	- minor nvme-fc fix from Tianjia"

- BFQ cgroup leak fix (Dmitry)

- Block layer MAINTAINERS addition (Geert)

- Fix null_blk FUA checking (Hou)

- get_max_io_size() size fix (Keith)

- Fix block page_is_mergeable() for compound pages (Matthew)

- Discard granularity fixes (Ming)

- IO scheduler ordering fix (Ming)

- Misc fixes


The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/io_uring-5.9-2020-08-23

for you to fetch changes up to 2d62e6b038e729c3e4bfbfcfbd44800ef0883680:

  null_blk: fix passing of REQ_FUA flag in null_handle_rq (2020-08-21 17:14:28 -0600)

----------------------------------------------------------------
io_uring-5.9-2020-08-23

----------------------------------------------------------------
Amit Engel (1):
      nvmet: Disable keep-alive timer when kato is cleared to 0h

Chaitanya Kulkarni (3):
      nvmet: add ns tear down label for pt-cmd handling
      nvmet: fix oops in pt cmd execution
      nvmet: call blk_mq_free_request() directly

Chao Leng (1):
      nvme: redirect commands on dying queue

Christoph Hellwig (4):
      nvme-pci: fix PRP pool size
      nvme: rename and document nvme_end_request
      nvme: refactor command completion
      nvme: just check the status code type in nvme_is_path_error

Dmitry Monakhov (1):
      bfq: fix blkio cgroup leakage v4

Geert Uytterhoeven (1):
      MAINTAINERS: Add missing header files to BLOCK LAYER section

Hou Pu (1):
      null_blk: fix passing of REQ_FUA flag in null_handle_rq

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

Tianjia Zhang (1):
      nvme-fc: Fix wrong return value in __nvme_fc_init_request()

Xu Wang (1):
      bsg-lib: convert comma to semicolon

Yufen Yu (1):
      blkcg: fix memleak for iolatency

 .../fault-injection/nvme-fault-injection.rst       |  2 +-
 MAINTAINERS                                        |  1 +
 block/bfq-cgroup.c                                 |  2 +-
 block/bfq-iosched.h                                |  1 -
 block/bfq-wf2q.c                                   | 12 +--
 block/bio.c                                        | 10 +--
 block/blk-cgroup.c                                 |  8 +-
 block/blk-merge.c                                  | 13 +++-
 block/blk-mq-sched.c                               |  9 +++
 block/blk-mq.c                                     | 13 +++-
 block/bsg-lib.c                                    |  2 +-
 drivers/block/loop.c                               | 33 +++++----
 drivers/block/null_blk_main.c                      |  2 +-
 drivers/block/rnbd/rnbd-srv.c                      |  3 +-
 drivers/block/virtio_blk.c                         | 31 ++++++--
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
 26 files changed, 238 insertions(+), 153 deletions(-)

-- 
Jens Axboe

