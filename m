Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6E1C433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 10:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351D2613B9
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 10:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhELKDC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 06:03:02 -0400
Received: from mail.wangsu.com ([123.103.51.227]:59092 "EHLO wangsu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230114AbhELKC5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 06:02:57 -0400
Received: from fedora33.wangsu.com (unknown [59.61.78.138])
        by app2 (Coremail) with SMTP id 4zNnewAHDwd+p5tg+R4CAA--.3295S2;
        Wed, 12 May 2021 18:01:40 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linf@wangsu.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blkdev.h: remove unused codes blk_account_rq
Date:   Wed, 12 May 2021 18:01:24 +0800
Message-Id: <20210512100124.173769-1-linf@wangsu.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 4zNnewAHDwd+p5tg+R4CAA--.3295S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1fAw4rXFWxZFWUCryUWrg_yoWDGrX_u3
        40kr4IkrWrGr43Ww4UJFW3tFWYgryxJa17uFsaqrWxJ3WkGanYvw48JFnxGay7Wa97Cr13
        X3W0g3s3Zr1fWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Last users of blk_account_rq gone with patch commit a1ce35fa49852db
("block: remove dead elevator code") and now it gets no caller, it can
be safely removed.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 include/linux/blkdev.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1255823b2bc0..f69c75bd6d27 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -676,11 +676,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
 
-static inline bool blk_account_rq(struct request *rq)
-{
-	return (rq->rq_flags & RQF_STARTED) && !blk_rq_is_passthrough(rq);
-}
-
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define rq_data_dir(rq)		(op_is_write(req_op(rq)) ? WRITE : READ)
-- 
2.30.2

