Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESENT V3 0/4] blk-mq: refactor and fix on issue request directly
Date: Mon, 29 Oct 2018 16:49:07 +0800
Message-Id: <1540802951-5408-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens

The 1st patch refactors the code of issue request directly.
It merges the blk_mq_try_issue_directly and __blk_mq_try_issue_directly
and make it handle the return value of .queue_rq itself.

The 2nd patch let the requests be inserted into hctx->dispatch when
the queue is stopped or quiesced if bypass_insert is true.

The 3rd patch make blk_mq_sched_insert_requests issue requests directly
with 'bypass_insert' false, then it needn't to handle the non-issued requests
any more.

The 4th patch ensures the hctx to be ran on its mapped cpu in issue directly
path.

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

Jianchao Wang(4)
blk-mq: refactor the code of issue request directly
blk-mq: insert request without involving any io
blk-mq: issue directly with bypass_insert 'false' in
blk-mq: ensure hctx to be ran on mapped cpu when issue

 block/blk-mq-sched.c |   8 ++-
 block/blk-mq.c       | 139 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 86 insertions(+), 61 deletions(-)

Thanks
Jianchao
