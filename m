Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6532124676E
	for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709216; cv=none; b=MlP48qf3abNz3gBdPS5AdVFXV+saa9clSLaX/ehBxOE1K5m4fCXJqkJQCWp5M4AfMlGWqll5NoMRyr1e9HIm+HvPk2tvX/e4dM+GkGmpRoiwAGHfk2mKq5+P335rTupd9lV9lWVqKqrTZn54a06GmQSiPLP171JMIJPvreI5ftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709216; c=relaxed/simple;
	bh=oMyo61nddFeEKl2AFoF0lrpHpsNMOpMWln8RIAuwlas=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=LAWs9GwsoYnb4zMitVEZCh4BlQphdlrIiJsdzXbl9jjyJ5p8q9jEoSHHwRbCYRl5/hVtsEZ+ZnAPX9J/ESYoKJsKLfLIAyYv/OZN+NTetAjG+Eth4djsmfvixNkC5ZurvMcqbpEdCdBJbBObHj6C2A1KMeufspfwwISb3Cy9+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jrlIRuqS; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jrlIRuqS"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e3b483daf3so39333825ab.0
        for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753709211; x=1754314011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=figgyFwv/iDPlE96XgDRs+SIvBByMB6NCNBgvZ8ClsQ=;
        b=jrlIRuqS/6s2+bhT8d7aadPFTrGm/bSC9X/cWQO2UInrvwU7Hwt4lRoJq6LHUT9Vqb
         fUXwkwpA3hvqK5MAoi2ybGYiyq8Y62oImCfy5JD82jPc/WjenlL6WvdHI1Wu0MeKOaiZ
         aJMhHpRucCuIPB1TbOz7FJngXgHY5AXeDk6ZZCb5i2qHPjktRCYshlEqHOuan0OPDg+b
         sxlD0e6I+QvsoqVDU90gWg4K1G9xyOSlbdWYduXLPgHq6IoWW/aWppSUORLIkG7aG8u2
         nPvCRblmVyew/m2uK5dD1Rh+6NfbnJO4FADKPp+CN17BZ7QTvk22cZvUdzyYYw8PFKWC
         q8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753709211; x=1754314011;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=figgyFwv/iDPlE96XgDRs+SIvBByMB6NCNBgvZ8ClsQ=;
        b=GmJKd11u9ozS6HodgK6S3cDL3GVQzYBVX6iEF7/yr50Z32mLXEezC02NQhku6uu0lP
         xRgcyempN3Gyu8lv9N4CWtJa4ZcO1IB/Fkb4kD5wXggQmdDtLEaJGrgHgADT0MSGcnY9
         +OtdQqfMJDgJXKmYqjeUUEIWP3uclr6cEyqdp3ESipLXFDKeRFGMUiZhNKOQfgEh74tD
         deZI18sNHDurQDbD6J1dZR5Z/lyrQVU7VGHgeyXr5pBkDFk1sMzl5akTPKiFQB1DQDB6
         WpBps0aV1YKtiRcBXCJzXUjuNVGq6+xipBBZDriPaKlC5qMQRqbHUJsexN5xJI/OuTrp
         0w0Q==
X-Gm-Message-State: AOJu0Yz9M72YhZ/nmzixXhCySqX61/nFMNLGoUngSEMRG9OMJiYTeWay
	VivEoQ1MTJii9uV6MDxLXmyA/ySiFa7KrMZ0/zlGOYyaMtvLbdq0aDbS7OzbtLdcWn1GbLA6QgW
	HaS/3
X-Gm-Gg: ASbGncu9NUakJ5TH3IwNS1ovviGdFOgIA7gA5WlvAgGNReuwOUUw0Qg9KGYUKAFV+Um
	iXkn8T/luBkT0PxLuSi6c6Lqf3Un7WUMJBhFQJLYacpMrshvNBTnDuLlfvZ+hNYK9u+bv7W+0Ch
	0NviVRtY2pvD6nyJ3u8CS4i1wikYuJJffXzixG4jeVvM1WVvj96e2CFxbC1IVzVy27d7RgQNgdt
	XLwqt88rv2TAHgNhvJYPGJD8KjKuAxYxuJpq9fbSK6mza4EFD/OKnGBsGQsPX9T6qppiV93K9Mr
	AZld4ucIw4jmJiir0oD134H5s6173O1pO3addZuzTNPw2Au3kUGbk2KZIDrDgYFNVdrEKeh3CFP
	KJPTWk6EKOqT9CHoPDiw=
X-Google-Smtp-Source: AGHT+IFvJZlxGJqGTRF/aeHq/rUXIJolnIDqAkvMvznS7F968xF/7jJXM6cdd+Q1/ErCfOEfgz8wnQ==
X-Received: by 2002:a05:6e02:441a:10b0:3e3:c6a6:2799 with SMTP id e9e14a558f8ab-3e3c6a62985mr140179685ab.21.1753709204494;
        Mon, 28 Jul 2025 06:26:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3d1b815d4sm18076465ab.3.2025.07.28.06.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 06:26:43 -0700 (PDT)
Message-ID: <9855947c-74e1-43cb-bda9-a720293f33ae@kernel.dk>
Date: Mon, 28 Jul 2025 07:26:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here are the block changes and update for the 6.17 kernel release. This
pull request contains:

- MD pull request via Yu
	- call del_gendisk synchronously, from Xiao
	- cleanup unused variable, from John
	- cleanup workqueue flags, from Ryo
	- fix faulty rdev can't be removed during resync, from Qixing

- NVMe pull request via Christoph
	- try PCIe function level reset on init failure (Keith Busch)
	- log TLS handshake failures at error level (Maurizio Lombardi)
	- pci-epf: do not complete commands twice if nvmet_req_init()
	  fails (Rick Wertenbroek)
	- misc cleanups (Alok Tiwari)

- Removal of the pktcdvd driver. This has been more than a decade coming
  at this point, and some recently revealed breakages that had it
  causing issues even for cases where it isn't required made me re-pull
  the trigger on this one. It's known broken and nobody has stepped up
  to maintain the code.

- Series for ublk supporting batch commands, enabling the use of
  multishot where appropriate.

- Speed up ublk exit handling.

- Fix for the two-stage elevator fixing which could leak data.

- Convert NVMe to use the new IOVA based API.

- Increase default max transfer size to something more reasonable.

- Series fixing write operations on zoned DM devices.

- Add tracepoints for zoned block device operations.

- Prep series working towards improving blk-mq queue management in the
  presence of isolated CPUs.

- Don't allow updating of the block size of a loop device that is
  currently under exclusively ownership/open.

- Set chunk sectors from stacked device stripe size and use it for the
  atomic write size limit.

- Switch to folios in bcache read_super()

- Fix for CD-ROM MRW exit flush handling.

- Various tweaks, fixes, and cleanups.

Please pull!


The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.17/block-20250728

for you to fetch changes up to 5989bfe6ac6bf230c2c84e118c786be0ed4be3f4:

  block: restore two stage elevator switch while running nr_hw_queue update (2025-07-25 06:10:02 -0600)

----------------------------------------------------------------
for-6.17/block-20250728

----------------------------------------------------------------
Alok Tiwari (5):
      nvme: fix multiple spelling and grammar issues in host drivers
      nvme: fix incorrect variable in io cqes error message
      nvmet: remove redundant assignment of error code in nvmet_ns_enable()
      nvme: fix typo in status code constant for self-test in progress
      docs: nvme: fix grammar in nvme-pci-endpoint-target.rst

Caleb Sander Mateos (14):
      ublk: use vmalloc for ublk_device's __queues
      ublk: remove struct ublk_rq_data
      ublk: check cmd_op first
      ublk: handle UBLK_IO_FETCH_REQ earlier
      ublk: remove task variable from __ublk_ch_uring_cmd()
      ublk: consolidate UBLK_IO_FLAG_{ACTIVE,OWNED_BY_SRV} checks
      ublk: don't take ublk_queue in ublk_unregister_io_buf()
      ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
      ublk: return early if blk_should_fake_timeout()
      ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task
      ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon task
      ublk: remove ubq checks from ublk_{get,put}_req_ref()
      ublk: cache-align struct ublk_io
      ublk: remove unused req argument from ublk_sub_req_ref()

Christoph Hellwig (10):
      block: don't merge different kinds of P2P transfers in a single bio
      block: add scatterlist-less DMA mapping helpers
      nvme-pci: refactor nvme_pci_use_sgls
      nvme-pci: merge the simple PRP and SGL setup into a common helper
      nvme-pci: remove superfluous arguments
      nvme-pci: convert the data mapping to blk_rq_dma_map
      nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
      nvme-pci: rework the build time assert for NVME_MAX_NR_DESCRIPTORS
      nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping
      nvme-pci: don't allocate dma_vec for IOVA mappings

Damien Le Moal (6):
      block: Increase BLK_DEF_MAX_SECTORS_CAP
      block: Make REQ_OP_ZONE_FINISH a write operation
      block: Introduce bio_needs_zone_write_plugging()
      dm: Always split write BIOs to zoned device limits
      dm: dm-crypt: Do not partially accept write BIOs with zoned targets
      dm: Check for forbidden splitting of zone write operations

Daniel Wagner (5):
      lib/group_cpus: Let group_cpu_evenly() return the number of initialized masks
      blk-mq: add number of queue calc helper
      nvme-pci: use block layer helpers to calculate num of queues
      scsi: use block layer helpers to calculate num of queues
      virtio: blk/scsi: use block layer helpers to calculate num of queues

Jan Kara (1):
      loop: Avoid updating block size under exclusive owner

Jens Axboe (4):
      block: remove pktcdvd driver
      Documentation: remove reference to pktcdvd in cdrom documentation
      Merge tag 'nvme-6.17-2025-07-22' of git://git.infradead.org/nvme into for-6.17/block
      Merge tag 'md-6.17-20250722' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-6.17/block

Johannes Thumshirn (6):
      blktrace: add zoned block commands to blk_fill_rwbs
      block: split blk_zone_update_request_bio into two functions
      block: add tracepoint for blk_zone_update_request_bio
      block: add tracepoint for blkdev_zone_mgmt
      block: add trace messages to zone write plugging
      block: fix blk_zone_append_update_request_bio() kernel-doc

John Garry (7):
      md/raid10: fix set but not used variable in sync_request_write()
      ilog2: add max_pow_of_two_factor()
      block: sanitize chunk_sectors for atomic write limits
      md/raid0: set chunk_sectors limit
      md/raid10: set chunk_sectors limit
      dm-stripe: limit chunk_sectors to the stripe size
      block: use chunk_sectors when evaluating stacked atomic write limits

Keith Busch (1):
      nvme-pci: try function level reset on init failure

Ma Ke (1):
      sunvdc: Balance device refcount in vdc_port_mpgroup_check

Matthew Wilcox (Oracle) (1):
      bcache: switch from pages to folios in read_super()

Maurizio Lombardi (1):
      nvme-tcp: log TLS handshake failures at error level

Ming Lei (18):
      nbd: fix lockdep deadlock warning
      ublk: validate ublk server pid
      ublk: look up ublk task via its pid in timeout handler
      ublk: move fake timeout logic into __ublk_complete_rq()
      ublk: let ublk_fill_io_cmd() cover more things
      ublk: avoid to pass `struct ublksrv_io_cmd *` to ublk_commit_and_fetch()
      ublk: move auto buffer register handling into one dedicated helper
      ublk: store auto buffer register data into `struct ublk_io`
      ublk: add helper ublk_check_fetch_buf()
      ublk: remove ublk_commit_and_fetch()
      ublk: pass 'const struct ublk_io *' to ublk_[un]map_io()
      selftests: ublk: remove `tag` parameter of ->tgt_io_done()
      selftests: ublk: pass 'ublk_thread *' to ->queue_io() and ->tgt_io_done()
      selftests: ublk: pass 'ublk_thread *' to more common helpers
      selftests: ublk: remove ublk queue self-defined flags
      selftests: ublk: improve flags naming
      selftests: ublk: add helper ublk_handle_uring_cmd() for handle ublk command
      selftests: ublk: add utils.h

Nilay Shroff (1):
      block: restore two stage elevator switch while running nr_hw_queue update

Phillip Potter (1):
      cdrom: Call cdrom_mrw_exit from cdrom_release function

Purva Yeshi (1):
      block: floppy: Fix uninitialized use of outparam

Rahul Kumar (1):
      block: zram: replace scnprintf() with sysfs_emit() in *_show() functions

Rick Wertenbroek (1):
      nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails

Ryo Takakura (1):
      md/raid5: unset WQ_CPU_INTENSIVE for raid5 unbound workqueue

Sarah Newman (1):
      drbd: add missing kref_get in handle_write_conflicts

Sergey Senozhatsky (1):
      zram: pass buffer offset to zcomp_available_show()

Shin'ichiro Kawasaki (1):
      dm: split write BIOs on zone boundaries when zone append is not emulated

Thomas Fourier (1):
      block: mtip32xx: Fix usage of dma_map_sg()

Uday Shankar (2):
      ublk: speed up ublk server exit handling
      ublk: introduce and use ublk_set_canceling helper

Xiao Ni (3):
      md: call del_gendisk in control path
      md: Don't clear MD_CLOSING until mddev is freed
      md: remove/add redundancy group only in level change

Zheng Qixing (1):
      md: allow removing faulty rdev during resync

 Documentation/ABI/testing/debugfs-pktcdvd          |   18 -
 Documentation/ABI/testing/sysfs-class-pktcdvd      |   97 -
 Documentation/cdrom/cdrom-standard.rst             |    1 -
 Documentation/cdrom/index.rst                      |    1 -
 Documentation/cdrom/packet-writing.rst             |  139 -
 Documentation/nvme/nvme-pci-endpoint-target.rst    |   22 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 -
 MAINTAINERS                                        |    7 -
 block/bio-integrity.c                              |    3 +
 block/bio.c                                        |   20 +-
 block/blk-mq-cpumap.c                              |   46 +-
 block/blk-mq-dma.c                                 |  161 ++
 block/blk-mq.c                                     |   96 +-
 block/blk-settings.c                               |   62 +-
 block/blk-zoned.c                                  |   43 +-
 block/blk.h                                        |   42 +-
 block/elevator.c                                   |   10 +-
 drivers/block/Kconfig                              |   43 -
 drivers/block/Makefile                             |    1 -
 drivers/block/drbd/drbd_receiver.c                 |    6 +-
 drivers/block/floppy.c                             |    2 +-
 drivers/block/loop.c                               |   38 +-
 drivers/block/mtip32xx/mtip32xx.c                  |   27 +-
 drivers/block/nbd.c                                |   12 +-
 drivers/block/pktcdvd.c                            | 2916 --------------------
 drivers/block/sunvdc.c                             |    4 +-
 drivers/block/ublk_drv.c                           |  578 ++--
 drivers/block/virtio_blk.c                         |    5 +-
 drivers/block/zram/zcomp.c                         |   15 +-
 drivers/block/zram/zcomp.h                         |    2 +-
 drivers/block/zram/zram_drv.c                      |   31 +-
 drivers/cdrom/cdrom.c                              |    8 +-
 drivers/md/bcache/super.c                          |   22 +-
 drivers/md/dm-crypt.c                              |   49 +-
 drivers/md/dm-stripe.c                             |    1 +
 drivers/md/dm.c                                    |   54 +-
 drivers/md/md.c                                    |   73 +-
 drivers/md/md.h                                    |   26 +-
 drivers/md/raid0.c                                 |    1 +
 drivers/md/raid10.c                                |    4 +-
 drivers/md/raid5.c                                 |    2 +-
 drivers/nvme/host/apple.c                          |    4 +-
 drivers/nvme/host/constants.c                      |    4 +-
 drivers/nvme/host/core.c                           |    2 +-
 drivers/nvme/host/fc.c                             |   10 +-
 drivers/nvme/host/nvme.h                           |    2 +-
 drivers/nvme/host/pci.c                            |  640 +++--
 drivers/nvme/host/rdma.c                           |    2 +-
 drivers/nvme/host/tcp.c                            |   11 +-
 drivers/nvme/target/core.c                         |    2 -
 drivers/nvme/target/passthru.c                     |    4 +-
 drivers/nvme/target/pci-epf.c                      |   25 +-
 drivers/nvme/target/zns.c                          |    2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |   15 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |   10 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |    5 +-
 drivers/scsi/virtio_scsi.c                         |    1 +
 drivers/virtio/virtio_vdpa.c                       |    9 +-
 fs/fuse/virtio_fs.c                                |    6 +-
 fs/xfs/xfs_mount.c                                 |    5 -
 include/linux/blk-mq-dma.h                         |   63 +
 include/linux/blk-mq.h                             |    2 +
 include/linux/blk_types.h                          |    8 +-
 include/linux/blkdev.h                             |   64 +-
 include/linux/cdrom.h                              |    1 -
 include/linux/group_cpus.h                         |    2 +-
 include/linux/log2.h                               |   14 +
 include/linux/nvme.h                               |    2 +-
 include/linux/pktcdvd.h                            |  198 --
 include/trace/events/block.h                       |   91 +-
 include/uapi/linux/ublk_cmd.h                      |   10 +
 kernel/irq/affinity.c                              |   11 +-
 kernel/trace/blktrace.c                            |   25 +
 lib/group_cpus.c                                   |   16 +-
 tools/testing/selftests/ublk/fault_inject.c        |   15 +-
 tools/testing/selftests/ublk/file_backed.c         |   32 +-
 tools/testing/selftests/ublk/kublk.c               |  140 +-
 tools/testing/selftests/ublk/kublk.h               |  135 +-
 tools/testing/selftests/ublk/null.c                |   32 +-
 tools/testing/selftests/ublk/stripe.c              |   33 +-
 tools/testing/selftests/ublk/utils.h               |   70 +
 81 files changed, 1986 insertions(+), 4426 deletions(-)
 delete mode 100644 Documentation/ABI/testing/debugfs-pktcdvd
 delete mode 100644 Documentation/ABI/testing/sysfs-class-pktcdvd
 delete mode 100644 Documentation/cdrom/packet-writing.rst
 delete mode 100644 drivers/block/pktcdvd.c
 create mode 100644 include/linux/blk-mq-dma.h
 delete mode 100644 include/linux/pktcdvd.h
 create mode 100644 tools/testing/selftests/ublk/utils.h

-- 
Jens Axboe

