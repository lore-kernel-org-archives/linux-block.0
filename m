Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEE6C10F0F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 23:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14326217D7
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 23:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfDDXtY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:49:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40771 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfDDXtY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 19:49:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id x12so5428844qts.7
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2019 16:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/NUbhdIMdPdC28SvvPXBU/DR7iBFS8yJCKKpQVE68o=;
        b=Va2qw18WmlRyfOdcfrnAvxojzmWz4jOnu9X9vgv4g9MC/icTpDyAL8c3VxaGkPIKHv
         DCueYNyOPWj7wSNW+nXZQn7T0JCRtiOZMhkENyJNLGD8LEr5Rh/8LM6lnkPZGSNOXEyq
         iW8UACaH2uuaqBjKdfK5bODa3AMzT4GZAQv0BBtvXGBUHkNJ+u4htJEQ/QD4WWHxhkRq
         AX/zTg5oIPuGmFlCHa3znS7Fs0TOm72VSs+Fr18asgqT+XlkPo7qg8y0xhSPD+dvg2ry
         I+qzeWFp+UeREqCwEVPjl/LKUbVP05GFHeY4YoE2aXa8DF8C8krp51Ccfc6L1RyfgEmA
         f/yw==
X-Gm-Message-State: APjAAAWahRYGinSnml+/JbQkbRjEE0vzfzzb8Cx/k/LSSfiFVH4DU3cs
        ZCZlaovINIXAR6OpU8v6zSgWkA==
X-Google-Smtp-Source: APXvYqzQYaWalERl1ungDxSpFVCTf0lOBJ+N2mDmas9MYP06rSntObFcMV+akfDk0JPebGGjoB4jXQ==
X-Received: by 2002:a0c:9e56:: with SMTP id z22mr7256822qve.173.1554421762630;
        Thu, 04 Apr 2019 16:49:22 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:422c:9885:a6c:81b2])
        by smtp.gmail.com with ESMTPSA id t69sm10632828qke.38.2019.04.04.16.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 16:49:21 -0700 (PDT)
Message-ID: <3e18326f005b201b889e2bd8365d289d1918bfe9.camel@redhat.com>
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly()
 changes
From:   Laurence Oberman <loberman@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Date:   Thu, 04 Apr 2019 19:49:19 -0400
In-Reply-To: <20190404214344.GA30656@ming.t460p>
References: <20190404170843.83517-1-bvanassche@acm.org>
         <20190404214344.GA30656@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-04-05 at 05:43 +0800, Ming Lei wrote:
> On Thu, Apr 04, 2019 at 10:08:43AM -0700, Bart Van Assche wrote:
> > blk_mq_try_issue_directly() can return BLK_STS*_RESOURCE for
> > requests that
> > have been queued. If that happens when blk_mq_try_issue_directly()
> > is called
> > by the dm-mpath driver then dm-mpath will try to resubmit a request
> > that is
> > already queued and a kernel crash follows. Since it is nontrivial
> > to fix
> > blk_mq_request_issue_directly(), revert the
> > blk_mq_request_issue_directly()
> > changes that went into kernel v5.0.
> > 
> > This patch reverts the following commits:
> > * d6a51a97c0b2 ("blk-mq: replace and kill
> > blk_mq_request_issue_directly") # v5.0.
> > * 5b7a6f128aad ("blk-mq: issue directly with bypass 'false' in
> > blk_mq_sched_insert_requests") # v5.0.
> > * 7f556a44e61d ("blk-mq: refactor the code of issue request
> > directly") # v5.0.
> 
> I am fine to revert them now.
> 
> However, could you revert them one by one so that they can be
> reviewed
> easily?
> 
> Thanks,
> Ming

Hello Ming
I did them 1 by 1 here for you


commit cff8d4710f8cc0817950942252bcf0809a95aa4a
Author: Laurence Oberman <loberman@ibclient.lab.eng.bos.redhat.com>
Date:   Thu Apr 4 19:51:33 2019 -0400

    Revert "blk-mq: replace and kill blk_mq_request_issue_directly"
    
    This reverts commit d6a51a97c0b2e21fec224746c2683ff739bcf4ae.

diff --git a/block/blk-core.c b/block/blk-core.c
index 4673ebe..a55389b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1245,8 +1245,6 @@ static int blk_cloned_rq_check_limits(struct
request_queue *q,
  */
 blk_status_t blk_insert_cloned_request(struct request_queue *q, struct
request *rq)
 {
-       blk_qc_t unused;
-
        if (blk_cloned_rq_check_limits(q, rq))
                return BLK_STS_IOERR;
 
@@ -1262,7 +1260,7 @@ blk_status_t blk_insert_cloned_request(struct
request_queue *q, struct request *
         * bypass a potential scheduler on the bottom device for
         * insert.
         */
-       return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused,
true, true);
+       return blk_mq_request_issue_directly(rq, true);
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ff3d7b..536b176 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1800,7 +1800,7 @@ static blk_status_t
__blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
        return ret;
 }
 
-blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx
*hctx,
                                                struct request *rq,
                                                blk_qc_t *cookie,
                                                bool bypass, bool last)
@@ -1872,6 +1872,13 @@ blk_status_t blk_mq_try_issue_directly(struct
blk_mq_hw_ctx *hctx,
        return ret;
 }
 
+blk_status_t blk_mq_request_issue_directly(struct request *rq, bool
last)
+{
+       blk_qc_t unused;
+
+       return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused,
true, last);
+}
+
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
                struct list_head *list)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d704fc7..423ea88 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -70,10 +70,8 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx
*hctx, struct request *rq,
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct
blk_mq_ctx *ctx,
                                struct list_head *list);
 
-blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-                                               struct request *rq,
-                                               blk_qc_t *cookie,
-                                               bool bypass, bool
last);
+/* Used by blk_insert_cloned_request() to issue request directly */
+blk_status_t blk_mq_request_issue_directly(struct request *rq, bool
last);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
                                    struct list_head *list);


commit 9b7f3de27504aefae8304dfd9640a1477599de8b
Author: Laurence Oberman <loberman@ibclient.lab.eng.bos.redhat.com>
Date:   Thu Apr 4 19:53:23 2019 -0400

    Revert "blk-mq: issue directly with bypass 'false' in
blk_mq_sched_insert_requests"
    
    This reverts commit 5b7a6f128aad761b471ca0ff620b4841b38e596f.

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4090553..aa6bc5c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -423,10 +423,12 @@ void blk_mq_sched_insert_requests(struct
blk_mq_hw_ctx *hctx,
                 * busy in case of 'none' scheduler, and this way may
save
                 * us one extra enqueue & dequeue to sw queue.
                 */
-               if (!hctx->dispatch_busy && !e && !run_queue_async)
+               if (!hctx->dispatch_busy && !e && !run_queue_async) {
                        blk_mq_try_issue_list_directly(hctx, list);
-               else
-                       blk_mq_insert_requests(hctx, ctx, list);
+                       if (list_empty(list))
+                               return;
+               }
+               blk_mq_insert_requests(hctx, ctx, list);
        }
 
        blk_mq_run_hw_queue(hctx, run_queue_async);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 536b176..df2150e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1882,20 +1882,22 @@ blk_status_t
blk_mq_request_issue_directly(struct request *rq, bool last)
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
                struct list_head *list)
 {
-       blk_qc_t unused;
-       blk_status_t ret = BLK_STS_OK;
-
        while (!list_empty(list)) {
+               blk_status_t ret;
                struct request *rq = list_first_entry(list, struct
request,
                                queuelist);
 
                list_del_init(&rq->queuelist);
-               if (ret == BLK_STS_OK)
-                       ret = blk_mq_try_issue_directly(hctx, rq,
&unused,
-                                                       false,
+               ret = blk_mq_request_issue_directly(rq,
list_empty(list));
+               if (ret != BLK_STS_OK) {
+                       if (ret == BLK_STS_RESOURCE ||
+                                       ret == BLK_STS_DEV_RESOURCE) {
+                               blk_mq_request_bypass_insert(rq,
                                                        list_empty(list
));
-               else
-                       blk_mq_sched_insert_request(rq, false, true,
false);
+                               break;
+                       }
+                       blk_mq_end_request(rq, ret);
+               }
        }
 
        /*
@@ -1903,7 +1905,7 @@ void blk_mq_try_issue_list_directly(struct
blk_mq_hw_ctx *hctx,
         * the driver there was more coming, but that turned out to
         * be a lie.
         */
-       if (ret != BLK_STS_OK && hctx->queue->mq_ops->commit_rqs)
+       if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
                hctx->queue->mq_ops->commit_rqs(hctx);
 }


commit 6db32dc1b5cb3d236f26f77947094f1d895ba557
Author: Laurence Oberman <loberman@ibclient.lab.eng.bos.redhat.com>
Date:   Thu Apr 4 19:54:28 2019 -0400

    Revert "blk-mq: refactor the code of issue request directly"
    
    This reverts commit 7f556a44e61d0b62d78db9a2662a5f0daef010f2.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df2150e..afac6c2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1800,83 +1800,78 @@ static blk_status_t
__blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
        return ret;
 }
 
-static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx
*hctx,
+static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx
*hctx,
                                                struct request *rq,
                                                blk_qc_t *cookie,
-                                               bool bypass, bool last)
+                                               bool bypass_insert,
bool last)
 {
        struct request_queue *q = rq->q;
        bool run_queue = true;
-       blk_status_t ret = BLK_STS_RESOURCE;
-       int srcu_idx;
-       bool force = false;
 
-       hctx_lock(hctx, &srcu_idx);
        /*
-        * hctx_lock is needed before checking quiesced flag.
+        * RCU or SRCU read lock is needed before checking quiesced
flag.
         *
-        * When queue is stopped or quiesced, ignore 'bypass', insert
-        * and return BLK_STS_OK to caller, and avoid driver to try to
-        * dispatch again.
+        * When queue is stopped or quiesced, ignore 'bypass_insert'
from
+        * blk_mq_request_issue_directly(), and return BLK_STS_OK to
caller,
+        * and avoid driver to try to dispatch again.
         */
-       if (unlikely(blk_mq_hctx_stopped(hctx) ||
blk_queue_quiesced(q))) {
+       if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
                run_queue = false;
-               bypass = false;
-               goto out_unlock;
+               bypass_insert = false;
+               goto insert;
        }
 
-       if (unlikely(q->elevator && !bypass))
-               goto out_unlock;
+       if (q->elevator && !bypass_insert)
+               goto insert;
 
        if (!blk_mq_get_dispatch_budget(hctx))
-               goto out_unlock;
+               goto insert;
 
        if (!blk_mq_get_driver_tag(rq)) {
                blk_mq_put_dispatch_budget(hctx);
-               goto out_unlock;
+               goto insert;
        }
 
-       /*
-        * Always add a request that has been through
-        *.queue_rq() to the hardware dispatch list.
-        */
-       force = true;
-       ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
-out_unlock:
-       hctx_unlock(hctx, srcu_idx);
-       switch (ret) {
-       case BLK_STS_OK:
-               break;
-       case BLK_STS_DEV_RESOURCE:
-       case BLK_STS_RESOURCE:
-               if (force) {
-                       blk_mq_request_bypass_insert(rq, run_queue);
-                       /*
-                        * We have to return BLK_STS_OK for the DM
-                        * to avoid livelock. Otherwise, we return
-                        * the real result to indicate whether the
-                        * request is direct-issued successfully.
-                        */
-                       ret = bypass ? BLK_STS_OK : ret;
-               } else if (!bypass) {
-                       blk_mq_sched_insert_request(rq, false,
-                                                   run_queue, false);
-               }
-               break;
-       default:
-               if (!bypass)
-                       blk_mq_end_request(rq, ret);
-               break;
-       }
+       return __blk_mq_issue_directly(hctx, rq, cookie, last);
+insert:
+       if (bypass_insert)
+               return BLK_STS_RESOURCE;
 
-       return ret;
+       blk_mq_request_bypass_insert(rq, run_queue);
+       return BLK_STS_OK;
+}
+
+static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+               struct request *rq, blk_qc_t *cookie)
+{
+       blk_status_t ret;
+       int srcu_idx;
+
+       might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
+
+       hctx_lock(hctx, &srcu_idx);
+
+       ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false,
true);
+       if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
+               blk_mq_request_bypass_insert(rq, true);
+       else if (ret != BLK_STS_OK)
+               blk_mq_end_request(rq, ret);
+
+       hctx_unlock(hctx, srcu_idx);
 }
 
 blk_status_t blk_mq_request_issue_directly(struct request *rq, bool
last)
 {
-       blk_qc_t unused;
+       blk_status_t ret;
+       int srcu_idx;
+       blk_qc_t unused_cookie;
+       struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-       return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused,
true, last);
+       hctx_lock(hctx, &srcu_idx);
+       ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie,
true, last);
+       hctx_unlock(hctx, srcu_idx);
+
+       return ret;
 }
 
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
@@ -2018,13 +2013,13 @@ static blk_qc_t blk_mq_make_request(struct
request_queue *q, struct bio *bio)
                if (same_queue_rq) {
                        data.hctx = same_queue_rq->mq_hctx;
                        blk_mq_try_issue_directly(data.hctx,
same_queue_rq,
-                                       &cookie, false, true);
+                                       &cookie);
                }
        } else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
                        !data.hctx->dispatch_busy)) {
                blk_mq_put_ctx(data.ctx);
                blk_mq_bio_to_request(rq, bio);
-               blk_mq_try_issue_directly(data.hctx, rq, &cookie,
false, true);
+               blk_mq_try_issue_directly(data.hctx, rq, &cookie);
        } else {
                blk_mq_put_ctx(data.ctx);
                blk_mq_bio_to_request(rq, bio);

