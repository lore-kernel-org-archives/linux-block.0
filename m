Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.13-rc
Message-ID: <feb795dd-1bcf-e79a-22ed-3a829f5beeb8@kernel.dk>
Date: Wed, 9 Aug 2017 08:19:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Three patches that should go into this release. Two of them are from
Paolo and fix up some corner cases with BFQ, and the last patch is from
Ming and fixes up a potential usage count imbalance regression in this
series, due to the NOWAIT work that went in.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Ming Lei (1):
      blk-mq: don't leak preempt counter/q_usage_counter when allocating rq failed

Paolo Valente (2):
      block, bfq: reset in_service_entity if it becomes idle
      block, bfq: consider also in_service_entity to state whether an entity is active

 block/bfq-iosched.h |  22 ++++++--
 block/bfq-wf2q.c    | 146 +++++++++++++++++++++++++++++-----------------------
 block/blk-mq.c      |  17 +++---
 3 files changed, 109 insertions(+), 76 deletions(-)

-- 
Jens Axboe
