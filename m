Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBF7C07E96
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 15:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DD661921
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 15:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhGHPjr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhGHPjq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jul 2021 11:39:46 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D40C061574
        for <linux-block@vger.kernel.org>; Thu,  8 Jul 2021 08:37:05 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so6237465oti.2
        for <linux-block@vger.kernel.org>; Thu, 08 Jul 2021 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wrLRQHTEo+T+wjARQjSV6Y2vXRpdwdJ/x/NE+UKNnH0=;
        b=pZynIhj/Z2TJu75pAfXnqULBvFL3e5hIiYXQA5gz6ytzZ95h49Vr6HZ6nevNmVsiXN
         6idsK4DXOoUrWBHlQ3ykEZ8IOTrb8SWRFgRQ4Q849YlPDad8O7qwxu+3MU5/Qzk6HqLj
         wGhy/fyQvGhIo9vWygcMuf+dvarxp3TULwBmYwYoLBSko3n5pwxcSgnN6mdhWTLo6wKN
         7LDNjLiYeMRmyRQ1E6aAg9pTfnF006tzytUqJxybBZvZymirG8X+BaqoIbrTOIfzju3R
         3YE6MkymM2oyYjihEryPV6Qjutb4UEDxfFcwnVxk8SH0IiAXtRQwk8Ap7aKqGwT097nW
         3eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wrLRQHTEo+T+wjARQjSV6Y2vXRpdwdJ/x/NE+UKNnH0=;
        b=S96JNs4oA6fvxsSioWeDXs/p4tanffXgF0ZlA7zQlte/0gZCrW5RLlgF0q91eRSRPT
         FscuXKNJ8CM88LdB5y7KZTx2kMAvY+D1pkAK3ls181/S6DQimw47zs+sRZ3E5GmkKPBT
         A17shdOiVUxPZ8HMDgH2xqOuYRgt2R9+R9GQF8UHHOmTAING/KKb4N4skewbnT1RIaRP
         5p/dVhqqviFHmlyO+uYsSUqCWGHV/Zd5OSHfnLlr/1LVDg7Db3JcUBeOCv1gYtVLaZvF
         /FRFmNz5QhP6Jq0pw7TlxMl9jtTCSFMMDcljmN1XGg0n73sUe2HbXBKg8YR0/n8GpvtE
         nFnw==
X-Gm-Message-State: AOAM532jjOEN/Z6Ro1NGbKFeHJS47kbVsqx3W487kc5FLh11yQZEnKEN
        nigkeCYcfMkUXqq/DbmUvmDBtc/dYenr2g==
X-Google-Smtp-Source: ABdhPJxoz9TTCaJp4uT4lHZSkkhOqEBiGVBfN2sg9zYSi78CSqiGtI1RVuaUQUBtsYCBiIe1rC+fpw==
X-Received: by 2002:a9d:12e3:: with SMTP id g90mr24158489otg.300.1625758624044;
        Thu, 08 Jul 2021 08:37:04 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s12sm545589otd.56.2021.07.08.08.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 08:37:03 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block changes for 5.14-rc1
Message-ID: <80e0449b-eb7a-35e2-4d49-517c744fa371@kernel.dk>
Date:   Thu, 8 Jul 2021 09:36:58 -0600
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

A combination of changes that ended up depending on both the driver and
core branch (and/or the IDE removal), and a few late arriving fixes. In
detail:

- Fix io ticks wrap-around issue (Chunguang)

- nvme-tcp sock locking fix (Maurizio)

- s390-dasd fixes (Kees, Christoph)

- blk_execute_rq polling support (Keith)

- blk-cgroup RCU iteration fix (Yu)

- nbd backend ID addition (Prasanna)

- Partition deletion fix (Yufen)

- Use blk_mq_alloc_disk for mmc, mtip32xx, ubd (Christoph)

- Removal of now dead block request types due to IDE removal (Christoph)

- Loop probing and control device cleanups (Christoph)

- Device uevent fix (Christoph)

- Misc cleanups/fixes (Tetsuo, Christoph)

Please pull!


The following changes since commit 440462198d9c45e48f2d8d9b18c5702d92282f46:

  Merge tag 'for-5.14/drivers-2021-06-29' of git://git.kernel.dk/linux-block (2021-06-30 12:21:16 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-08

for you to fetch changes up to a731763fc479a9c64456e0643d0ccf64203100c9:

  blk-cgroup: prevent rcu_sched detected stalls warnings while iterating blkgs (2021-07-07 09:36:36 -0600)

----------------------------------------------------------------
block-5.14-2021-07-08

----------------------------------------------------------------
Christoph Hellwig (23):
      mtip32xx: simplify sysfs setup
      mtip32xx: use blk_mq_alloc_disk and blk_cleanup_disk
      null_blk: remove an unused variable assignment in null_add_dev
      ubd: remove the code to register as the legacy IDE driver
      ubd: use blk_mq_alloc_disk and blk_cleanup_disk
      mmc: remove an extra blk_{get,put}_queue pair
      mmc: switch to blk_mq_alloc_disk
      mmc: initialized disk->minors
      loop: reorder loop_exit
      loop: reduce loop_ctl_mutex coverage in loop_exit
      loop: remove the l argument to loop_add
      loop: don't call loop_lookup before adding a loop device
      loop: split loop_control_ioctl
      loop: move loop_ctl_mutex locking into loop_add
      loop: don't allow deleting an unspecified loop device
      loop: split loop_lookup
      loop: rewrite loop_exit using idr_for_each_entry
      block: mark blk_mq_init_queue_data static
      block: remove REQ_OP_SCSI_{IN,OUT}
      ubd: remove dead code in ubd_setup_common
      dasd: unexport dasd_set_target_state
      block: grab a device refcount in disk_uevent
      block: remove the bdgrab in blk_drop_partitions

Chunguang Xu (1):
      block: fix the problem of io_ticks becoming smaller

Jens Axboe (1):
      Merge branch 'nvme-5.14' of git://git.infradead.org/nvme into block-5.14

Kees Cook (1):
      s390/dasd: Avoid field over-reading memcpy()

Keith Busch (4):
      block: support polling through blk_execute_rq
      nvme: use blk_execute_rq() for passthrough commands
      block: return errors from blk_execute_rq()
      nvme: use return value from blk_execute_rq()

Maurizio Lombardi (1):
      nvme-tcp: can't set sk_user_data without write_lock

Prasanna Kumar Kalever (1):
      nbd: provide a way for userspace processes to identify device backends

Tetsuo Handa (1):
      loop: remove unused variable in loop_set_status()

Yu Kuai (1):
      blk-cgroup: prevent rcu_sched detected stalls warnings while iterating blkgs

Yufen Yu (1):
      block: check disk exist before trying to add partition

 arch/um/drivers/ubd_kern.c         | 160 ++++++-----------------------------
 block/blk-cgroup.c                 |  15 ++++
 block/blk-core.c                   |   4 +-
 block/blk-exec.c                   |  25 +++++-
 block/blk-mq.c                     |   3 +-
 block/bsg-lib.c                    |   2 +-
 block/bsg.c                        |   2 +-
 block/genhd.c                      |   4 +-
 block/partitions/core.c            |  29 ++++---
 block/scsi_ioctl.c                 |   6 +-
 drivers/block/loop.c               | 169 +++++++++++++++----------------------
 drivers/block/mtip32xx/mtip32xx.c  | 150 +++++++++-----------------------
 drivers/block/nbd.c                |  60 ++++++++++++-
 drivers/block/null_blk/main.c      |   1 -
 drivers/block/pktcdvd.c            |   2 +-
 drivers/cdrom/cdrom.c              |   2 +-
 drivers/mmc/core/block.c           |  29 ++-----
 drivers/mmc/core/queue.c           |  23 +++--
 drivers/mmc/core/queue.h           |   2 +-
 drivers/nvme/host/core.c           |  65 +++++++-------
 drivers/nvme/host/fabrics.c        |  13 ++-
 drivers/nvme/host/fabrics.h        |   2 +-
 drivers/nvme/host/fc.c             |   2 +-
 drivers/nvme/host/ioctl.c          |   6 +-
 drivers/nvme/host/nvme.h           |   4 +-
 drivers/nvme/host/rdma.c           |   3 +-
 drivers/nvme/host/tcp.c            |   2 +-
 drivers/nvme/target/loop.c         |   2 +-
 drivers/nvme/target/passthru.c     |   8 +-
 drivers/nvme/target/tcp.c          |   1 -
 drivers/s390/block/dasd.c          |   1 -
 drivers/s390/block/dasd_eckd.c     |   2 +-
 drivers/s390/block/dasd_eckd.h     |   6 +-
 drivers/scsi/scsi_error.c          |   2 +-
 drivers/scsi/scsi_lib.c            |   8 +-
 drivers/scsi/sg.c                  |   2 +-
 drivers/scsi/st.c                  |   2 +-
 drivers/target/target_core_pscsi.c |   2 +-
 fs/nfsd/blocklayout.c              |   2 +-
 include/linux/blk-mq.h             |   2 -
 include/linux/blk_types.h          |   3 -
 include/linux/blkdev.h             |  37 ++------
 include/uapi/linux/nbd-netlink.h   |   1 +
 43 files changed, 346 insertions(+), 520 deletions(-)

-- 
Jens Axboe

