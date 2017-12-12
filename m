Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	kernel-team@fb.com,
	osandov@fb.com,
	linux-block@vger.kernel.org,
	hch@lst.de
Subject: [PATCHSET v2] blk-mq: reimplement timeout handling
Date: Tue, 12 Dec 2017 11:01:28 -0800
Message-Id: <20171212190134.535941-1-tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>

Changes from the last version[1]

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

This patchset contains the following six patches.

 0001-blk-mq-protect-completion-path-with-RCU.patch
 0002-blk-mq-replace-timeout-synchronization-with-a-RCU-an.patch
 0003-blk-mq-use-blk_mq_rq_state-instead-of-testing-REQ_AT.patch
 0004-blk-mq-make-blk_abort_request-trigger-timeout-path.patch
 0005-blk-mq-remove-REQ_ATOM_COMPLETE-usages-from-blk-mq.patch
 0006-blk-mq-remove-REQ_ATOM_STARTED.patch

and is available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git blk-mq-timeout

diffstat follows.  Thanks.

 block/blk-core.c       |    2 
 block/blk-mq-debugfs.c |    4 
 block/blk-mq.c         |  255 ++++++++++++++++++++++++++++---------------------
 block/blk-mq.h         |   48 ++++++++-
 block/blk-timeout.c    |    9 -
 block/blk.h            |    7 -
 include/linux/blk-mq.h |    1 
 include/linux/blkdev.h |   23 ++++
 8 files changed, 226 insertions(+), 123 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20171209192525.982030-1-tj@kernel.org
