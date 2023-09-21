Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA07CE7D0A9
	for <linux-block@archiver.kernel.org>; Thu, 21 Sep 2023 20:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjIUUbH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjIUUag (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2023 16:30:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8772BCFF33
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2023 11:20:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so23803577b3.1
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2023 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695320434; x=1695925234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hw98Zupb8UHh+CqlMSyJaPhi0/ITpRz5yyNHO/GwHao=;
        b=OXQoiftLHS+vkpFjzdG4wZSNGwcqJ3uPKs1hCgcLuhDOUa4fAa3bxLzV4wOcS0nGfv
         jlj4CgYH2GaRKu5Cq3oAYiPW+xjn96HA+p76PI9twOmKaJ+L7bgv53lV0Mn2nOol+kqR
         X3RmpKfHu0vlGMA+l+CDDPoXyLx8VAZrNL6FR48BTXykeqvmQNui27vq02b6x+TGSX/C
         gIo6cVMxXeBCl3dKBFCkLgZWryF0nHyzwDvlR9XZArQ6MZ6vzCkHtqPVSlUJSnPsp0xC
         l3q7GCXxUPoxoaXo2qfeu/Stf6uHSEPELPvNgIAkcPvtaQuIXlN1nrI3L7UUrhVssir0
         ZV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320434; x=1695925234;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hw98Zupb8UHh+CqlMSyJaPhi0/ITpRz5yyNHO/GwHao=;
        b=OF+rxvq0/Dxb9Sg5eNPJmldp7oLIL+d+XCNuDuFicOslDi6C3HMon5s3k/Qh5Ll4kk
         RfaGjv6I1gCzbdHUv/Qjz+6BRj6AZh9XVlqmM0fNYx4lYRkxzvMhkfxkmcvc1gzdpkWy
         TO3mQJpTk7yFGf1P/8lsMbH6ee2KWhwstrrEveK3pKNhP8stbS1MfKCCUao38KYIDhI8
         ZPTCuYpWfjop7su2PLPVkdN/vqIZfg9CDDdo3V31Q5rf1xV472OndWqK83EHLeryEKEy
         i+81azvIYfJLJyCd/0QXnSOFMpSUpw5e4RWD7SYNdixoigyk0XwVjUltfgfbCCqEI9hC
         QhTg==
X-Gm-Message-State: AOJu0YysRQgUx8d2uUtd/uQym5FXaur4ktr5grdlH/GQI/zimPo/cPCY
        RbN6pUZIBc9YSCWOgljimK0Oxj7MJ0DAmmRj8sM=
X-Google-Smtp-Source: AGHT+IGJgoOxhF4DLozb4xqhSavBmQjQaAZ2tyi0n+ac2tz4zDa9tN5xGVxVwr2RHxAucdD+d6PFSGiWcoQHHGhxMjY=
X-Received: from saranyamohan.svl.corp.google.com ([2620:15c:2a3:200:5dbd:3ff1:e146:3806])
 (user=saranyamohan job=sendgmr) by 2002:a05:690c:831:b0:589:a533:405b with
 SMTP id by17-20020a05690c083100b00589a533405bmr6592ywb.3.1695320434564; Thu,
 21 Sep 2023 11:20:34 -0700 (PDT)
Date:   Thu, 21 Sep 2023 11:20:12 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921182012.3965572-1-saranyamohan@google.com>
Subject: [PATCH] block: fix use-after-free of q->q_usage_counter
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Wensheng <zhangwensheng@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Hillf Danton <hdanton@sina.com>, Yu Kuai <yukuai3@huawei.com>,
        Dennis Zhou <dennis@kernel.org>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

commit d36a9ea5e7766961e753ee38d4c331bbe6ef659b upstream.

For blk-mq, queue release handler is usually called after
blk_mq_freeze_queue_wait() returns. However, the
q_usage_counter->release() handler may not be run yet at that time, so
this can cause a use-after-free.

Fix the issue by moving percpu_ref_exit() into blk_free_queue_rcu().
Since ->release() is called with rcu read lock held, it is agreed that
the race should be covered in caller per discussion from the two links.

Backport-notes: Not a clean cherry-pick since a lot has changed,
however essentially the same fix.

Reported-by: Zhang Wensheng <zhangwensheng@huaweicloud.com>
Reported-by: Zhong Jinghua <zhongjinghua@huawei.com>
Link: https://lore.kernel.org/linux-block/Y5prfOjyyjQKUrtH@T590/T/#u
Link: https://lore.kernel.org/lkml/Y4%2FmzMd4evRg9yDi@fedora/
Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Dennis Zhou <dennis@kernel.org>
Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20221215021629.74870-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 block/blk-core.c  | 2 --
 block/blk-sysfs.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0d0dd8151f7..e5eeec801f56 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -414,8 +414,6 @@ void blk_cleanup_queue(struct request_queue *q)
 		blk_mq_sched_free_requests(q);
 	mutex_unlock(&q->sysfs_lock);
 
-	percpu_ref_exit(&q->q_usage_counter);
-
 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 8c5816364dd1..9174137a913c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -726,6 +726,8 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 {
 	struct request_queue *q = container_of(rcu_head, struct request_queue,
 					       rcu_head);
+
+	percpu_ref_exit(&q->q_usage_counter);
 	kmem_cache_free(blk_requestq_cachep, q);
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog

