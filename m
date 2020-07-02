Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEF4C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 10:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9A420772
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 10:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5jizEqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGBK6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgGBK6J (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 06:58:09 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEABC08C5C1;
        Thu,  2 Jul 2020 03:58:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so26743333lji.12;
        Thu, 02 Jul 2020 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=kKRrfxb90VfzoXGfhNPYe5HmgW3st+L4rXe9X50lhVE=;
        b=M5jizEqu0whp1mWCOc7mCG0MqJ+3nBdSSCWbYjY5AtvlruQJOFWkk/uOcem20L271/
         3OrK02PrH2xU5ivMXit67+Qt6HiQr9toxA4KYEvrjJEh5ndlN2/dnAZdTRvjRojL2qu6
         44qMR8N0qhwZkfTGIHltX+EPl9uvHZrOv48XPh2/7DaguUTkKZRbrORVc0bT9QxutjHY
         57hyQyF5gkCrbLfeH2gvcoaa5sIgdwyjrxFCqY5CXCDkv5G1Wmv6jHkD+OiQcHdePK+3
         mkdJLRyQAA1hlQH/954UswcQtHMtevAWNWOBQLfrDiI7q3siT8jqJIWYPIYQK5eRGkhf
         ULZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=kKRrfxb90VfzoXGfhNPYe5HmgW3st+L4rXe9X50lhVE=;
        b=gIQbyjBtIPnypwG8dcf0Wkh6ITFjTTWzZQQg6XeG0UH/XWoPqOFoWFv2E5Sn65yM7p
         i+ONTg0gAwimrkcsmd8qr17hNtO8YcAM275Zi1Kw9YGea7tJg+XDHGAzUACRQy+UKhS/
         GOohKyVt67H4CQo43ZIeTBFIweo4mswZ3YWim1M6O/mhjXDE8hvj9VWgFjBz5VhAyKTr
         hY0TQt91u0pJx30MwFiEnGtpqULWf9eE3fffgqnpGmuY/yrrFqBHjaS9KExS4/fPyRwW
         mEJcV/dZ5o3FzDiXAnhU8mMz4ZyI2EKyGnk5CJmuv6Yg0xtWCQsK5P6OTqSULc+6KAzU
         sDJw==
X-Gm-Message-State: AOAM533jZBCpbkjwBT1Gug1TgqsXEwHulSg6iBz0N3vc9yj8daX4Xkk/
        buvp35ImAo77tlgJxl5J1dZppYi8
X-Google-Smtp-Source: ABdhPJzdo/qQ2Z3Hfy5L+tGUBzoUfTRwMbyWzP0wyBFXT+6IRzG/dBG/3PUJwrvwJ689yjDxsm9qFQ==
X-Received: by 2002:a05:651c:222:: with SMTP id z2mr614115ljn.395.1593687487828;
        Thu, 02 Jul 2020 03:58:07 -0700 (PDT)
Received: from smtp.gmail.com (95.108.174.193-red.dhcp.yndx.net. [95.108.174.193])
        by smtp.gmail.com with ESMTPSA id n9sm3219097lfd.60.2020.07.02.03.58.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 03:58:07 -0700 (PDT)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, Dmitry Monakhov <dmonakhov@gmail.com>
Subject: [PATCH] bfq: fix blkio cgroup leakage
Date:   Thu,  2 Jul 2020 10:57:51 +0000
Message-Id: <20200702105751.20482-1-dmonakhov@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

commit db37a34c563b ("block, bfq: get a ref to a group when adding it to a service tree")
introduce leak forbfq_group and blkcg_gq objects because of get/put
imbalance. See trace balow:
-> blkg_alloc
   -> bfq_pq_alloc
     -> bfqg_get (+1)
->bfq_activate_bfqq
  ->bfq_activate_requeue_entity
    -> __bfq_activate_entity
       ->bfq_get_entity
         ->bfqg_and_blkg_get (+1)  <==== : Note1
->bfq_del_bfqq_busy
  ->bfq_deactivate_entity+0x53/0xc0 [bfq]
    ->__bfq_deactivate_entity+0x1b8/0x210 [bfq]
      -> bfq_forget_entity(is_in_service = true)
	 entity->on_st_or_in_serv = false   <=== :Note2
	 if (is_in_service)
	     return;  ==> do not touch reference
-> blkcg_css_offline
 -> blkcg_destroy_blkgs
  -> blkg_destroy
   -> bfq_pd_offline
    -> __bfq_deactivate_entity
         if (!entity->on_st_or_in_serv) /* true, because (Note2)
		return false;
 -> bfq_pd_free
    -> bfqg_put() (-1, byt bfqg->ref == 2) because of (Note2)
So bfq_group and blkcg_gq  will leak forever, see test-case below.
If fact bfq_group objects reference counting are quite different
from bfq_queue. bfq_groups object are referenced by blkcg_gq via
blkg_policy_data pointer, so  neither nor blkg_get() neither bfqg_get
required here.


This patch drop commit db37a34c563b ("block, bfq: get a ref to a group when adding it to a service tree")
and add corresponding comment.

##TESTCASE_BEGIN:
#!/bin/bash

max_iters=${1:-100}
#prep cgroup mounts
mount -t tmpfs cgroup_root /sys/fs/cgroup
mkdir /sys/fs/cgroup/blkio
mount -t cgroup -o blkio none /sys/fs/cgroup/blkio

# Prepare blkdev
grep blkio /proc/cgroups
truncate -s 1M img
losetup /dev/loop0 img
echo bfq > /sys/block/loop0/queue/scheduler

grep blkio /proc/cgroups
for ((i=0;i<max_iters;i++))
do
    mkdir -p /sys/fs/cgroup/blkio/a
    echo 0 > /sys/fs/cgroup/blkio/a/cgroup.procs
    dd if=/dev/loop0 bs=4k count=1 of=/dev/null iflag=direct 2> /dev/null
    echo 0 > /sys/fs/cgroup/blkio/cgroup.procs
    rmdir /sys/fs/cgroup/blkio/a
    grep blkio /proc/cgroups
done
##TESTCASE_END:

Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
---
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.h |  1 -
 block/bfq-wf2q.c    | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 68882b9..b791e20 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -332,7 +332,7 @@ static void bfqg_put(struct bfq_group *bfqg)
 		kfree(bfqg);
 }
 
-void bfqg_and_blkg_get(struct bfq_group *bfqg)
+static void bfqg_and_blkg_get(struct bfq_group *bfqg)
 {
 	/* see comments in bfq_bic_update_cgroup for why refcounting bfqg */
 	bfqg_get(bfqg);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index cd224aa..7038952 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -986,7 +986,6 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node);
-void bfqg_and_blkg_get(struct bfq_group *bfqg);
 void bfqg_and_blkg_put(struct bfq_group *bfqg);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 34ad095..6a363bb 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -529,13 +529,14 @@ static void bfq_get_entity(struct bfq_entity *entity)
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 
+	/* Grab reference only for bfq_queue's objects, bfq_group ones
+	 * are owned by blkcg_gq
+	 */
 	if (bfqq) {
 		bfqq->ref++;
 		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
 			     bfqq, bfqq->ref);
-	} else
-		bfqg_and_blkg_get(container_of(entity, struct bfq_group,
-					       entity));
+	}
 }
 
 /**
@@ -649,14 +650,8 @@ static void bfq_forget_entity(struct bfq_service_tree *st,
 
 	entity->on_st_or_in_serv = false;
 	st->wsum -= entity->weight;
-	if (is_in_service)
-		return;
-
-	if (bfqq)
+	if (bfqq && !is_in_service)
 		bfq_put_queue(bfqq);
-	else
-		bfqg_and_blkg_put(container_of(entity, struct bfq_group,
-					       entity));
 }
 
 /**
-- 
2.7.4

