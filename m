Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D60C77B7A
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 22:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEMWMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 18:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEMWMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 18:12:43 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9459C2D55
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 15:12:42 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75774360e46so415753385a.2
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684015961; x=1686607961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aorJbr2vWqTfz4xCQEc44dONwfNHEh7HNMggbMbeThc=;
        b=Zib5koM5wfL6dbup3SEFNbT3G2BDzKg+KVwvBqWK/cK7PVwumvI+rsffcwVnkT6Wj6
         FId6cEY9Ck4+ziUC4MJ80W0bkti/VETeDi4b/sDzFuBXYLiJYPdCS6919MaElLOhxUxX
         qARhhvfiplp13hsrFkX0FNrxkA4aXFg5ca5YTnw9Lg1R5Mt0luq2JvhdiJkE1jhClxfF
         YUB3yZ1VoKgs6rhHkroFqn0rn3SZJCDddQcea7qo+bmGeXUMkkyHhy1A0AoWwUssH8Wv
         TMRVyNrU37mmTYXjjh+rM8vtzxMbOX1tfeHJZrPab54D26hk6VZqbWdCWK2w8JPL0Vmj
         TOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684015961; x=1686607961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aorJbr2vWqTfz4xCQEc44dONwfNHEh7HNMggbMbeThc=;
        b=k5/jV3L8YPm0qwmCdD0MsofBJf+vKWXkKpc3QLDZiBIhnmsLua7UrstSOIFRr3vG5j
         srUCj0wYhwEzvVZ9XNnd0E88NgzfvYUcis2qwKhUrLbeUPnydOtY3rtivEjwJR9lcje6
         YX81Xio99hTp7X2jL/tAuyp+Cg935RjOVWkm3REjI3O+/F3w0IFh1Pj6T4inRKt6hWQy
         MCCgxc85h+ChP0K3ZhfCsiXzU6TieRQ2QMf+XzaWN4zLp7yt3RxYh3kzYXThWqRcWnQV
         IFzGsDzn0yDEcrs1QX4EJcq1v4XTkARgSM7/+z3mgYaEMrbTEH5V9iYHNpv6QgaR6GQl
         WreQ==
X-Gm-Message-State: AC+VfDy8XWjuI6jEEJwPjZHLHyR+fAd8gqvY5jtTCvZRBq9FlkZqE7rg
        ilOeNlSkGOIAUut2EVKW+vA=
X-Google-Smtp-Source: ACHHUZ4oZKjOS8COCGNpfZMECnSjYgydDhaCgYtEvQ1qobX9Zmu61JGoq7x171okr27z3jCEU8mp7g==
X-Received: by 2002:a05:6214:e46:b0:621:2641:c656 with SMTP id o6-20020a0562140e4600b006212641c656mr30753642qvc.31.1684015961578;
        Sat, 13 May 2023 15:12:41 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id t8-20020a05620a034800b0074ca7c33b79sm6239608qkm.23.2023.05.13.15.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 15:12:41 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     axboe@kernel.dk
Cc:     horms@kernel.org, linux-block@vger.kernel.org, lkp@intel.com,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tian.lan@twosigma.com, tilan7663@gmail.com
Subject: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Date:   Sat, 13 May 2023 18:12:27 -0400
Message-Id: <20230513221227.497327-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <892f5292-884b-42ef-fe24-05cfac56e527@kernel.dk>
References: <892f5292-884b-42ef-fe24-05cfac56e527@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tian Lan <tian.lan@twosigma.com>

The nr_active counter continues to increase over time which causes the
blk_mq_get_tag to hang until the thread is rescheduled to a different
core despite there are still tags available.

kernel-stack

  INFO: task inboundIOReacto:3014879 blocked for more than 2 seconds
  Not tainted 6.1.15-amd64 #1 Debian 6.1.15~debian11
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:inboundIOReacto state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
    Call Trace:
    <TASK>
    __schedule+0x351/0xa20
    scheduler+0x5d/0xe0
    io_schedule+0x42/0x70
    blk_mq_get_tag+0x11a/0x2a0
    ? dequeue_task_stop+0x70/0x70
    __blk_mq_alloc_requests+0x191/0x2e0

kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
__blk_mq_free_request being called.

  320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0 in-flight 1
         b'__blk_mq_free_request+0x1 [kernel]'
         b'bt_iter+0x50 [kernel]'
         b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
         b'blk_mq_timeout_work+0x7c [kernel]'
         b'process_one_work+0x1c4 [kernel]'
         b'worker_thread+0x4d [kernel]'
         b'kthread+0xe6 [kernel]'
         b'ret_from_fork+0x1f [kernel]'

Signed-off-by: Tian Lan <tian.lan@twosigma.com>
---
 block/blk-mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6dad0886a2f..850bfb844ed2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -683,6 +683,10 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
+
+	if (rq->rq_flags & RQF_MQ_INFLIGHT)
+		__blk_mq_dec_active_requests(hctx);
+
 	if (rq->tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
 	if (sched_tag != BLK_MQ_NO_TAG)
@@ -694,15 +698,11 @@ static void __blk_mq_free_request(struct request *rq)
 void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	if ((rq->rq_flags & RQF_ELVPRIV) &&
 	    q->elevator->type->ops.finish_request)
 		q->elevator->type->ops.finish_request(rq);
 
-	if (rq->rq_flags & RQF_MQ_INFLIGHT)
-		__blk_mq_dec_active_requests(hctx);
-
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->disk->bdi);
 
-- 
2.25.1

