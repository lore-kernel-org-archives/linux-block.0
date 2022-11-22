Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED5C43217
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 14:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKVOVv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiKVOVq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 09:21:46 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC88762394;
        Tue, 22 Nov 2022 06:21:44 -0800 (PST)
Received: from localhost.localdomain (unknown [10.14.30.50])
        by mail-app4 (Coremail) with SMTP id cS_KCgCHrN_o2nxjHR5BCA--.15646S3;
        Tue, 22 Nov 2022 22:21:40 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH 1/4] elevator: update the document of elevator_switch
Date:   Tue, 22 Nov 2022 22:21:23 +0800
Message-Id: <94250961689ba7d2e67a7d9e7995a11166fedb31.1669126766.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1669126766.git.nickyc975@zju.edu.cn>
References: <cover.1669126766.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgCHrN_o2nxjHR5BCA--.15646S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4xKw1fuF4fXrWrCryxuFg_yoWkJwc_Z3
        45tas7J34DWr4YgryfKF15trW09ws3XFy5Gws2grn3Xas0kFyvyr48ur17ur1xWa1UC343
        A3yqv3WFvrnagjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
        xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
        64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgcCB1ZdtciuZAADs-
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We no longer support falling back to the old io scheduler if switching to
the new one fails. Update the document to indicate that.

Fixes: a1ce35fa4985 ("block: remove dead elevator code")
Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/elevator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index a5bdc3b1e7e5..01aa9f38f22e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -650,10 +650,10 @@ void elevator_init_mq(struct request_queue *q)
 }
 
 /*
- * switch to new_e io scheduler. be careful not to introduce deadlocks -
- * we don't free the old io scheduler, before we have allocated what we
- * need for the new one. this way we have a chance of going back to the old
- * one, if the new one fails init for some reason.
+ * Switch to new_e io scheduler.
+ *
+ * If switching fails, we are most likely running out of memory and not able
+ * to restore the old io scheduler, so leaving the io scheduler being none.
  */
 int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
-- 
2.34.1

