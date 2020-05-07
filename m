Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B54C38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1208120753
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgEGHTx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 03:19:53 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:33472 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbgEGHTx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 03:19:53 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 03:19:52 EDT
Received: from ubuntu.localdomain (unknown [111.198.226.155])
        by APP-01 (Coremail) with SMTP id qwCowACnrOTNtLNeuFdlAA--.20608S2;
        Thu, 07 May 2020 15:12:13 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: block: use set_current_state macro
Date:   Thu,  7 May 2020 15:12:11 +0800
Message-Id: <20200507071211.15709-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowACnrOTNtLNeuFdlAA--.20608S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZF18uF1UuF45Aw47Jr43Jrb_yoW8Jr4kpF
        4rKay3tr1xKFW7Ja13JFWDXryYga97K3429as5C3ySqFyYqr1fCr1qq34YqFy7Zr9Iyw17
        uFy0vrykWa15taUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyIb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2Iq
        xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
        xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc_-PUUUUU
X-Originating-IP: [111.198.226.155]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCgMJA1z4i1LX4QAAsI
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use set_current_state macro instead of current->state = TASK_RUNNING.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/block/swim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 4c297f69171d..dd34504382e5 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -327,7 +327,7 @@ static inline void swim_motor(struct swim __iomem *base,
 			swim_select(base, RELAX);
 			if (swim_readbit(base, MOTOR_ON))
 				break;
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(1);
 		}
 	} else if (action == OFF) {
@@ -346,7 +346,7 @@ static inline void swim_eject(struct swim __iomem *base)
 		swim_select(base, RELAX);
 		if (!swim_readbit(base, DISK_IN))
 			break;
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 	swim_select(base, RELAX);
@@ -370,7 +370,7 @@ static inline int swim_step(struct swim __iomem *base)
 
 	for (wait = 0; wait < HZ; wait++) {
 
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 
 		swim_select(base, RELAX);
-- 
2.17.1

