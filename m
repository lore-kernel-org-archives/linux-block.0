Return-Path: <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <lvivier@redhat.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org,
    stable@vger.kernel.org
Message-Id: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 00/10] SWIM driver fixes
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
List-ID: <linux-block@vger.kernel.org>

This patch series has fixes for bugs in the SWIM floppy disk controller
driver, including an oops and a soft lockup.

One way to apply these patches to v4.14+ is by first cherry-picking
these commits:
b87eaec27eca3def6c8ed617e3b1bac08d7bc715
e5f0d2e2a153b18dcf31e1a633e210c37829d759
There are of course other ways to fix the patch rejects, but this way
would be convenient for me because it would simplify my own backporting.

Changes since v1:
- Dropped the two IOP patches as they aren't simple fixes. This way,
  the entire series is suitable for stable trees.
- Added Cc, Fixes, Acked-by and Reviewed-by tags.


Finn Thain (10):
  m68k/mac: Revisit floppy disc controller base addresses
  m68k/mac: Fix SWIM memory resource end address
  m68k/mac: Don't remap SWIM MMIO region
  block/swim: Fix array bounds check
  block/swim: Remove extra put_disk() call from error path
  block/swim: Don't log an error message for an invalid ioctl
  block/swim: Rename macros to avoid inconsistent inverted logic
  block/swim: Check drive type
  block/swim: Fix IO error at end of medium
  block/swim: Select appropriate drive on device open

 arch/m68k/include/asm/macintosh.h |  10 +--
 arch/m68k/mac/config.c            | 126 ++++++++++++++++++++------------------
 drivers/block/swim.c              |  49 +++++++--------
 drivers/block/swim3.c             |   6 +-
 4 files changed, 96 insertions(+), 95 deletions(-)

-- 
2.16.1
