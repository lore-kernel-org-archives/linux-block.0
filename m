Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B023EC433B4
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D97B6141C
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhDUADV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:03:21 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:34454 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbhDUADU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 20:03:20 -0400
Received: by mail-pl1-f169.google.com with SMTP id t22so20271234ply.1
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 17:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Di2CfCL8byMqwy8hyI2sa5jc4+9OFqr/SRk2zQLdeM=;
        b=Be//+5Kzgfyhyek2MfNdOeOR885lbyMu40idi4VddoPjTBpPBOJdywAYU0ceeKGxvn
         abUStz+eicnIFLi0DPt3mJK41HiKHIsQT0igTfNw4oUvOLfl+ARhE+zs+/UF9w9JpXWF
         CoRvhtcvdjYanvetHkDtx+tMpoXHHAzrudgcZypcBW+8BfYFf+gZ5MUO3lJTb4gm7MwN
         oPoJPlsfaCacJAABgKDf3pOURqxlUxv3Cl0I9yu4FU70rqUylcDd4oa7QH9fiHltXJS7
         unT8hfXmI1xJAKEf0mjFbrOZIEEQTqMT1bAska+9Vd5tKRd/klnsrbA2ipvjGVIIvCBm
         WzcA==
X-Gm-Message-State: AOAM5315ZtlPXyUEeM9DmkRkLqMYIdloPkcsfW53h+VWiXuGQIdOiUGJ
        Im2xKu5+pMWqwK0MnfvFlXc=
X-Google-Smtp-Source: ABdhPJxfyTo7XojfssKUK2iHKCKuXVlqbyWus86u58yQlhdaawkPQnY1WRA/NH9dcKcZ2UYo+n5O5A==
X-Received: by 2002:a17:902:c745:b029:eb:6fc0:39e7 with SMTP id q5-20020a170902c745b02900eb6fc039e7mr30722131plq.82.1618963368393;
        Tue, 20 Apr 2021 17:02:48 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:6cb:4566:9005:c2af])
        by smtp.gmail.com with ESMTPSA id 33sm149560pgq.21.2021.04.20.17.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:02:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v7 4/5] blk-mq: Make it safe to use RCU to iterate over blk_mq_tag_set.tag_list
Date:   Tue, 20 Apr 2021 17:02:34 -0700
Message-Id: <20210421000235.2028-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421000235.2028-1-bvanassche@acm.org>
References: <20210421000235.2028-1-bvanassche@acm.org>
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

Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
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
index 8b59f6b4ec8e..7d2ea6357c7d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2947,7 +2947,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 	struct blk_mq_tag_set *set = q->tag_set;
 
 	mutex_lock(&set->tag_list_lock);
-	list_del(&q->tag_set_list);
+	list_del_rcu(&q->tag_set_list);
 	if (list_is_singular(&set->tag_list)) {
 		/* just transitioned to unshared */
 		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
@@ -2955,7 +2955,11 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
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
