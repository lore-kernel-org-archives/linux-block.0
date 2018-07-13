Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39649 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbeGMJDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:05 -0400
Received: by mail-pf0-f196.google.com with SMTP id s21-v6so22295872pfm.6
        for <linux-block@vger.kernel.org>; Fri, 13 Jul 2018 01:49:25 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 04/10] lightnvm: Remove redundant rq->__data_len initialization
Date: Fri, 13 Jul 2018 10:48:39 +0200
Message-Id: <20180713084845.19511-5-mb@lightnvm.io>
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

Since both blk_old_get_request() and blk_mq_alloc_request() initialize
rq->__data_len to zero, it is not necessary to initialize that member
in nvme_nvm_alloc_request(). Hence remove the rq->__data_len
initialization from nvme_nvm_alloc_request().

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 41279da799ed..a76db8820f1c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -662,12 +662,10 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
 
 	rq->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 
-	if (rqd->bio) {
+	if (rqd->bio)
 		blk_init_request_from_bio(rq, rqd->bio);
-	} else {
+	else
 		rq->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
-		rq->__data_len = 0;
-	}
 
 	return rq;
 }
-- 
2.11.0
