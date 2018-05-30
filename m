Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, osandov@osandov.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/2] block: kyber: make kyber more friendly with merging
Date: Wed, 30 May 2018 15:26:06 +0800
Message-Id: <1527665168-1965-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens

This is the 3rd version patchset to make the kyber io scheduler more firendly
with merging.

Most of time, kyber io scheduler will not leave any requests in ctx rq_list,
this is because even if tokens of one domain is used up, kyber will try to
dispatch requests from other domain and flush the rq_list there. So there is not
any change to do merge.

To improve this, setup kyber_ctx_queue (kcq) which is similar with blk_mq_ctx but has
rq_list for every domain, and build mapping between kcq and khd as ctx and hctx.
Then we could merge, insert and dispatch on rq_list of different domains separately.
At the same time, only flush the rq_list of kcq after get domain token
successfully, then the requests could be left in the rq_list of that domain and 
maybe merged with following io. In my local test on NVMe card, the sequential io
performance could be improved a lot, especially on high workload. More details
please refer to the second patch.

Changes V2 to V3:
 - discard kcq->index and use request->mq_ctx->index_hw
 - changes based on Omar's suggestion
 - some other changes to fix warning of checkpatch.pl with --strict option

Changes V1 to V2:
 - Add patch from Jens which abstract out the blk-mq-sched rq list iteration bio
 merge helper interface and rebase the patch based on it.
 - merge bio_sched_domain and rq_sched_domain to avoid the duplicated code.
 - allocate kcqs per khd

Jens Axboe (1)
0001-blk-mq-abstract-out-blk-mq-sched-rq-list-iteration-b.patch

Jianchao Wang (1)
0002-block-kyber-make-kyber-more-friendly-with-merging.patch

 block/blk-mq-sched.c   |  34 ++++++++++++------
 block/kyber-iosched.c  | 190 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 include/linux/blk-mq.h |   3 +-
 3 files changed, 184 insertions(+), 43 deletions(-)


Thanks
Jianchao
