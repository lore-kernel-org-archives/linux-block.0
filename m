Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jack@suse.cz,
	axboe@kernel.dk,
	clm@fb.com,
	jbacik@fb.com
Cc: kernel-team@fb.com,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	peterz@infradead.org,
	jianchao.w.wang@oracle.com,
	Bart.VanAssche@wdc.com,
	linux-block@vger.kernel.org
Subject: [PATCHSET v4] blk-mq: reimplement timeout handling
Date: Mon,  8 Jan 2018 11:15:34 -0800
Message-Id: <20180108191542.379478-1-tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>

Hello,

Changes from [v3]

- Rebased on top of for-4.16/block.

- Integrated Jens's hctx_[un]lock() factoring patch and refreshed the
  patches accordingly.

- Added comment explaining the use of hctx_lock() instead of
  rcu_read_lock() in completion path.

Changes from [v2]

- Possible extended looping around seqcount and u64_stat_sync fixed.

- Misplaced MQ_RQ_IDLE state setting fixed.

- RQF_MQ_TIMEOUT_EXPIRED added to prevent firing the same timeout
  multiple times.

- s/queue_rq_src/srcu/ patch added.

- Other misc changes.

Changes from [v1]

- BLK_EH_RESET_TIMER handling fixed.

- s/request->gstate_seqc/request->gstate_seq/

- READ_ONCE() added to blk_mq_rq_udpate_state().

- Removed left over blk_clear_rq_complete() invocation from
  blk_mq_rq_timed_out().

Currently, blk-mq timeout path synchronizes against the usual
issue/completion path using a complex scheme involving atomic
bitflags, REQ_ATOM_*, memory barriers and subtle memory coherence
rules.  Unfortunatley, it contains quite a few holes.

It's pretty easy to make blk_mq_check_expired() terminate a later
instance of a request.  If we induce 5 sec delay before
time_after_eq() test in blk_mq_check_expired(), shorten the timeout to
2s, and issue back-to-back large IOs, blk-mq starts timing out
requests spuriously pretty quickly.  Nothing actually timed out.  It
just made the call on a recycle instance of a request and then
terminated a later instance long after the original instance finished.
The scenario isn't theoretical either.

This patchset replaces the broken synchronization mechanism with a RCU
and generation number based one.  Please read the patch description of
the second path for more details.

This patchset contains the following eight patches.

0001-blk-mq-move-hctx-lock-unlock-into-a-helper.patch
0002-blk-mq-protect-completion-path-with-RCU.patch
0003-blk-mq-replace-timeout-synchronization-with-a-RCU-an.patch
0004-blk-mq-use-blk_mq_rq_state-instead-of-testing-REQ_AT.patch
0005-blk-mq-make-blk_abort_request-trigger-timeout-path.patch
0006-blk-mq-remove-REQ_ATOM_COMPLETE-usages-from-blk-mq.patch
0007-blk-mq-remove-REQ_ATOM_STARTED.patch
0008-blk-mq-rename-blk_mq_hw_ctx-queue_rq_srcu-to-srcu.patch

and is available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git blk-mq-timeout-v4

diffstat follows.  Thanks.

 block/blk-core.c       |    2 
 block/blk-mq-debugfs.c |    4 
 block/blk-mq.c         |  340 ++++++++++++++++++++++++++++---------------------
 block/blk-mq.h         |   49 ++++++-
 block/blk-timeout.c    |   11 -
 block/blk.h            |    7 -
 include/linux/blk-mq.h |    3 
 include/linux/blkdev.h |   25 +++
 8 files changed, 283 insertions(+), 158 deletions(-)

--
tejun

[v3] http://lkml.kernel.org/r/20171216120726.517153-1-tj@kernel.org
[v2] http://lkml.kernel.org/r/20171010155441.753966-1-tj@kernel.org
[v1] http://lkml.kernel.org/r/20171209192525.982030-1-tj@kernel.org
