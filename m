Return-Path: <SRS0=N2dH=5O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFC2C43331
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 22:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DC820733
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 22:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a4b+gs7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgC2WxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Mar 2020 18:53:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35774 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgC2WxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Mar 2020 18:53:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id c12so3139414plz.2
        for <linux-block@vger.kernel.org>; Sun, 29 Mar 2020 15:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=UHuAdk7zRSoQ12SqtxsWeevmEJ48GLKub1KGcCyWdi0=;
        b=a4b+gs7xeIWjNovTqwxJe34IR2PvczeBqWnSyOOCwQpOfx5SQcJvPsnrEZ9E+TtEtb
         myDXPBtf3ds6aySeMm1IR7TgLIVxbxRdjIB3s7RkGTg68tTtd4L3UI39h3/HMpmDTnBg
         sr9YotmLSlE1e4mkUExxnt1ZfqgZohMqLSCcRdTKf2ncLP4Nq7BAjtQGLoKBZo/Phf9B
         C48a3Qv+3OKZCcbNcujdq7Ih/vvXBrpJ1sjxgKM4Lq6eeSrriji4H0z/Z8w9WV1zRYR6
         v6L5Zum5HjQiHDsVCmN99qrpCBbDKegdRPeTPLesqGYbNHdkrGY1N4Gvqmc+XBgLW0LF
         n9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=UHuAdk7zRSoQ12SqtxsWeevmEJ48GLKub1KGcCyWdi0=;
        b=qn+nb0LhJOR43mae2EbXzjOgUc3RJP9lXKEVoo1Yam5fmvp2WLevj4+v5tfLMR7mct
         C2aI3EYzrqoim2BfEHTufuLmyrB7bgcXHe3fr58i4BBSc0dHf75dXnsqpPFncOjM841R
         jRNpyiQWCv1MGRXuFkvLzhxqgV5K0xwXlEEoeBsfSfvJrA/E+K/kT7SyI9cAcjKNjkaf
         tQIQf4ScbiI9VCfrIw/iXZ9Nh6DaZ9JmDascnGpSWREbSeWL8aW2JYXgo1seG7WOmE2l
         MRtiPo4eeV4Eer3do211NNaHXnzvv6QXWf40Rwpm3wtLFI3VHDwBFYv/wvobjSr6WZdE
         EVuA==
X-Gm-Message-State: ANhLgQ387qPZ7CxMeQehgRWTZVjKBPP+AWm+xTQ5CoAwCHwXNyDQdMWQ
        DAYrNr30z5PhuRGNTsK898gU8+JF7UdqGA==
X-Google-Smtp-Source: ADFU+vsfaSHp7HYM+h5cStspXrGyROKSt4jH/az8HCoj1dIz3fJEni0KMBcPvmD/lqetvZyqWWXMOA==
X-Received: by 2002:a17:90a:254f:: with SMTP id j73mr12028825pje.11.1585522401967;
        Sun, 29 Mar 2020 15:53:21 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r7sm8735858pfg.38.2020.03.29.15.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 15:53:21 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 5.7-rc
Message-ID: <e1ff1845-0f31-e518-7ac0-e88f02901f0d@kernel.dk>
Date:   Sun, 29 Mar 2020 16:53:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7A8E98DF4F9FF06533BF066C"
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------7A8E98DF4F9FF06533BF066C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here are the core block changes for this merge window. This pull request
contains:

- Online capacity resizing (Balbir)

- Number of hardware queue change fixes (Bart)

- null_blk fault injection addition (Bart)

- Cleanup of queue allocation, unifying the node/no-node API (Christoph)

- Cleanup of genhd, moving code to where it makes sense (Christoph)

- Cleanup of the partition handling code (Christoph)

- disk stat fixes/improvements (Konstantin)

- BFQ improvements (Paolo)

- Various fixes and improvements

Note that this will throw a merge conflict in <linux/genhd.h>, due to
this fix in 5.6:

commit b53df2e7442c73a932fb74228147fb946e531585 (tag: block-5.6-2020-03-13)
Author: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Date:   Fri Feb 21 10:37:08 2020 +0900

    block: Fix partition support for host aware zoned block devices

The fixup is trivial, delete everything in the merge conflict, except
disk_has_partitions(). I'm attaching my resolution, for reference.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.7/block-2020-03-29


----------------------------------------------------------------
Alexey Dobriyan (1):
      block, zoned: fix integer overflow with BLKRESETZONE et al

Balbir Singh (5):
      block/genhd: Notify udev about capacity change
      virtio_blk.c: Convert to use set_capacity_revalidate_and_notify
      xen-blkfront.c: Convert to use set_capacity_revalidate_and_notify
      nvme: Convert to use set_capacity_revalidate_and_notify
      scsi: Convert to use set_capacity_revalidate_and_notify

Bart Van Assche (8):
      blk-mq: Fix a comment in include/linux/blk-mq.h
      blk-mq: Keep set->nr_hw_queues and set->map[].nr_queues in sync
      blk-mq: Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()
      null_blk: Suppress an UBSAN complaint triggered when setting 'memory_backed'
      null_blk: Fix changing the number of hardware queues
      null_blk: Fix the null_add_dev() error path
      null_blk: Handle null_add_dev() failures properly
      null_blk: Add support for init_hctx() fault injection

Chaitanya Kulkarni (1):
      block: return NULL in blk_alloc_queue() on error

Christoph Hellwig (37):
      block: fix a device invalidation regression
      block: remove the blk_lookup_devt export
      block: remove __bdevname
      block: move disk_name and related helpers out of partition-generic.c
      block: move sysfs methods shared by disks and partitions to genhd.c
      block: remove alloc_part_info and free_part_info
      scsi: simplify scsi_bios_ptable
      scsi: move scsicam_bios_param to the end of scsicam.c
      scsi: simplify scsi_partsize
      block: unexport read_dev_sector and put_dev_sector
      block: cleanup how md_autodetect_dev is called
      block: remove warn_no_part
      block: declare all partition detection routines in check.h
      block: remove block/partitions/karma.h
      block: remove block/partitions/osf.h
      block: remove block/partitions/sgi.h
      block: remove block/partitions/sun.h
      block: move struct partition out of genhd.h
      block: move the *_PARTITION enum out of genhd.h
      partitions/msdos: remove LINUX_SWAP_PARTITION
      block: move the various x86 Unix label formats out of genhd.h
      block: merge partition-generic.c and check.c
      block: mark block_depr static
      block: mark part_in_flight and part_in_flight_rw static
      block: unexport disk_get_part
      block: unexport disk_map_sector_rcu
      block: unexport get_gendisk
      block: move guard_bio_eod to bio.c
      block: move block layer internals out of include/linux/genhd.h
      block: move the part_stat* helpers from genhd.h to a new header
      block: move the ->devnode callback to struct block_device_operations
      block: add a blk_mq_init_queue_data helper
      null_blk: use blk_mq_init_queue_data
      bcache: pass the make_request methods to blk_queue_make_request
      block: simplify queue allocation
      Revert "blkdev: check for valid request queue before issuing flush"
      block: move bio_map_* to blk-map.c

Guoqing Jiang (6):
      block: fix comment for blk_cloned_rq_check_limits
      block: use bio_{wouldblock,io}_error in direct_make_request
      block: remove redundant setting of QUEUE_FLAG_DYING
      block: cleanup for _blk/blk_rq_prep_clone
      block: remove unneeded argument from blk_alloc_flush_queue
      block: cleanup comment for blk_flush_complete_seq

Johannes Thumshirn (1):
      block: factor out requeue handling from dispatch code

Konstantin Khlebnikov (3):
      block/diskstats: more accurate approximation of io_ticks for slow disks
      block/diskstats: accumulate all per-cpu counters in one pass
      block/diskstats: replace time_in_queue with sum of request times

Ming Lei (1):
      block: Prevent hung_check firing during long sync IO

Paolo Valente (4):
      block, bfq: move forward the getting of an extra ref in bfq_bfqq_move
      block, bfq: turn put_queue into release_process_ref in __bfq_bic_change_cgroup
      block, bfq: make reparent_leaf_entity actually work only on leaf entities
      block, bfq: invoke flush_idle_tree after reparent_active_queues in pd_offline

Revanth Rajashekar (1):
      block: sed-opal: Change the check condition for regular session validity

Sahitya Tummala (1):
      block: Fix use-after-free issue accessing struct io_cq

Stephen Kitt (1):
      block: Document genhd capability flags

Weiping Zhang (1):
      blk-iocost: remove duplicated lines in comments

Zhiqiang Liu (1):
      block, bfq: fix use-after-free in bfq_idle_slice_timer_body

 Documentation/admin-guide/iostats.rst            |   5 +-
 Documentation/block/capability.rst               |  16 +-
 Documentation/scsi/scsi_mid_low_api.txt          |  21 -
 arch/m68k/emu/nfblock.c                          |   3 +-
 arch/xtensa/platforms/iss/simdisk.c              |   3 +-
 block/Makefile                                   |   3 +-
 block/bfq-cgroup.c                               |  87 ++--
 block/bfq-iosched.c                              |  18 +-
 block/bfq-iosched.h                              |   1 +
 block/bio.c                                      | 580 +++--------------------
 block/blk-cgroup.c                               |   2 +-
 block/blk-core.c                                 |  82 ++--
 block/blk-flush.c                                |  16 +-
 block/blk-ioc.c                                  |   7 +
 block/blk-iocost.c                               |   3 -
 block/blk-map.c                                  | 508 ++++++++++++++++++++
 block/blk-mq.c                                   |  59 ++-
 block/blk-settings.c                             |  36 --
 block/blk-zoned.c                                |   2 +-
 block/blk.h                                      | 138 +++++-
 block/genhd.c                                    | 219 +++++++--
 block/ioctl.c                                    |   1 +
 block/opal_proto.h                               |   1 +
 block/partitions/Makefile                        |   3 +-
 block/partitions/acorn.c                         |   1 -
 block/partitions/acorn.h                         |  15 -
 block/partitions/aix.c                           |   1 -
 block/partitions/aix.h                           |   2 -
 block/partitions/amiga.c                         |  11 +-
 block/partitions/amiga.h                         |   7 -
 block/partitions/atari.h                         |   1 -
 block/partitions/check.c                         | 198 --------
 block/partitions/check.h                         |  41 +-
 block/partitions/cmdline.c                       |   1 -
 block/partitions/cmdline.h                       |   3 -
 block/{partition-generic.c => partitions/core.c} | 319 +++++++------
 block/partitions/efi.h                           |   3 -
 block/partitions/ibm.c                           |   1 -
 block/partitions/ibm.h                           |   2 -
 block/partitions/karma.c                         |   3 +-
 block/partitions/karma.h                         |   9 -
 block/partitions/ldm.c                           |   6 +-
 block/partitions/ldm.h                           |   2 -
 block/partitions/mac.h                           |   1 -
 block/partitions/msdos.c                         | 172 ++++++-
 block/partitions/msdos.h                         |   9 -
 block/partitions/osf.c                           |   2 +-
 block/partitions/osf.h                           |   8 -
 block/partitions/sgi.c                           |   7 +-
 block/partitions/sgi.h                           |   9 -
 block/partitions/sun.c                           |   9 +-
 block/partitions/sun.h                           |   9 -
 block/partitions/sysv68.c                        |   1 -
 block/partitions/sysv68.h                        |   2 -
 block/partitions/ultrix.c                        |   1 -
 block/partitions/ultrix.h                        |   6 -
 block/sed-opal.c                                 |   2 +-
 drivers/block/brd.c                              |   4 +-
 drivers/block/drbd/drbd_main.c                   |   3 +-
 drivers/block/drbd/drbd_receiver.c               |   1 +
 drivers/block/drbd/drbd_worker.c                 |   1 +
 drivers/block/null_blk_main.c                    | 106 +++--
 drivers/block/pktcdvd.c                          |  15 +-
 drivers/block/ps3vram.c                          |   3 +-
 drivers/block/rsxx/dev.c                         |   3 +-
 drivers/block/umem.c                             |   4 +-
 drivers/block/virtio_blk.c                       |   5 +-
 drivers/block/xen-blkfront.c                     |   6 +-
 drivers/block/zram/zram_drv.c                    |   5 +-
 drivers/lightnvm/core.c                          |   3 +-
 drivers/md/bcache/request.c                      |   7 +-
 drivers/md/bcache/request.h                      |   3 +
 drivers/md/bcache/super.c                        |  11 +-
 drivers/md/dm.c                                  |  10 +-
 drivers/md/md.c                                  |   9 +-
 drivers/nvdimm/blk.c                             |   3 +-
 drivers/nvdimm/btt.c                             |   3 +-
 drivers/nvdimm/pmem.c                            |   3 +-
 drivers/nvme/host/core.c                         |   2 +-
 drivers/nvme/host/multipath.c                    |   3 +-
 drivers/nvme/target/admin-cmd.c                  |   1 +
 drivers/s390/block/dcssblk.c                     |   4 +-
 drivers/s390/block/xpram.c                       |   4 +-
 drivers/scsi/BusLogic.c                          |   8 +-
 drivers/scsi/aacraid/linit.c                     |   7 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c               |  13 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.c               |  13 +-
 drivers/scsi/arcmsr/arcmsr_hba.c                 |  13 +-
 drivers/scsi/megaraid.c                          |  13 +-
 drivers/scsi/scsi_debug.c                        |   5 +-
 drivers/scsi/scsicam.c                           | 186 ++++----
 drivers/scsi/sd.c                                |   3 +-
 fs/block_dev.c                                   |  20 +-
 fs/buffer.c                                      |  43 --
 fs/ext4/super.c                                  |   8 +-
 fs/ext4/sysfs.c                                  |   1 +
 fs/f2fs/f2fs.h                                   |   1 +
 fs/f2fs/super.c                                  |   1 +
 fs/internal.h                                    |   1 -
 fs/reiserfs/journal.c                            |   5 +-
 include/linux/bio.h                              |  15 +-
 include/linux/blk-mq.h                           |   7 +-
 include/linux/blkdev.h                           |  14 +-
 include/linux/fs.h                               |   1 -
 include/linux/genhd.h                            | 521 +++-----------------
 include/linux/iocontext.h                        |   1 +
 include/linux/msdos_partition.h                  |  50 ++
 include/linux/part_stat.h                        | 115 +++++
 include/linux/raid/detect.h                      |   3 +
 include/scsi/scsicam.h                           |   7 +-
 init/do_mounts.c                                 |  12 +-
 111 files changed, 1949 insertions(+), 2038 deletions(-)
 delete mode 100644 block/partitions/acorn.h
 delete mode 100644 block/partitions/aix.h
 delete mode 100644 block/partitions/amiga.h
 delete mode 100644 block/partitions/check.c
 delete mode 100644 block/partitions/cmdline.h
 rename block/{partition-generic.c => partitions/core.c} (72%)
 delete mode 100644 block/partitions/ibm.h
 delete mode 100644 block/partitions/karma.h
 delete mode 100644 block/partitions/msdos.h
 delete mode 100644 block/partitions/osf.h
 delete mode 100644 block/partitions/sgi.h
 delete mode 100644 block/partitions/sun.h
 delete mode 100644 block/partitions/sysv68.h
 delete mode 100644 block/partitions/ultrix.h
 create mode 100644 include/linux/msdos_partition.h
 create mode 100644 include/linux/part_stat.h
 create mode 100644 include/linux/raid/detect.h

-- 
Jens Axboe


--------------7A8E98DF4F9FF06533BF066C
Content-Type: text/plain; charset=UTF-8;
 name="merge.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="merge.txt"

Y29tbWl0IDMxNzc5Y2VkZGFjN2QwNGNjMmJiNTRhYWExM2YwMGYyMDQ1MTQ2OTcKTWVyZ2U6
IDU3MDIwM2VjODMwZCA2NTRhMzY2N2RmMzYKQXV0aG9yOiBKZW5zIEF4Ym9lIDxheGJvZUBr
ZXJuZWwuZGs+CkRhdGU6ICAgU3VuIE1hciAyOSAxNjo1MToxNSAyMDIwIC0wNjAwCgogICAg
TWVyZ2UgYnJhbmNoICdmb3ItNS43L2Jsb2NrJyBpbnRvIHRlc3QKICAgIAogICAgKiBmb3It
NS43L2Jsb2NrOiAoNzIgY29tbWl0cykKICAgICAgYmxvY2s6IHJldHVybiBOVUxMIGluIGJs
a19hbGxvY19xdWV1ZSgpIG9uIGVycm9yCiAgICAgIGJsb2NrOiBtb3ZlIGJpb19tYXBfKiB0
byBibGstbWFwLmMKICAgICAgUmV2ZXJ0ICJibGtkZXY6IGNoZWNrIGZvciB2YWxpZCByZXF1
ZXN0IHF1ZXVlIGJlZm9yZSBpc3N1aW5nIGZsdXNoIgogICAgICBibG9jazogc2ltcGxpZnkg
cXVldWUgYWxsb2NhdGlvbgogICAgICBiY2FjaGU6IHBhc3MgdGhlIG1ha2VfcmVxdWVzdCBt
ZXRob2RzIHRvIGJsa19xdWV1ZV9tYWtlX3JlcXVlc3QKICAgICAgbnVsbF9ibGs6IHVzZSBi
bGtfbXFfaW5pdF9xdWV1ZV9kYXRhCiAgICAgIGJsb2NrOiBhZGQgYSBibGtfbXFfaW5pdF9x
dWV1ZV9kYXRhIGhlbHBlcgogICAgICBibG9jazogbW92ZSB0aGUgLT5kZXZub2RlIGNhbGxi
YWNrIHRvIHN0cnVjdCBibG9ja19kZXZpY2Vfb3BlcmF0aW9ucwogICAgICBibG9jazogbW92
ZSB0aGUgcGFydF9zdGF0KiBoZWxwZXJzIGZyb20gZ2VuaGQuaCB0byBhIG5ldyBoZWFkZXIK
ICAgICAgYmxvY2s6IG1vdmUgYmxvY2sgbGF5ZXIgaW50ZXJuYWxzIG91dCBvZiBpbmNsdWRl
L2xpbnV4L2dlbmhkLmgKICAgICAgYmxvY2s6IG1vdmUgZ3VhcmRfYmlvX2VvZCB0byBiaW8u
YwogICAgICBibG9jazogdW5leHBvcnQgZ2V0X2dlbmRpc2sKICAgICAgYmxvY2s6IHVuZXhw
b3J0IGRpc2tfbWFwX3NlY3Rvcl9yY3UKICAgICAgYmxvY2s6IHVuZXhwb3J0IGRpc2tfZ2V0
X3BhcnQKICAgICAgYmxvY2s6IG1hcmsgcGFydF9pbl9mbGlnaHQgYW5kIHBhcnRfaW5fZmxp
Z2h0X3J3IHN0YXRpYwogICAgICBibG9jazogbWFyayBibG9ja19kZXByIHN0YXRpYwogICAg
ICBibG9jazogZmFjdG9yIG91dCByZXF1ZXVlIGhhbmRsaW5nIGZyb20gZGlzcGF0Y2ggY29k
ZQogICAgICBibG9jay9kaXNrc3RhdHM6IHJlcGxhY2UgdGltZV9pbl9xdWV1ZSB3aXRoIHN1
bSBvZiByZXF1ZXN0IHRpbWVzCiAgICAgIGJsb2NrL2Rpc2tzdGF0czogYWNjdW11bGF0ZSBh
bGwgcGVyLWNwdSBjb3VudGVycyBpbiBvbmUgcGFzcwogICAgICBibG9jay9kaXNrc3RhdHM6
IG1vcmUgYWNjdXJhdGUgYXBwcm94aW1hdGlvbiBvZiBpb190aWNrcyBmb3Igc2xvdyBkaXNr
cwogICAgICAuLi4KICAgIAogICAgU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VA
a2VybmVsLmRrPgoKZGlmZiAtLWNjIGJsb2NrL2dlbmhkLmMKaW5kZXggOWMyZTEzY2UwZDE5
LDE0Y2YzOTVhMTQ3OS4uMDZiNjQyYjIzYTA3Ci0tLSBhL2Jsb2NrL2dlbmhkLmMKKysrIGIv
YmxvY2svZ2VuaGQuYwpAQEAgLTI5OSw0NCAtMzcyLDcgKzM3Miw0MyBAQEAgc3RydWN0IGhk
X3N0cnVjdCAqZGlza19tYXBfc2VjdG9yX3JjdShzCiAgCX0KICAJcmV0dXJuICZkaXNrLT5w
YXJ0MDsKICB9Ci0gRVhQT1JUX1NZTUJPTF9HUEwoZGlza19tYXBfc2VjdG9yX3JjdSk7CiAg
CiArLyoqCiArICogZGlza19oYXNfcGFydGl0aW9ucwogKyAqIEBkaXNrOiBnZW5kaXNrIG9m
IGludGVyZXN0CiArICoKICsgKiBXYWxrIHRocm91Z2ggdGhlIHBhcnRpdGlvbiB0YWJsZSBh
bmQgY2hlY2sgaWYgdmFsaWQgcGFydGl0aW9uIGV4aXN0cy4KICsgKgogKyAqIENPTlRFWFQ6
CiArICogRG9uJ3QgY2FyZS4KICsgKgogKyAqIFJFVFVSTlM6CiArICogVHJ1ZSBpZiB0aGUg
Z2VuZGlzayBoYXMgYXQgbGVhc3Qgb25lIHZhbGlkIG5vbi16ZXJvIHNpemUgcGFydGl0aW9u
LgogKyAqIE90aGVyd2lzZSBmYWxzZS4KICsgKi8KICtib29sIGRpc2tfaGFzX3BhcnRpdGlv
bnMoc3RydWN0IGdlbmRpc2sgKmRpc2spCiArewogKwlzdHJ1Y3QgZGlza19wYXJ0X3RibCAq
cHRibDsKICsJaW50IGk7CiArCWJvb2wgcmV0ID0gZmFsc2U7CiArCiArCXJjdV9yZWFkX2xv
Y2soKTsKICsJcHRibCA9IHJjdV9kZXJlZmVyZW5jZShkaXNrLT5wYXJ0X3RibCk7CiArCiAr
CS8qIEl0ZXJhdGUgcGFydGl0aW9ucyBza2lwcGluZyB0aGUgd2hvbGUgZGV2aWNlIGF0IGlu
ZGV4IDAgKi8KICsJZm9yIChpID0gMTsgaSA8IHB0YmwtPmxlbjsgaSsrKSB7CiArCQlpZiAo
cmN1X2RlcmVmZXJlbmNlKHB0YmwtPnBhcnRbaV0pKSB7CiArCQkJcmV0ID0gdHJ1ZTsKICsJ
CQlicmVhazsKICsJCX0KICsJfQogKwogKwlyY3VfcmVhZF91bmxvY2soKTsKICsKICsJcmV0
dXJuIHJldDsKICt9CiArRVhQT1JUX1NZTUJPTF9HUEwoZGlza19oYXNfcGFydGl0aW9ucyk7
CiArCiAgLyoKICAgKiBDYW4gYmUgZGVsZXRlZCBhbHRvZ2V0aGVyLiBMYXRlci4KICAgKgpk
aWZmIC0tY2MgaW5jbHVkZS9saW51eC9nZW5oZC5oCmluZGV4IDA3ZGM5MTgzNWI5OCw4NWI5
ZTI1M2NkMzkuLjM5ZmM5ZmU3MDlmYwotLS0gYS9pbmNsdWRlL2xpbnV4L2dlbmhkLmgKKysr
IGIvaW5jbHVkZS9saW51eC9nZW5oZC5oCkBAQCAtMjg0LDE0NCAtMjk3LDYgKzI4NSw4IEBA
QCBleHRlcm4gdm9pZCBkaXNrX3BhcnRfaXRlcl9pbml0KHN0cnVjdCAKICBleHRlcm4gc3Ry
dWN0IGhkX3N0cnVjdCAqZGlza19wYXJ0X2l0ZXJfbmV4dChzdHJ1Y3QgZGlza19wYXJ0X2l0
ZXIgKnBpdGVyKTsKICBleHRlcm4gdm9pZCBkaXNrX3BhcnRfaXRlcl9leGl0KHN0cnVjdCBk
aXNrX3BhcnRfaXRlciAqcGl0ZXIpOwogIAotIGV4dGVybiBzdHJ1Y3QgaGRfc3RydWN0ICpk
aXNrX21hcF9zZWN0b3JfcmN1KHN0cnVjdCBnZW5kaXNrICpkaXNrLAotIAkJCQkJICAgICBz
ZWN0b3JfdCBzZWN0b3IpOwogK2Jvb2wgZGlza19oYXNfcGFydGl0aW9ucyhzdHJ1Y3QgZ2Vu
ZGlzayAqZGlzayk7CiArCi0gLyoKLSAgKiBNYWNyb3MgdG8gb3BlcmF0ZSBvbiBwZXJjcHUg
ZGlzayBzdGF0aXN0aWNzOgotICAqCi0gICoge2Rpc2t8cGFydHxhbGx9X3N0YXRfe2FkZHxz
dWJ8aW5jfGRlY30oKSBtb2RpZnkgdGhlIHN0YXQgY291bnRlcnMKLSAgKiBhbmQgc2hvdWxk
IGJlIGNhbGxlZCBiZXR3ZWVuIGRpc2tfc3RhdF9sb2NrKCkgYW5kCi0gICogZGlza19zdGF0
X3VubG9jaygpLgotICAqCi0gICogcGFydF9zdGF0X3JlYWQoKSBjYW4gYmUgY2FsbGVkIGF0
IGFueSB0aW1lLgotICAqCi0gICogcGFydF9zdGF0X3thZGR8c2V0X2FsbH0oKSBhbmQge2lu
aXR8ZnJlZX1fcGFydF9zdGF0cyBhcmUgZm9yCi0gICogaW50ZXJuYWwgdXNlIG9ubHkuCi0g
ICovCi0gI2lmZGVmCUNPTkZJR19TTVAKLSAjZGVmaW5lIHBhcnRfc3RhdF9sb2NrKCkJKHsg
cmN1X3JlYWRfbG9jaygpOyBnZXRfY3B1KCk7IH0pCi0gI2RlZmluZSBwYXJ0X3N0YXRfdW5s
b2NrKCkJZG8geyBwdXRfY3B1KCk7IHJjdV9yZWFkX3VubG9jaygpOyB9IHdoaWxlICgwKQot
IAotICNkZWZpbmUgcGFydF9zdGF0X2dldF9jcHUocGFydCwgZmllbGQsIGNwdSkJCQkJCVwK
LSAJKHBlcl9jcHVfcHRyKChwYXJ0KS0+ZGtzdGF0cywgKGNwdSkpLT5maWVsZCkKLSAKLSAj
ZGVmaW5lIHBhcnRfc3RhdF9nZXQocGFydCwgZmllbGQpCQkJCQlcCi0gCXBhcnRfc3RhdF9n
ZXRfY3B1KHBhcnQsIGZpZWxkLCBzbXBfcHJvY2Vzc29yX2lkKCkpCi0gCi0gI2RlZmluZSBw
YXJ0X3N0YXRfcmVhZChwYXJ0LCBmaWVsZCkJCQkJCVwKLSAoewkJCQkJCQkJCVwKLSAJdHlw
ZW9mKChwYXJ0KS0+ZGtzdGF0cy0+ZmllbGQpIHJlcyA9IDA7CQkJCVwKLSAJdW5zaWduZWQg
aW50IF9jcHU7CQkJCQkJXAotIAlmb3JfZWFjaF9wb3NzaWJsZV9jcHUoX2NwdSkJCQkJCVwK
LSAJCXJlcyArPSBwZXJfY3B1X3B0cigocGFydCktPmRrc3RhdHMsIF9jcHUpLT5maWVsZDsJ
XAotIAlyZXM7CQkJCQkJCQlcCi0gfSkKLSAKLSBzdGF0aWMgaW5saW5lIHZvaWQgcGFydF9z
dGF0X3NldF9hbGwoc3RydWN0IGhkX3N0cnVjdCAqcGFydCwgaW50IHZhbHVlKQotIHsKLSAJ
aW50IGk7Ci0gCi0gCWZvcl9lYWNoX3Bvc3NpYmxlX2NwdShpKQotIAkJbWVtc2V0KHBlcl9j
cHVfcHRyKHBhcnQtPmRrc3RhdHMsIGkpLCB2YWx1ZSwKLSAJCQkJc2l6ZW9mKHN0cnVjdCBk
aXNrX3N0YXRzKSk7Ci0gfQotIAotIHN0YXRpYyBpbmxpbmUgaW50IGluaXRfcGFydF9zdGF0
cyhzdHJ1Y3QgaGRfc3RydWN0ICpwYXJ0KQotIHsKLSAJcGFydC0+ZGtzdGF0cyA9IGFsbG9j
X3BlcmNwdShzdHJ1Y3QgZGlza19zdGF0cyk7Ci0gCWlmICghcGFydC0+ZGtzdGF0cykKLSAJ
CXJldHVybiAwOwotIAlyZXR1cm4gMTsKLSB9Ci0gCi0gc3RhdGljIGlubGluZSB2b2lkIGZy
ZWVfcGFydF9zdGF0cyhzdHJ1Y3QgaGRfc3RydWN0ICpwYXJ0KQotIHsKLSAJZnJlZV9wZXJj
cHUocGFydC0+ZGtzdGF0cyk7Ci0gfQotIAotICNlbHNlIC8qICFDT05GSUdfU01QICovCi0g
I2RlZmluZSBwYXJ0X3N0YXRfbG9jaygpCSh7IHJjdV9yZWFkX2xvY2soKTsgMDsgfSkKLSAj
ZGVmaW5lIHBhcnRfc3RhdF91bmxvY2soKQlyY3VfcmVhZF91bmxvY2soKQotIAotICNkZWZp
bmUgcGFydF9zdGF0X2dldChwYXJ0LCBmaWVsZCkJCSgocGFydCktPmRrc3RhdHMuZmllbGQp
Ci0gI2RlZmluZSBwYXJ0X3N0YXRfZ2V0X2NwdShwYXJ0LCBmaWVsZCwgY3B1KQlwYXJ0X3N0
YXRfZ2V0KHBhcnQsIGZpZWxkKQotICNkZWZpbmUgcGFydF9zdGF0X3JlYWQocGFydCwgZmll
bGQpCQlwYXJ0X3N0YXRfZ2V0KHBhcnQsIGZpZWxkKQotIAotIHN0YXRpYyBpbmxpbmUgdm9p
ZCBwYXJ0X3N0YXRfc2V0X2FsbChzdHJ1Y3QgaGRfc3RydWN0ICpwYXJ0LCBpbnQgdmFsdWUp
Ci0gewotIAltZW1zZXQoJnBhcnQtPmRrc3RhdHMsIHZhbHVlLCBzaXplb2Yoc3RydWN0IGRp
c2tfc3RhdHMpKTsKLSB9Ci0gCi0gc3RhdGljIGlubGluZSBpbnQgaW5pdF9wYXJ0X3N0YXRz
KHN0cnVjdCBoZF9zdHJ1Y3QgKnBhcnQpCi0gewotIAlyZXR1cm4gMTsKLSB9Ci0gCi0gc3Rh
dGljIGlubGluZSB2b2lkIGZyZWVfcGFydF9zdGF0cyhzdHJ1Y3QgaGRfc3RydWN0ICpwYXJ0
KQotIHsKLSB9Ci0gCi0gI2VuZGlmIC8qIENPTkZJR19TTVAgKi8KLSAKLSAjZGVmaW5lIHBh
cnRfc3RhdF9yZWFkX21zZWNzKHBhcnQsIHdoaWNoKQkJCQlcCi0gCWRpdl91NjQocGFydF9z
dGF0X3JlYWQocGFydCwgbnNlY3Nbd2hpY2hdKSwgTlNFQ19QRVJfTVNFQykKLSAKLSAjZGVm
aW5lIHBhcnRfc3RhdF9yZWFkX2FjY3VtKHBhcnQsIGZpZWxkKQkJCQlcCi0gCShwYXJ0X3N0
YXRfcmVhZChwYXJ0LCBmaWVsZFtTVEFUX1JFQURdKSArCQkJXAotIAkgcGFydF9zdGF0X3Jl
YWQocGFydCwgZmllbGRbU1RBVF9XUklURV0pICsJCQlcCi0gCSBwYXJ0X3N0YXRfcmVhZChw
YXJ0LCBmaWVsZFtTVEFUX0RJU0NBUkRdKSkKLSAKLSAjZGVmaW5lIF9fcGFydF9zdGF0X2Fk
ZChwYXJ0LCBmaWVsZCwgYWRkbmQpCQkJCVwKLSAJKHBhcnRfc3RhdF9nZXQocGFydCwgZmll
bGQpICs9IChhZGRuZCkpCi0gCi0gI2RlZmluZSBwYXJ0X3N0YXRfYWRkKHBhcnQsIGZpZWxk
LCBhZGRuZCkJZG8gewkJCVwKLSAJX19wYXJ0X3N0YXRfYWRkKChwYXJ0KSwgZmllbGQsIGFk
ZG5kKTsJCQkJXAotIAlpZiAoKHBhcnQpLT5wYXJ0bm8pCQkJCQkJXAotIAkJX19wYXJ0X3N0
YXRfYWRkKCZwYXJ0X3RvX2Rpc2soKHBhcnQpKS0+cGFydDAsCQlcCi0gCQkJCWZpZWxkLCBh
ZGRuZCk7CQkJCVwKLSB9IHdoaWxlICgwKQotIAotICNkZWZpbmUgcGFydF9zdGF0X2RlYyhn
ZW5kaXNrcCwgZmllbGQpCQkJCQlcCi0gCXBhcnRfc3RhdF9hZGQoZ2VuZGlza3AsIGZpZWxk
LCAtMSkKLSAjZGVmaW5lIHBhcnRfc3RhdF9pbmMoZ2VuZGlza3AsIGZpZWxkKQkJCQkJXAot
IAlwYXJ0X3N0YXRfYWRkKGdlbmRpc2twLCBmaWVsZCwgMSkKLSAjZGVmaW5lIHBhcnRfc3Rh
dF9zdWIoZ2VuZGlza3AsIGZpZWxkLCBzdWJuZCkJCQkJXAotIAlwYXJ0X3N0YXRfYWRkKGdl
bmRpc2twLCBmaWVsZCwgLXN1Ym5kKQotIAotICNkZWZpbmUgcGFydF9zdGF0X2xvY2FsX2Rl
YyhnZW5kaXNrcCwgZmllbGQpCQkJCVwKLSAJbG9jYWxfZGVjKCYocGFydF9zdGF0X2dldChn
ZW5kaXNrcCwgZmllbGQpKSkKLSAjZGVmaW5lIHBhcnRfc3RhdF9sb2NhbF9pbmMoZ2VuZGlz
a3AsIGZpZWxkKQkJCQlcCi0gCWxvY2FsX2luYygmKHBhcnRfc3RhdF9nZXQoZ2VuZGlza3As
IGZpZWxkKSkpCi0gI2RlZmluZSBwYXJ0X3N0YXRfbG9jYWxfcmVhZChnZW5kaXNrcCwgZmll
bGQpCQkJCVwKLSAJbG9jYWxfcmVhZCgmKHBhcnRfc3RhdF9nZXQoZ2VuZGlza3AsIGZpZWxk
KSkpCi0gI2RlZmluZSBwYXJ0X3N0YXRfbG9jYWxfcmVhZF9jcHUoZ2VuZGlza3AsIGZpZWxk
LCBjcHUpCQkJXAotIAlsb2NhbF9yZWFkKCYocGFydF9zdGF0X2dldF9jcHUoZ2VuZGlza3As
IGZpZWxkLCBjcHUpKSkKLSAKLSB1bnNpZ25lZCBpbnQgcGFydF9pbl9mbGlnaHQoc3RydWN0
IHJlcXVlc3RfcXVldWUgKnEsIHN0cnVjdCBoZF9zdHJ1Y3QgKnBhcnQpOwotIHZvaWQgcGFy
dF9pbl9mbGlnaHRfcncoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsIHN0cnVjdCBoZF9zdHJ1
Y3QgKnBhcnQsCi0gCQkgICAgICAgdW5zaWduZWQgaW50IGluZmxpZ2h0WzJdKTsKLSB2b2lk
IHBhcnRfZGVjX2luX2ZsaWdodChzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgc3RydWN0IGhk
X3N0cnVjdCAqcGFydCwKLSAJCQlpbnQgcncpOwotIHZvaWQgcGFydF9pbmNfaW5fZmxpZ2h0
KHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLCBzdHJ1Y3QgaGRfc3RydWN0ICpwYXJ0LAotIAkJ
CWludCBydyk7Ci0gCi0gc3RhdGljIGlubGluZSBzdHJ1Y3QgcGFydGl0aW9uX21ldGFfaW5m
byAqYWxsb2NfcGFydF9pbmZvKHN0cnVjdCBnZW5kaXNrICpkaXNrKQotIHsKLSAJaWYgKGRp
c2spCi0gCQlyZXR1cm4ga3phbGxvY19ub2RlKHNpemVvZihzdHJ1Y3QgcGFydGl0aW9uX21l
dGFfaW5mbyksCi0gCQkJCSAgICBHRlBfS0VSTkVMLCBkaXNrLT5ub2RlX2lkKTsKLSAJcmV0
dXJuIGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBwYXJ0aXRpb25fbWV0YV9pbmZvKSwgR0ZQX0tF
Uk5FTCk7Ci0gfQotIAotIHN0YXRpYyBpbmxpbmUgdm9pZCBmcmVlX3BhcnRfaW5mbyhzdHJ1
Y3QgaGRfc3RydWN0ICpwYXJ0KQotIHsKLSAJa2ZyZWUocGFydC0+aW5mbyk7Ci0gfQotIAot
IHZvaWQgdXBkYXRlX2lvX3RpY2tzKHN0cnVjdCBoZF9zdHJ1Y3QgKnBhcnQsIHVuc2lnbmVk
IGxvbmcgbm93KTsKLSAKICAvKiBibG9jay9nZW5oZC5jICovCiAgZXh0ZXJuIHZvaWQgZGV2
aWNlX2FkZF9kaXNrKHN0cnVjdCBkZXZpY2UgKnBhcmVudCwgc3RydWN0IGdlbmRpc2sgKmRp
c2ssCiAgCQkJICAgIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKipncm91cHMpOwo=
--------------7A8E98DF4F9FF06533BF066C--
