Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDEAC072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 06:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B49A2175B
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 06:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbfEXGN7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 02:13:59 -0400
Received: from app1.whu.edu.cn ([202.114.64.88]:50962 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387936AbfEXGN7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 02:13:59 -0400
X-Greylist: delayed 2221 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 May 2019 02:13:57 EDT
Received: from localhost (unknown [111.202.192.3])
        by email1 (Coremail) with SMTP id AQBjCgDnR6XugudcZXHNAA--.25152S2;
        Fri, 24 May 2019 13:36:51 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Wang <rocking@whu.edu.cn>
Subject: [UNTESTED PATCH] block: fix a potential null pointer dereference
Date:   Fri, 24 May 2019 13:35:20 +0800
Message-Id: <20190524053520.30963-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQBjCgDnR6XugudcZXHNAA--.25152S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFWrtrW8XFWkAr18AFW7CFg_yoW3AFX_Ww
        4vyan7uFn5Xr43ur1DZFWYyF1vkr48JF4xGFWftr9rX3WFq3Z0ywsxGr45JFZ3GFWfuryD
        Xw4kXr15Xr1xZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GrWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUhdbbUUUUU=
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_queue_dying() still needs request_queue "q" when
enter_succeeded is false, so let's set "q" zero later.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 419d600e6637..3d43909db3b8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1056,7 +1056,6 @@ blk_qc_t generic_make_request(struct bio *bio)
 				flags = BLK_MQ_REQ_NOWAIT;
 			if (blk_queue_enter(q, flags) < 0) {
 				enter_succeeded = false;
-				q = NULL;
 			}
 		}
 
@@ -1088,6 +1087,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 				bio_wouldblock_error(bio);
 			else
 				bio_io_error(bio);
+			q = NULL;
 		}
 		bio = bio_list_pop(&bio_list_on_stack[0]);
 	} while (bio);
-- 
2.19.1

