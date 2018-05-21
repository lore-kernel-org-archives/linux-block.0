Return-Path: <prvs=672e5e3bd=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v12 0/2] blk-mq: Rework blk-mq timeout handling again
Date: Mon, 21 May 2018 10:16:50 -0700
Message-Id: <20180521171652.3021-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series reworks blk-mq timeout handling by introducing a state
machine per request. Please consider this patch series for inclusion in the
upstream kernel.

Bart.

Changes compared to v11:
- Reworked patch 1/2: instead of introducing CONFIG_ARCH_HAVE_CMPXCHG64, make
  sure that cmpxchg64() is only defined if it can be used.

Changes compared to v10:
- In patch 1/2, added "default y if 64BIT" to the "config ARCH_HAVE_CMPXCHG64"
  entry in arch/Kconfig. Left out the "select ARCH_HAVE_CMPXCHG64" statements
  that became superfluous due to this change (alpha, arm64, powerpc and s390).
- Also in patch 1/2, only select ARCH_HAVE_CMPXCHG64 if X86_CMPXCHG64 has been
  selected.
- In patch 2/2, moved blk_mq_change_rq_state() from blk-mq.h to blk-mq.c.
- Added a comment header above __blk_mq_requeue_request() and
  blk_mq_requeue_request().
- Documented the MQ_RQ_* state transitions in block/blk-mq.h.
- Left out the fourth argument of blk_mq_rq_set_deadline().

Changes compared to v9:
- Addressed multiple comments related to patch 1/2: added
  CONFIG_ARCH_HAVE_CMPXCHG64 for riscv, modified
  features/locking/cmpxchg64/arch-support.txt as requested and made the
  order of the symbols in the arch/*/Kconfig alphabetical where possible.

Changes compared to v8:
- Split into two patches.
- Moved the spin_lock_init() call from blk_mq_rq_ctx_init() into
  blk_mq_init_request().
- Fixed the deadline set by blk_add_timer().
- Surrounded the das_lock member with #ifndef CONFIG_ARCH_HAVE_CMPXCHG64 /
  #endif.

Changes compared to v7:
- Fixed the generation number mechanism. Note: with this patch applied the
  behavior of the block layer does not depend on the generation number.
- Added more 32-bit architectures to the list of architectures on which
  cmpxchg64() should not be used.

Changes compared to v6:
- Used a union instead of bit manipulations to store multiple values into
  a single 64-bit field.
- Reduced the size of the timeout field from 64 to 32 bits.
- Made sure that the block layer still builds with this patch applied
  for the sh and mips architectures.
- Fixed two sparse warnings that were introduced by this patch in the
  WRITE_ONCE() calls.

Changes compared to v5:
- Restored the synchronize_rcu() call between marking a request for timeout
  handling and the actual timeout handling to avoid that timeout handling
  starts while .queue_rq() is still in progress if the timeout is very short.
- Only use cmpxchg() if another context could attempt to change the request
  state concurrently. Use WRITE_ONCE() otherwise.

Changes compared to v4:
- Addressed multiple review comments from Christoph. The most important are
  that atomic_long_cmpxchg() has been changed into cmpxchg() and also that
  there is now a nice and clean split between the legacy and blk-mq versions
  of blk_add_timer().
- Changed the patch name and modified the patch description because there is
  disagreement about whether or not the v4.16 blk-mq core can complete a
  single request twice. Kept the "Cc: stable" tag because of
  https://bugzilla.kernel.org/show_bug.cgi?id=199077.

Changes compared to v3 (see also https://www.mail-archive.com/linux-block@vger.kernel.org/msg20073.html):
- Removed the spinlock again that was introduced to protect the request state.
  v4 uses atomic_long_cmpxchg() instead.
- Split __deadline into two variables - one for the legacy block layer and one
  for blk-mq.

Changes compared to v2 (https://www.mail-archive.com/linux-block@vger.kernel.org/msg18338.html):
- Rebased and retested on top of kernel v4.16.

Changes compared to v1 (https://www.mail-archive.com/linux-block@vger.kernel.org/msg18089.html):
- Removed the gstate and aborted_gstate members of struct request and used
  the __deadline member to encode both the generation and state information.

Bart Van Assche (2):
  ARM: cmpxchg64: Only define cmpxchg64() if not using the Thumb
    instruction set
  blk-mq: Rework blk-mq timeout handling again

 arch/arm/include/asm/cmpxchg.h |   4 +
 block/blk-core.c               |   6 --
 block/blk-mq-debugfs.c         |   1 -
 block/blk-mq.c                 | 238 +++++++++++++++++++----------------------
 block/blk-mq.h                 |  64 +++++------
 block/blk-timeout.c            | 133 +++++++++++++++--------
 block/blk.h                    |  11 +-
 include/linux/blkdev.h         |  48 +++++----
 8 files changed, 267 insertions(+), 238 deletions(-)

-- 
2.16.3
