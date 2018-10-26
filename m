Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] blk-mq: refactor and fix on issue request directly
Date: Sat, 27 Oct 2018 00:01:08 +0800
Message-Id: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens

The 1st patch refactors the code of issue request directly.
It merges the blk_mq_try_issue_directly and __blk_mq_try_issue_directly
and make blk_mq_try_issue_directly handle return value of .queue_rq itself.

The 2nd patch make blk_mq_sched_insert_requests issue request directly with
bypass "false" instead of the "true", then needn't to handle the non-issued
requests any more.

The 3rd patch ensures the hctx to be ran on its mapped cpu in issue directly
path.

V2:
 - Add 1st and 2nd patch.

Jianchao Wang(3)
    blk-mq: refactor the code of issue request directly
    blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
    blk-mq: ensure hctx to be ran on mapped cpu when issue

 block/blk-mq-sched.c |   8 ++--
 block/blk-mq.c       | 128 ++++++++++++++++++++++++---------------------------
 2 files changed, 63 insertions(+), 73 deletions(-)
