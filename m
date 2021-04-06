Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF67C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 21:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2077E613CC
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 21:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhDFVtV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:49:21 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:45861 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhDFVtU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 17:49:20 -0400
Received: by mail-pl1-f174.google.com with SMTP id l1so8261008plg.12
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 14:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCHbxEQTPXzPs6gplaMPUW2H7lBxzQw14sRK7JnImiU=;
        b=M2dCh4S0+D65GgXpgqvoww+dATd3jgsUdwf0xKvzvVGB5F30xh0NtV7ncPHUfoLNlO
         4kWkZKMBC5Uh6BuhVoBChaA3yUxrezW5Jusj9A3ZZu7HfgExaVjOi9sYysSKA9d/cJiG
         qsqv18MnDqwPzf2saSsLXWJpg4UZdi7cLRxf1NVrj58vjZjYeJA49cWhSOi2hHCrCCVc
         OCmsVj9v6cuXuSAS/PS5xe92JgNdYcMBqjJupKfdPTi55Y/MyqHstwU91MFrJ+nfOQTR
         W19YRyqjNMg9Ca4xhj+rfFSHKUw6aVFg4QNjC0EzpPmEIRfeYoYbqhg7tvyBNsG5NDEJ
         t4UA==
X-Gm-Message-State: AOAM532/s4cfu4dDx37hxd+JmZPwvdETiNZOPoCse6Uw9V5iriJTdAP4
        2Mv5K4G2ZGuSp5a65piXD3w=
X-Google-Smtp-Source: ABdhPJwpyXS8IVKkPr8WfOysnGPnW6iNxNi8b0f6dOSNANyDvOoAeuyLeK2dZbHHMBVBOgpno3Lfgw==
X-Received: by 2002:a17:90b:1802:: with SMTP id lw2mr215911pjb.226.1617745752478;
        Tue, 06 Apr 2021 14:49:12 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id my18sm2866062pjb.38.2021.04.06.14.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 14:49:11 -0700 (PDT)
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
Subject: [PATCH v6 1/5] blk-mq: Move the elevator_exit() definition
Date:   Tue,  6 Apr 2021 14:49:01 -0700
Message-Id: <20210406214905.21622-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406214905.21622-1-bvanassche@acm.org>
References: <20210406214905.21622-1-bvanassche@acm.org>
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
index 8f4337c5a9e6..2ed6c684d63a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -199,15 +199,6 @@ void __elevator_exit(struct request_queue *, struct elevator_queue *);
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
