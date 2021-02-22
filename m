Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C29C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 02:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9C464EE9
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 02:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhBVC3A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Feb 2021 21:29:00 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:46259 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhBVC27 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Feb 2021 21:28:59 -0500
Received: by mail-pf1-f171.google.com with SMTP id k13so5686322pfh.13
        for <linux-block@vger.kernel.org>; Sun, 21 Feb 2021 18:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8h/HGqx3B4HQuX3I7n7RbS9jxNdNr6bVyVh8Zh0uYEc=;
        b=YbWLJV6Gbhr897x7pav/LOWZG2mAFGJDi6t/6UM7zFWlojBURcmAkLEYXKma4HWgtC
         AHwSxHeYiMiOAvORpr+ZK2sh9jIJCbLBnqEDppipHEYAPnOWs+XekablwfIVPbl3kbKx
         C4Uanhk/TC9WYsEymD6a49pQPgvpn0BdOU9NuhT9C+uR43/d4IfmhrZ3I4n5M6FHQRev
         JSs5mKusZzTKivq3H+nLx8rgbONozOw4CdECje4kT0kspLUfQFJgpjYxRnKqRV0CKXD2
         hECbq0nLAKNxJQ0nIs1cDXNZr35vuNaLSzAT9GMAT862JFJhdnFNWio4S/F1gDE0b84A
         1qNQ==
X-Gm-Message-State: AOAM533f+L4QKNMkA4v8vQIhfrbdJf1+TRhExJ7UH9c2XTZcwOGQMG/o
        uQCgPSEVbPciWHungF2sNCg=
X-Google-Smtp-Source: ABdhPJyz8Y84ipf6wR2LOthgVI2/RLuK/o6+W+BcpvClkVywKIfwx25KDcP2fHqT7nXhGPZ7PXxF4w==
X-Received: by 2002:aa7:808d:0:b029:1ed:993c:3922 with SMTP id v13-20020aa7808d0000b02901ed993c3922mr3955382pff.75.1613960893024;
        Sun, 21 Feb 2021 18:28:13 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:eb6d:74c2:f5f3:564c])
        by smtp.gmail.com with ESMTPSA id c69sm17049854pfb.88.2021.02.21.18.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 18:28:10 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] block: Remove unused blk_pm_*() function definitions
Date:   Sun, 21 Feb 2021 18:28:05 -0800
Message-Id: <20210222022805.18196-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit a1ce35fa4985 ("block: remove dead elevator code") removed the last
callers of blk_pm_requeue_request(), blk_pm_add_request() and
blk_pm_put_request(). Hence remove the definitions of these functions.
Removing these functions removes all users of the struct request nr_pending
member. Hence also remove 'nr_pending'. Note: 'nr_pending' is no longer
used since commit 7cedffec8e75 ("block: Make blk_get_request() block for
non-PM requests while suspended").

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-pm.h         | 38 --------------------------------------
 include/linux/blkdev.h |  1 -
 2 files changed, 39 deletions(-)

diff --git a/block/blk-pm.h b/block/blk-pm.h
index a2283cc9f716..8a5a0d4b357f 100644
--- a/block/blk-pm.h
+++ b/block/blk-pm.h
@@ -21,31 +21,6 @@ static inline void blk_pm_mark_last_busy(struct request *rq)
 	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
 		pm_runtime_mark_last_busy(rq->q->dev);
 }
-
-static inline void blk_pm_requeue_request(struct request *rq)
-{
-	lockdep_assert_held(&rq->q->queue_lock);
-
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
-		rq->q->nr_pending--;
-}
-
-static inline void blk_pm_add_request(struct request_queue *q,
-				      struct request *rq)
-{
-	lockdep_assert_held(&q->queue_lock);
-
-	if (q->dev && !(rq->rq_flags & RQF_PM))
-		q->nr_pending++;
-}
-
-static inline void blk_pm_put_request(struct request *rq)
-{
-	lockdep_assert_held(&rq->q->queue_lock);
-
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
-		--rq->q->nr_pending;
-}
 #else
 static inline int blk_pm_resume_queue(const bool pm, struct request_queue *q)
 {
@@ -55,19 +30,6 @@ static inline int blk_pm_resume_queue(const bool pm, struct request_queue *q)
 static inline void blk_pm_mark_last_busy(struct request *rq)
 {
 }
-
-static inline void blk_pm_requeue_request(struct request *rq)
-{
-}
-
-static inline void blk_pm_add_request(struct request_queue *q,
-				      struct request *rq)
-{
-}
-
-static inline void blk_pm_put_request(struct request *rq)
-{
-}
 #endif
 
 #endif /* _BLOCK_BLK_PM_H_ */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 69035e9f632b..c032cfe133c7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -462,7 +462,6 @@ struct request_queue {
 #ifdef CONFIG_PM
 	struct device		*dev;
 	enum rpm_status		rpm_status;
-	unsigned int		nr_pending;
 #endif
 
 	/*
