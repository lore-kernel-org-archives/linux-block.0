Return-Path: <SRS0=N2dH=5O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03401C43331
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 22:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E2C20733
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 22:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YPvP9GY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgC2W5E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Mar 2020 18:57:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39740 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbgC2W5E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Mar 2020 18:57:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id g32so1734504pgb.6
        for <linux-block@vger.kernel.org>; Sun, 29 Mar 2020 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cnMn0JMPOjD++AoiscNvE9/Wq+L8NCdGAbIk4sC+jac=;
        b=YPvP9GY3NLX7Mw4pNLnMNKpbO1J35winD06KoVv/J5kxXNXq7rIJq0o7P5NhbP8sNV
         OmbwaTsKKNiFFQVuWnRdnNqS5YzlKbuxj7Hc2EQPbF4AR2FlYxQCG7lAa91O07Ixuz7I
         vJ5nGnZZkXnrD9YulrOYKP6T+KcPfm5U3qaUqA21YnmtOGT5G0yhpWUtATy4U1yKkL04
         Zmq8EOCUULfPa68XKoA4RpQr+x3bOAlUUijYr76hT5cfR4oKFEu53E/ejQiKJxlXO4gq
         Qnm8E1rclEcqYJNwi/DcFrMQBt5CZz5cIh+kqJ0oQMCjkD8bJ2/g8okHcJpn9N59snvj
         8Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cnMn0JMPOjD++AoiscNvE9/Wq+L8NCdGAbIk4sC+jac=;
        b=I1CRK+Ud0y789eB1bnyPfj67odc/m3l9hweOdVRaWSxQ16fK7j2kKwWwZcBXSvNATK
         9l6PpAu1N978lWTEohGx/gLUMkZ/eiHbg5BYsSUE4OwJ3Q9XMq/M07y885DaSJbRhqem
         kbPrgBXxn4IzpvWqPiV7flofC/qsNvfR0i5TnIrXIPcHyhSP7zKcso598YgOT2aN2aR2
         BM+oEPbmrtnPcyKh7gYWSgWHz4SMJYpIZskSH9iGgM5oom7kRfhRJsv1qpH20v4I+0Zs
         xjCE2RrqaWrtalv3Q1eeAo67gYK26oE0JxZpf34dxEF5uTb5EO+psNqE83K0z5IOTOW4
         gWTQ==
X-Gm-Message-State: ANhLgQ3VlSMHSfIuvADIL/5i3dv5PwwldlBEKaoU9dEVQRfb6zVy+0UT
        B3sKhhGLJFKLDGRNNH48zNl4ypOo2lhisw==
X-Google-Smtp-Source: ADFU+vvrT2laTHjVi7vhs2rVa3KVVbab5aWIB96lq/+AdWH6rI+fH82nu/zN3VNP0EUpNkj7h6bnBQ==
X-Received: by 2002:a63:da45:: with SMTP id l5mr9663874pgj.273.1585522620192;
        Sun, 29 Mar 2020 15:57:00 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id fa16sm8672841pjb.39.2020.03.29.15.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 15:56:59 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver changes for 5.7-rc
Message-ID: <2e5a9ae1-d97f-da23-12f7-4672e3302035@kernel.dk>
Date:   Sun, 29 Mar 2020 16:56:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's the pull request on the block driver side for 5.7. This sits on
top (of an earlier) for-5.7/block. This pull request contains:

- The floppy cleanup series from Willy

- NVMe updates and fixes (Various)

- null_blk trace improvements (Chaitanya)

- bcache fixes (Coly)

- md fixes (via Song)

- loop block size change optimizations (Martijn)

- scnprintf() use (Takashi)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.7/drivers-2020-03-29


----------------------------------------------------------------
Alexey Dobriyan (2):
      null_blk: fix spurious IO errors after failed past-wp access
      nvme-pci: slimmer CQ head update

Amit Engel (1):
      nvmet: check ncqr & nsqr for set-features cmd

Chaitanya Kulkarni (7):
      nvmet: configfs code cleanup
      nvmet: make ctrl-id configurable
      nvmet: check sscanf value for subsys serial attr
      nvme: code cleanup nvme_identify_ns_desc()
      block: add a zone condition debug helper
      null_blk: add tracepoint helpers for zoned mode
      null_blk: add trace in null_blk_zoned.c

Christoph Hellwig (3):
      nvme: refactor nvme_identify_ns_descs error handling
      nvme: rename __nvme_find_ns_head to nvme_find_ns_head
      nvme: cleanup namespace identifier reporting in nvme_init_ns_head

Coly Li (6):
      bcache: move macro btree() and btree_root() into btree.h
      bcache: add bcache_ prefix to btree_root() and btree() macros
      bcache: make bch_btree_check() to be multithreaded
      bcache: make bch_sectors_dirty_init() to be multithreaded
      bcache: optimize barrier usage for atomic operations
      bcache: remove dupplicated declaration from btree.h

Davidlohr Bueso (1):
      bcache: optimize barrier usage for Rmw atomic bitops

Dongli Zhang (1):
      null_blk: describe the usage of fault injection param

Edmund Nadolski (1):
      nvme: remove unused return code from nvme_alloc_ns

Guoqing Jiang (1):
      md: check arrays is suspended in mddev_detach before call quiesce operations

Gustavo A. R. Silva (1):
      rsxx: Replace zero-length array with flexible-array member

Hou Pu (2):
      nbd: enable replace socket if only one connection is configured
      nbd: requeue command if the soecket is changed

Israel Rukshin (8):
      nvme: Use nvme_state_terminal helper
      nvme: Remove unused return code from nvme_delete_ctrl_sync
      nvme-pci: Re-order nvme_pci_free_ctrl
      nvme: Fix ctrl use-after-free during sysfs deletion
      nvme: Make nvme_uninit_ctrl symmetric to nvme_init_ctrl
      nvme: Fix controller creation races with teardown flow
      nvme-rdma: Add warning on state change failure at nvme_rdma_setup_ctrl
      nvme-tcp: Add warning on state change failure at nvme_tcp_setup_ctrl

Jackie Liu (1):
      block/drbd: delete invalid function drbd_md_mark_dirty_

Jean Delvare (1):
      nvme: Don't deter users from enabling hwmon support

Jens Axboe (2):
      Merge branch 'md-next' of ssh://gitolite.kernel.org/.../song/md into for-5.7/drivers
      Merge branch 'nvme-5.7-rc1' of git://git.infradead.org/nvme into for-5.7/drivers

John Meneghini (1):
      nvme-multipath: do not reset on unknown status

Josh Triplett (1):
      nvme: Check for readiness more quickly, to speed up boot time

Keith Busch (3):
      nvme-pci: Remove tag from process cq
      nvme-pci: Remove two-pass completions
      nvme-pci: Simplify nvme_poll_irqdisable

Konstantin Khlebnikov (1):
      block: keep bdi->io_pages in sync with max_sectors_kb for stacked devices

Mark Ruijter (1):
      nvmet: make ctrl model configurable

Martijn Coenen (2):
      loop: Only change blocksize when needed.
      loop: Only freeze block queue when needed.

Max Gurtovoy (5):
      nvme-pci: properly print controller address
      nvmet: Add get_mdts op for controllers
      nvmet-rdma: Implement get_mdts controller op
      nvmet-rdma: allocate RW ctxs according to mdts
      nvme: release ida resources

Rupesh Girase (1):
      nvme: log additional message for controller status

Sagi Grimberg (7):
      nvme: expose hostnqn via sysfs for fabrics controllers
      nvme: expose hostid via sysfs for fabrics controllers
      nvme-tcp: optimize queue io_cpu assignment for multiple queue maps
      nvmet-tcp: fix maxh2cdata icresp parameter
      nvme-tcp: move send failure to nvme_tcp_try_send
      nvme-tcp: break from io_work loop if recv failed
      nvmet-tcp: optimize tcp stack TX when data digest is used

Takashi Iwai (4):
      block: aoe: Use scnprintf() for avoiding potential buffer overflow
      lightnvm: pblk: Use scnprintf() for avoiding potential buffer overflow
      bcache: Use scnprintf() for avoiding potential buffer overflow
      nvme-fabrics: Use scnprintf() for avoiding potential buffer overflow

Willy Tarreau (16):
      floppy: cleanup: expand macro FDCS
      floppy: cleanup: expand macro UFDCS
      floppy: cleanup: expand macro UDP
      floppy: cleanup: expand macro UDRS
      floppy: cleanup: expand macro UDRWE
      floppy: cleanup: expand macro DP
      floppy: cleanup: expand macro DRS
      floppy: cleanup: expand macro DRWE
      floppy: cleanup: expand the R/W / format command macros
      floppy: cleanup: expand the reply_buffer macros
      floppy: remove dead code for drives scanning on ARM
      floppy: remove incomplete support for second FDC from ARM code
      floppy: prepare ARM code to simplify base address separation
      floppy: introduce new functions fdc_inb() and fdc_outb()
      floppy: separate the FDC's base address from its registers
      floppy: rename the global "fdc" variable to "current_fdc"

Wunderlich, Mark (2):
      nvme-tcp: Set SO_PRIORITY for all host sockets
      nvmet-tcp: set SO_PRIORITY for accepted sockets

masahiro31.yamada@kioxia.com (1):
      nvme: Add compat_ioctl handler for NVME_IOCTL_SUBMIT_IO

 arch/arm/include/asm/floppy.h   |   88 +---
 block/blk-settings.c            |    3 +
 block/blk-zoned.c               |   32 ++
 drivers/block/Makefile          |    6 +
 drivers/block/aoe/aoeblk.c      |    4 +-
 drivers/block/drbd/drbd_main.c  |   11 -
 drivers/block/floppy.c          | 1093 ++++++++++++++++++++-------------------
 drivers/block/loop.c            |   18 +-
 drivers/block/nbd.c             |   27 +-
 drivers/block/null_blk_main.c   |    9 +
 drivers/block/null_blk_trace.c  |   21 +
 drivers/block/null_blk_trace.h  |   79 +++
 drivers/block/null_blk_zoned.c  |   12 +-
 drivers/block/rsxx/dma.c        |    2 +-
 drivers/lightnvm/pblk-sysfs.c   |   42 +-
 drivers/md/bcache/btree.c       |  242 ++++++---
 drivers/md/bcache/btree.h       |   84 +++
 drivers/md/bcache/sysfs.c       |    2 +-
 drivers/md/bcache/writeback.c   |  164 +++++-
 drivers/md/bcache/writeback.h   |   19 +
 drivers/md/md.c                 |    2 +-
 drivers/nvme/host/Kconfig       |    2 -
 drivers/nvme/host/core.c        |  255 +++++----
 drivers/nvme/host/fabrics.c     |    8 +-
 drivers/nvme/host/fc.c          |    3 -
 drivers/nvme/host/multipath.c   |   21 +-
 drivers/nvme/host/nvme.h        |    6 +-
 drivers/nvme/host/pci.c         |   91 +---
 drivers/nvme/host/rdma.c        |    9 +-
 drivers/nvme/host/tcp.c         |  120 ++++-
 drivers/nvme/target/admin-cmd.c |   34 +-
 drivers/nvme/target/configfs.c  |  146 +++++-
 drivers/nvme/target/core.c      |    9 +-
 drivers/nvme/target/loop.c      |    3 -
 drivers/nvme/target/nvmet.h     |   11 +
 drivers/nvme/target/rdma.c      |   15 +-
 drivers/nvme/target/tcp.c       |   35 +-
 include/linux/blkdev.h          |    4 +
 include/uapi/linux/fdreg.h      |   18 +-
 39 files changed, 1774 insertions(+), 976 deletions(-)
 create mode 100644 drivers/block/null_blk_trace.c
 create mode 100644 drivers/block/null_blk_trace.h

-- 
Jens Axboe

