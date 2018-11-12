Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/6] blk-mq: refactor and fix on issue request directly
Date: Mon, 12 Nov 2018 17:23:23 +0800
Message-Id: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens

Please consider this patchset for 4.21.
It refactors the code of issue request directly to unify the interface
and make the code clearer and more readable, and also fixes two defects
there.

The 1st patch make __blk_mq_issue_directly be able to accept NULL cookie
pointer then we needn't the dummy unused_cookie.

The 2nd patch refactors the code of issue request directly to unify the
helper interface which could handle all the cases.

The 3rd patch fix the issue that when queue is stopped or quiesced request
may pass through bottom device's potential io scheduler.

The 4th patch fix the issue that hctx maybe ran on a cpu where it is not
mapped in issue directly path.

The 5th patch make blk_mq_sched_insert_requests issue requests directly
with 'bypass' false, then it needn't to handle the non-issued requests
any more.

The 6th patch replace and kill the one line blk_mq_request_issue_directly.

V5:
 - rebase against Jens' for-4.21/block branch
 - adjust the order of patch04 and patch05
 - add patch06 to replace and kill the one line blk_mq_request_bypass_insert
 - comment changes

V4:
 - split the original patch 1 into two patches, 1st and 2nd patch currently
 - rename the mq_decision to mq_issue_decision
 - comment changes

V3:
 - Correct the code about the case bypass_insert is true and io scheduler
   attached. The request still need to be issued in case above. (1/4)
 - Refactor the code to make code clearer. blk_mq_make_request is introduced
   to decide insert, end or just return based on the return value of .queue_rq
   and bypass_insert (1/4) 
 - Add the 2nd patch. It introduce a new decision result which indicates to
   insert request with blk_mq_request_bypass_insert.
 - Modify the code to adapt the new patch 1.

V2:
 - Add 1st and 2nd patch to refactor the code.

Jianchao Wang(6)
  blk-mq: make __blk_mq_issue_directly be able to accept NULL cookie pointer
  blk-mq: refactor the code of issue request directly
  blk-mq: fix issue directly case when q is stopped or quiesced
  blk-mq: ensure hctx to be ran on mapped cpu when issue directly
  blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
  blk-mq: replace and kill blk_mq_request_issue_directly

block/blk-core.c     |   2 +-
block/blk-mq-sched.c |   8 +--
block/blk-mq.c       | 156 +++++++++++++++++++++++++++++----------------------
block/blk-mq.h       |   6 +-
4 files changed, 97 insertions(+), 75 deletions(-)

Thanks
Jianchao
