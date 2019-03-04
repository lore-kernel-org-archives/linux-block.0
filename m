Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50618C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 01:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA8720842
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 01:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qc76EgKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCDBxf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:53:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43552 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfCDBxf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Mar 2019 20:53:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id l11so1855032pgq.10
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 17:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=V87K0u188f6fWgI25lEBoeTg2N2SmTtc5jKuScmtEHU=;
        b=qc76EgKI5IcIjW9sqgNBwllyWvpRWTdF+raWRISd5XXA6drIYZTUL+coZjEVprTyqa
         QDBg1mT7J4GjX3y2fjesnDoLOkC5gULG2+bDKk8xSQaL8D4SxVPvKp1SWjFU+Z1png8h
         gi/kLS3ja83NjqOhUiY7+3CydT5yTlcBDH+ieXmxEgPkk+67BrUtTsVhqdvrZAxTyODO
         +OV8Css7Lsr+wFSBjopa3n+V6CzQzGJ5LTb3nvWkxj95Ki+LfKuDoG+kYNVCwEwRLqvM
         QZzlJBOEC5hLlf7657ZiyOXku09BklUMMvvegrVcHdlBwH/x1antqOwcOnxLQukX1XOV
         EPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=V87K0u188f6fWgI25lEBoeTg2N2SmTtc5jKuScmtEHU=;
        b=cVZ4c2khzK3vxcNz8MyOv3m7MIDNRNADkClEZbNn8tr2fBUZIH3Y8KROAbAxFfTnPj
         LelEA0gZgfCPbGx/v8UlZomxKB2koTrACeElBVYvKJnSUfHVHfUD88Fo4Rl2bNiqCX1C
         C/fjXxd/RCZJXMwv4v6UeCQivDXkhcvIfm3UhfVyNPjZPjZIU/WR2j7HqE5ibO6Lk80H
         em4j+M7QhbB5WuB6OuVO6Wo3Xe3rB/h7FXF0K5Dowv4Vsg6xnWB/NjUIQ1VDmv7dW7+r
         X6HhcR9zVi+RlC9AsCWaKuhWpPs1l9mxoHUlox9iWs2x7biJs3RBqqBmnRcFy+u9Gmo+
         BsGA==
X-Gm-Message-State: APjAAAXWVZ4nV6i2DjTzbOcx5ukTzDIF3oaX38BJOLYAlP1qrDSRhOOz
        wPUmn48/dAdNyekq21TChe8Q0yr7UNslBQw3
X-Google-Smtp-Source: APXvYqzOf0JZ6VImhmDeCrunoDUkMovIDiZWyL9QQkZbVugsUUF63KRJi3zrsnbmvaewmnSglynWZQ==
X-Received: by 2002:a63:4913:: with SMTP id w19mr15985452pga.394.1551664413230;
        Sun, 03 Mar 2019 17:53:33 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j20sm6352693pfh.141.2019.03.03.17.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 17:53:32 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <60f2e4cc-b0cb-1d17-bbb1-445e6a28b248@kernel.dk>
Date:   Sun, 3 Mar 2019 18:53:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This is the main block pull request for 5.1. Not a huge amount of
changes in this round, the biggest one is that we finally have Mings
multi-page bvec support merged. Apart from that, this pull request
contains:

- Small series that avoids quiescing the queue for sysfs changes that
  match what we currently have (Aleksei)

- Series of bcache fixes (via Coly)

- Series of lightnvm fixes (via Mathias)

- NVMe pull request from Christoph. Nothing major, just SPDX/license
  cleanups, RR mp policy (Hannes), and little fixes (Bart, Chaitanya).

- BFQ series (Paolo)

- Save blk-mq cpu -> hw queue mapping, removing a pointer indirection
  for the fast path (Jianchao)

- fops->iopoll() added for async IO polling, this is a feature that the
  upcoming io_uring interface will use (Christoph, me)

- Partition scan loop fixes (Dongli)

- mtip32xx conversion from managed resource API (Christoph)

- cdrom registration race fix (Guenter)

- MD pull from Song, two minor fixes.

- Various documentation fixes (Marcos)

- Multi-page bvec feature. This brings a lot of nice improvements with
  it, like more efficient splitting, larger IOs can be supported without
  growing the bvec table size, and so on. (Ming)

- Various little fixes to core and drivers.


Note that this will throw a merge conflict, due to the late revert of
the gfs2 commit ""gfs2: read journal in large chunks to locate the
head". The resolution is trivial, since it's just deleting the code.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.1/block-20190302


----------------------------------------------------------------
Aleksei Zakharov (3):
      block: avoid setting nr_requests to current value
      block: avoid setting wbt_lat_usec to current value
      block: avoid setting none scheduler if it's already none

Andy Shevchenko (2):
      lightnvm: Use u64 instead of __le64 for CPU visible side
      lightnvm: pblk: Switch to use new generic UUID API

Bart Van Assche (6):
      nvmet: fix indentation
      nvme-fabrics: document the poll function argument
      nvme-pci: check kstrtoint() return value in queue_count_set()
      nvme: unexport nvme_delete_ctrl_sync()
      nvme: introduce a helper function for controller deletion
      nvme: avoid that deleting a controller triggers a circular locking complaint

Carlos Maiolino (1):
      fs: fix guard_bio_eod to check for real EOD errors

Chaitanya Kulkarni (2):
      nvme: add support for the Write Zeroes command
      nvme-rdma: use nr_phys_segments when map rq to sgl

Christoph Hellwig (19):
      mtip32xx: ѕtop abusing the managed resource APIs
      btrfs: look at bi_size for repair decisions
      nvme_ioctl.h: remove duplicate GPL boilerplate
      nvme-tcp.h: fix SPDX header
      nvme-fabrics: convert to SPDX identifiers
      nvme-fc: convert to SPDX identifiers
      nvme-rdma: convert to SPDX identifiers
      nvme-lightnvm: convert to SPDX identifiers
      nvme-pci: convert to SPDX identifiers
      nvme: convert to SPDX identifiers
      nvmet-fc: convert to SPDX identifiers
      nvmet-fcloop: convert to SPDX identifiers
      nvme-loop: convert to SPDX identifiers
      nvmet-rdma: convert to SPDX identifiers
      nvmet: convert to SPDX identifiers
      fs: add an iopoll method to struct file_operations
      block: wire up block device iopoll method
      iomap: wire up the iopoll method
      block: optimize bvec iteration in bvec_iter_advance

Colin Ian King (1):
      bcache: fix indentation issue, remove tabs on a hunk of code

Coly Li (16):
      bcache: not use hard coded memset size in bch_cache_accounting_clear()
      bcache: export backing_dev_name via sysfs
      bcache: export backing_dev_uuid via sysfs
      bcache: improve sysfs_strtoul_clamp()
      bcache: fix input integer overflow of congested threshold
      bcache: fix input overflow to sequential_cutoff
      bcache: add sysfs_strtoul_bool() for setting bit-field variables
      bcache: use sysfs_strtoul_bool() to set bit-field variables
      bcache: fix input overflow to writeback_delay
      bcache: fix potential div-zero error of writeback_rate_i_term_inverse
      bcache: fix potential div-zero error of writeback_rate_p_term_inverse
      bcache: fix input overflow to writeback_rate_minimum
      bcache: fix input overflow to journal_delay_ms
      bcache: fix input overflow to cache set io_error_limit
      bcache: fix input overflow to cache set sysfs file io_error_halflife
      bcache: use (REQ_META|REQ_PRIO) to indicate bio for metadata

Daniel Axtens (1):
      bcache: never writeback a discard operation

Dongli Zhang (3):
      loop: do not print warn message if partition scan is successful
      loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()
      blk-mq: use HCTX_TYPE_DEFAULT but not 0 to index blk_mq_tag_set->map

Guenter Roeck (1):
      cdrom: Fix race condition in cdrom_sysctl_register

Gustavo A. R. Silva (1):
      md-linear: use struct_size() in kzalloc()

Hannes Reinecke (2):
      nvme-multipath: round-robin I/O policy
      nvme: return error from nvme_alloc_ns()

Hans Holmberg (3):
      lightnvm: pblk: stop taking the free lock in in pblk_lines_free
      lightnvm: pblk: use vfree to free metadata on error path
      lightnvm: pblk: extend line wp balance check

Heiner Litz (1):
      lightnvm: pblk: fix race condition on GC

Heinz Mauelshagen (1):
      null_blk: fix checking for REQ_FUA

Javier González (1):
      lightnvm: pblk: prevent stall due to wb threshold

Jens Axboe (7):
      Merge branch 'nvme-5.1' of git://git.infradead.org/nvme into for-5.1/block
      Merge branch 'md-next' of https://github.com/liu-song-6/linux into for-5.1/block
      block: kill QUEUE_FLAG_FLUSH_NQ
      block: queue flag cleanup
      Merge tag 'v5.0-rc6' into for-5.1/block
      Merge branch 'nvme-5.1' of git://git.infradead.org/nvme into for-5.1/block
      block: add bio_set_polled() helper

Jianchao Wang (2):
      blk-mq: save queue mapping result into ctx directly
      blk-mq: save default hctx into ctx->hctxs for not-supported type

Keyur Patel (1):
      block: Replace function name in string with __func__

Li RongQing (1):
      nbd: propagate genlmsg_reply return code

Marcos Paulo de Souza (2):
      blk-cgroup: Fix doc related to blkcg_exit_queue
      blk-sysfs: Rework documention of __blk_release_queue

Masahiro Yamada (1):
      lightnvm: pblk: fix TRACE_INCLUDE_PATH

Ming Lei (24):
      block: don't use bio->bi_vcnt to figure out segment number
      block: remove bvec_iter_rewind()
      block: introduce multi-page bvec helpers
      block: introduce bio_for_each_bvec() and rq_for_each_bvec()
      block: use bio_for_each_bvec() to compute multi-page bvec count
      block: use bio_for_each_bvec() to map sg
      block: introduce mp_bvec_last_segment()
      fs/buffer.c: use bvec iterator to truncate the bio
      btrfs: use mp_bvec_last_segment to get bio's last page
      block: loop: pass multi-page bvec to iov_iter
      bcache: avoid to use bio_for_each_segment_all() in bch_bio_alloc_pages()
      block: allow bio_for_each_segment_all() to iterate over multi-page bvec
      block: enable multipage bvecs
      block: always define BIO_MAX_PAGES as 256
      block: document usage of bio iterator helpers
      block: kill QUEUE_FLAG_NO_SG_MERGE
      block: kill BLK_MQ_F_SG_MERGE
      block: avoid to READ fields of null bio
      block: bounce: make sure that bvec table is updated
      block: introduce bvec_nth_page()
      block: optimize __blk_segment_map_sg() for single-page bvec
      block: optimize blk_bio_segment_split for single-page bvec
      block: introduce mp_bvec_for_each_page() for iterating over page
      block: fix updating bio's front segment size

Paolo Valente (14):
      block, bfq: do not consider interactive queues in srt filtering
      block, bfq: avoid selecting a queue w/o budget
      block, bfq: make sure queue budgets are not below service received
      block, bfq: remove case of redirected bic from insert_request
      block, bfq: consider also ioprio classes in symmetry detection
      block, bfq: split function bfq_better_to_idle
      block, bfq: do not plug I/O of in-service queue when harmful
      block, bfq: unconditionally plug I/O in asymmetric scenarios
      block, bfq: fix sequential rq detection in rate estimation
      block, bfq: fix queue removal from weights tree
      block, bfq: reduce threshold for detecting command queueing
      block, bfq: port commit "cfq-iosched: improve hw_tag detection"
      block, bfq: do not overcharge writes in asymmetric scenarios
      block, bfq: fix in-service-queue check for queue merging

Sagi Grimberg (1):
      nvme: remove the .stop_ctrl callout

Tang Junhui (1):
      bcache: treat stale && dirty keys as bad keys

YueHaibing (1):
      floppy: remove set but not used variable 'q'

Yufen Yu (1):
      raid1: simplify raid1_error function

zhengbin (1):
      block: fix NULL pointer dereference in register_disk

 Documentation/block/biovecs.txt   |  25 ++
 Documentation/filesystems/vfs.txt |   3 +
 block/bfq-iosched.c               | 705 ++++++++++++++++++++------------------
 block/bfq-iosched.h               |  11 +-
 block/bfq-wf2q.c                  |  18 +-
 block/bio.c                       |  49 ++-
 block/blk-cgroup.c                |   2 +-
 block/blk-merge.c                 | 231 +++++++++----
 block/blk-mq-debugfs.c            |   3 -
 block/blk-mq-sched.c              |   2 +-
 block/blk-mq-tag.c                |   2 +-
 block/blk-mq.c                    |  33 +-
 block/blk-mq.h                    |  20 +-
 block/blk-settings.c              |   9 -
 block/blk-sysfs.c                 |  22 +-
 block/blk.h                       |   2 +-
 block/bounce.c                    |  10 +-
 block/elevator.c                  |   5 +-
 block/genhd.c                     |  18 +-
 drivers/ata/libata-scsi.c         |   2 -
 drivers/block/floppy.c            |   3 -
 drivers/block/loop.c              |  48 ++-
 drivers/block/mtip32xx/mtip32xx.c |  37 +-
 drivers/block/nbd.c               |   5 +-
 drivers/block/null_blk_main.c     |   3 +-
 drivers/block/rbd.c               |   2 +-
 drivers/block/skd_main.c          |   1 -
 drivers/block/xen-blkfront.c      |   2 +-
 drivers/cdrom/cdrom.c             |   7 +-
 drivers/lightnvm/pblk-core.c      |   8 +-
 drivers/lightnvm/pblk-gc.c        |  20 +-
 drivers/lightnvm/pblk-init.c      |   4 +-
 drivers/lightnvm/pblk-map.c       |   1 +
 drivers/lightnvm/pblk-rb.c        |  26 +-
 drivers/lightnvm/pblk-recovery.c  |  64 ++--
 drivers/lightnvm/pblk-rl.c        |   5 +-
 drivers/lightnvm/pblk-trace.h     |   2 +-
 drivers/lightnvm/pblk-write.c     |   1 +
 drivers/lightnvm/pblk.h           |  17 +-
 drivers/md/bcache/btree.c         |   3 +-
 drivers/md/bcache/extents.c       |  13 +-
 drivers/md/bcache/request.c       |   7 +-
 drivers/md/bcache/stats.c         |   2 +-
 drivers/md/bcache/super.c         |  30 +-
 drivers/md/bcache/sysfs.c         |  81 +++--
 drivers/md/bcache/sysfs.h         |  23 +-
 drivers/md/bcache/util.c          |   6 +-
 drivers/md/bcache/writeback.h     |   3 +
 drivers/md/dm-crypt.c             |   3 +-
 drivers/md/dm-rq.c                |   2 +-
 drivers/md/dm-table.c             |  13 -
 drivers/md/md-linear.c            |   3 +-
 drivers/md/raid1.c                |   9 +-
 drivers/mmc/core/queue.c          |   3 +-
 drivers/nvme/host/core.c          | 122 +++++--
 drivers/nvme/host/fabrics.c       |  11 +-
 drivers/nvme/host/fabrics.h       |  10 +-
 drivers/nvme/host/fault_inject.c  |   2 +-
 drivers/nvme/host/fc.c            |  14 +-
 drivers/nvme/host/lightnvm.c      |  16 +-
 drivers/nvme/host/multipath.c     |  96 +++++-
 drivers/nvme/host/nvme.h          |  21 +-
 drivers/nvme/host/pci.c           |  12 +-
 drivers/nvme/host/rdma.c          |  26 +-
 drivers/nvme/host/tcp.c           |  10 +-
 drivers/nvme/host/trace.c         |  10 +-
 drivers/nvme/host/trace.h         |  10 +-
 drivers/nvme/target/admin-cmd.c   |  10 +-
 drivers/nvme/target/configfs.c    |  10 +-
 drivers/nvme/target/core.c        |  10 +-
 drivers/nvme/target/discovery.c   |  12 +-
 drivers/nvme/target/fabrics-cmd.c |  10 +-
 drivers/nvme/target/fc.c          |  14 +-
 drivers/nvme/target/fcloop.c      |  13 +-
 drivers/nvme/target/io-cmd-bdev.c |  10 +-
 drivers/nvme/target/loop.c        |  10 +-
 drivers/nvme/target/nvmet.h       |  10 +-
 drivers/nvme/target/rdma.c        |  10 +-
 drivers/scsi/scsi_lib.c           |   2 +-
 drivers/staging/erofs/data.c      |   3 +-
 drivers/staging/erofs/unzip_vle.c |   3 +-
 fs/block_dev.c                    |  28 +-
 fs/btrfs/compression.c            |   3 +-
 fs/btrfs/disk-io.c                |   3 +-
 fs/btrfs/extent_io.c              |  16 +-
 fs/btrfs/inode.c                  |   6 +-
 fs/btrfs/raid56.c                 |   3 +-
 fs/buffer.c                       |  12 +-
 fs/crypto/bio.c                   |   3 +-
 fs/direct-io.c                    |   4 +-
 fs/exofs/ore.c                    |   3 +-
 fs/exofs/ore_raid.c               |   3 +-
 fs/ext4/page-io.c                 |   3 +-
 fs/ext4/readpage.c                |   3 +-
 fs/f2fs/data.c                    |   9 +-
 fs/gfs2/file.c                    |   2 +
 fs/gfs2/lops.c                    |   9 +-
 fs/gfs2/meta_io.c                 |   3 +-
 fs/iomap.c                        |  53 ++-
 fs/mpage.c                        |   3 +-
 fs/xfs/xfs_aops.c                 |   9 +-
 fs/xfs/xfs_file.c                 |   1 +
 include/linux/bio.h               |  51 ++-
 include/linux/blk-mq.h            |   1 -
 include/linux/blkdev.h            |  68 ++--
 include/linux/bvec.h              | 123 +++++--
 include/linux/fs.h                |   2 +
 include/linux/iomap.h             |   1 +
 include/linux/nvme-fc-driver.h    |  10 +-
 include/linux/nvme-fc.h           |  14 +-
 include/linux/nvme-rdma.h         |  10 +-
 include/linux/nvme-tcp.h          |   2 +-
 include/linux/nvme.h              |  10 +-
 include/uapi/linux/nvme_ioctl.h   |   9 -
 114 files changed, 1472 insertions(+), 1124 deletions(-)

-- 
Jens Axboe

