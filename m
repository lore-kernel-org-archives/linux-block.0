Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED1C10F0E
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 11:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AE320880
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 11:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ww/iqk67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfDGLDa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:03:30 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:41338 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfDGLDa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 07:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1554635004;
        bh=M/39fHHCfyO/lWEh7xgRzpKiHBiG97ucNLNgx/pAcq4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        b=ww/iqk67v15oYIKXFuhgxkfpm5cc5IgbQ+2RI9FqXc8DRDZeyrkFKN8iqZsHbP3oK
         u5YpiRJpOkxl0UlTrf42pqg6MndX+uIT6MeNKemgmcck0ZDk3QdF4NF1RZ7BDajg41
         g8ukdbc46Zh/goW9pD6QgHMFAXVsvmpv3WVzy0lg=
X-QQ-mid: esmtp5t1554635003trxnz6ayf
Received: from localhost.localdomain (unknown [114.243.218.102])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 07 Apr 2019 19:03:14 +0800 (CST)
X-QQ-SSF: 01000000000000F0FH3000000000000
X-QQ-FEAT: QD5fYv+5331/ytCz0uGk6QRwM2AWMTkVofKyQwcL8lcJHBaYF4nf+RLYviI2J
        C3+ulRiQJ7L5tsKo7qg4rDDVXIXDYhHlCdi3sTgWn3lREWpA0AoYB+tAn7rcurzEX0EjADP
        MhQOGhlzggkCDjk/UPmgtfTgtV/ttNwRMTmd7Y17+48DuTjLAYwGZty1BqpiUEP3BVYocS6
        TiuHlqw9jGp33S+bT9EnMDfKd8SwQ/oUYRoaLLh5Qp5rolo2h0FjkPUovA3x7fSRkacnXm/
        ZQZlWKOBtZ0j9JkYG9osqNCA1vaLzXzVYifA==
X-QQ-GoodBg: 0
From:   Shenghui Wang <shhuiw@foxmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH] block: cleanup for blk_cleanup_queue()
Date:   Sun,  7 Apr 2019 19:03:14 +0800
Message-Id: <20190407110314.7145-1-shhuiw@foxmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

2 small cleanup:
* blk_set_queue_dying(q) has set QUEUE_FLAG_DYING. Remove the redundant
  statement 'blk_queue_flag_set(QUEUE_FLAG_DYING, q)'
* requests queued drained before DEAD marking, not DYING marking.
  Update the comment.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4673ebe42255..177377becfab 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -334,11 +334,10 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
-	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 	mutex_unlock(&q->sysfs_lock);
 
 	/*
-	 * Drain all requests queued before DYING marking. Set DEAD flag to
+	 * Drain all requests queued before DEAD marking. Set DEAD flag to
 	 * prevent that q->request_fn() gets invoked after draining finished.
 	 */
 	blk_freeze_queue(q);
-- 
2.20.1



