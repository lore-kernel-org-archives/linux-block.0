Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E406FC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 21:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B945361262
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 21:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbhDFVtZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:49:25 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:33521 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbhDFVtZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 17:49:25 -0400
Received: by mail-pl1-f173.google.com with SMTP id p10so3137618pld.0
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 14:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13kP3iYajUPF1gdCA46eYKhRnxztFc/t6rLAjj9NS5w=;
        b=PePZoChTp2a7a+JAW+VOwJ1AdQsKwvO1nEXJEDjoC2ivathChjU3Sf8ooeN2IJ9Joi
         T1F4bJSj2PecpvLfkn3iH9HC8O8bg49cpuyLq4jmHEKbOD0FBhbwYTjExSOgK/+zRu84
         xvKdiWzrI7igJO4vbNV/r8Uee7RCs80TPme0SGhuHpdtPSP7Xm9gcp0CpoaIpwAe3CyF
         ywt0pSXNW4c/2Dn9aeo8V6m6GQBkEJ9QRHjCY+Y6CIxS7CjepzKdWgMpB6zBgr8MeJAe
         pJu+hKDHVv4m2EiGQyTvi1Oa71sYH8ndGNiSkSazF6EDTys2fSS1TSqVWwq5FhJSIx0R
         Br9Q==
X-Gm-Message-State: AOAM5328gb/gzduD627++jV6xf1S48FL9/SXt1W9W2g+0uB0Qz5xwmor
        1CkBH+hONbb6VrbUCuJvEXo=
X-Google-Smtp-Source: ABdhPJw3tiVqjivosiSko9AWaO7HyXzgY/vSEU2zAcaSzlb8CI7tlNX+mq4bJrrPjJasJK1RLv+dzg==
X-Received: by 2002:a17:903:208b:b029:e9:8c2:4da with SMTP id d11-20020a170903208bb02900e908c204damr276172plc.68.1617745756337;
        Tue, 06 Apr 2021 14:49:16 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id my18sm2866062pjb.38.2021.04.06.14.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 14:49:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 4/5] blk-mq: Make it safe to use RCU to iterate over blk_mq_tag_set.tag_list
Date:   Tue,  6 Apr 2021 14:49:04 -0700
Message-Id: <20210406214905.21622-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406214905.21622-1-bvanassche@acm.org>
References: <20210406214905.21622-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the next patch in this series will use RCU to iterate over tag_list,
make this safe. Note: call_rcu() is already used to free the request queue.
From blk-sysfs.c:

	call_rcu(&q->rcu_head, blk_free_queue_rcu);

See also:
* Commit 705cda97ee3a ("blk-mq: Make it safe to use RCU to iterate over
  blk_mq_tag_set.tag_list"; v4.12).
* Commit 08c875cbf481 ("block: Use non _rcu version of list functions for
  tag_set_list"; v5.9).

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d6c9b655c0f5..ee98ce03fdc9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2946,7 +2946,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 	struct blk_mq_tag_set *set = q->tag_set;
 
 	mutex_lock(&set->tag_list_lock);
-	list_del(&q->tag_set_list);
+	list_del_rcu(&q->tag_set_list);
 	if (list_is_singular(&set->tag_list)) {
 		/* just transitioned to unshared */
 		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
@@ -2954,7 +2954,11 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		blk_mq_update_tag_set_shared(set, false);
 	}
 	mutex_unlock(&set->tag_list_lock);
-	INIT_LIST_HEAD(&q->tag_set_list);
+	/*
+	 * Calling synchronize_rcu() and INIT_LIST_HEAD(&q->tag_set_list) is
+	 * not necessary since blk_mq_del_queue_tag_set() is only called from
+	 * blk_cleanup_queue().
+	 */
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
