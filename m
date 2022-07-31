Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92F0C00140
	for <linux-block@archiver.kernel.org>; Sun, 31 Jul 2022 15:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiGaPDy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbiGaPDx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 11:03:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE50DF43
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 08:03:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h28so2103001pfq.11
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=DVFoJl4onZaTMcZXwZwAdO6IbKXBG3Elf64djWgKXBM=;
        b=hMgixFvxxSfhrg2Ai4r7L0VtMrFWHa1MER4gBgS9xfQmM2pT27L5ftbewUKyjdPyjW
         r9+LssmpDYPRvKm0A3pPXndUrJLtib/jBbA4MQchQ+6/DzHYjLarJhwI9yqLBl9ECD/R
         kOwW58IVSQsmbejndhIIWTd9F3sxaYx7zkpHWqF7yyoy6eHG4K6dwGuVX5aEDrt+N7A+
         hzvqcjWQJLRZLhBvtX+bxFEKO/8vybn847yIyi2cj0RbH3KdhHP0F1ei5faO/4Oj+A8R
         EAzxBXL2zRA7ue4sVMISvj56WsCr6qAmZbvi2d9Pg+9OyvdQ6T/sIsLyp9+ISIbp2m/v
         yHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=DVFoJl4onZaTMcZXwZwAdO6IbKXBG3Elf64djWgKXBM=;
        b=KH3ImgZumOnRmG7/vwcyaFJg7sAIwPyGct9RQHXCoKmbM5WPtBZYWQGl3SdT/kgMep
         S9Jik4Tg3wDxQBlVF0hr1gJAmjN8HBzCu1paWtGrzJ/bAHESIuIj+gk6SVwOq76ex3OS
         6F8FkZeKm5PTlaOhvLSnAe6mszuKjli5jequg0/MdJaX2khkCPRC4ZPJi4KjkD30sbiG
         MCqiWgSnXXXSVbq0v2rmp0NOZN70I8KFUAkDGSfb/u5ve4v0VPYU5Q0Vx9p+XBusfeQo
         4Z6nyTliY3kxGbrCBDsnc0w2v3ruCPjvsmV/FoLJq5SdjQKCEFEa22FcXKPfAgxX2ZOa
         2X9g==
X-Gm-Message-State: AJIora/nirHGw5f9BVu7jb3C+zGLqLGTDoCFK3AaEZbn4730l0Hx+quo
        +gW3giD1Jnc4nG6J5GIXJ5Ykq7QkgCXmSw==
X-Google-Smtp-Source: AGRyM1sURHZfiX5wzHPXeR2AYrhP7Lk6Dv+I6i2w7bXyw4mEzFXSNOLocSlc5UTDsoyxW52cTR87VA==
X-Received: by 2002:a63:1208:0:b0:411:9b47:f6cc with SMTP id h8-20020a631208000000b004119b47f6ccmr10037046pgl.79.1659279829242;
        Sun, 31 Jul 2022 08:03:49 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l185-20020a6391c2000000b0041bf7924fc4sm1060389pge.13.2022.07.31.08.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 08:03:48 -0700 (PDT)
Message-ID: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
Date:   Sun, 31 Jul 2022 09:03:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver changes for 5.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the core block changes, here are the block driver changes for
5.20-rc1. In detail:

- NVMe pull request via Christoph
	- add support for In-Band authentication (Hannes Reinecke)
	- handle the persistent internal error AER (Michael Kelley)
	- use in-capsule data for TCP I/O queue connect (Caleb Sander)
	- remove timeout for getting RDMA-CM established event
	  (Israel Rukshin)
	- misc cleanups (Joel Granados, Sagi Grimberg, Chaitanya Kulkarni,
	  Guixin Liu, Xiang wangx)

- MD pull request via Song
	- Improve raid5 lock contention, by Logan Gunthorpe.
	- Misc fixes to raid5, by Logan Gunthorpe.
	- Fix race condition with md_reap_sync_thread(), by Guoqing Jiang.

- Work on unifying the null_blk module parameters and configfs API
  (Vincent)

- drbd bitmap IO error fix (Lars)

- Set of rnbd fixes (Guoqing, Md Haris)

- Remove experimental marker on bcache async device registration (Coly)

- Misc fixes and cleanups (Ming, Yu, Dan, Christophe

Note that this will throw a merge conflict in
drivers/block/drbd/drbd_bitmap.c due to the request flag changes from
Bart. The resolution is trivial, just keep the new enum req_op:

diff --cc drivers/block/drbd/drbd_bitmap.c
index 603f6828dd79,bd2133ef6e0a..7d9db33363de
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@@ -977,16 -990,17 +990,17 @@@ static inline sector_t drbd_md_last_bit
  static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_hold(local)
  {
  	struct drbd_device *device = ctx->device;
 -	unsigned int op = (ctx->flags & BM_AIO_READ) ? REQ_OP_READ : REQ_OP_WRITE;
 +	enum req_op op = ctx->flags & BM_AIO_READ ? REQ_OP_READ : REQ_OP_WRITE;
- 	struct bio *bio = bio_alloc_bioset(device->ldev->md_bdev, 1, op,
- 					   GFP_NOIO, &drbd_md_io_bio_set);
  	struct drbd_bitmap *b = device->bitmap;
+ 	struct bio *bio;
  	struct page *page;
+ 	sector_t last_bm_sect;
+ 	sector_t first_bm_sect;
+ 	sector_t on_disk_sector;
  	unsigned int len;
  
- 	sector_t on_disk_sector =
- 		device->ldev->md.md_offset + device->ldev->md.bm_offset;
- 	on_disk_sector += ((sector_t)page_nr) << (PAGE_SHIFT-9);
+ 	first_bm_sect = device->ldev->md.md_offset + device->ldev->md.bm_offset;
+ 	on_disk_sector = first_bm_sect + (((sector_t)page_nr) << (PAGE_SHIFT-SECTOR_SHIFT));
  
  	/* this might happen with very small
  	 * flexible external meta data device,

Please pull!


The following changes since commit ee78ec1077d37d1a4a0860589a65df8ae6d2255c:

  blk-mq: blk_mq_tag_busy is no need to return a value (2022-06-27 06:29:12 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.20/drivers-2022-07-29

for you to fetch changes up to 508e357579f07d43cb3feabe93b46bc1648ca5d9:

  bcache: remove EXPERIMENTAL for Kconfig option 'Asynchronous device registration' (2022-07-28 11:13:11 -0600)

----------------------------------------------------------------
for-5.20/drivers-2022-07-29

----------------------------------------------------------------
Caleb Sander (1):
      nvme-tcp: use in-capsule data for I/O connect

Chaitanya Kulkarni (2):
      nvme: remove unused timeout parameter
      nvme: fix qid param blk_mq_alloc_request_hctx

Chris Webb (1):
      md: Explicitly create command-line configured devices

Christophe JAILLET (1):
      block: null_blk: Use the bitmap API to allocate bitmaps

Coly Li (1):
      bcache: remove EXPERIMENTAL for Kconfig option 'Asynchronous device registration'

Dan Carpenter (1):
      null_blk: fix ida error handling in null_add_dev()

Guixin Liu (2):
      nvme-pci: use nvme core helper to cancel requests in tagset
      nvme-apple: use nvme core helper to cancel requests in tagset

Guoqing Jiang (9):
      md: unlock mddev before reap sync_thread in action_store
      rnbd-clt: open code send_msg_open in rnbd_clt_map_device
      rnbd-clt: don't free rsp in msg_open_conf for map scenario
      rnbd-clt: kill read_only from struct rnbd_clt_dev
      rnbd-clt: reduce the size of struct rnbd_clt_dev
      rnbd-clt: adjust the layout of struct rnbd_clt_dev
      rnbd-clt: check capacity inside rnbd_clt_change_capacity
      rnbd-clt: pass sector_t type for resize capacity
      rnbd-clt: make rnbd_clt_change_capacity return void

Hannes Reinecke (11):
      crypto: add crypto_has_shash()
      crypto: add crypto_has_kpp()
      lib/base64: RFC4648-compliant base64 encoding
      nvme: add definitions for NVMe In-Band authentication
      nvme-fabrics: decode 'authentication required' connect error
      nvme: implement In-Band authentication
      nvme-auth: Diffie-Hellman key exchange support
      nvmet: parse fabrics commands on io queues
      nvmet: implement basic In-Band Authentication
      nvmet-auth: Diffie-Hellman key exchange support
      nvmet-auth: expire authentication sessions

Israel Rukshin (1):
      nvme-rdma: remove timeout for getting RDMA-CM established event

Jens Axboe (2):
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.20/drivers
      Merge tag 'nvme-5.20-2022-07-14' of git://git.infradead.org/nvme into for-5.20/drivers

Joel Granados (1):
      nvme-multipath: refactor nvme_mpath_add_disk

Lars Ellenberg (1):
      drbd: bm_page_async_io: fix spurious bitmap "IO error" on large volumes

Logan Gunthorpe (25):
      md/raid5-log: Drop extern decorators for function prototypes
      md/raid5-ppl: Drop unused argument from ppl_handle_flush_request()
      md/raid5: suspend the array for calls to log_exit()
      md/raid5-cache: Take mddev_lock in r5c_journal_mode_show()
      md/raid5-cache: Drop RCU usage of conf->log
      md/raid5-cache: Clear conf->log after finishing work
      md/raid5-cache: Annotate pslot with __rcu notation
      md: Use enum for overloaded magic numbers used by mddev->curr_resync
      md: Ensure resync is reported after it starts
      md: Notify sysfs sync_completed in md_reap_sync_thread()
      md/raid5: Make logic blocking check consistent with logic that blocks
      md/raid5: Factor out ahead_of_reshape() function
      md/raid5: Refactor raid5_make_request loop
      md/raid5: Move stripe_add_to_batch_list() call out of add_stripe_bio()
      md/raid5: Move common stripe get code into new find_get_stripe() helper
      md/raid5: Factor out helper from raid5_make_request() loop
      md/raid5: Drop the do_prepare flag in raid5_make_request()
      md/raid5: Move read_seqcount_begin() into make_stripe_request()
      md/raid5: Refactor for loop in raid5_make_request() into while loop
      md/raid5: Keep a reference to last stripe_head for batch
      md/raid5: Refactor add_stripe_bio()
      md/raid5: Check all disks in a stripe_head for reshape progress
      md/raid5: Pivot raid5_make_request()
      md/raid5: Improve debug prints
      md/raid5: Increase restriction on max segments per request

Md Haris Iqbal (2):
      block/rnbd-srv: Set keep_id to true after mutex_trylock
      block/rnbd-srv: Replace sess_dev_list with index_idr

Michael Kelley (1):
      nvme: handle the persistent internal error AER

Ming Lei (1):
      null_blk: cleanup null_init_tag_set

Sagi Grimberg (1):
      nvme-loop: use nvme core helpers to cancel all requests in a tagset

Song Liu (1):
      MAINTAINERS: add patchwork link to linux-raid project

Vincent Fu (2):
      null_blk: add module parameters for 4 options
      null_blk: add configfs variables for 2 options

Xiang wangx (1):
      nvme: remove a double word in a comment

Yu Kuai (1):
      nbd: add missing definition of pr_fmt

Zhang Jiaming (1):
      md: Fix spelling mistake in comments

 Documentation/block/null_blk.rst       |   22 +
 MAINTAINERS                            |    1 +
 crypto/kpp.c                           |    6 +
 crypto/shash.c                         |    6 +
 drivers/block/drbd/drbd_bitmap.c       |   49 +-
 drivers/block/nbd.c                    |    6 +-
 drivers/block/null_blk/main.c          |  108 +++-
 drivers/block/null_blk/null_blk.h      |    2 +
 drivers/block/rnbd/rnbd-clt-sysfs.c    |    2 +-
 drivers/block/rnbd/rnbd-clt.c          |  201 ++++---
 drivers/block/rnbd/rnbd-clt.h          |   18 +-
 drivers/block/rnbd/rnbd-srv.c          |   20 +-
 drivers/block/rnbd/rnbd-srv.h          |    4 -
 drivers/md/bcache/Kconfig              |    2 +-
 drivers/md/dm-raid.c                   |    1 +
 drivers/md/md-autodetect.c             |    1 +
 drivers/md/md-cluster.c                |    4 +-
 drivers/md/md.c                        |   76 ++-
 drivers/md/md.h                        |   16 +
 drivers/md/raid5-cache.c               |   40 +-
 drivers/md/raid5-log.h                 |   77 ++-
 drivers/md/raid5-ppl.c                 |    2 +-
 drivers/md/raid5.c                     |  646 +++++++++++++-------
 drivers/nvme/Kconfig                   |    1 +
 drivers/nvme/Makefile                  |    1 +
 drivers/nvme/common/Kconfig            |    4 +
 drivers/nvme/common/Makefile           |    7 +
 drivers/nvme/common/auth.c             |  482 +++++++++++++++
 drivers/nvme/host/Kconfig              |   15 +
 drivers/nvme/host/Makefile             |    1 +
 drivers/nvme/host/apple.c              |    7 +-
 drivers/nvme/host/auth.c               | 1017 ++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c               |  190 +++++-
 drivers/nvme/host/fabrics.c            |   94 ++-
 drivers/nvme/host/fabrics.h            |    7 +
 drivers/nvme/host/multipath.c          |    6 +-
 drivers/nvme/host/nvme.h               |   39 +-
 drivers/nvme/host/pci.c                |    6 +-
 drivers/nvme/host/rdma.c               |   14 +-
 drivers/nvme/host/tcp.c                |   13 +-
 drivers/nvme/host/trace.c              |   32 +
 drivers/nvme/target/Kconfig            |   15 +
 drivers/nvme/target/Makefile           |    1 +
 drivers/nvme/target/admin-cmd.c        |    4 +-
 drivers/nvme/target/auth.c             |  525 +++++++++++++++++
 drivers/nvme/target/configfs.c         |  138 ++++-
 drivers/nvme/target/core.c             |   15 +
 drivers/nvme/target/fabrics-cmd-auth.c |  545 +++++++++++++++++
 drivers/nvme/target/fabrics-cmd.c      |   55 +-
 drivers/nvme/target/loop.c             |    8 +-
 drivers/nvme/target/nvmet.h            |   75 ++-
 include/crypto/hash.h                  |    2 +
 include/crypto/kpp.h                   |    2 +
 include/linux/base64.h                 |   16 +
 include/linux/nvme-auth.h              |   41 ++
 include/linux/nvme.h                   |  213 ++++++-
 lib/Makefile                           |    2 +-
 lib/base64.c                           |  103 ++++
 58 files changed, 4474 insertions(+), 532 deletions(-)
 create mode 100644 drivers/nvme/common/Kconfig
 create mode 100644 drivers/nvme/common/Makefile
 create mode 100644 drivers/nvme/common/auth.c
 create mode 100644 drivers/nvme/host/auth.c
 create mode 100644 drivers/nvme/target/auth.c
 create mode 100644 drivers/nvme/target/fabrics-cmd-auth.c
 create mode 100644 include/linux/base64.h
 create mode 100644 include/linux/nvme-auth.h
 create mode 100644 lib/base64.c

-- 
Jens Axboe

