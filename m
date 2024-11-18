Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9F1ABEA5
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940692; cv=none; b=u03uoiIjK6n3xvMTleO2Y2glw1p4nBVO/IV4wezeN6yP+AG5/PqjSTQoyuj0BhewpDvdg8gudFzRnAAmPeLUSHk8rN0FBK2dt/JDEE2UQ/ia7o8Hy3qDrHx0oRg8gwfCFs8XLNfxTuOdNACs+HWy8Ol2Lf88ZUi3/ZHWak+lfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940692; c=relaxed/simple;
	bh=eVvWWI4pYEF8JGhx2KJY+g+FqaZCmwoTOJNmmFwccIs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jderGA0q817qKbqLUpq2mGKXfyeZPffuVmWcAcXEgRfbkIIwRUCFTbFLSRaSpZsZEpixWXmg++L1WGgpFeV4X/rRxo0domjji+sOlUYOBwvxo+3Z1q+Yc7mCYorSNa73eiSkuO+fgZJlT3YNlkQjgwbdVIz/DvbYkjLIAUa6XXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L5ONhu3s; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L5ONhu3s"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc0c05e25so1994408eaf.3
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 06:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731940687; x=1732545487; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOnHrq9IF+qKIlX01vhmoSjnf/5YTGDlWICuHu8Dyko=;
        b=L5ONhu3sA+nGFi4LZcI0yjIH8C1LCkM3c0eqNfsyycqah6xHBOD54Ggxf5/jvpmDMF
         JEn4uKwB2Ajq1sYLnkLb+ZBrjxUj+3bWZIBWBjhAYxyfLX5PUT0Lq0uFYev7K5Bht2Z0
         ryWKYX68c410rIgnRAiwvwBS2VVAn4wllI2eRMGKlVmAS5OprZDsKo5HIBcpZ7LwE97m
         kvmSx1iRuHKEx24eacrKHtu6mUkMkpPSCvJeiRQ6miTZc4h9xIxXtMZw+IGqd6Hfk7s8
         njkdkNaxSizCS/A8t7T03B1vox+F+UFMWtV9GPGFPaD4qkpYd9JP1/jSOWjRk5TTO+Z8
         /7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940687; x=1732545487;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uOnHrq9IF+qKIlX01vhmoSjnf/5YTGDlWICuHu8Dyko=;
        b=qh4WLW/6FWo5Xcs29qRu++N0PxFo7DMjHDndDZ67+SKK3z0U57CODT1/QCGWVqetej
         GCrTH3chTQMqXWLY8Eo5n7zTwP2IKAV8IjKlsd6wdEcwMiCzfiQmPzlLj9+GpxVFgF+U
         xTl7fk4r4mU/VUgAFB496l2EyQVtJI2UbbJ01ATrPCslgibJk8Y8gxQ8KRvpjcqX1a0A
         fWXVMQ65jH0fQ8uGDMsJ128QpmHtgY5Q7P3mXirNhX7061kbgoQIQqsiD0rDCJKu/q9h
         wS3oeR7gCIgv92FSqqmWBmtP09vrwdU144XN/hpfTHRNNwxV0TnF7tL5xg+44SHNIXeH
         NdPw==
X-Gm-Message-State: AOJu0YyyZ+7G0e4O+UE5SI4wR7EFcMFwa514UZHAu3hTLRejkxnRSbhn
	hlaSkM/nku20F9WT6GR3z0eB7YvDZN3OGbo3DWy9PpTkRSaJyT7NGmn36N896NDkufbqoCuVAEa
	2WJo=
X-Google-Smtp-Source: AGHT+IEQ1jdEnm2WH61OGybdE7JYkx0oO+o4UrzqRGHKgVkjH157D2w48ZpjH5sKndGLdSlwcjh0Nw==
X-Received: by 2002:a05:6820:3102:b0:5e5:c456:8996 with SMTP id 006d021491bc7-5eeab4195e9mr10097733eaf.4.1731940686949;
        Mon, 18 Nov 2024 06:38:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a781a18casm2673949a34.56.2024.11.18.06.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 06:38:06 -0800 (PST)
Message-ID: <968b578f-146c-4e94-a68e-e7451762a81a@kernel.dk>
Date: Mon, 18 Nov 2024 07:38:04 -0700
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
Subject: [GIT PULL] Block updates for 6.13-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here are the initial set of block updates for the 6.13 kernel. Fairly
quiet round this time. This request contains:

- NVMe updates via Keith
	- Use uring_cmd helper (Pavel)
	- Host Memory Buffer allocation enhancements (Christoph)
	- Target persistent reservation support (Guixin)
	- Persistent reservation tracing (Guixen)
	- NVMe 2.1 specification support (Keith)
	- Rotational Meta Support (Matias, Wang, Keith)
	- Volatile cache detection enhancment (Guixen)

- MD updates via Song
	- Maintainers update
	- raid5 sync IO fix
	- Enhance handling of faulty and blocked devices
	- raid5-ppl atomic improvement
	- md-bitmap fix

- Support for manually defining embedded partition tables

- Zone append fixes and cleanups

- Stop sending the queued requests in the plug list to the driver
  ->queue_rqs() handle in revers order.

- Zoned write plug cleanups

- Cleanups disk stats tracking and add support for disk stats for
  passthrough IO

- Add preparatory support for file system atomic writes

- Add lockdep support for queue freezing. Already found a bunch of
  issues, and some fixes for that are in here. More will be coming.

- Fix race between queue stopping/quiescing and IO queueing

- ublk recovery improvements

- Fix ublk mmap for 64k pages

- Various fixes and cleanups

Note that merging this will throw a simple merge conflict
drivers/nvme/host/core.c due to the SRCU iteration fix that got merged
late in the 6.12 cycle. I won't bother with noting how to resolve it
here, as it's about as simple as it gets.

Please pull!


The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.13/block-20241118

for you to fetch changes up to 88d47f629313730f26a3b00224d1e1a5e3b7bb79:

  Merge tag 'md-6.13-20241115' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-6.13/block (2024-11-15 12:37:33 -0700)

----------------------------------------------------------------
for-6.13/block-20241118

----------------------------------------------------------------
Bart Van Assche (2):
      blk-mq: Make blk_mq_quiesce_tagset() hold the tag list mutex less long
      blk-mq: Unexport blk_mq_flush_busy_ctxs()

Chaitanya Kulkarni (1):
      nvme-core: remove repeated wq flags

Christian Marangi (6):
      block: add support for defining read-only partitions
      docs: block: Document support for read-only partition in cmdline part
      block: introduce add_disk_fwnode()
      mmc: block: attach partitions fwnode if found in mmc-card
      block: add support for partition table defined in OF
      dt-bindings: mmc: Document support for partition table in mmc-card

Christoph Hellwig (24):
      block: return void from the queue_sysfs_entry load_module method
      block: add a bdev_limits helper
      block: remove zone append special casing from the direct I/O path
      block: remove bio_add_zone_append_page
      block: update blk_stack_limits documentation
      block: remove the max_zone_append_sectors check in blk_revalidate_disk_zones
      block: pre-calculate max_zone_append_sectors
      nvme-pci: fix freeing of the HMB descriptor table
      nvme-pci: use dma_alloc_noncontigous if possible
      block: take chunk_sectors into account in bio_split_write_zeroes
      block: fix bio_split_rw_at to take zone_write_granularity into account
      block: lift bio_is_zone_append to bio.h
      block: pre-calculate max_zone_append_sectors
      nvme-multipath: don't bother clearing max_hw_zone_append_sectors
      block: remove the write_hint field from struct request
      block: remove the ioprio field from struct request
      block: export blk_validate_limits
      btrfs: validate queue limits
      nvme-pci: reverse request order in nvme_queue_rqs
      virtio_blk: reverse request order in virtio_queue_rqs
      block: remove rq_list_move
      block: add a rq_list type
      block: don't reorder requests in blk_add_rq_to_plug
      block: don't reorder requests in blk_mq_add_to_batch

Damien Le Moal (3):
      block: Switch to using refcount_t for zone write plugs
      block: RCU protect disk->conv_zones_bitmap
      block: Add a public bdev_zone_is_seq() helper

David Wang (1):
      block/genhd: use seq_put_decimal_ull for diskstats decimal values

Greg Joyce (1):
      block: sed-opal: add ioctl IOC_OPAL_SET_SID_PW

Guixin Liu (7):
      nvmet: make nvmet_wq visible in sysfs
      nvme: add reservation command's defines
      nvmet: support reservation feature
      nvme: check ns's volatile write cache not present
      nvmet: report ns's vwc not present
      nvme: parse reservation commands's action and rtype to string
      nvmet: add tracing of reservation commands

Jens Axboe (13):
      block: move iostat check into blk_acount_io_start()
      block: remove redundant passthrough check in blk_mq_need_time_stamp()
      block: remove 'req->part' check for stats accounting
      block: kill blk_do_io_stat() helper
      block: set issue time stamp based on queue state
      block: move issue side time stamping to blk_account_io_start()
      Merge branch 'for-6.13/block-atomic' into for-6.13/block
      Merge tag 'md-6.13-20241105' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.13/block
      Revert "block: pre-calculate max_zone_append_sectors"
      Merge tag 'md-6.13-20241107' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.13/block
      Merge tag 'nvme-6.13-2024-11-13' of git://git.infradead.org/nvme into for-6.13/block
      block: make struct rq_list available for !CONFIG_BLOCK
      Merge tag 'md-6.13-20241115' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-6.13/block

John Garry (12):
      block/fs: Pass an iocb to generic_atomic_write_valid()
      fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
      block: Add bdev atomic write limits helpers
      loop: Use bdev limit helpers for configuring discard
      loop: Simplify discard granularity calc
      block: Rework bio_split() return value
      block: Error an attempt to split an atomic write in bio_split()
      block: Handle bio_split() errors in bio_submit_split()
      md/raid0: Handle bio_split() errors
      md/raid1: Handle bio_split() errors
      md/raid10: Handle bio_split() errors
      md/raid5: Increase r5conf.cache_name size

Julia Lawall (1):
      block: replace call_rcu by kfree_rcu for simple kmem_cache_free callback

Keith Busch (11):
      block: enable passthrough command statistics
      blk-integrity: remove seed for user mapped buffers
      nvmet: implement id ns for nvm command set
      nvmet: implement active command set ns list
      nvmet: implement supported log pages
      nvmet: implement supported features log
      nvmet: implement crto property
      nvmet: declare 2.1 version compliance
      nvmet: implement endurance groups
      nvmet: implement rotational media information log
      nvmet: support for csi identify ns

Konstantin Khlebnikov (1):
      block: add partition uuid into uevent as "PARTUUID"

Li Lingfeng (1):
      block: flush all throttled bios when deleting the cgroup

Li Wang (1):
      loop: fix type of block size

Matias Bjørling (1):
      nvme: use command set independent id ns if available

Ming Lei (11):
      blk-mq: add non_owner variant of start_freeze/unfreeze queue APIs
      nvme: core: switch to non_owner variant of start_freeze/unfreeze queue
      block: model freeze & enter queue as lock for supporting lockdep
      iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages
      lib/iov_iter.c: initialize bi.bi_idx before iterating over bvec
      lib/iov_iter: fix bvec iterator setup
      block: remove blk_freeze_queue()
      rbd: unfreeze queue after marking disk as dead
      block: always verify unfreeze lock on the owner task
      block: don't verify IO lock for freeze/unfreeze in elevator_init_mq()
      ublk: fix ublk_ch_mmap() for 64K page size

Miroslav Franc (1):
      s390/dasd: fix redundant /proc/dasd* entries removal

Muchun Song (4):
      block: fix missing dispatching request when queue is started or unquiesced
      block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding
      block: fix ordering between checking BLK_MQ_S_STOPPED request adding
      block: remove redundant explicit memory barrier from rq_qos waiter and waker

Pavel Begunkov (1):
      nvme: use helpers to access io_uring cmd space

Philipp Stanner (1):
      mtip32xx: Replace deprecated PCI functions

Song Liu (2):
      MAINTAINERS: Make Yu Kuai co-maintainer of md/raid subsystem
      MAINTAINERS: Update git tree for mdraid subsystem

Uday Shankar (5):
      ublk: check recovery flags for validity
      ublk: refactor recovery configuration flag helpers
      ublk: merge stop_work and quiesce_work
      ublk: support device recovery without I/O queueing
      Documentation: ublk: document UBLK_F_USER_RECOVERY_FAIL_IO

Uros Bizjak (1):
      md/raid5-ppl: Use atomic64_inc_return() in ppl_new_iounit()

Wang Yugui (1):
      Snvme: add rotational support

Xiao Ni (1):
      md/raid5: Wait sync io to finish before changing group cnt

Xiuhong Wang (1):
      Revert "blk-throttle: Fix IO hang for a corner case"

Yang Erkun (1):
      brd: defer automatic disk creation until module initialization succeeds

Yu Jiaoliang (1):
      s390/dasd: Fix typo in comment

Yu Kuai (7):
      md: add a new helper rdev_blocked()
      md: don't wait faulty rdev in md_wait_for_blocked_rdev()
      md: don't record new badblocks for faulty rdev
      md/raid1: factor out helper to handle blocked rdev from raid1_write_request()
      md/raid1: don't wait for Faulty rdev in wait_blocked_rdev()
      md/raid10: don't wait for Faulty rdev in wait_blocked_rdev()
      md/raid5: don't set Faulty rdev for blocked_rdev

Yuan Can (1):
      md/md-bitmap: Add missing destroy_work_on_stack()

zhangguopeng (1):
      block: Replace sprintf() with sysfs_emit()

 Documentation/ABI/stable/sysfs-block               |    7 +
 Documentation/block/cmdline-partition.rst          |    5 +-
 Documentation/block/ublk.rst                       |   24 +-
 .../devicetree/bindings/mmc/mmc-card.yaml          |   52 +
 MAINTAINERS                                        |    4 +-
 block/bio-integrity.c                              |   13 +-
 block/bio.c                                        |   81 +-
 block/blk-core.c                                   |   26 +-
 block/blk-crypto-fallback.c                        |    2 +-
 block/blk-integrity.c                              |    4 +-
 block/blk-ioc.c                                    |    9 +-
 block/blk-merge.c                                  |  107 +-
 block/blk-mq.c                                     |  307 ++++--
 block/blk-mq.h                                     |   15 +-
 block/blk-rq-qos.c                                 |    4 +-
 block/blk-settings.c                               |   40 +-
 block/blk-sysfs.c                                  |   80 +-
 block/blk-throttle.c                               |   76 +-
 block/blk-zoned.c                                  |   68 +-
 block/blk.h                                        |   52 +-
 block/elevator.c                                   |   18 +-
 block/elevator.h                                   |    4 +-
 block/fops.c                                       |   22 +-
 block/genhd.c                                      |  136 ++-
 block/partitions/Kconfig                           |    9 +
 block/partitions/Makefile                          |    1 +
 block/partitions/check.h                           |    1 +
 block/partitions/cmdline.c                         |    3 +
 block/partitions/core.c                            |    8 +
 block/partitions/of.c                              |  110 ++
 block/sed-opal.c                                   |   26 +
 drivers/block/brd.c                                |   66 +-
 drivers/block/loop.c                               |   13 +-
 drivers/block/mtip32xx/mtip32xx.c                  |   14 +-
 drivers/block/null_blk/main.c                      |    9 +-
 drivers/block/null_blk/zoned.c                     |    2 +-
 drivers/block/rbd.c                                |    1 +
 drivers/block/ublk_drv.c                           |  208 ++--
 drivers/block/virtio_blk.c                         |   55 +-
 drivers/md/dm-cache-target.c                       |    4 +-
 drivers/md/dm-clone-target.c                       |    4 +-
 drivers/md/dm-thin.c                               |    2 +-
 drivers/md/dm-zone.c                               |    4 +-
 drivers/md/md-bitmap.c                             |    1 +
 drivers/md/md.c                                    |   15 +-
 drivers/md/md.h                                    |   24 +
 drivers/md/raid0.c                                 |   12 +
 drivers/md/raid1.c                                 |  108 +-
 drivers/md/raid10.c                                |   87 +-
 drivers/md/raid5-ppl.c                             |    2 +-
 drivers/md/raid5.c                                 |   17 +-
 drivers/md/raid5.h                                 |    2 +-
 drivers/mmc/core/block.c                           |   55 +-
 drivers/nvme/host/apple.c                          |    2 +-
 drivers/nvme/host/core.c                           |   38 +-
 drivers/nvme/host/ioctl.c                          |   21 +-
 drivers/nvme/host/multipath.c                      |    2 -
 drivers/nvme/host/nvme.h                           |    1 +
 drivers/nvme/host/pci.c                            |  120 +-
 drivers/nvme/host/trace.c                          |   58 +-
 drivers/nvme/host/zns.c                            |    2 +-
 drivers/nvme/target/Makefile                       |    2 +-
 drivers/nvme/target/admin-cmd.c                    |  288 ++++-
 drivers/nvme/target/configfs.c                     |   27 +
 drivers/nvme/target/core.c                         |   64 +-
 drivers/nvme/target/fabrics-cmd.c                  |    7 +-
 drivers/nvme/target/nvmet.h                        |   67 +-
 drivers/nvme/target/pr.c                           | 1156 ++++++++++++++++++++
 drivers/nvme/target/trace.c                        |  108 ++
 drivers/nvme/target/zns.c                          |   21 +-
 drivers/s390/block/dasd.c                          |    2 +-
 drivers/s390/block/dasd_devmap.c                   |    2 +-
 drivers/s390/block/dasd_eckd.c                     |    2 +-
 drivers/s390/block/dasd_proc.c                     |    5 +
 drivers/scsi/sd.c                                  |    6 +-
 drivers/scsi/sd_zbc.c                              |    2 -
 fs/btrfs/zoned.c                                   |   13 +-
 fs/read_write.c                                    |   15 +-
 include/linux/bio-integrity.h                      |    4 +-
 include/linux/bio.h                                |   19 +-
 include/linux/blk-integrity.h                      |    5 +-
 include/linux/blk-mq.h                             |  115 +-
 include/linux/blkdev.h                             |  111 +-
 include/linux/fs.h                                 |    2 +-
 include/linux/nvme.h                               |  135 ++-
 include/linux/sed-opal.h                           |    1 +
 include/trace/events/block.h                       |    6 +-
 include/uapi/linux/sed-opal.h                      |    1 +
 include/uapi/linux/ublk_cmd.h                      |   18 +
 io_uring/rw.c                                      |    4 +-
 lib/iov_iter.c                                     |   68 +-
 91 files changed, 3617 insertions(+), 922 deletions(-)
 create mode 100644 block/partitions/of.c
 create mode 100644 drivers/nvme/target/pr.c

-- 
Jens Axboe

