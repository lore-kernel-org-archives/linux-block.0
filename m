Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E827DC43460
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 00:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF48A61396
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 00:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhDEA2x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Apr 2021 20:28:53 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:45651 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhDEA2r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Apr 2021 20:28:47 -0400
Received: by mail-pg1-f176.google.com with SMTP id d10so2264306pgf.12
        for <linux-block@vger.kernel.org>; Sun, 04 Apr 2021 17:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jdw7IUbjEHsW4gVeAnRemrrLcSamlKgxgELWUtZYqK8=;
        b=kBSVzNxVaO/mJQZ1XujRDpHw+AoN90uvO88jbqHinq7vPoeINPuDqIL72YgyqOKotR
         ZPm/mh/rp3CI2204MGYYF9IevpBV5PhbjhJU8MkXQvwSnf1s4rLwVe5U0kyiBtK6uAdx
         GP9lWUlY6ymKRAb5Qb/mdF46DiWF4LsXCa1aKaWVaQwm0TTOnOybhIyRi+6XJYLeJJbS
         w8b3Lt/4u9iqN+RHUEPYWat1Rzc+huz/wbAXGHTgZBt132BMUu1UyO8+z1WMbKiB4Ynu
         42WN10HOYV8m5Lg8uf5I0Z7SqBddfGx/T5G/qc0g7wSC+QspDz1h7J1pTemLH6mr9XRl
         UP8w==
X-Gm-Message-State: AOAM530ID1dsQEURcbqy2Ewf2QU2wkxtMyMxvjGZRbc9aKvBnrOgmHFX
        W4pQhhu4aed2KSAACXa3fjk=
X-Google-Smtp-Source: ABdhPJz2zqmmKwgizwaTrw8homQffSqgP32rYjZHGfBMcY/OC7B4eu+SU9ifnexjzoAfibazcOGBWg==
X-Received: by 2002:a63:d815:: with SMTP id b21mr20943691pgh.217.1617582522565;
        Sun, 04 Apr 2021 17:28:42 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:91b0:bd58:a9d0:2f54])
        by smtp.gmail.com with ESMTPSA id x4sm13444254pfn.134.2021.04.04.17.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 17:28:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>
Subject: [PATCH v5 1/3] blk-mq: Move the elevator_exit() definition
Date:   Sun,  4 Apr 2021 17:28:32 -0700
Message-Id: <20210405002834.32339-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210405002834.32339-1-bvanassche@acm.org>
References: <20210405002834.32339-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since elevator_exit() has only one caller, move its definition from
block/blk.h into block/elevator.c. Remove the inline keyword since modern
compilers are smart enough to decide when to inline functions that occur
in the same compilation unit.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Khazhy Kumykov <khazhy@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk.h      | 9 ---------
 block/elevator.c | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e..e0a4a7577f6c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -198,15 +198,6 @@ void __elevator_exit(struct request_queue *, struct elevator_queue *);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
 
-static inline void elevator_exit(struct request_queue *q,
-		struct elevator_queue *e)
-{
-	lockdep_assert_held(&q->sysfs_lock);
-
-	blk_mq_sched_free_requests(q);
-	__elevator_exit(q, e);
-}
-
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
 ssize_t part_stat_show(struct device *dev, struct device_attribute *attr,
diff --git a/block/elevator.c b/block/elevator.c
index 293c5c81397a..4b20d1ab29cc 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -197,6 +197,14 @@ void __elevator_exit(struct request_queue *q, struct elevator_queue *e)
 	kobject_put(&e->kobj);
 }
 
+static void elevator_exit(struct request_queue *q, struct elevator_queue *e)
+{
+	lockdep_assert_held(&q->sysfs_lock);
+
+	blk_mq_sched_free_requests(q);
+	__elevator_exit(q, e);
+}
+
 static inline void __elv_rqhash_del(struct request *rq)
 {
 	hash_del(&rq->hash);
