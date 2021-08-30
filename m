Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EF7C432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 14:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B493D60240
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 14:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhH3OdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbhH3OdX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 10:33:23 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0993DC061575
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 07:32:30 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e186so20136455iof.12
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wSeItNf2j2BTB0N5riOuXhZPxFPxsZfWW9GKHLK8ubg=;
        b=C29j9IGFZj+AbV3R0Nxur1XEdcj/0ZCu78Rd3NvM6n3ARUnFKhgYSw1tAbxlS03hDY
         5ifaKbTWRoHYMMdo41QZO5LUkm2VU3TVSJRQXqQQoLVoGz80UxUPYoImYEW2fS/FAciA
         e0BFf/X1u+EZJZug3YpP7kcTOH1lfvDf0589qZ5s4Qt3dE5uMbKwgtV3dsSTh/QGzKRw
         +qPN/+yKJeSRfWLA33LFLYCY643H/wYIT7u65ovkhdUVY9dCAbzzrZqsmHUOFkfDUNbd
         Tsx1DbRGXm2yPmzXomVNXPMrGA3wwuC+XLss3s9SOw/tssBMqi1YvQXjD3qaJ2aoDa7h
         ZzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wSeItNf2j2BTB0N5riOuXhZPxFPxsZfWW9GKHLK8ubg=;
        b=ibV5CIE7TH4iB54CVkiJ/QQ8o487UHINelrmI522mDbqGQd9Q+WqVNOK1+c89j/hik
         e51HEayu1Pqt1zmdILfTPbTNB/GtQslQjoR54wdw66q+UALk7laFWRBb2zVn14b2yOpF
         dV2vSNO6mZQhmJxXd+8t6dw9p5ZYRnBfTq+LQDfRzTV5Eoy6yJ97nOhr4VC5Yg6rKAau
         ocsqJRmcGEBnZqS6iZ3PvBo1ZB774q4axbu7Ur1/5lYRNfv7ggcUNSubSNkehyTCcYF4
         mOMcjdgjqxJKX9CyiHdIuV0bWtn1VuII5XO749SI5R7KP1cFiMwDOwpTHu3D9H9GPvwp
         nQtg==
X-Gm-Message-State: AOAM530RFrQeev4CwZQaoX4OHP0YjHFjgsrqY6Owwn9STOEBcg3SJ9Le
        89LdNnemr5EL2LP9DpgABUjBYFh1nvPPgg==
X-Google-Smtp-Source: ABdhPJwvwV+2qLik/AQdlF3PwOULCnvPjQl64Daan8lRk57SUve62+1ZQ+vq33QEqnnECvIla6vUag==
X-Received: by 2002:a5e:d60e:: with SMTP id w14mr18572371iom.135.1630333949060;
        Mon, 30 Aug 2021 07:32:29 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i14sm8954148ilc.51.2021.08.30.07.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 07:32:28 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 5.15-rc1
Message-ID: <e1a3e2aa-ad96-c9c6-af38-16b7300a5612@kernel.dk>
Date:   Mon, 30 Aug 2021 08:32:27 -0600
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

Nothing major in here - lots of good cleanups and tech debt handling,
which is also evident in the diffstats. In particular:

- Add disk sequence numbers (Matteo)

- Discard merge fix (Ming)

- Relax disk zoned reporting restrictions (Niklas)

- Bio error handling zoned leak fix (Pavel)

- Start of proper add_disk() error handling (Luis, Christoph)

- blk crypto fix (Eric)

- Non-standard GPT location support (Dmitry)

- IO priority improvements and cleanups (Damien)o

- blk-throtl improvements (Chunguang)

- diskstats_show() stack reduction (Abd-Alrhman)

- Loop scheduler selection (Bart)

- Switch block layer to use kmap_local_page() (Christoph)

- Remove obsolete disk_name helper (Christoph)

- block_device refcounting improvements (Christoph)

- Ensure gendisk always has a request queue reference (Christoph)

- Misc fixes/cleanups (Shaokun, Oliver, Guoqing)

Note that this will throw two conflicts when being pulled in:

1) block/mq-deadline-cgroup.c - this one got reverted late in the 5.14
   cycle, git rm is the right resolution here.

2) drivers/block/virtio_blk.c - error handling fix later in the 5.14
   cycle ends up touching the same out path. My resolution:

diff --cc drivers/block/virtio_blk.c
index afb37aac09e8,63dc121a4c43..2a5e27bb8e59
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@@ -902,10 -875,13 +899,13 @@@ static int virtblk_probe(struct virtio_
  	virtblk_update_capacity(vblk, false);
  	virtio_device_ready(vdev);
  
- 	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
+ 	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
+ 	if (err)
 -		goto out_cleanup_disk;
++		goto err_cleanup_disk;
+ 
  	return 0;
  
 -out_cleanup_disk:
 +err_cleanup_disk:
  	blk_cleanup_disk(vblk->disk);
  out_free_tags:
  	blk_mq_free_tag_set(&vblk->tag_set);

Apart from that, all clean.

Please pull!


The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.15/block-2021-08-30

for you to fetch changes up to 1d1cf156dc176e30eeaced5cf1450d582d387b81:

  sg: pass the device name to blk_trace_setup (2021-08-25 06:46:54 -0600)

----------------------------------------------------------------
for-5.15/block-2021-08-30

----------------------------------------------------------------
Abd-Alrhman Masalkhi (1):
      block: reduce stack usage in diskstats_show

Bart Van Assche (2):
      blk-mq: Introduce the BLK_MQ_F_NO_SCHED_BY_DEFAULT flag
      loop: Select I/O scheduler 'none' from inside add_disk()

Christoph Hellwig (95):
      MIPS: don't include <linux/genhd.h> in <asm/mach-rc32434/rb.h>
      bvec: fix the include guards for bvec.h
      bvec: add a bvec_kmap_local helper
      bvec: add memcpy_{from,to}_bvec and memzero_bvec helper
      block: use memzero_page in zero_fill_bio
      rbd: use memzero_bvec
      dm-writecache: use bvec_kmap_local instead of bvec_kmap_irq
      ps3disk: use memcpy_{from,to}_bvec
      block: remove bvec_kmap_irq and bvec_kunmap_irq
      block: rewrite bio_copy_data_iter to use bvec_kmap_local and memcpy_to_bvec
      block: use memcpy_to_bvec in copy_to_high_bio_irq
      block: use memcpy_from_bvec in bio_copy_kern_endio_read
      block: use memcpy_from_bvec in __blk_queue_bounce
      block: use bvec_kmap_local in t10_pi_type1_{prepare,complete}
      block: use bvec_kmap_local in bio_integrity_process
      block: assert the locking state in delete_partition
      block: unhash the whole device inode earlier
      block: allocate bd_meta_info later in add_partitions
      block: change the refcounting for partitions
      loop: don't grab a reference to the block device
      block: remove bdgrab
      block: remove bdput
      block: use the %pg format specifier in printk_all_partitions
      block: use the %pg format specifier in show_partition
      block: simplify printing the device names disk_stack_limits
      block: simplify disk name formatting in check_partition
      block: remove disk_name()
      block: remove cmdline-parser.c
      block: make the block holder code optional
      block: remove the extra kobject reference in bd_link_disk_holder
      block: look up holders by bdev
      block: support delayed holder registration
      dm: cleanup cleanup_mapped_device
      dm: move setting md->type into dm_setup_md_queue
      dm: delay registering the gendisk
      block: remove support for delayed queue registrations
      mm: hide laptop_mode_wb_timer entirely behind the BDI API
      block: pass a gendisk to blk_queue_update_readahead
      block: add a queue_has_disk helper
      block: move the bdi from the request_queue to the gendisk
      block: remove the bd_bdi in struct block_device
      writeback: make the laptop_mode prototypes available unconditionally
      mmc: block: let device_add_disk create disk attributes
      mmc: block: cleanup gendisk creation
      nvme: remove the GENHD_FL_UP check in nvme_ns_remove
      nvme: replace the GENHD_FL_UP check in nvme_mpath_shutdown_disk
      sx8: use the internal state machine to check if del_gendisk needs to be called
      bcache: add proper error unwinding in bcache_device_init
      bcache: move the del_gendisk call out of bcache_device_free
      block: remove GENHD_FL_UP
      block: store a gendisk in struct parsed_partitions
      block: pass a gendisk to bdev_add_partition
      block: pass a gendisk to bdev_del_partition
      block: pass a gendisk to bdev_resize_partition
      block: free the extended dev_t minor later
      block: ensure the bdi is freed after inode_detach_wb
      bvec: add a bvec_virt helper
      block: use bvec_virt in bio_integrity_{process,free}
      dm: make EBS depend on !HIGHMEM
      dm-ebs: use bvec_virt
      dm-integrity: use bvec_virt
      squashfs: use bvec_virt
      rbd: use bvec_virt
      virtio_blk: use bvec_virt
      bcache: use bvec_virt
      sd: use bvec_virt
      ubd: use bvec_virt
      ps3vram: use bvec_virt
      dasd: use bvec_virt
      dcssblk: use bvec_virt
      nvme: use bvec_virt
      blk-cgroup: refactor blkcg_print_stat
      blk-cgroup: stop using seq_get_buf
      block: unexport blk_register_queue
      block: add back the bd_holder_dir reference in bd_link_disk_holder
      nvme: use blk_mq_alloc_disk
      st: do not allocate a gendisk
      sg: do not allocate a gendisk
      block: cleanup the lockdep handling in *alloc_disk
      block: remove alloc_disk and alloc_disk_node
      block: remove the minors argument to __alloc_disk_node
      block: pass a request_queue to __blk_alloc_disk
      block: hold a request_queue reference for the lifetime of struct gendisk
      block: add an explicit ->disk backpointer to the request_queue
      block: add a sanity check for a live disk in del_gendisk
      block: fold register_disk into device_add_disk
      block: call bdev_add later in device_add_disk
      block: create the bdi link earlier in device_add_disk
      block: call blk_integrity_add earlier in device_add_disk
      block: call blk_register_queue earlier in device_add_disk
      block: remove a pointless call to MINOR() in device_add_disk
      block: remove CONFIG_DEBUG_BLOCK_EXT_DEVT
      block: refine the disk_live check in del_gendisk
      block: mark blkdev_fsync static
      sg: pass the device name to blk_trace_setup

Chunguang Xu (1):
      blk-throtl: optimize IOPS throttle for large IO scenarios

Damien Le Moal (7):
      block: remove blk-mq-sysfs dead code
      block: bfq: fix bfq_set_next_ioprio_data()
      block: improve ioprio class description comment
      block: change ioprio_valid() to an inline function
      block: fix IOPRIO_PRIO_CLASS() and IOPRIO_PRIO_VALUE() macros
      block: Introduce IOPRIO_NR_LEVELS
      block: fix default IO priority handling

Dmitry Osipenko (4):
      block: Add alternative_gpt_sector() operation
      partitions/efi: Support non-standard GPT location
      mmc: block: Support alternative_gpt_sector() operation
      mmc: sdhci-tegra: Enable MMC_CAP2_ALT_GPT_TEGRA

Eric Biggers (1):
      blk-crypto: fix check for too-large dun_bytes

Guoqing Jiang (1):
      block: move some macros to blkdev.h

Luis Chamberlain (5):
      block: return errors from blk_integrity_add
      block: return errors from disk_alloc_events
      block: add error handling for device_add_disk / add_disk
      virtio_blk: add error handling support for add_disk()
      null_blk: add error handling support for add_disk()

Matteo Croce (6):
      block: add disk sequence number
      block: export the diskseq in uevents
      block: add ioctl to read the disk sequence number
      block: export diskseq in sysfs
      block: add a helper to raise a media changed event
      loop: raise media_change event

Ming Lei (1):
      block: return ELEVATOR_DISCARD_MERGE if possible

Niklas Cassel (2):
      blk-zoned: allow zone management send operations without CAP_SYS_ADMIN
      blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN

Oliver Hartkopp (1):
      ioprio: move user space relevant ioprio bits to UAPI includes

Pavel Begunkov (1):
      bio: fix page leak bio_add_hw_page failure

Shaokun Zhang (1):
      block, bfq: cleanup the repeated declaration

 Documentation/ABI/testing/sysfs-block   |  12 +
 arch/m68k/configs/stmark2_defconfig     |   1 -
 arch/mips/include/asm/mach-rc32434/rb.h |   2 -
 arch/riscv/configs/defconfig            |   1 -
 arch/riscv/configs/rv32_defconfig       |   1 -
 arch/um/drivers/ubd_kern.c              |   3 +-
 block/Kconfig                           |  14 +-
 block/Makefile                          |   2 +-
 block/bfq-iosched.c                     |  17 +-
 block/bfq-iosched.h                     |   6 +-
 block/bfq-wf2q.c                        |   6 +-
 block/bio-integrity.c                   |  21 +-
 block/bio.c                             |  52 ++---
 block/blk-cgroup.c                      | 139 +++++-------
 block/blk-core.c                        |  18 +-
 block/blk-crypto.c                      |   2 +-
 block/blk-integrity.c                   |  12 +-
 block/blk-iocost.c                      |  23 +-
 block/blk-iolatency.c                   |  38 ++--
 block/blk-map.c                         |   2 +-
 block/blk-merge.c                       |  18 +-
 block/blk-mq-sysfs.c                    |  55 -----
 block/blk-mq.c                          |   8 +-
 block/blk-settings.c                    |  34 +--
 block/blk-sysfs.c                       |  35 +--
 block/blk-throttle.c                    |  32 +++
 block/blk-wbt.c                         |   8 +-
 block/blk-zoned.c                       |   6 -
 block/blk.h                             |  20 +-
 block/bounce.c                          |  39 +---
 block/cmdline-parser.c                  | 255 ---------------------
 block/disk-events.c                     |  69 ++++--
 block/elevator.c                        |   7 +-
 block/genhd.c                           | 385 ++++++++++++++++----------------
 block/holder.c                          | 174 +++++++++++++++
 block/ioctl.c                           |  16 +-
 block/ioprio.c                          |   9 +-
 block/mq-deadline-cgroup.c              |   8 +-
 block/mq-deadline-main.c                |   2 +
 block/partitions/Kconfig                |   1 -
 block/partitions/acorn.c                |   4 +-
 block/partitions/aix.c                  |  20 +-
 block/partitions/amiga.c                |   7 +-
 block/partitions/atari.c                |   4 +-
 block/partitions/check.h                |   2 +-
 block/partitions/cmdline.c              | 273 +++++++++++++++++++++-
 block/partitions/core.c                 |  73 +++---
 block/partitions/efi.c                  |  48 ++--
 block/partitions/ibm.c                  |   4 +-
 block/partitions/ldm.c                  |  18 +-
 block/partitions/mac.c                  |   2 +-
 block/partitions/msdos.c                |   6 +-
 block/partitions/sgi.c                  |   5 +-
 block/partitions/sun.c                  |   5 +-
 block/t10-pi.c                          |  16 +-
 drivers/block/brd.c                     |   3 -
 drivers/block/drbd/drbd_nl.c            |   2 +-
 drivers/block/drbd/drbd_req.c           |   5 +-
 drivers/block/loop.c                    |  13 +-
 drivers/block/null_blk/main.c           |   7 +-
 drivers/block/pktcdvd.c                 |   8 +-
 drivers/block/ps3disk.c                 |  18 +-
 drivers/block/ps3vram.c                 |   2 +-
 drivers/block/rbd.c                     |  18 +-
 drivers/block/sx8.c                     |   2 +-
 drivers/block/virtio_blk.c              |  14 +-
 drivers/md/Kconfig                      |   4 +-
 drivers/md/bcache/Kconfig               |   1 +
 drivers/md/bcache/btree.c               |   2 +-
 drivers/md/bcache/super.c               |  26 ++-
 drivers/md/bcache/util.h                |   2 -
 drivers/md/dm-ebs-target.c              |   2 +-
 drivers/md/dm-integrity.c               |   4 +-
 drivers/md/dm-ioctl.c                   |   4 -
 drivers/md/dm-rq.c                      |   1 -
 drivers/md/dm-table.c                   |   2 +-
 drivers/md/dm-writecache.c              |   5 +-
 drivers/md/dm.c                         |  32 ++-
 drivers/md/md.h                         |   4 +-
 drivers/mmc/core/block.c                | 164 +++++++-------
 drivers/mmc/core/core.c                 |  35 +++
 drivers/mmc/core/core.h                 |   2 +
 drivers/mmc/core/mmc.c                  |   2 +
 drivers/mmc/host/sdhci-tegra.c          |   9 +
 drivers/nvme/host/core.c                |  56 ++---
 drivers/nvme/host/multipath.c           |   2 +-
 drivers/s390/block/dasd_diag.c          |   2 +-
 drivers/s390/block/dasd_eckd.c          |  14 +-
 drivers/s390/block/dasd_fba.c           |   4 +-
 drivers/s390/block/dasd_genhd.c         |   7 +-
 drivers/s390/block/dcssblk.c            |   3 +-
 drivers/scsi/sd.c                       |   8 +-
 drivers/scsi/sg.c                       |  32 +--
 drivers/scsi/sr.c                       |   7 +-
 drivers/scsi/st.c                       |  49 +---
 drivers/scsi/st.h                       |   2 +-
 fs/block_dev.c                          | 257 +++------------------
 fs/f2fs/sysfs.c                         |   2 +-
 fs/fat/fatent.c                         |   1 +
 fs/nilfs2/super.c                       |   2 +-
 fs/squashfs/block.c                     |   7 +-
 fs/squashfs/lz4_wrapper.c               |   2 +-
 fs/squashfs/lzo_wrapper.c               |   2 +-
 fs/squashfs/xz_wrapper.c                |   2 +-
 fs/squashfs/zlib_wrapper.c              |   2 +-
 fs/squashfs/zstd_wrapper.c              |   2 +-
 fs/super.c                              |   2 +-
 fs/xfs/xfs_buf.c                        |   2 +-
 include/linux/backing-dev.h             |   2 +-
 include/linux/bio.h                     |  42 ----
 include/linux/blk-cgroup.h              |   4 +-
 include/linux/blk-mq.h                  |  16 +-
 include/linux/blk_types.h               |   4 -
 include/linux/blkdev.h                  |  38 +++-
 include/linux/bvec.h                    |  64 +++++-
 include/linux/cmdline-parser.h          |  46 ----
 include/linux/device-mapper.h           |   1 -
 include/linux/fs.h                      |   4 -
 include/linux/genhd.h                   |  70 +++---
 include/linux/ioprio.h                  |  44 +---
 include/linux/mmc/card.h                |   1 +
 include/linux/mmc/host.h                |   1 +
 include/linux/writeback.h               |   5 -
 include/trace/events/kyber.h            |   6 +-
 include/uapi/linux/fs.h                 |   1 +
 include/uapi/linux/ioprio.h             |  52 +++++
 init/do_mounts.c                        |   4 -
 lib/Kconfig.debug                       |  27 ---
 mm/backing-dev.c                        |   3 +
 mm/page-writeback.c                     |   2 -
 130 files changed, 1584 insertions(+), 1755 deletions(-)
 delete mode 100644 block/cmdline-parser.c
 create mode 100644 block/holder.c
 delete mode 100644 include/linux/cmdline-parser.h
 create mode 100644 include/uapi/linux/ioprio.h

-- 
Jens Axboe

