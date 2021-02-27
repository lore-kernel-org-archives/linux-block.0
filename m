Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6983FC433DB
	for <linux-block@archiver.kernel.org>; Sat, 27 Feb 2021 19:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3556A64E56
	for <linux-block@archiver.kernel.org>; Sat, 27 Feb 2021 19:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhB0Tyn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Feb 2021 14:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhB0Txe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Feb 2021 14:53:34 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4E3C06174A
        for <linux-block@vger.kernel.org>; Sat, 27 Feb 2021 11:52:53 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id j12so8507575pfj.12
        for <linux-block@vger.kernel.org>; Sat, 27 Feb 2021 11:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=j/p2mRPfybjNatPISg308ATAftRKE38cVAVlBHi28Ak=;
        b=ftBEKzZhgDrEsZl0y6ITw2bLQkJvESfC8+c0LkehBjyRzZVCTQzWwwTt+9qzOUC+Q+
         hB2zAPNCwLJi2TzBfvol4DZTgO9JxAPD4oclwFs1zwEmCi6FapV4J/tcqkPihBrvskIz
         JY4G5z5Pg8UV6Ai6YpVqmV4paX8DnvXs/PlJzwVVZbxbXmRhOQIyq3gYCsaaZky3sO8y
         ZV5kFbadqRswaCmxJi3Wm1mvtp2Q0RW3NS1OClREHYmltoBQTqGoUTOX/WaIi2A5PKcT
         FyLQPWFAOPEtWdEApcdmApiNk3X5hwdrmziKdea9ZQm7gLPTt1OYJDQQufeeiUggXeAE
         vw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=j/p2mRPfybjNatPISg308ATAftRKE38cVAVlBHi28Ak=;
        b=X8bFMzgxflvmlX/NhjJUfTiSHC76fpeYGdogXsclIDR/u7Rlen2/EI/Ggi7r4nqTZ/
         S3fyKB7EmZaTjW9CiqRYJydzRlrOaEXTQPw8UPm+LOdJjW4nySVp3GXzmhJjqTdRhhW3
         PoOs5GIgu0dJd9ejC++XlwZ3kC0kfHvl9MfL55vfcwaEkicp/mjXtLFyPHAI97k4+SaB
         x23waZFmrXJrB477RDeRpAXo1F6aqX6sdDYBxHLKjXtQJodiWhqAjUOgZ5TTNJqGXWL0
         QXRmaeUVMyPPeq6iu/py0hW6+Jc2HXEnIv/Jxmf7i+Zh+XL8a4rBUBmvC94yfj8ZV0ZE
         hDcw==
X-Gm-Message-State: AOAM530y5NRMxZr4xjLTPfPe7N7codddBHd/xg1agblczBJXHecfht2N
        OijsNb2ouWF7QwzOgFRFY0Fo2NI8lkRbYw==
X-Google-Smtp-Source: ABdhPJwzIRtEC+FK0nITi22HHkL/5Dn/ZOHfaoZO7mu3fm76T9ppcRuH3ALU6TB90wiZQi/8ZAN46w==
X-Received: by 2002:a63:2217:: with SMTP id i23mr7715640pgi.437.1614455572554;
        Sat, 27 Feb 2021 11:52:52 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w207sm11598962pff.62.2021.02.27.11.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Feb 2021 11:52:52 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-block@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block fixes for this merge window
Message-ID: <4fb0811b-af58-60db-1c27-ef367876c491@kernel.dk>
Date:   Sat, 27 Feb 2021 12:52:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few stragglers (and one due to me missing it originally), and fixes
for changes in this merge window mostly. In particular:

- blktrace cleanups (Chaitanya, Greg)

- Kill dead blk_pm_* functions (Bart)

- Fixes for the bio alloc changes (Christoph)

- Fix for the partition changes (Christoph, Ming)

- Fix for turning off iopoll with polled IO inflight (Jeffle)

- nbd disconnect fix (Josef)

- loop fsync error fix (Mauricio)

- kyber update depth fix (Yang)

- max_sectors alignment fix (Mikulas)

- Add bio_max_segs helper (Matthew)

Please pull!


The following changes since commit 31caf8b2a847214be856f843e251fc2ed2cd1075:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2021-02-21 17:23:56 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.12-2021-02-27

for you to fetch changes up to 5f7136db82996089cdfb2939c7664b29e9da141d:

  block: Add bio_max_segs (2021-02-26 15:49:51 -0700)

----------------------------------------------------------------
block-5.12-2021-02-27

----------------------------------------------------------------
Bart Van Assche (1):
      block: Remove unused blk_pm_*() function definitions

Chaitanya Kulkarni (6):
      block: remove superfluous param in blk_fill_rwbs()
      blktrace: add blk_fill_rwbs documentation comment
      blktrace: fix blk_rq_issue documentation
      blktrace: fix blk_rq_merge documentation
      block: get rid of the trace rq insert wrapper
      blktrace: fix documentation for blk_fill_rw()

Christoph Hellwig (6):
      block: don't skip empty device in in disk_uevent
      block: reopen the device in blkdev_reread_part
      block-crypto-fallback: use a bio_set for splitting bios
      block: fix bounce_clone_bio for passthrough bios
      block: remove the gfp_mask argument to bounce_clone_bio
      block: memory allocations in bounce_clone_bio must not fail

Greg Kroah-Hartman (1):
      blktrace: remove debugfs file dentries from struct blk_trace

Jeffle Xu (1):
      block: fix potential IO hang when turning off io_poll

Josef Bacik (1):
      nbd: handle device refs for DESTROY_ON_DISCONNECT properly

Matthew Wilcox (Oracle) (1):
      block: Add bio_max_segs

Mauricio Faria de Oliveira (1):
      loop: fix I/O error on fsync() in detached loop devices

Mikulas Patocka (1):
      blk-settings: align max_sectors on "logical_block_size" boundary

Ming Lei (1):
      block: fix logging on capacity change

Yang Yang (1):
      kyber: introduce kyber_depth_updated()

 block/bfq-iosched.c                 |  4 +++-
 block/blk-core.c                    |  1 +
 block/blk-crypto-fallback.c         | 12 ++++++++++--
 block/blk-map.c                     |  4 +---
 block/blk-mq-sched.c                |  6 ------
 block/blk-mq-sched.h                |  1 -
 block/blk-pm.h                      | 38 -------------------------------------
 block/blk-settings.c                | 12 ++++++++++++
 block/blk-sysfs.c                   |  7 +++++--
 block/bounce.c                      | 24 +++++++++++------------
 block/genhd.c                       |  4 ++--
 block/ioctl.c                       | 21 +++++++++++++-------
 block/kyber-iosched.c               | 33 ++++++++++++++++----------------
 block/mq-deadline.c                 |  4 +++-
 drivers/block/loop.c                |  3 +++
 drivers/block/nbd.c                 | 32 ++++++++++++++++++-------------
 drivers/block/xen-blkback/blkback.c |  4 +---
 drivers/md/dm-io.c                  |  4 ++--
 drivers/md/dm-log-writes.c          | 10 +++++-----
 drivers/nvme/target/io-cmd-bdev.c   |  8 ++++----
 drivers/nvme/target/passthru.c      |  4 ++--
 drivers/target/target_core_iblock.c |  9 +++------
 drivers/target/target_core_pscsi.c  |  2 +-
 fs/block_dev.c                      | 10 +++++-----
 fs/direct-io.c                      |  2 +-
 fs/erofs/data.c                     |  4 +---
 fs/ext4/readpage.c                  |  3 +--
 fs/f2fs/data.c                      |  3 +--
 fs/f2fs/node.c                      |  2 +-
 fs/iomap/buffered-io.c              |  4 ++--
 fs/mpage.c                          |  4 +---
 fs/nfs/blocklayout/blocklayout.c    |  6 +++---
 fs/xfs/xfs_bio_io.c                 |  2 +-
 fs/xfs/xfs_buf.c                    |  4 ++--
 include/linux/bio.h                 |  7 ++++++-
 include/linux/blkdev.h              |  1 -
 include/linux/blktrace_api.h        |  4 +---
 include/trace/events/bcache.h       | 10 +++++-----
 include/trace/events/block.h        | 20 +++++++++----------
 kernel/trace/blktrace.c             | 20 ++++++++++++-------
 40 files changed, 173 insertions(+), 180 deletions(-)

-- 
Jens Axboe

