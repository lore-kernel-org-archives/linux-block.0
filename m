Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7979EC433DB
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 02:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 560F561922
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 02:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhC2CAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Mar 2021 22:00:46 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:38848 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhC2CAg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 22:00:36 -0400
Received: by mail-pf1-f178.google.com with SMTP id v10so3519886pfn.5
        for <linux-block@vger.kernel.org>; Sun, 28 Mar 2021 19:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYJRE/xreMdBfSedYAzb+UvnhwmwpqcZnYReZKFZZac=;
        b=gGM6jgvygXQayKKXpltH+wuSVtpX58kW1xtKKOt7FrNgSBZWwhoQKGEn8DHIFVqnhV
         DXHILUEA0mm0aYwZtgYr/am7yPtnfKXKCTPDzu/9WyU11PTP/KSFt5OoRrzTdRBI/rGM
         T1GnWTPZb3IMkRFVmIlf27JtNaefOlSsG+RjF17SZCmTazZrvsDIfEd3kPj9aFuL1B4X
         MlPDReAvm0lAqpVY6AJaRiBD55MJPpWDPGeGSk337DkbDso+nTOKDNcAz5HpgDaXzSyv
         pJinB83ye7Oxe1QPwqnA6g15CKVgISfiAvvL+fvqMsjY9Mb+J+A/nhmFh3pPlSbDUbkE
         E15g==
X-Gm-Message-State: AOAM530Blw4lEJ2bHf0MLlk9XSa5B1QyRCsayHdWHnbx7AWZyS4SzDvz
        C3so2LI4re5/KF+422cuEGg=
X-Google-Smtp-Source: ABdhPJyHtpQ4o9m8FkxKLjcp0C3oFdghYDYetRE74oviWtRoB4HG0MwKL0u+pS7CwkLJretD2ehNOg==
X-Received: by 2002:a63:1c4c:: with SMTP id c12mr21659191pgm.179.1616983236423;
        Sun, 28 Mar 2021 19:00:36 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id x125sm15784979pfd.124.2021.03.28.19.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 19:00:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v4 1/3] blk-mq: Move the elevator_exit() definition
Date:   Sun, 28 Mar 2021 19:00:26 -0700
Message-Id: <20210329020028.18241-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329020028.18241-1-bvanassche@acm.org>
References: <20210329020028.18241-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since elevator_exit() only has one caller, move its definition from
block/blk.h into block/elevator.c. Remove the inline keyword since modern
compilers are smart enough to decide when to inline functions that occur
in the same compilation unit.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Khazhy Kumykov <khazhy@google.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
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
