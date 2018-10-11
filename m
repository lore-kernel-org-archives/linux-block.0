Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34887 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbeJLB7C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Oct 2018 21:59:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id l17-v6so4840940pff.2
        for <linux-block@vger.kernel.org>; Thu, 11 Oct 2018 11:30:37 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 00/13] Convert floppy drivers to blk-mq
Date: Thu, 11 Oct 2018 11:30:10 -0700
Message-Id: <cover.1539282366.git.osandov@fb.com>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This series converts the various floppy drivers to blk-mq. Save for the
last one (floppy), they're compile-tested only. If I've Cc'd you, it's
because I think you might be able to test the changes. Please test if
you can, or let me know if there's a way to use QEMU/some other emulator
to test. The full series is available at [1]. Thanks!

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Laurent Vivier <lvivier@redhat.com>

1: https://github.com/osandov/linux/tree/mq-conversions.

Omar Sandoval (13):
  swim: fix cleanup on setup error
  swim: convert to blk-mq
  swim3: add real error handling in setup
  swim3: end whole request on error
  swim3: convert to blk-mq
  amiflop: fold headers into C file
  amiflop: clean up on errors during setup
  amiflop: convert to blk-mq
  ataflop: fold headers into C file
  ataflop: fix error handling during setup
  ataflop: convert to blk-mq
  floppy: end whole request on error
  floppy: convert to blk-mq

 arch/m68k/include/asm/atafd.h    |  13 --
 arch/m68k/include/asm/atafdreg.h |  80 --------
 drivers/block/amiflop.c          | 330 +++++++++++++++++++------------
 drivers/block/ataflop.c          | 288 ++++++++++++++++-----------
 drivers/block/floppy.c           |  80 +++++---
 drivers/block/swim.c             | 116 ++++++-----
 drivers/block/swim3.c            | 221 +++++++++++----------
 include/linux/amifd.h            |  63 ------
 include/linux/amifdreg.h         |  82 --------
 9 files changed, 604 insertions(+), 669 deletions(-)
 delete mode 100644 arch/m68k/include/asm/atafd.h
 delete mode 100644 arch/m68k/include/asm/atafdreg.h
 delete mode 100644 include/linux/amifd.h
 delete mode 100644 include/linux/amifdreg.h

-- 
2.19.1
