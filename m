Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5423DC77B76
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 20:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDUUAs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 16:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjDUUAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 16:00:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299D32D5A
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 13:00:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b781c9787so701132b3a.1
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682107229; x=1684699229;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9XTTJyKgDEv5MV5CbbH1NQCA9UWaBH2JOUr97MMSio=;
        b=Q6Lk6/JTA2m05/TnUI6AXCM8l/yZBM8gZv69cwCudBSzMMSpz8oiPP4W5oixpB3Akn
         X/Wg8Osjnrwts3+AEX6zELLfxj3gvAYQPw/2fuxV5lQsZNOc9jC8Bf8D9YTBxFhY05OW
         H/R2OQD12Sa9Ha9S+H0p6Wm42nUGIHMU1FaTSG1aTCYAYdapS+Ukf0iZ/+dw471X5jvf
         ln0Jq613/1eto3Lnsrm4qxTVX8W0xDPDvWJvfaKLIWUltSF9f4NFzcm6N4XcdyA4Zfad
         ySYOI1wDP06pJ3SEOxbW3G0KAtugmWeKgWblDqRePRpPrtu1vs1hZN9zN0rkEsQxMuYT
         Su3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682107229; x=1684699229;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+9XTTJyKgDEv5MV5CbbH1NQCA9UWaBH2JOUr97MMSio=;
        b=haTyQT5JOOD4Qzo02VCwegiashAT+fm3aU/ao7281iML+7vNHIYhNX+vSiwLeAgHOJ
         Ep0vTO/NupiD9jSWCr4IkKEtZ4CG1AVfiHuOf4UIaliG812bgjYRq9bC7tgUiJoicMV+
         +8lPnPOGz4vn6GNW8tZrtoP07OpRsNNZqITFjtQl3T1V6H94yWJyGBkXIhRSAHZQEB/w
         DB6dbuTLUExo6o7R/dfD/k/klT1XpIlnPxJazyOs2XCSLC5GMBbZi45N/PYhKrHx5Kxh
         BZ4Gg6N9jT4eDtY84UhBI52JcR7TpWJ54RWL+mcs5QCMvj6Jwdoa/1u274XJeTob3Fc2
         v+WQ==
X-Gm-Message-State: AAQBX9dHUhqXKva8NMpz7x0Xz91NcdGrt9eyPbN3W6HChDtQ5MIYbAPn
        sUTLl/9CPcX5MSXJ9ixbwJ/4/01XNwjT2m0bZTE=
X-Google-Smtp-Source: AKy350bAmQ0kc0MM4ME7QUo1opJmpwZ+iFkcc/WOfzPV68tTyZRJ1Jun514nH7Y0R8YvsRXli8UzuQ==
X-Received: by 2002:a05:6a21:3384:b0:f0:251f:f099 with SMTP id yy4-20020a056a21338400b000f0251ff099mr8507511pzb.1.1682107229497;
        Fri, 21 Apr 2023 13:00:29 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x4-20020a628604000000b00639fc7124c2sm3399856pfd.148.2023.04.21.13.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 13:00:29 -0700 (PDT)
Message-ID: <360c9052-38c9-ae6d-2bdd-206482d75132@kernel.dk>
Date:   Fri, 21 Apr 2023 14:00:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 6.4-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the block updates for the 6.4 merge window. This pull request
contains:

- Set of drbd patches, bringing us closer to unifying the out-of-tree
  version and the in tree one (Andreas, Christoph)

- Support for auto-quiesce for the s390 dasd driver (Stefan)

- MD pull request via Song
	- md/bitmap: Optimal last page size (Jon Derrick)
	- Various raid10 fixes (Yu Kuai, Li Nan)
	- md: add error_handlers for raid0 and linear (Mariusz Tkaczyk)

- NVMe pull request via Christoph
	- Drop redundant pci_enable_pcie_error_reporting (Bjorn Helgaas)
	- Validate nvmet module parameters (Chaitanya Kulkarni)
	- Fence TCP socket on receive error (Chris Leech)
	- Fix async event trace event (Keith Busch)
	- Minor cleanups (Chaitanya Kulkarni, zhenwei pi)
	- Fix and cleanup nvmet Identify handling (Damien Le Moal,
	  Christoph Hellwig)
	- Fix double blk_mq_complete_request race in the timeout handler
	  (Lei Yin)
	- Fix irq locking in nvme-fcloop (Ming Lei)
	- Remove queue mapping helper for rdma devices (Sagi Grimberg)

- Use structured request attribute checks for nbd (Jakub)

- Fix blk-crypto race conditions between keyslot management (Eric)

- Add sed-opal support for reading read locking range attributes
  (Ondrej)

- Make fault injection configurable for null_blk (Akinobu)

- Series cleaning up the request insertion API (Christoph)

- Series cleaning up the queue running API (Christoph)

- blkg config helper cleanups (Tejun)

- Lazy init support for blk-iolatency (Tejun)

- Various fixes and tweaks to ublk (Ming)

- Remove hybrid polling. It hasn't really been useful since we got async
  polled IO support, and these days we don't support sync polled IO at
  all. (Keith)

- Misc fixes, cleanups, improvements (Zhong, Ondrej, Colin, Chengming,
  Chaitanya, me)

Please pull!


The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.4/block-2023-04-21

for you to fetch changes up to 55793ea54d77719a071b1ccc05a05056e3b5e009:

  nbd: fix incomplete validation of ioctl arg (2023-04-20 13:43:44 -0600)

----------------------------------------------------------------
for-6.4/block-2023-04-21

----------------------------------------------------------------
Akinobu Mita (3):
      fault-inject: allow configuration via configfs
      block: null_blk: make fault-injection dynamically configurable per device
      fault-inject: fix build error when FAULT_INJECTION_CONFIGFS=y and CONFIGFS_FS=m

Andreas Gruenbacher (3):
      drbd: Rip out the ERR_IF_CNT_IS_NEGATIVE macro
      drbd: Add peer device parameter to whole-bitmap I/O handlers
      drbd: INFO_bm_xfer_stats(): Pass a peer device argument

Bjorn Helgaas (1):
      nvme-pci: drop redundant pci_enable_pcie_error_reporting()

Chaitanya Kulkarni (9):
      block: open code __blk_account_io_start()
      block: open code __blk_account_io_done()
      null_blk: use non-deprecated lib functions
      null_blk: use kmap_local_page() and kunmap_local()
      nvmet-tcp: validate so_priority modparam value
      nvmet-tcp: validate idle poll modparam value
      nvme-apple: return directly instead of else
      nvme-apple: return directly instead of else
      null_blk: Always check queue mode setting from configfs

Chengming Zhou (5):
      block, bfq: remove BFQ_WEIGHT_LEGACY_DFL
      blk-cgroup: delete cpd_bind_fn of blkcg_policy
      blk-cgroup: delete cpd_init_fn of blkcg_policy
      blk-stat: fix QUEUE_FLAG_STATS clear
      blk-throttle: only enable blk-stat when BLK_DEV_THROTTLING_LOW

Chris Leech (1):
      nvme-tcp: fence TCP socket on receive error

Christoph Böhmwalder (4):
      genetlink: make _genl_cmd_to_str static
      drbd: drbd_uuid_compare: pass a peer_device
      drbd: pass drbd_peer_device to __req_mod
      drbd: Pass a peer device to the resync and online verify functions

Christoph Hellwig (29):
      nvmet: fix Identify Identification Descriptor List handling
      nvmet: rename nvmet_execute_identify_cns_cs_ns
      nvmet: remove nvmet_req_cns_error_complete
      blk-mq: don't plug for head insertions in blk_execute_rq_nowait
      blk-mq: remove blk-mq-tag.h
      blk-mq: include <linux/blk-mq.h> in block/blk-mq.h
      blk-mq: move more logic into blk_mq_insert_requests
      blk-mq: fold blk_mq_sched_insert_requests into blk_mq_dispatch_plug_list
      blk-mq: move blk_mq_sched_insert_request to blk-mq.c
      blk-mq: fold __blk_mq_insert_request into blk_mq_insert_request
      blk-mq: fold __blk_mq_insert_req_list into blk_mq_insert_request
      blk-mq: remove blk_flush_queue_rq
      blk-mq: refactor passthrough vs flush handling in blk_mq_insert_request
      blk-mq: refactor the DONTPREP/SOFTBARRIER andling in blk_mq_requeue_work
      blk-mq: factor out a blk_mq_get_budget_and_tag helper
      blk-mq: fold __blk_mq_try_issue_directly into its two callers
      blk-mq: don't run the hw_queue from blk_mq_insert_request
      blk-mq: don't run the hw_queue from blk_mq_request_bypass_insert
      blk-mq: don't kick the requeue_list in blk_mq_add_to_requeue_list
      blk-mq: pass a flags argument to blk_mq_insert_request
      blk-mq: pass a flags argument to blk_mq_request_bypass_insert
      blk-mq: pass a flags argument to elevator_type->insert_requests
      blk-mq: pass a flags argument to blk_mq_add_to_requeue_list
      blk-mq: cleanup __blk_mq_sched_dispatch_requests
      blk-mq: remove the blk_mq_hctx_stopped check in blk_mq_run_work_fn
      blk-mq: move the blk_mq_hctx_stopped check in __blk_mq_delay_run_hw_queue
      blk-mq: move the !async handling out of __blk_mq_delay_run_hw_queue
      blk-mq: remove __blk_mq_run_hw_queue
      blk-mq: fix the blk_mq_add_to_requeue_list call in blk_kick_flush

Colin Ian King (1):
      block, bfq: Fix division by zero error on zero wsum

Damien Le Moal (6):
      nvmet: fix error handling in nvmet_execute_identify_cns_cs_ns()
      nvmet: fix Identify Namespace handling
      nvmet: fix Identify Controller handling
      nvmet: fix Identify Active Namespace ID list handling
      nvmet: fix I/O Command Set specific Identify Controller
      nvmet: cleanup nvmet_execute_identify()

Eric Biggers (6):
      blk-mq: release crypto keyslot before reporting I/O complete
      blk-crypto: make blk_crypto_evict_key() return void
      blk-crypto: make blk_crypto_evict_key() more robust
      blk-crypto: remove blk_crypto_insert_cloned_request()
      blk-mq: return actual keyslot error in blk_insert_cloned_request()
      blk-crypto: drop the NULL check from blk_crypto_put_keyslot()

Jakub Kicinski (2):
      nbd: allow genl access outside init_net
      nbd: use the structured req attr check

Jens Axboe (4):
      Merge tag 'nvme-6.4-2023-04-14' of git://git.infradead.org/nvme into for-6.4/block
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.4/block
      block: re-arrange the struct block_device fields for better layout
      block: store bdev->bd_disk->fops->submit_bio state in bdev

Jiangshan Yi (1):
      md/raid10: Fix typo in comment (replacment -> replacement)

Jon Derrick (3):
      md: Move sb writer loop to its own function
      md: Fix types in sb writer
      md: Use optimal I/O size for last bitmap page

Keith Busch (2):
      blk-mq: remove hybrid polling
      nvme: fix async event trace event

Lei Yin (1):
      nvme: fix double blk_mq_complete_request for timeout request with low probability

Li Nan (2):
      md/raid10: fix task hung in raid10d
      md/raid10: fix null-ptr-deref in raid10_sync_request

Mariusz Tkaczyk (1):
      md: add error_handlers for raid0 and linear

Ming Lei (8):
      block: ublk_drv: add common exit handling
      block: ublk_drv: don't consider flush request in map/unmap io
      block: ublk_drv: add two helpers to clean up map/unmap request
      block: ublk_drv: clean up several helpers
      block: ublk_drv: cleanup 'struct ublk_map_data'
      nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage"
      block: ublk: switch to ioctl command encoding
      ublk: don't return 0 in case of any failure

Ondrej Kozina (6):
      sed-opal: do not add same authority twice in boolean ace.
      sed-opal: add helper for adding user authorities in ACE.
      sed-opal: allow user authority to get locking range attributes.
      sed-opal: add helper to get multiple columns at once.
      sed-opal: Add command to read locking range parameters.
      sed-opal: geometry feature reporting command

Sagi Grimberg (1):
      blk-mq-rdma: remove queue mapping helper for rdma devices

Stefan Haberland (7):
      s390/dasd: remove unused DASD EER defines
      s390/dasd: add autoquiesce feature
      s390/dasd: add aq_mask sysfs attribute
      s390/dasd: add aq_requeue sysfs attribute
      s390/dasd: add aq_timeouts autoquiesce trigger
      s390/dasd: add autoquiesce event for start IO error
      s390/dasd: fix hanging blockdevice after request requeue

Tejun Heo (4):
      blkcg: Drop unnecessary RCU read [un]locks from blkg_conf_prep/finish()
      blkcg: Restructure blkg_conf_prep() and friends
      blk-iolatency: s/blkcg_rq_qos/iolat_rq_qos/
      blk-iolatency: Make initialization lazy

Thomas Weißschuh (1):
      md: make kobj_type structures constant

Tom Rix (1):
      md/raid5: remove unused working_disks variable

Yu Kuai (6):
      md: fix soft lockup in status_resync
      md/raid10: don't BUG_ON() in raise_barrier()
      md/raid10: fix leak of 'r10bio->remaining' for recovery
      md/raid10: fix memleak for 'conf->bio_split'
      md/raid10: fix memleak of md thread
      md/raid10: don't call bio_start_io_acct twice for bio which experienced read error

Zhong Jinghua (1):
      nbd: fix incomplete validation of ioctl arg

zhenwei pi (1):
      nvme-rdma: minor cleanup in nvme_rdma_create_cq()

 Documentation/ABI/stable/sysfs-block              |  15 +-
 Documentation/block/inline-encryption.rst         |   3 +-
 Documentation/fault-injection/fault-injection.rst |   8 +
 arch/s390/include/uapi/asm/dasd.h                 |   2 +
 block/Kconfig                                     |   5 -
 block/Makefile                                    |   1 -
 block/bdev.c                                      |   1 +
 block/bfq-cgroup.c                                |  20 +-
 block/bfq-iosched.c                               |  19 +-
 block/bfq-iosched.h                               |   1 -
 block/blk-cgroup.c                                | 147 +++--
 block/blk-cgroup.h                                |  12 +-
 block/blk-core.c                                  |  14 +-
 block/blk-crypto-internal.h                       |  38 +-
 block/blk-crypto-profile.c                        |  60 +-
 block/blk-crypto.c                                |  66 ++-
 block/blk-flush.c                                 |  17 +-
 block/blk-iocost.c                                |  58 +-
 block/blk-iolatency.c                             |  39 +-
 block/blk-merge.c                                 |   2 +
 block/blk-mq-cpumap.c                             |   1 -
 block/blk-mq-debugfs.c                            |  28 -
 block/blk-mq-pci.c                                |   1 -
 block/blk-mq-rdma.c                               |  44 --
 block/blk-mq-sched.c                              | 143 +----
 block/blk-mq-sched.h                              |   7 -
 block/blk-mq-sysfs.c                              |   2 -
 block/blk-mq-tag.c                                |   2 -
 block/blk-mq-tag.h                                |  73 ---
 block/blk-mq-virtio.c                             |   1 -
 block/blk-mq.c                                    | 665 +++++++++-------------
 block/blk-mq.h                                    |  77 ++-
 block/blk-pm.c                                    |   2 -
 block/blk-rq-qos.h                                |   2 +-
 block/blk-stat.c                                  |  23 +-
 block/blk-sysfs.c                                 |  26 +-
 block/blk-throttle.c                              |  19 +-
 block/blk.h                                       |   6 -
 block/elevator.h                                  |   4 +-
 block/genhd.c                                     |   3 +
 block/kyber-iosched.c                             |   7 +-
 block/mq-deadline.c                               |  13 +-
 block/opal_proto.h                                |  10 +
 block/sed-opal.c                                  | 330 +++++++++--
 drivers/block/Kconfig                             |  17 +
 drivers/block/drbd/drbd_actlog.c                  |  13 +-
 drivers/block/drbd/drbd_bitmap.c                  |  13 +-
 drivers/block/drbd/drbd_int.h                     | 120 ++--
 drivers/block/drbd/drbd_main.c                    |  72 ++-
 drivers/block/drbd/drbd_nl.c                      |  19 +-
 drivers/block/drbd/drbd_receiver.c                | 102 ++--
 drivers/block/drbd/drbd_req.c                     |  30 +-
 drivers/block/drbd/drbd_req.h                     |  11 +-
 drivers/block/drbd/drbd_state.c                   |  29 +-
 drivers/block/drbd/drbd_worker.c                  | 114 ++--
 drivers/block/nbd.c                               |  15 +-
 drivers/block/null_blk/Kconfig                    |   2 +-
 drivers/block/null_blk/main.c                     | 135 +++--
 drivers/block/null_blk/null_blk.h                 |   7 +-
 drivers/block/ublk_drv.c                          | 133 +++--
 drivers/md/dm-table.c                             |  19 +-
 drivers/md/md-bitmap.c                            | 143 +++--
 drivers/md/md-linear.c                            |  14 +-
 drivers/md/md.c                                   |  27 +-
 drivers/md/md.h                                   |  10 +-
 drivers/md/raid0.c                                |  14 +-
 drivers/md/raid10.c                               | 102 ++--
 drivers/md/raid5.c                                |   5 +-
 drivers/nvme/host/apple.c                         |   8 +-
 drivers/nvme/host/core.c                          |   9 +-
 drivers/nvme/host/pci.c                           |   6 +-
 drivers/nvme/host/rdma.c                          |  19 +-
 drivers/nvme/host/tcp.c                           |   3 +
 drivers/nvme/host/trace.h                         |  15 +-
 drivers/nvme/target/admin-cmd.c                   |  81 ++-
 drivers/nvme/target/fcloop.c                      |  48 +-
 drivers/nvme/target/nvmet.h                       |  12 +-
 drivers/nvme/target/tcp.c                         |  34 +-
 drivers/nvme/target/zns.c                         |  20 +-
 drivers/s390/block/dasd.c                         |  75 ++-
 drivers/s390/block/dasd_devmap.c                  | 126 ++++
 drivers/s390/block/dasd_eckd.c                    |   1 +
 drivers/s390/block/dasd_eer.c                     |   1 +
 drivers/s390/block/dasd_int.h                     |  32 +-
 include/linux/blk-crypto.h                        |   4 +-
 include/linux/blk-mq-rdma.h                       |  11 -
 include/linux/blk-mq.h                            |   2 -
 include/linux/blk_types.h                         |  21 +-
 include/linux/blkdev.h                            |  12 -
 include/linux/fault-inject.h                      |  22 +
 include/linux/genl_magic_func.h                   |   2 +-
 include/linux/sed-opal.h                          |   2 +
 include/uapi/linux/sed-opal.h                     |  24 +
 include/uapi/linux/ublk_cmd.h                     |  43 ++
 io_uring/rw.c                                     |   2 +-
 lib/Kconfig.debug                                 |  14 +-
 lib/fault-inject.c                                | 191 +++++++
 97 files changed, 2255 insertions(+), 1768 deletions(-)
 delete mode 100644 block/blk-mq-rdma.c
 delete mode 100644 block/blk-mq-tag.h
 delete mode 100644 include/linux/blk-mq-rdma.h

-- 
Jens Axboe

