Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E69C433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 15:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088CF61131
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 15:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhD0PBP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 11:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbhD0PBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 11:01:13 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721DEC061574
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 08:00:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id l21so16669219iob.1
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 08:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Uips1egR18RO/jqRak2AvlIeEgWfB3yVE8Rwqpevq8g=;
        b=2PTSrMNwHko178XXGPDO2ku5RmXBA9J4DkNNkh35yKJJU5uSh0Wx0x/DFqf9xso8fx
         L0dfLS+w6CLwxPNxR5nXb/EScXdEbTi8oR24GrDd3NGYkwdlXN40vkrjnIvS/aN76+qQ
         DDqzqHAk53i4/SODKhpwDwfQuGmf/QU8FOQZolD2HAXc+BciDpFz62q0h8Urg7rQPwUX
         GlkOfw71Dpre0i2NiTyR4g8PEEGH/LM3QpIA/DIvORBKKfCpgSGXEapQolBhBnjJLNr6
         U9YQ0PxMUo0Jw+32koWqN5FbeJWZ/VabmjVKhZvgfQJC9Ng4Qvgzh7CSOjYzft5yyij3
         74Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Uips1egR18RO/jqRak2AvlIeEgWfB3yVE8Rwqpevq8g=;
        b=hC+AfHufqfUetgnlkBHPMWwG8dFfcHo8nB8vWyNnzkbJtrG+YTP+fpMZOKpOj/DmH6
         zdBKGCgzzpfImrb3dSNBnQDBwHeYXNkCboSHEg7rZYE9oN55ZagLW3+EflV3wgSacL/C
         XhXNvmh0gX//pAlhzNhM0tx6cXeMqx4xsFc+vED5Z3Pb41hFJuHlpkDHRJZuu+f4h1Zj
         5NInXXUK7jkdmUJAfU1NG4x6h6kbSM/O5oifXTNjdIFZnaQfqAFQpPEM5XYsZf7zTkED
         qu5xf1kxZCtdirr8eX7unPAtjeG90RENmMtLQfhabDenHkkNntFTd8jClz1euzgRbht1
         0BXA==
X-Gm-Message-State: AOAM531Bc2MgucQtEdQHHQ8wFowfex85dJZ2+UP4Mpz7CWKcWK9A/Xuq
        AQNCL9VFCrBGOStfiGp6OxjN2CWyzaa8ZA==
X-Google-Smtp-Source: ABdhPJwcIWBGjf9602S6DEDvkDJ5Z6RpEreEoYkPtercsEpMBmTxkb7GGNmbWszN1jE1RpbDRZuWQA==
X-Received: by 2002:a02:6951:: with SMTP id e78mr21832654jac.56.1619535628615;
        Tue, 27 Apr 2021 08:00:28 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o6sm58440ioa.21.2021.04.27.08.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 08:00:27 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Core block changes for 5.13-rc
Message-ID: <e0a1b214-e3db-c7fa-dde1-8a5d93f2ff46@kernel.dk>
Date:   Tue, 27 Apr 2021 09:00:27 -0600
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

Pretty quiet round this time, which is nice. In detail:

- Series revamping bounce buffer support (Christoph)

- Dead code removal (Christoph, Bart)

- Partition iteration revamp, now using xarray (Christoph)

- Passthrough request scheduler improvements (Lin)

- Series of BFQ improvements (Paolo)

- Fix ioprio task iteration (Peter)

- Various little tweaks and fixes (Tejun, Saravanan, Bhaskar, Max,
  Nikolay)

Please pull!


The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.13/block-2021-04-27

for you to fetch changes up to f46ec84b5acbf8d7067d71a6bbdde213d4b86036:

  blk-iocost: don't ignore vrate_min on QD contention (2021-04-26 06:44:18 -0600)

----------------------------------------------------------------
for-5.13/block-2021-04-27

----------------------------------------------------------------
Bart Van Assche (2):
      blk-zoned: Remove the definition of blk_zone_start()
      block: Remove an obsolete comment from sg_io()

Bhaskar Chowdhury (1):
      blk-mq: Sentence reconstruct for better readability

Christoph Hellwig (23):
      aha1542: use a local bounce buffer
      Buslogic: remove ISA support
      BusLogic: reject broken old firmware that requires ISA-style bounce buffering
      advansys: remove ISA support
      scsi: remove the unchecked_isa_dma flag
      block: remove BLK_BOUNCE_ISA support
      block: refactor the bounce buffering code
      block: stop calling blk_queue_bounce for passthrough requests
      dasd: use bdev_disk_changed instead of blk_drop_partitions
      block: remove invalidate_partition
      block: move more syncing and invalidation to delete_partition
      block: refactor blk_drop_partitions
      block: take bd_mutex around delete_partitions in del_gendisk
      block: simplify partition removal
      block: simplify partition_overlaps
      block: simplify printk_all_partitions
      block: simplify show_partition
      block: simplify diskstats_show
      block: remove disk_part_iter
      block: initialize ret in bdev_disk_changed
      block: remove an incorrect check from blk_rq_append_bio
      block: remove zero_fill_bio_iter
      block: move bio_list_copy_data to pktcdvd

Jeffle Xu (1):
      block: add queue_to_disk() to get gendisk from request_queue

Lin Feng (2):
      blk-mq: bypass IO scheduler's limit_depth for passthrough request
      bfq/mq-deadline: remove redundant check for passthrough request

Max Gurtovoy (1):
      block: add sysfs entry for virt boundary mask

Ming Lei (1):
      blk-mq: set default elevator as deadline in case of hctx shared tagset

Nikolay Borisov (1):
      blk-mq: Always use blk_mq_is_sbitmap_shared

Paolo Valente (6):
      block, bfq: always inject I/O of queues blocked by wakers
      block, bfq: put reqs of waker and woken in dispatch list
      block, bfq: make shared queues inherit wakers
      block, bfq: fix weight-raising resume with !low_latency
      block, bfq: keep shared queues out of the waker mechanism
      block, bfq: merge bursts of newly-created queues

Peter Zijlstra (1):
      block: Fix sys_ioprio_set(.which=IOPRIO_WHO_PGRP) task iteration

Saravanan D (1):
      blk-mq: Fix spurious debugfs directory creation during initialization

Tejun Heo (1):
      blk-iocost: don't ignore vrate_min on QD contention

 Documentation/scsi/BusLogic.rst         |  26 +--
 Documentation/scsi/scsi_mid_low_api.rst |   4 -
 block/bfq-cgroup.c                      |   2 +
 block/bfq-iosched.c                     | 398 ++++++++++++++++++++++++++++++--
 block/bfq-iosched.h                     |  15 ++
 block/bfq-wf2q.c                        |   8 +
 block/bio-integrity.c                   |   3 +-
 block/bio.c                             |  43 +---
 block/blk-core.c                        |   6 +-
 block/blk-iocost.c                      |   4 -
 block/blk-map.c                         | 119 +++-------
 block/blk-mq-debugfs.c                  |   8 +
 block/blk-mq-tag.c                      |   8 +-
 block/blk-mq.c                          |   3 +-
 block/blk-settings.c                    |  53 +----
 block/blk-sysfs.c                       |   9 +-
 block/blk-zoned.c                       |   8 -
 block/blk.h                             |  18 +-
 block/bounce.c                          | 138 ++---------
 block/elevator.c                        |   3 +-
 block/genhd.c                           | 183 +++++----------
 block/ioprio.c                          |  11 +-
 block/mq-deadline.c                     |   7 +-
 block/partitions/core.c                 |  54 ++---
 block/scsi_ioctl.c                      |   6 +-
 drivers/ata/libata-scsi.c               |   3 +-
 drivers/block/pktcdvd.c                 |  36 +++
 drivers/nvme/host/lightnvm.c            |   2 +-
 drivers/s390/block/dasd_genhd.c         |   3 +-
 drivers/scsi/BusLogic.c                 | 205 +---------------
 drivers/scsi/BusLogic.h                 |  11 -
 drivers/scsi/Kconfig                    |   2 +-
 drivers/scsi/advansys.c                 | 321 +++-----------------------
 drivers/scsi/aha1542.c                  | 105 +++++----
 drivers/scsi/esas2r/esas2r_main.c       |   1 -
 drivers/scsi/hosts.c                    |   7 +-
 drivers/scsi/scsi_debugfs.c             |   1 -
 drivers/scsi/scsi_lib.c                 |  52 +----
 drivers/scsi/scsi_scan.c                |   6 +-
 drivers/scsi/scsi_sysfs.c               |   2 -
 drivers/scsi/sg.c                       |  10 +-
 drivers/scsi/sr_ioctl.c                 |  12 +-
 drivers/scsi/st.c                       |  20 +-
 drivers/scsi/st.h                       |   2 -
 drivers/target/target_core_pscsi.c      |   4 +-
 fs/block_dev.c                          |  10 +-
 include/linux/bio.h                     |   8 +-
 include/linux/blkdev.h                  |  46 ++--
 include/linux/genhd.h                   |  21 +-
 include/scsi/scsi_cmnd.h                |   7 +-
 include/scsi/scsi_host.h                |   6 -
 include/trace/events/kyber.h            |   6 +-
 mm/Kconfig                              |   9 +-
 53 files changed, 788 insertions(+), 1267 deletions(-)

-- 
Jens Axboe

