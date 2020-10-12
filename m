Return-Path: <SRS0=jKGj=DT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06E4C433DF
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 14:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BE220838
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 14:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t6wlEQKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgJLOMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Oct 2020 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgJLOMS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Oct 2020 10:12:18 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FEBC0613D0
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2020 07:12:17 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id n6so17765868ioc.12
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2020 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+cH6IZL+mepIDRuvNAl+l1IwZstEJIR1PyxVMEUOuwE=;
        b=t6wlEQKG4yih3ZNj/uNAxVrhLxBNY23ceWbZ56cfZrlQ8ADZ44eI0946hyrUfisAvj
         nw5qGN55xjGqD4pi+ZURyGDF3zblEU5cnW4bS44+5W4Y0tgQkIqK1EcY08VmnQ2JM0n0
         K/rvx6wzpmH0wZ+w4Vo5biomktt5PQlyYSLB36Ldrrv0YbOM/eyJdqCNb7AcmCuISBsX
         UaXfOnjy/geC3Snlo5FqyXhAPpJx9eFUd06beuZJW1IQFIy/tFhx4mj3gf0xbVnGAJ7u
         dzoXxuN2i7ipKY3830Zm1lZ+WoQXO82Fe/NlW2tanL1Qb/EncBQZiHv3EoIvrnaSsuKv
         xAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+cH6IZL+mepIDRuvNAl+l1IwZstEJIR1PyxVMEUOuwE=;
        b=dbgHxmUIOgpInxXUcrt5wVbJpTF7LydHxyVncfc1ga0k5piuiCoMAXUnIP9dgcBizB
         5gR3LE4kjyZrLW39MpXHwbPeSOjrEWt0Sq9dHmCG+ZVtobVmowigD+u5eJyDifAJCVvX
         M1lXcy4x0DCFdDeXwhldKS4ZLNRZyL2jaPT1vE6ozHtyY7LkS6rcDoMJGMkv9XFOJkhd
         vnQEo8zxSLpZEpma5qZXw7ObjM3VAEoGgEoMtqqYx1vpZ9ynXp54Av8cT2VW6RnamM3w
         JPSgKcRjnMr2f9AdaLmD3PHivcmwRLHGlTZsrHwbZoFDgJ7QomeihwJZz/OS1rLRMr9S
         wUwA==
X-Gm-Message-State: AOAM532MepAVx1Z3CVNTXnhl0Za5x5jbnz/qbU615AR98XsoQlyGnZrg
        /VtqCmua/pSh8zlVoCJlvR1iE42Ek6wM7Q==
X-Google-Smtp-Source: ABdhPJz12oLGYZOXix+sJKvO69CHGygwl+cyMxipep8PM0qKzg99EHs+y/mPKCCQMQJ5I8AhcSNw9w==
X-Received: by 2002:a02:1349:: with SMTP id 70mr3506832jaz.130.1602511936480;
        Mon, 12 Oct 2020 07:12:16 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j11sm9371086ili.83.2020.10.12.07.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 07:12:15 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver updates for 5.10-rc1
Message-ID: <70937a19-2f2d-ab26-92da-2e3ce8ef2764@kernel.dk>
Date:   Mon, 12 Oct 2020 08:12:15 -0600
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

On top of the core block pull request, here are the driver updates for
the 5.10 merge window. A few SCSI updates in here too, in coordination
with Martin as they depend on core block changes for the shared tag
bitmap. This pull request contains:

- NVMe pull requests via Christoph:
	- fix keep alive timer modification (Amit Engel)
	- order the PCI ID list more sensibly (Andy Shevchenko)
	- cleanup the open by controller helper (Chaitanya Kulkarni)
	- use an xarray for the CSE log lookup (Chaitanya Kulkarni)
	- support ZNS in nvmet passthrough mode (Chaitanya Kulkarni)
	- fix nvme_ns_report_zones (Christoph Hellwig)
	- add a sanity check to nvmet-fc (James Smart)
	- fix interrupt allocation when too many polled queues are
	  specified (Jeffle Xu)
	- small nvmet-tcp optimization (Mark Wunderlich)
	- fix a controller refcount leak on init failure (Chaitanya
	  Kulkarni)
	- misc cleanups (Chaitanya Kulkarni)
	- major refactoring of the scanning code (Christoph Hellwig)

- MD updates via Song:
	- Bug fixes in bitmap code, from Zhao Heming
	- Fix a work queue check, from Guoqing Jiang
	- Fix raid5 oops with reshape, from Song Liu
	- Clean up unused code, from Jason Yan
	- Discard improvements, from Xiao Ni
	- raid5/6 page offset support, from Yufen Yu

- Shared tag bitmap for SCSI/hisi_sas/null_blk (John, Kashyap, Hannes)

- null_blk open/active zone limit support (Niklas)

- Set of bcache updates (Coly, Dongsheng, Qinglang)

Please pull!


The following changes since commit f56753ac2a90810726334df04d735e9f8f5a32d9:

  bdi: replace BDI_CAP_NO_{WRITEBACK,ACCT_DIRTY} with a single flag (2020-09-24 13:43:39 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/drivers-5.10-2020-10-12

for you to fetch changes up to 79cd16681acccffcf5521f6e3d8c7c50aaffca0a:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.10/drivers (2020-10-09 09:03:20 -0600)

----------------------------------------------------------------
drivers-5.10-2020-10-12

----------------------------------------------------------------
Amit Engel (1):
      nvmet: handle keep-alive timer when kato is modified by a set features cmd

Andy Shevchenko (1):
      nvme-pci: Move enumeration by class to be last in the table

Chaitanya Kulkarni (6):
      nvme: lift the file open code from nvme_ctrl_get_by_path
      nvme: use an xarray to lookup the Commands Supported and Effects log
      nvmet: add passthru ZNS support
      nvme-loop: don't put ctrl on nvme_init_ctrl error
      nvme-core: remove extra variable
      nvme-core: remove extra condition for vwc

Christoph Hellwig (21):
      nvme: fix error handling in nvme_ns_report_zones
      block: optimize blk_queue_zoned_model for !CONFIG_BLK_DEV_ZONED
      nvme: fix initialization of the zone bitmaps
      nvme: remove the disk argument to nvme_update_zone_info
      nvme: rename nvme_validate_ns to nvme_validate_or_alloc_ns
      nvme: rename _nvme_revalidate_disk
      nvme: rename __nvme_revalidate_disk
      nvme: lift the check for an unallocated namespace into nvme_identify_ns
      nvme: call nvme_identify_ns as the first thing in nvme_alloc_ns_block
      nvme: factor out a nvme_configure_metadata helper
      nvme: freeze the queue over ->lba_shift updates
      nvme: clean up the check for too large logic block sizes
      nvme: remove the 0 lba_shift check in nvme_update_ns_info
      nvme: set the queue limits in nvme_update_ns_info
      nvme: update the known admin effects
      nvme: remove nvme_update_formats
      nvme: revalidate zone bitmaps in nvme_update_ns_info
      nvme: query namespace identifiers before adding the namespace
      nvme: move nvme_validate_ns
      nvme: refactor nvme_validate_ns
      nvme: remove nvme_identify_ns_list

Coly Li (13):
      bcache: share register sysfs with async register
      bcache: remove 'int n' from parameter list of bch_bucket_alloc_set()
      bcache: explicitly make cache_set only have single cache
      bcache: remove for_each_cache()
      bcache: add set_uuid in struct cache_set
      bcache: only use block_bytes() on struct cache
      bcache: remove useless alloc_bucket_pages()
      bcache: remove useless bucket_pages()
      bcache: only use bucket_bytes() on struct cache
      bcache: don't check seq numbers in register_cache_set()
      bcache: remove can_attach_cache()
      bcache: check and set sync status on cache's in-memory super block
      bcache: remove embedded struct cache_sb from struct cache_set

Dongsheng Yang (1):
      bcache: check c->root with IS_ERR_OR_NULL() in mca_reserve()

Guoqing Jiang (1):
      md: fix the checking of wrong work queue

Gustavo A. R. Silva (2):
      rsxx: Use fallthrough pseudo-keyword
      block: scsi_ioctl: Avoid the use of one-element arrays

Hannes Reinecke (1):
      scsi: Add host and host template flag 'host_tagset'

James Smart (1):
      nvmet-fc: fix missing check for no hostport struct

Jason Yan (1):
      md/raid0: remove unused function is_io_in_chunk_boundary()

Jeffle Xu (1):
      nvme-pci: allocate separate interrupt for the reserved non-polled I/O queue

Jens Axboe (5):
      Merge branch 'for-5.10/block' into for-5.10/drivers
      Merge branch 'md-next' of https://git.kernel.org/.../song/md into for-5.10/drivers
      Merge tag 'nvme-5.10-2020-09-27' of git://git.infradead.org/nvme into for-5.10/drivers
      Merge tag 'nvme-5.10-2020-10-08' of git://git.infradead.org/nvme into for-5.10/drivers
      Merge branch 'md-next' of https://git.kernel.org/.../song/md into for-5.10/drivers

John Garry (4):
      null_blk: Support shared tag bitmap
      scsi: core: Show nr_hw_queues in sysfs
      scsi: hisi_sas: Switch v3 hw to MQ
      scsi: scsi_debug: Support host tagset

Kashyap Desai (1):
      scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug

Mark Wunderlich (1):
      nvmet-tcp: have queue io_work context run on sock incoming cpu

Niklas Cassel (1):
      null_blk: add support for max open/active zone limit for zoned devices

Qinglang Miao (1):
      bcache: Convert to DEFINE_SHOW_ATTRIBUTE

Song Liu (1):
      md/raid5: fix oops during stripe resizing

Xianting Tian (1):
      md: only calculate blocksize once and use i_blocksize()

Xiao Ni (5):
      md: add md_submit_discard_bio() for submitting discard bio
      md/raid10: extend r10bio devs to raid disks
      md/raid10: pull codes that wait for blocked dev into one function
      md/raid10: improve raid10 discard request
      md/raid10: improve discard request for far layout

Yufen Yu (9):
      md/raid5: add a new member of offset into r5dev
      md/raid5: make async_copy_data() to support different page offset
      md/raid5: add new xor function to support different page offset
      md/raid5: convert to new xor compution interface
      md/raid6: let syndrome computor support different page offset
      md/raid6: let async recovery function support different page offset
      md/raid5: let multiple devices of stripe_head share page
      md/raid5: resize stripe_head when reshape array
      md/raid5: reallocate page array after setting new stripe_size

Zhao Heming (3):
      md/bitmap: md_bitmap_read_sb uses wrong bitmap blocks
      md/bitmap: md_bitmap_get_counter returns wrong blocks
      md/bitmap: fix memory leak of temporary bitmap

Zhen Lei (1):
      md: Simplify code with existing definition RESYNC_SECTORS in raid10.c

 block/scsi_ioctl.c                          |   6 +-
 crypto/async_tx/async_pq.c                  |  72 ++++--
 crypto/async_tx/async_raid6_recov.c         | 163 ++++++++++----
 crypto/async_tx/async_xor.c                 | 120 ++++++++--
 crypto/async_tx/raid6test.c                 |  24 +-
 drivers/block/null_blk.h                    |   5 +
 drivers/block/null_blk_main.c               |  22 +-
 drivers/block/null_blk_zoned.c              | 319 ++++++++++++++++++++++-----
 drivers/block/rsxx/core.c                   |   2 +-
 drivers/md/bcache/alloc.c                   |  60 +++--
 drivers/md/bcache/bcache.h                  |  29 +--
 drivers/md/bcache/btree.c                   | 146 ++++++-------
 drivers/md/bcache/btree.h                   |   2 +-
 drivers/md/bcache/closure.c                 |  16 +-
 drivers/md/bcache/debug.c                   |  10 +-
 drivers/md/bcache/extents.c                 |   6 +-
 drivers/md/bcache/features.c                |   4 +-
 drivers/md/bcache/io.c                      |   2 +-
 drivers/md/bcache/journal.c                 | 246 ++++++++++-----------
 drivers/md/bcache/movinggc.c                |  58 +++--
 drivers/md/bcache/request.c                 |   6 +-
 drivers/md/bcache/super.c                   | 244 ++++++++-------------
 drivers/md/bcache/sysfs.c                   |  10 +-
 drivers/md/bcache/writeback.c               |   2 +-
 drivers/md/md-bitmap.c                      |  16 +-
 drivers/md/md-cluster.c                     |   1 +
 drivers/md/md.c                             |  22 +-
 drivers/md/md.h                             |   2 +
 drivers/md/raid0.c                          |  31 +--
 drivers/md/raid10.c                         | 431 ++++++++++++++++++++++++++++++------
 drivers/md/raid10.h                         |   1 +
 drivers/md/raid5.c                          | 278 +++++++++++++++++++----
 drivers/md/raid5.h                          |  29 ++-
 drivers/nvme/host/core.c                    | 511 ++++++++++++++++++-------------------------
 drivers/nvme/host/nvme.h                    |  13 +-
 drivers/nvme/host/pci.c                     |  35 ++-
 drivers/nvme/host/zns.c                     |  57 ++---
 drivers/nvme/target/admin-cmd.c             |   2 +
 drivers/nvme/target/core.c                  |   4 +-
 drivers/nvme/target/fc.c                    |   2 +-
 drivers/nvme/target/loop.c                  |   4 +-
 drivers/nvme/target/nvmet.h                 |   2 +
 drivers/nvme/target/passthru.c              |  43 +++-
 drivers/nvme/target/tcp.c                   |  21 +-
 drivers/scsi/hisi_sas/hisi_sas.h            |   3 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c       |  36 +--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c      |  87 +++-----
 drivers/scsi/hosts.c                        |   1 +
 drivers/scsi/megaraid/megaraid_sas_base.c   |  39 ++++
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  29 +--
 drivers/scsi/scsi_debug.c                   |  28 +--
 drivers/scsi/scsi_lib.c                     |   2 +
 drivers/scsi/scsi_sysfs.c                   |  11 +
 include/linux/async_tx.h                    |  23 +-
 include/linux/blkdev.h                      |   4 +-
 include/scsi/scsi_host.h                    |   9 +-
 include/trace/events/bcache.h               |   4 +-
 include/uapi/linux/cdrom.h                  |   5 +-
 58 files changed, 2091 insertions(+), 1269 deletions(-)

-- 
Jens Axboe

