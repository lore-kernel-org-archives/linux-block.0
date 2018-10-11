Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	kernel-team@fb.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Finn Thain <fthain@telegraphics.com.au>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 00/11] Convert floppy drivers to blk-mq
Date: Thu, 11 Oct 2018 12:20:40 -0700
Message-Id: <cover.1539284959.git.osandov@fb.com>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Hi,

This series converts the various floppy drivers to blk-mq. Save for the
last one (floppy), they're compile-tested only. If I've Cc'd you, it's
because I think you might be able to test the changes. Please test if
you can, or let me know if there's a way to use QEMU/some other emulator
to test. The full series is available at [1]. Thanks!

Changes from v1:

- Drop "swim3: end whole request on error" and "floppy: end whole
  request on error".
- Handle errors on individual bios correctly in the other drivers.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Laurent Vivier <lvivier@redhat.com>

1: https://github.com/osandov/linux/tree/mq-conversions.

Omar Sandoval (11):
  swim: fix cleanup on setup error
  swim: convert to blk-mq
  swim3: add real error handling in setup
  swim3: convert to blk-mq
  amiflop: fold headers into C file
  amiflop: clean up on errors during setup
  amiflop: convert to blk-mq
  ataflop: fold headers into C file
  ataflop: fix error handling during setup
  ataflop: convert to blk-mq
  floppy: convert to blk-mq

 arch/m68k/include/asm/atafd.h    |  13 --
 arch/m68k/include/asm/atafdreg.h |  80 --------
 drivers/block/amiflop.c          | 328 +++++++++++++++++++------------
 drivers/block/ataflop.c          | 283 +++++++++++++++-----------
 drivers/block/floppy.c           |  74 ++++---
 drivers/block/swim.c             | 114 ++++++-----
 drivers/block/swim3.c            | 219 ++++++++++-----------
 include/linux/amifd.h            |  63 ------
 include/linux/amifdreg.h         |  82 --------
 9 files changed, 590 insertions(+), 666 deletions(-)
 delete mode 100644 arch/m68k/include/asm/atafd.h
 delete mode 100644 arch/m68k/include/asm/atafdreg.h
 delete mode 100644 include/linux/amifd.h
 delete mode 100644 include/linux/amifdreg.h

-- 
2.19.1
