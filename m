Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0002C49ED9
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 04:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886A121A4C
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 04:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfILERL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 00:17:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfILERL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 00:17:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D0E08A218D;
        Thu, 12 Sep 2019 04:17:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65D3E5C22C;
        Thu, 12 Sep 2019 04:17:03 +0000 (UTC)
Date:   Thu, 12 Sep 2019 12:16:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@infradead.org,
        keith.busch@intel.com, tj@kernel.org, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] block: fix null pointer dereference in
 blk_mq_rq_timed_out()
Message-ID: <20190912041658.GA5020@ming.t460p>
References: <20190907102450.40291-1-yuyufen@huawei.com>
 <20190912024618.GE2731@ming.t460p>
 <b3d7b459-5f31-d473-2508-20048119c1b2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d7b459-5f31-d473-2508-20048119c1b2@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Thu, 12 Sep 2019 04:17:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 12, 2019 at 11:29:18AM +0800, Yufen Yu wrote:
> 
> 
> On 2019/9/12 10:46, Ming Lei wrote:
> > On Sat, Sep 07, 2019 at 06:24:50PM +0800, Yufen Yu wrote:
> > > There is a race condition between timeout check and completion for
> > > flush request as follow:
> > > 
> > > timeout_work    issue flush      issue flush
> > >                  blk_insert_flush
> > >                                   blk_insert_flush
> > > blk_mq_timeout_work
> > >                  blk_kick_flush
> > > 
> > > blk_mq_queue_tag_busy_iter
> > > blk_mq_check_expired(flush_rq)
> > > 
> > >                  __blk_mq_end_request
> > >                 flush_end_io
> > >                 blk_kick_flush
> > >                 blk_rq_init(flush_rq)
> > >                 memset(flush_rq, 0)
> > Not see there is memset(flush_rq, 0) in block/blk-flush.c
> 
> Call path as follow:
> 
> blk_kick_flush
>     blk_rq_init
>         memset(rq, 0, sizeof(*rq));

Looks I miss this one in blk_rq_init(), sorry for that.

Given there are only two users of blk_rq_init(), one simple fix could be
not clearing queue in blk_rq_init(), something like below?

diff --git a/block/blk-core.c b/block/blk-core.c
index 77807a5d7f9e..25e6a045c821 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -107,7 +107,9 @@ EXPORT_SYMBOL_GPL(blk_queue_flag_test_and_set);
 
 void blk_rq_init(struct request_queue *q, struct request *rq)
 {
-	memset(rq, 0, sizeof(*rq));
+	const int offset = offsetof(struct request, q);
+
+	memset((void *)rq + offset, 0, sizeof(*rq) - offset);
 
 	INIT_LIST_HEAD(&rq->queuelist);
 	rq->q = q;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ac790178787..382e71b8787d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -130,7 +130,7 @@ enum mq_rq_state {
  * especially blk_mq_rq_ctx_init() to take care of the added fields.
  */
 struct request {
-	struct request_queue *q;
+	struct request_queue *q;	/* Must be the 1st field */
 	struct blk_mq_ctx *mq_ctx;
 	struct blk_mq_hw_ctx *mq_hctx;
 

Thanks,
Ming
