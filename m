Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AEFC433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8743D64F5E
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhBCDdA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:33:00 -0500
Received: from mail.wangsu.com ([123.103.51.227]:41629 "EHLO wangsu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232109AbhBCDcj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Feb 2021 22:32:39 -0500
Received: from fedora31.wangsu.com (unknown [59.61.78.237])
        by app2 (Coremail) with SMTP id 4zNnewCnrj4EGRpgLKUEAA--.4716S2;
        Wed, 03 Feb 2021 11:31:23 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linf@wangsu.com
Subject: [PATCH] Fix Revert "bfq: Fix computation of shallow depth" in linux-block.git
Date:   Wed,  3 Feb 2021 11:31:13 +0800
Message-Id: <20210203033113.100260-1-linf@wangsu.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 4zNnewCnrj4EGRpgLKUEAA--.4716S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1kJr4DWFy5Kr4xZF1xAFb_yoW8Jw4rpw
        47Gw45tF1rKF10vFykur13X3yF9as5Ar92ga4aqw18ArW3XFn7XF9YkFyFvrnrXrs3CF4j
        vw15GFyF9a48XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r48McIj6xkF7I0En7xvr7AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
        I20VAGYxC7MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx2
        6r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU4UGYDUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Not yet got your mail, but per https://lkml.org/lkml/2021/2/2/1901, this patch
 is the incremental. Codes based on:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/patch/?id=8a483b42b1b3cef7e72564cdcdde62a373bd2f01

Notes: After checking previous hand-applied patch in block-5.11 broken 2 lines
in original patch, the incremental covers all.

Thanks.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 block/bfq-iosched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 959e25c..9e81d10 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6332,13 +6332,13 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	 * limit 'something'.
 	 */
 	/* no more than 50% of tags for async I/O */
-	bfqd->word_depths[0][1] = max(((1U << bt->sb.shift) * 3) >> 2, 1U);
+	bfqd->word_depths[0][0] = max((1U << bt->sb.shift) >> 1, 1U);
 	/*
 	 * no more than 75% of tags for sync writes (25% extra tags
 	 * w.r.t. async I/O, to prevent async I/O from starving sync
 	 * writes)
 	 */
-	bfqd->word_depths[0][1] = max((bt->sb.depth * 3) >> 2, 1U);
+	bfqd->word_depths[0][1] = max(((1U << bt->sb.shift) * 3) >> 2, 1U);
 
 	/*
 	 * In-word depths in case some bfq_queue is being weight-
-- 
2.25.4

