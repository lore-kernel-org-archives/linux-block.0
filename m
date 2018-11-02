Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/5] blk-mq: refactor and fix on issue request directly
Date: Fri,  2 Nov 2018 15:08:51 +0800
Message-Id: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens

These patch set refactors the code of issueing request driectly and
fix some defects.

The 1st patch make __blk_mq_issue_directly be able to accept NULL cookie
pointer.

The 2nd patch refactors the code of issue request directly.
It merges the blk_mq_try_issue_directly and __blk_mq_try_issue_directly
and make it handle the return value of .queue_rq itself.

The 3rd patch let the requests be inserted into hctx->dispatch when
the queue is stopped or quiesced if bypass is true.

The 4th patch make blk_mq_sched_insert_requests issue requests directly
with 'bypass' false, then it needn't to handle the non-issued requests
any more.

The 5th patch ensures the hctx to be ran on its mapped cpu in issue directly
path.

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
 - Add 1st and 2nd patch

Jianchao Wang (5)
blk-mq: make __blk_mq_issue_directly be able to accept
blk-mq: refactor the code of issue request directly
blk-mq: fix issue directly case when q is stopped or
blk-mq: issue directly with bypass 'false' in
blk-mq: ensure hctx to be ran on mapped cpu when issue

 block/blk-mq-sched.c |   8 ++-
 block/blk-mq.c       | 149 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 92 insertions(+), 65 deletions(-)

Thanks
Jianchao
