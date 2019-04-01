Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15E8C3E8A3
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 21:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2162133D
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 21:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDAVU2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:20:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39445 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDAVU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 17:20:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id b65so5103422plb.6;
        Mon, 01 Apr 2019 14:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuyj9Ia/9eXCnJDm/1aJGDY3orUh57LWX6Hn+U0TvtE=;
        b=iqLiYuIB6CGCkx990AlIP9X/tzifZVinOEJdEGXwpO8hpcAaNKxEkjkzgutu/aaM9I
         ppI/eO0vQKEbflqmpWVtg4iXW9Gus4ucGEpt2QFqq0MLsQWL92QXtil9py5gmXIAPUEP
         aiV8nuPIKWkLZZV4+QULBpCWwSF9e+VmqhWWT670ptUOFYtKFW5uyJXmcWCdIgMlO/Fm
         kRSt00rz660Ke7I82pMaQrB+GSGJfFZa82mgXU4jJhFLMKDA8LT7y83DGFxiA3X15A7v
         dACoVRGXV0uex+6bpIj9Yh7J1zIIS+aTMNOfCsLS6HpzVa/0wSPLRYmw/TtUbQVc8C8g
         8suw==
X-Gm-Message-State: APjAAAXo+vFuX+IzBijMpPUlZu4tB3Axy3SZpvVaocAJqEnP6K4Alhbj
        xIY5gS94g/mAEKXPc6cMvQ8=
X-Google-Smtp-Source: APXvYqwutshXZIqzVkHzccb/O/tNQRTtmvsj5AcaDLsnWYhiM4/klnsP6Bz0JuZQPhlTTfU+rQSrOA==
X-Received: by 2002:a17:902:e01:: with SMTP id 1mr67745974plw.128.1554153627234;
        Mon, 01 Apr 2019 14:20:27 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z129sm20178813pfz.103.2019.04.01.14.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:20:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Subject: [PATCH 1/4] block: Move the percpu_ref_exit(&q->q_usage_counter) call into __blk_release_queue()
Date:   Mon,  1 Apr 2019 14:20:11 -0700
Message-Id: <20190401212014.192753-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190401212014.192753-1-bvanassche@acm.org>
References: <20190401212014.192753-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch makes it safe to access the queue usage counter from inside
blk_mq_run_hw_queues(). Other than deferring q_usage_counter freeing,
this patch does not change any functionality.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c  | 2 --
 block/blk-sysfs.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4673ebe42255..fdcf6de2243f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -377,8 +377,6 @@ void blk_cleanup_queue(struct request_queue *q)
 	if (queue_is_mq(q))
 		blk_mq_free_queue(q);
 
-	percpu_ref_exit(&q->q_usage_counter);
-
 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 422327089e0f..b8b3d69cd0a5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -870,6 +870,7 @@ static void __blk_release_queue(struct work_struct *work)
 
 	bioset_exit(&q->bio_split);
 
+	percpu_ref_exit(&q->q_usage_counter);
 	ida_simple_remove(&blk_queue_ida, q->id);
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
-- 
2.21.0.196.g041f5ea1cf98

