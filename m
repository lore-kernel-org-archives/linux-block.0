Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D507C432C0
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC182067D
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 17:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ed8Ai6Rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKURaf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:30:35 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43568 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKURaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 12:30:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id q8so1900672qtr.10
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2019 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=o5/QrLKFkIlkNgGgteM0pUleF2Kop1Q4B7bSR05qdGU=;
        b=Ed8Ai6RxPVXlfe5gmwD+s7Z6ouLBESj8kLO/MU77eFM/83BrWgE0WxU9E4wEb4BTY7
         RW8WWdQdQhfkq2CAkmcDQr/R7HPfgOaR/7UYWXAenTh3u/g9qTuiOpT61BCqJ/dZho0S
         TpbL3r+XtPXZKZInaWwJn1jhpkt7S+f1W9lekaUjYW6dczI++I8uFVrMSTkp0jf2/LgQ
         PdYxtkcPM2rQimELeh+/8gyqMByCaSDLoSEBfgGnts4CbLL/BPaeVtmsGb+pYwkHvXR5
         Mzh0d5NgbdMJgsaC+g/rCTZiyqfKLmDb1EEJLmTPfJNH3lcTw2Kb+5b5TN8+oOz8WqaE
         kRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=o5/QrLKFkIlkNgGgteM0pUleF2Kop1Q4B7bSR05qdGU=;
        b=T6DyAEmz62LuVVSbGwdobOqhT4LDCPshMsX5R26T/LDWpU6zL/IEo4IqVXur0R2MmD
         SlwVVZ40/VFTqCjn1eNJmxEZftK0TGpdOnrsw7uv4J7aayHHjGpSspmc+w6XqLIqAZwJ
         sVytWMFk3qlT2tUEFBv7ZlmVkUjS20kJv8PIR/Q6TR/e9j5oXp/65Jen2LeAhsSHSXjP
         xjGDVBJ7Ys/6FGoVwp+cYXLpQljRevwH42kSsOw5mShehBtPP4QgqOQTaNi2i88NObtb
         Jf80PF/SWAZ31a8VxOr+XkKbq4DpcnalZwg9H7wr6kfLu0OmmPQACv+Y8ZU9jlQKK+mo
         RkrQ==
X-Gm-Message-State: APjAAAVZARkqNDAkaCqDLhLBqK84cRrapiuiZ/T9dbRc5he/M7G2uwqV
        3iWH6Kr5JfDNhYndPqK1AU5PRh9xplbvVg==
X-Google-Smtp-Source: APXvYqwr68929xxeX15E8ED3LeCIYqZCnHpy1m4d46gB2EF+omksrG/FieyNEl+Z1emdpeBRQmiEBg==
X-Received: by 2002:a02:9641:: with SMTP id c59mr1702627jai.40.1574357432216;
        Thu, 21 Nov 2019 09:30:32 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n12sm1120374iob.71.2019.11.21.09.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 09:30:31 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Main block driver changes for 5.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <8d7e00cd-2e9d-8692-1104-30709a7b7426@kernel.dk>
Date:   Thu, 21 Nov 2019 10:30:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's the main block driver pull request for 5.5. This depends on the
for-5.5/block core branch I sent out earlier. Nothing major in here,
mostly just fixes. This pull request contains:

- Set of bcache changes via Coly

- MD changes from Song

- loop unmap write-zeroes fix (Darrick)

- Spelling fixes (Geert)

- zoned additions cleanups to null_blk/dm (Ajay)

- Allow null_blk online submit queue changes (Bart)

- NVMe changes via Keith, nothing major here either.


Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.5/drivers-20191121


----------------------------------------------------------------
Ajay Joshi (3):
      null_blk: return fixed zoned reads > write pointer
      dm: add zone open, close and finish support
      null_blk: add zone open, close, and finish support

Andrea Righi (1):
      bcache: fix deadlock in bcache_allocator

Bart Van Assche (2):
      null_blk: Improve nullb_device_##NAME##_store() readability
      null_blk: Enable modifying 'submit_queues' after an instance has been configured

Christoph Hellwig (10):
      nvmet: Introduce common execute function for get_log_page and identify
      nvmet: Cleanup discovery execute handlers
      nvmet: Introduce nvmet_dsm_len() helper
      nvmet: Remove the data_len field from the nvmet_req struct
      nvmet: Open code nvmet_req_execute()
      nvmet: clean up command parsing a bit
      nvmet: add plugging for read/write when ns is bdev
      nvmet: stop using bio_set_op_attrs
      bcache: remove the extra cflags for request.o
      bcache: don't export symbols

Coly Li (8):
      bcache: fix fifo index swapping condition in journal_pin_cmp()
      bcache: fix static checker warning in bcache_device_free()
      bcache: add more accurate error messages in read_super()
      bcache: deleted code comments for dead code in bch_data_insert_keys()
      bcache: add code comment bch_keylist_pop() and bch_keylist_pop_front()
      bcache: add code comments in bch_btree_leaf_dirty()
      bcache: add idle_max_writeback_rate sysfs interface
      bcache: at least try to shrink 1 node in bch_mca_scan()

Damien Le Moal (2):
      nvme: Cleanup and rename nvme_block_nr()
      nvme: Introduce nvme_lba_to_sect()

Dan Carpenter (1):
      md/raid0: Fix an error message in raid0_make_request()

Darrick J. Wong (1):
      loop: fix no-unmap write-zeroes request behavior

David Jeffery (1):
      md: improve handling of bio with REQ_PREFLUSH in md_flush_request()

Eugene Syromiatnikov (2):
      drivers/md/raid5.c: use the new spelling of RWH_WRITE_LIFE_NOT_SET
      drivers/md/raid5-ppl.c: use the new spelling of RWH_WRITE_LIFE_NOT_SET

Geert Uytterhoeven (2):
      block: mtip32xx: Spelling s/configration/configuration/
      nvme-pci: Spelling s/resdicovered/rediscovered/

Guoju Fang (1):
      bcache: fix a lost wake-up problem caused by mca_cannibalize_lock

Guoqing Jiang (1):
      md/bitmap: avoid race window between md_bitmap_resize and bitmap_file_clear_bit

Hannes Reinecke (1):
      md/raid1: avoid soft lockup under high load

Israel Rukshin (4):
      nvme: introduce nvme_is_aen_req function
      nvmet: use bio_io_error instead of duplicating it
      nvmet: add unlikely check at nvmet_req_alloc_sgl
      nvmet-rdma: add unlikely check at nvmet_rdma_map_sgl_keyed

James Smart (5):
      nvme-fc: Sync nvme-fc header to FC-NVME-2
      nvme-fc and nvmet-fc: sync with FC-NVME-2 header changes
      nvme-fc: Set new cmd set indicator in nvme-fc cmnd iu
      nvme-fc: clarify error messages
      nvme-fc: ensure association_id is cleared regardless of a Disconnect LS

Jens Axboe (5):
      Merge branch 'md-next' of https://git.kernel.org/.../song/md into for-5.5/drivers
      Merge branch 'for-5.5/block' into for-5.5/drivers
      Merge branch 'md-next' of git://git.kernel.org/.../song/md into for-5.5/drivers
      Merge branch 'md-next' of git://git.kernel.org/.../song/md into for-5.5/drivers
      Revert "bcache: fix fifo index swapping condition in journal_pin_cmp()"

John Pittman (1):
      md/raid10: prevent access of uninitialized resync_pages offset

Logan Gunthorpe (2):
      nvmet-tcp: Don't check data_len in nvmet_tcp_map_data()
      nvmet-tcp: Don't set the request's data_len

Max Gurtovoy (2):
      nvme: introduce "Command Aborted By host" status code
      nvme: move common call to nvme_cleanup_cmd to core layer

Prabhath Sajeepa (1):
      nvme: Fix parsing of ANA log page

Revanth Rajashekar (1):
      nvme: resync include/linux/nvme.h with nvmecli

Sagi Grimberg (1):
      nvmet: fill discovery controller sn, fr and mn correctly

Yufen Yu (2):
      md: no longer compare spare disk superblock events in super_load
      md: avoid invalid memory access for array sb->dev_roles

 drivers/block/loop.c              |  26 ++++--
 drivers/block/mtip32xx/mtip32xx.c |   2 +-
 drivers/block/null_blk.h          |   8 ++
 drivers/block/null_blk_main.c     | 104 ++++++++++++++++------
 drivers/block/null_blk_zoned.c    |  54 +++++++++--
 drivers/md/bcache/Makefile        |   2 -
 drivers/md/bcache/alloc.c         |   5 +-
 drivers/md/bcache/bcache.h        |   4 +-
 drivers/md/bcache/bset.c          |  17 +---
 drivers/md/bcache/btree.c         |  19 +++-
 drivers/md/bcache/closure.c       |   7 --
 drivers/md/bcache/request.c       |  12 ---
 drivers/md/bcache/super.c         |  56 ++++++++----
 drivers/md/bcache/sysfs.c         |   7 ++
 drivers/md/bcache/writeback.c     |   4 +
 drivers/md/dm-flakey.c            |   7 +-
 drivers/md/dm-linear.c            |   2 +-
 drivers/md/dm.c                   |   5 +-
 drivers/md/md-bitmap.c            |   2 +-
 drivers/md/md-linear.c            |   5 +-
 drivers/md/md-multipath.c         |   5 +-
 drivers/md/md.c                   |  57 ++++++++++--
 drivers/md/md.h                   |   4 +-
 drivers/md/raid0.c                |   7 +-
 drivers/md/raid1.c                |   6 +-
 drivers/md/raid10.c               |   7 +-
 drivers/md/raid5-ppl.c            |   2 +-
 drivers/md/raid5.c                |   8 +-
 drivers/nvme/host/core.c          |  24 ++---
 drivers/nvme/host/fc.c            |  49 +++++-----
 drivers/nvme/host/multipath.c     |  13 ++-
 drivers/nvme/host/nvme.h          |  20 ++++-
 drivers/nvme/host/pci.c           |   6 +-
 drivers/nvme/host/rdma.c          |  16 ++--
 drivers/nvme/host/tcp.c           |   4 +-
 drivers/nvme/target/admin-cmd.c   | 133 +++++++++++++++++-----------
 drivers/nvme/target/core.c        |  20 ++---
 drivers/nvme/target/discovery.c   |  70 ++++++++-------
 drivers/nvme/target/fabrics-cmd.c |  15 +++-
 drivers/nvme/target/fc.c          |  31 ++++---
 drivers/nvme/target/io-cmd-bdev.c |  43 +++++----
 drivers/nvme/target/io-cmd-file.c |  20 +++--
 drivers/nvme/target/loop.c        |   7 +-
 drivers/nvme/target/nvmet.h       |  10 ++-
 drivers/nvme/target/rdma.c        |   8 +-
 drivers/nvme/target/tcp.c         |  14 ++-
 include/linux/nvme-fc.h           | 182 ++++++++++++++++++++++++++++----------
 include/linux/nvme.h              |  54 ++++++++++-
 48 files changed, 783 insertions(+), 400 deletions(-)

-- 
Jens Axboe

