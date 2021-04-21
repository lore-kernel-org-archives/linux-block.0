Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E153C433ED
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D85561418
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhDUADS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:03:18 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41716 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhDUADS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 20:03:18 -0400
Received: by mail-pf1-f174.google.com with SMTP id w6so12382490pfc.8
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 17:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qi9EjZACA+wXjNYVSb3/f0Q0Q/+q7Lww8fd5pVf2aDQ=;
        b=AwQpdj66QlA0rI8ZNSrxuf8j749jauXGwEp3niAcmIe7seCbvIpSSR2N4P4DGast5k
         EgdkDWfeBxwp9vdyAXIcC34bMlHtC2QEePyzS531jeS2aUQJGOJ1Pa1N4a3pxIKCK22X
         /xSkeod+3NUe/z2llwE5SLM2ziG3PmR++jQlz4wjvu/KGnTlsOgwVOMcXOTxKhDCZsxN
         k3XXLdZuEgtyZOb+8S7cssldUChPCUEGQhAWNnc8fyKvYNU1KdWCaEOH7a8gxZgP68fi
         2G3TMZc5ouIs5sfsedTcH8LaJNSvaOTdLt8n1CMPj+eJHUd6V+WWnIr7Nc0IPsQZ0R3G
         sC4Q==
X-Gm-Message-State: AOAM530Ia1NkwEQUkzpEnkNgYoyOoelJLhs0StXOEKTj8TTNBJJrrHvD
        5HV2wdZBRBlZOUQHrGRqY6I=
X-Google-Smtp-Source: ABdhPJxpwzrlGhexXQRRX1mMhM3hCVZd65s4IvZeiSC+4nPIUJc+rAT9OYQ0iIjse/navantIkPBvQ==
X-Received: by 2002:a17:90b:34b:: with SMTP id fh11mr7922824pjb.105.1618963364529;
        Tue, 20 Apr 2021 17:02:44 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:6cb:4566:9005:c2af])
        by smtp.gmail.com with ESMTPSA id 33sm149560pgq.21.2021.04.20.17.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:02:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v7 1/5] blk-mq: Move the elevator_exit() definition
Date:   Tue, 20 Apr 2021 17:02:31 -0700
Message-Id: <20210421000235.2028-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421000235.2028-1-bvanassche@acm.org>
References: <20210421000235.2028-1-bvanassche@acm.org>
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
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
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
index 8b3591aee0a5..529233957207 100644
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
index 440699c28119..7c486ce858e0 100644
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
