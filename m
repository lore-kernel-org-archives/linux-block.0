Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74741C433EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 20:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbiCWUkY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbiCWUkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 16:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A55B74600
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648067932;
        h=from:from:sender:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type; bh=GIytgxH4Pq4RXhamKNGHt+Bh2DNJS/Td8vkil6LYZ7A=;
        b=geZScK/ed6G9DviI3wey3RoLzM3AFHhR1ISNqWxUN+uJtCu3aU2wi5FJ9jhkEAk77T2Z8g
        ujRs/fm7pbD81wGwL0LcP1kv8BDgzh+Fit7VDLfueGXn0U9WdlUbENbqNDqmbMm4OBqSd/
        TUfFnKy+lvn8Kz5MIKUnxKdE319i4Qc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-pN2AwXLaPTmkiKjrlxcDHQ-1; Wed, 23 Mar 2022 16:38:51 -0400
X-MC-Unique: pN2AwXLaPTmkiKjrlxcDHQ-1
Received: by mail-qv1-f72.google.com with SMTP id z2-20020a056214060200b00440d1bc7815so2136873qvw.1
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 13:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=GIytgxH4Pq4RXhamKNGHt+Bh2DNJS/Td8vkil6LYZ7A=;
        b=B75kZxR3y2HtLevhUQtqv9Gt0WaODhTEWigbjbnjkMPvPOQm0aY0APDNp4jwYyIw+Q
         Z6Ep3x5qpswBcOyNRypNZF/HhFdl3GNuFCTYuNKplAvaR1YD8uQ5EEorUHJwve6iDVTl
         OWu0MsZ2tvOX6OdWS73EXFajhJXiV1sy+n0jlnJMHe5X7ipKki3fxibXq4IgpLx3f6Ul
         v710ic3Lu4zZrWWVeLUTuETauTwLQrGF/7DERtJ7f8e1VEYSTwdx4+3fZ1IgEMIF8jkX
         eCihnXzqwH7Vqm9L+aKz6wxrxxg6/1xoYRA609wIlzy6xogCzMRGVVVYOTXP5GRSK+p4
         axYA==
X-Gm-Message-State: AOAM531ilz8Jom1obhnq/1vANsY9xAGbT1sQPpzlSXczQcQXOvcQXITt
        nNIc56KMQLKZdop8nvNsqsZQh3Zb/9M/rP2VaccdxQqoOoN63e+VJ2rAPvvB2TV4NAXs9cWj0hm
        dXxe0m6TzCqJ2vhsHYXqIgA==
X-Received: by 2002:a05:620a:4e8:b0:67d:4589:abe1 with SMTP id b8-20020a05620a04e800b0067d4589abe1mr1221370qkh.211.1648067930928;
        Wed, 23 Mar 2022 13:38:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIYfvaUIAa84F3dALCaqJZTRMe/cyX1y+MCMaU1Ox7B77DD6EmV0ZmOvyjHvkOwzf/JwMUVA==
X-Received: by 2002:a05:620a:4e8:b0:67d:4589:abe1 with SMTP id b8-20020a05620a04e800b0067d4589abe1mr1221355qkh.211.1648067930653;
        Wed, 23 Mar 2022 13:38:50 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h206-20020a379ed7000000b0067b5192da4csm504421qke.12.2022.03.23.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:38:50 -0700 (PDT)
Sender: Mike Snitzer <msnitzer@redhat.com>
From:   Mike Snitzer <snitzer@redhat.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
Date:   Wed, 23 Mar 2022 16:38:49 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Aashish Sharma <shraash@google.com>,
        Barry Song <21cnbao@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jordy Zomer <jordy@jordyzomer.github.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Ming Lei <ming.lei@redhat.com>, Thore Sommer <public@thson.de>,
        Tom Rix <trix@redhat.com>, Wang Qing <wangqing@vivo.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [git pull] device mapper changes for 5.18
Message-ID: <YjuFWbp0vdh/7c5A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

These changes build on Jens' for-5.18 block tree because of various
changes that impacted DM and DM's need for bio_start_io_acct_time().

The following changes since commit bcd2be763252f3a4d5fc4d6008d4d96c601ee74b:

  block/bfq_wf2q: correct weight to ioprio (2022-02-16 20:09:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.18/dm-changes

for you to fetch changes up to 4d7bca13dd9a5033174b0735056c5658cb893e76:

  dm: consolidate spinlocks in dm_io struct (2022-03-21 14:15:36 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Significant refactoring and fixing of how DM core does bio-based IO
  accounting with focus on fixing wildly inaccurate IO stats for
  dm-crypt (and other DM targets that defer bio submission in their
  own workqueues). End result is proper IO accounting, made possible
  by targets being updated to use the new dm_submit_bio_remap()
  interface.

- Add hipri bio polling support (REQ_POLLED) to bio-based DM.

- Reduce dm_io and dm_target_io structs so that a single dm_io (which
  contains dm_target_io and first clone bio) weighs in at 256 bytes.
  For reference the bio struct is 128 bytes.

- Various other small cleanups, fixes or improvements in DM core and
  targets.

- Update MAINTAINERS with my kernel.org email address to allow
  distinction between my "upstream" and "Red" Hats.

----------------------------------------------------------------
Aashish Sharma (1):
      dm crypt: fix get_key_size compiler warning if !CONFIG_KEYS

Barry Song (1):
      dm io: remove stale comment block for dm_io()

Christoph Hellwig (2):
      dm-zoned: remove the ->name field in struct dmz_dev
      dm: stop using bdevname

Colin Ian King (1):
      dm cache policy smq: make static read-only array table const

Jordy Zomer (1):
      dm ioctl: prevent potential spectre v1 gadget

Kirill Tkhai (1):
      dm: fix use-after-free in dm_cleanup_zoned_dev()

Mike Snitzer (33):
      dm: interlock pending dm_io and dm_wait_for_bios_completion
      dm: fix double accounting of flush with data
      dm stats: fix too short end duration_ns when using precise_timestamps
      dm: eliminate copying of dm_io fields in dm_io_dec_pending
      dm: reorder members in mapped_device struct
      dm: rename split functions
      dm: fold __clone_and_map_data_bio into __split_and_process_bio
      dm: refactor dm_split_and_process_bio a bit
      dm: reduce code duplication in __map_bio
      dm: remove impossible BUG_ON in __send_empty_flush
      dm: remove unused mapped_device argument from free_tio
      dm: remove legacy code only needed before submit_bio recursion
      dm: record old_sector in dm_target_io before calling map function
      dm: move duplicate code from callers of alloc_tio into alloc_tio
      dm: reduce dm_io and dm_target_io struct sizes
      dm: flag clones created by __send_duplicate_bios
      dm: add dm_submit_bio_remap interface
      dm crypt: use dm_submit_bio_remap
      dm delay: use dm_submit_bio_remap
      dm: requeue IO if mapping table not yet available
      dm: remove unnecessary local variables in __bind
      dm mpath: use DMINFO instead of printk with KERN_INFO
      dm: add WARN_ON_ONCE to dm_submit_bio_remap
      dm thin: use dm_submit_bio_remap
      dm: simplify dm_sumbit_bio_remap interface
      dm cache: use dm_submit_bio_remap
      dm: factor out dm_io_complete
      dm: return void from __send_empty_flush
      dm: update email address in MAINTAINERS
      dm: switch dm_io booleans over to proper flags
      dm: switch dm_target_io booleans over to proper flags
      dm: reduce size of dm_io and dm_target_io structs
      dm: consolidate spinlocks in dm_io struct

Ming Lei (2):
      block: add ->poll_bio to block_device_operations
      dm: support bio polling

Thore Sommer (1):
      dm ima: fix wrong length calculation for no_data string

Tom Rix (1):
      dm: cleanup double word in comment

Wang Qing (1):
      dm thin: use time_is_before_jiffies instead of open coding it

Zhiqiang Liu (1):
      dm thin metadata: remove unused dm_thin_remove_block and __remove

 MAINTAINERS                      |   2 +-
 block/blk-core.c                 |  14 +-
 block/genhd.c                    |   4 +
 drivers/md/dm-cache-policy-smq.c |   4 +-
 drivers/md/dm-cache-target.c     |  17 +-
 drivers/md/dm-clone-target.c     |  10 +-
 drivers/md/dm-core.h             |  99 ++++--
 drivers/md/dm-crypt.c            |  15 +-
 drivers/md/dm-delay.c            |   5 +-
 drivers/md/dm-ima.c              |   6 +-
 drivers/md/dm-io.c               |   8 -
 drivers/md/dm-ioctl.c            |   2 +
 drivers/md/dm-mpath.c            |   5 +-
 drivers/md/dm-rq.c               |   7 +-
 drivers/md/dm-stats.c            |  34 +-
 drivers/md/dm-stats.h            |  11 +-
 drivers/md/dm-table.c            |  57 +++-
 drivers/md/dm-thin-metadata.c    |  28 --
 drivers/md/dm-thin-metadata.h    |   1 -
 drivers/md/dm-thin.c             |  15 +-
 drivers/md/dm-zoned-metadata.c   |   4 +-
 drivers/md/dm-zoned-target.c     |   1 -
 drivers/md/dm-zoned.h            |   9 +-
 drivers/md/dm.c                  | 673 ++++++++++++++++++++++++++-------------
 include/linux/blkdev.h           |   2 +
 include/linux/device-mapper.h    |   9 +-
 include/uapi/linux/dm-ioctl.h    |   4 +-
 27 files changed, 685 insertions(+), 361 deletions(-)

