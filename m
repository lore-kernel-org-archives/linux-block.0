Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F48C71153
	for <linux-block@archiver.kernel.org>; Tue, 29 Aug 2023 19:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjH2T6d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Aug 2023 15:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237861AbjH2T6Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Aug 2023 15:58:24 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19611B7
        for <linux-block@vger.kernel.org>; Tue, 29 Aug 2023 12:58:20 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76cf9cf65feso61570685a.0
        for <linux-block@vger.kernel.org>; Tue, 29 Aug 2023 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1693339100; x=1693943900; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENKK7T5gs6+ytMTIfWESDpAxi63ubWHkMP//WMBXluE=;
        b=2OXXxm9wUWgIKbTN9zXtA0YlzeCSRlhBVOxx8J2cOuaZS90I1PEfdywvNxmG6/atDH
         Y69JHIhq64HA8KaiR5lJ2OthNBTd/rCyi4f25ZfpKE+TC5FMLb98QfbghzP9jqjO3ZjF
         qDNeOhdT0HC1EXOxop+CtHKl86yIcwi6CcJzPJBP4qeipYKitiSHhLym7JnGNInG88rr
         Lbsoq2s63bVLUvZOwQL3T9eyqgXAJTbSIf8x0TNyuGuR0V4jopuBiEL1AEu2daGuZxDJ
         4XIMoh0z50F4+dBgepGdo+vBQu1r0pSAo1RI6imL+iwF1VqhrrY0VulI2Hm1XKvaMRzx
         0hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693339100; x=1693943900;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ENKK7T5gs6+ytMTIfWESDpAxi63ubWHkMP//WMBXluE=;
        b=lOeCyKJfsafUeXqGpoGx3zRkgR4sVIKFVPMy2jhTxOwTd9UuepsZlQDuWZUPIeKEFc
         bnLwYJrYgVdkDy1iRxzk3Y76O6/X20Zl9SCmry+Co80dSgxomOQ83Q9+HG4DLRQHDRrf
         02JexXL7CN7JlwBIxxwFZt2TRQysI2JPQcoKuXBbqhTFt9/PlP16T49P3QRAAwFnawWg
         pNZaLQjdiAlusD4oS3MRLsbjySKlkZQlNoeCxWYCfG1DLbwQShZEnO+GP5EcL3MKV0xU
         3VuTjpJN9X6p0dzpbOFfG9YIx+pRdrfOpXwpa6++w1SfzMaJaMco4sK1gunT1Kp9EpCC
         Gx7w==
X-Gm-Message-State: AOJu0Yyec7zRKtppIfe55SicDl3AU+MDOfoB+5/dId0cC+3zKoqmTmF2
        HSiqXYjUe+p3L+FDDg//R+g5g53to2g3het5aj0=
X-Google-Smtp-Source: AGHT+IHfRQZNQjgUKnNSdHF1CJ8g1l6eutHDrr2jpK6ZpDRhp9EMlfFCGXxAohEBP60uqwc5csPl8g==
X-Received: by 2002:a05:622a:1a20:b0:412:1c5f:4781 with SMTP id f32-20020a05622a1a2000b004121c5f4781mr4052qtb.4.1693339099600;
        Tue, 29 Aug 2023 12:58:19 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11d9::1176? ([2620:10d:c091:400::5:d18a])
        by smtp.gmail.com with ESMTPSA id f7-20020ac84987000000b00403ff38d855sm3245699qtq.4.2023.08.29.12.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 12:58:19 -0700 (PDT)
Message-ID: <843290f8-4b62-439a-b2e4-0b71ed20391e@kernel.dk>
Date:   Tue, 29 Aug 2023 13:58:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 6.6-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Linus,

Here are the block updates for the 6.6-rc1 merge window. Pretty quiet
round for this release. This pull request contains:

- Add support for zoned storage to ublk (Andreas, Ming)

- Series improving performance for drivers that mark themselves as
  needing a blocking context for issue (Bart)

- Cleanup the flush logic (Chengming)

- sed opal keyring support (Greg)

- Fixes and improvements to the integrity support (Jinyoung)

- Add some exports for bcachefs that we can hopefully delete again in
  the future (Kent)

- deadline throttling fix (Zhiguo)

- Series allowing building the kernel without buffer_head support
  (Christoph)

- Sanitize the bio page adding flow (Christoph)

- Write back cache fixes (Christoph)

- MD updates via Song:
	- Fix perf regression for raid0 large sequential writes (Jan)
	- Fix split bio iostat for raid0 (David)
	- Various raid1 fixes (Heinz, Xueshi)
	- raid6test build fixes (WANG)
	- Deprecate bitmap file support (Christoph)
	- Fix deadlock with md sync thread (Yu)
	- Refactor md io accounting (Yu)
	- Various non-urgent fixes (Li, Yu, Jack)

- Various fixes and cleanups (Arnd, Azeem, Chengming, Damien, Li, Ming,
  Nitesh, Ruan, Tejun, Thomas, Xu, 

Note that this will throw a conflict in fs/super.c, due to commit:

commit 5e87491415217d6bec0bcae08a3156622be2b177
Author: Christian Brauner <brauner@kernel.org>
Date:   Fri Aug 18 16:00:50 2023 +0200

    super: wait for nascent superblocks

in your tree and

commit 4a8b719f95c0dcd15fb7a04b806ad8139fa7c850
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Aug 1 19:21:56 2023 +0200

    fs: remove emergency_thaw_bdev

in the block tree. The resolution is straight forward, so I won't bore
you with those details.

Please pull!


The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.6/block-2023-08-28

for you to fetch changes up to 146afeb235ccec10c17ad8ea26327c0c79dbd968:

  block: use strscpy() to instead of strncpy() (2023-08-22 18:07:50 -0600)

----------------------------------------------------------------
for-6.6/block-2023-08-28

----------------------------------------------------------------
Andreas Hindborg (3):
      ublk: add helper to check if device supports user copy
      ublk: move check for empty address field on command submission
      ublk: enable zoned storage support

Arnd Bergmann (1):
      swim3: mark swim3_init() static

Azeem Shaikh (2):
      kyber: Replace strlcpy with strscpy
      blk-wbt: Replace strlcpy with strscpy

Bart Van Assche (3):
      scsi: Inline scsi_kick_queue()
      scsi: Remove a blk_mq_run_hw_queues() call
      block: Improve performance for BLK_MQ_F_BLOCKING drivers

Chengming Zhou (10):
      blk-mq: use percpu csd to remote complete instead of per-rq csd
      blk-flush: fix rq->flush.seq for post-flush requests
      blk-flush: count inflight flush_data requests
      blk-flush: reuse rq queuelist in flush state machine
      iocost_monitor: fix kernel queue kobj changes
      iocost_monitor: print vrate inuse along with base_vrate
      iocost_monitor: improve it by adding iocg wait_ms
      blk-mq: fix tags leak when shrink nr_hw_queues
      blk-mq: delete redundant tagset map update when fallback
      blk-mq: prealloc tags when increase tagset nr_hw_queues

Christoph Hellwig (27):
      block: cleanup queue_wc_store
      block: don't allow enabling a cache on devices that don't support it
      block: tidy up the bio full checks in bio_add_hw_page
      block: use SECTOR_SHIFT bio_add_hw_page
      block: move the BIO_CLONED checks out of __bio_try_merge_page
      block: move the bi_vcnt check out of __bio_try_merge_page
      block: move the bi_size overflow check in __bio_try_merge_page
      block: downgrade a bio_full call in bio_add_page
      block: move the bi_size update out of __bio_try_merge_page
      block: don't pass a bio to bio_try_merge_hw_seg
      md-bitmap: set BITMAP_WRITE_ERROR in write_sb_page
      md-bitmap: initialize variables at declaration time in md_bitmap_file_unmap
      md-bitmap: use %pD to print the file name in md_bitmap_file_kick
      md-bitmap: split file writes into a separate helper
      md-bitmap: rename read_page to read_file_page
      md-bitmap: refactor md_bitmap_init_from_disk
      md-bitmap: cleanup read_sb_page
      md-bitmap: account for mddev->bitmap_info.offset in read_sb_page
      md-bitmap: don't use ->index for pages backing the bitmap file
      md: make bitmap file support optional
      md: deprecate bitmap file support
      fs: remove emergency_thaw_bdev
      fs: rename and move block_page_mkwrite_return
      block: open code __generic_file_write_iter for blkdev writes
      block: stop setting ->direct_IO
      block: use iomap for writes to block devices
      fs: add CONFIG_BUFFER_HEAD

Damien Le Moal (1):
      block: uapi: Fix compilation errors using ioprio.h with C++

David Jeffery (1):
      md: raid0: account for split bio in iostat accounting

Greg Joyce (3):
      block: sed-opal: Implement IOC_OPAL_DISCOVERY
      block: sed-opal: Implement IOC_OPAL_REVERT_LSP
      block: sed-opal: keyring support for SED keys

Heinz Mauelshagen (1):
      md raid1: allow writebehind to work on any leg device set WriteMostly

Jack Wang (1):
      md/raid1: Avoid lock contention from wake_up()

Jan Kara (2):
      md/raid0: Factor out helper for mapping and submitting a bio
      md/raid0: Fix performance regression for large sequential writes

Jens Axboe (4):
      Merge tag 'md-next-20230729' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.6/block
      block: fix bad lockdep annotation in blk-iolatency
      Merge tag 'md-next-20230814-resend' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.6/block
      Merge tag 'md-next-20230817' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.6/block

Jinyoung Choi (5):
      block: cleanup bio_integrity_prep
      block: make bvec_try_merge_hw_page() non-static
      bio-integrity: update the payload size in bio_integrity_add_page()
      bio-integrity: cleanup adding integrity pages to bip's bvec.
      bio-integrity: create multi-page bvecs in bio_integrity_add_page()

Kent Overstreet (3):
      block: Add some exports for bcachefs
      block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
      block: Bring back zero_fill_bio_iter

Li Lingfeng (2):
      block: remove init_mutex and open-code blk_iolatency_try_init
      md: Hold mddev->reconfig_mutex when trying to get mddev->sync_thread

Li Nan (6):
      md/raid1: prioritize adding disk to 'removed' mirror
      md/raid10: optimize fix_read_error
      md: remove redundant check in fix_read_error()
      md/raid10: check replacement and rdev to prevent submit the same io twice
      md/raid10: factor out dereference_rdev_and_rrdev()
      md/raid10: use dereference_rdev_and_rrdev() to get devices

Li Zetao (2):
      fs/Kconfig: Fix compile error for romfs
      ublk: Fix signedness bug returning warning

Li Zhijian (1):
      drivers/rnbd: restore sysfs interface to rnbd-client

Ming Lei (2):
      ublk: fix 'warn: variable dereferenced before check 'req'' from Smatch
      ublk: zoned: support REQ_OP_ZONE_RESET_ALL

Nitesh Shetty (1):
      block: refactor to use helper

Ruan Jinjie (1):
      ublk: Switch to memdup_user_nul() helper

Tejun Heo (1):
      blk-cgroup: Fix NULL deref caused by blkg_policy_data being installed before init

Thomas Weißschuh (1):
      nbd: automatically load module on genl access

WANG Xuerui (5):
      raid6: remove the <linux/export.h> include from recov.c
      raid6: guard the tables.c include of <linux/export.h> with __KERNEL__
      raid6: test: cosmetic cleanups for the test Makefile
      raid6: test: make sure all intermediate and artifact files are .gitignored
      raid6: test: only check for Altivec if building on powerpc hosts

Xu Panda (1):
      block: use strscpy() to instead of strncpy()

Xueshi Hu (3):
      md/raid1: call free_r1bio() before allow_barrier() in raid_end_bio_io()
      md/raid1: free the r1bio before waiting for blocked rdev
      md/raid1: hold the barrier until handle_read_error() finishes

Yu Kuai (21):
      Revert "md: unlock mddev before reap sync_thread in action_store"
      md: refactor action_store() for 'idle' and 'frozen'
      md: add a mutex to synchronize idle and frozen in action_store()
      md: refactor idle/frozen_sync_thread() to fix deadlock
      md: wake up 'resync_wait' at last in md_reap_sync_thread()
      md: enhance checking in md_check_recovery()
      md: move initialization and destruction of 'io_acct_set' to md.c
      md: also clone new io if io accounting is disabled
      raid5: fix missing io accounting in raid5_align_endio()
      md/raid1: switch to use md_account_bio() for io accounting
      md/raid10: switch to use md_account_bio() for io accounting
      md/md-multipath: enable io accounting
      md/md-linear: enable io accounting
      md/md-faulty: enable io accounting
      md: don't quiesce in mddev_suspend()
      md: restore 'noio_flag' for the last mddev_resume()
      md/md-bitmap: remove unnecessary local variable in backlog_store()
      md/md-bitmap: hold 'reconfig_mutex' in backlog_store()
      md/raid5-cache: fix a deadlock in r5l_exit_log()
      md/raid10: fix a 'conf->barrier' leakage in raid10_takeover()
      md/raid5-cache: fix null-ptr-deref for r5l_flush_stripe_to_raid()

Zhang Shurong (1):
      md: raid1: fix potential OOB in raid1_remove_disk()

Zhiguo Niu (1):
      block/mq-deadline: use correct way to throttling write requests

 block/Kconfig                       |   3 +
 block/bio-integrity.c               |  59 +++---
 block/bio.c                         | 142 +++++++-------
 block/blk-cgroup.c                  |  32 ++--
 block/blk-core.c                    |   1 +
 block/blk-flush.c                   |  26 +--
 block/blk-iolatency.c               |  35 ++--
 block/blk-mq.c                      |  45 +++--
 block/blk-settings.c                |   7 +-
 block/blk-sysfs.c                   |  21 +--
 block/blk.h                         |  10 +-
 block/fops.c                        | 143 ++++++++++++--
 block/mq-deadline.c                 |   3 +-
 block/opal_proto.h                  |   4 +
 block/partitions/cmdline.c          |  12 +-
 block/sed-opal.c                    | 252 ++++++++++++++++++++++++-
 drivers/block/nbd.c                 |   1 +
 drivers/block/rnbd/rnbd-clt-sysfs.c |   2 +-
 drivers/block/swim3.c               |   2 +-
 drivers/block/ublk_drv.c            | 366 +++++++++++++++++++++++++++++++++---
 drivers/md/Kconfig                  |  11 ++
 drivers/md/dm-crypt.c               |   1 -
 drivers/md/dm-raid.c                |   1 -
 drivers/md/md-bitmap.c              | 347 +++++++++++++++++-----------------
 drivers/md/md-bitmap.h              |   1 +
 drivers/md/md-cluster.c             |   8 +-
 drivers/md/md-faulty.c              |   2 +
 drivers/md/md-linear.c              |   1 +
 drivers/md/md-multipath.c           |   1 +
 drivers/md/md.c                     | 228 +++++++++++++---------
 drivers/md/md.h                     |  13 +-
 drivers/md/raid0.c                  |  98 +++++-----
 drivers/md/raid1.c                  |  86 +++++----
 drivers/md/raid1.h                  |   1 -
 drivers/md/raid10.c                 |  85 +++++----
 drivers/md/raid10.h                 |   1 -
 drivers/md/raid5-cache.c            |  14 +-
 drivers/md/raid5.c                  |  72 ++-----
 drivers/nvme/host/ioctl.c           |   1 -
 drivers/nvme/target/io-cmd-bdev.c   |   3 +-
 drivers/scsi/scsi_lib.c             |  12 +-
 drivers/target/target_core_iblock.c |   3 +-
 fs/Kconfig                          |   4 +
 fs/Makefile                         |   2 +-
 fs/adfs/Kconfig                     |   1 +
 fs/affs/Kconfig                     |   1 +
 fs/befs/Kconfig                     |   1 +
 fs/bfs/Kconfig                      |   1 +
 fs/buffer.c                         |   6 -
 fs/efs/Kconfig                      |   1 +
 fs/exfat/Kconfig                    |   1 +
 fs/ext2/Kconfig                     |   1 +
 fs/ext4/Kconfig                     |   1 +
 fs/ext4/inode.c                     |   2 +-
 fs/f2fs/Kconfig                     |   1 +
 fs/f2fs/file.c                      |   2 +-
 fs/fat/Kconfig                      |   1 +
 fs/freevxfs/Kconfig                 |   1 +
 fs/gfs2/Kconfig                     |   1 +
 fs/gfs2/file.c                      |  16 +-
 fs/hfs/Kconfig                      |   1 +
 fs/hfsplus/Kconfig                  |   1 +
 fs/hpfs/Kconfig                     |   1 +
 fs/internal.h                       |   6 -
 fs/iomap/buffered-io.c              |   2 +-
 fs/isofs/Kconfig                    |   1 +
 fs/jfs/Kconfig                      |   1 +
 fs/minix/Kconfig                    |   1 +
 fs/nilfs2/Kconfig                   |   1 +
 fs/nilfs2/file.c                    |   2 +-
 fs/ntfs/Kconfig                     |   1 +
 fs/ntfs3/Kconfig                    |   1 +
 fs/ocfs2/Kconfig                    |   1 +
 fs/omfs/Kconfig                     |   1 +
 fs/qnx4/Kconfig                     |   1 +
 fs/qnx6/Kconfig                     |   1 +
 fs/reiserfs/Kconfig                 |   1 +
 fs/romfs/Kconfig                    |   1 +
 fs/super.c                          |   4 +-
 fs/sysv/Kconfig                     |   1 +
 fs/udf/Kconfig                      |   1 +
 fs/udf/file.c                       |   2 +-
 fs/ufs/Kconfig                      |   1 +
 include/linux/bio.h                 |   7 +-
 include/linux/blk-mq.h              |   6 +-
 include/linux/blkdev.h              |   2 +
 include/linux/buffer_head.h         |  44 ++---
 include/linux/iomap.h               |   4 +
 include/linux/mm.h                  |  18 ++
 include/linux/sed-opal.h            |   5 +
 include/trace/events/block.h        |   2 +
 include/trace/events/kyber.h        |   8 +-
 include/trace/events/wbt.h          |   8 +-
 include/uapi/linux/ioprio.h         |  21 ++-
 include/uapi/linux/sed-opal.h       |  25 ++-
 include/uapi/linux/ublk_cmd.h       |  64 ++++++-
 lib/raid6/mktables.c                |   2 +
 lib/raid6/recov.c                   |   1 -
 lib/raid6/test/.gitignore           |   3 +
 lib/raid6/test/Makefile             |  50 ++---
 mm/migrate.c                        |   4 +-
 tools/cgroup/iocost_monitor.py      |  21 ++-
 102 files changed, 1684 insertions(+), 845 deletions(-)
 create mode 100644 lib/raid6/test/.gitignore

-- 
Jens Axboe


