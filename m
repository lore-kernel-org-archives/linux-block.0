Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A1BC49ED6
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 14:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF76120644
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 14:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfIKOrw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:47:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56902 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfIKOrw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 10:47:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id D8DA2260B29
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, m@bjorling.me,
        kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 2/3] null_blk: fix module name at log message
Date:   Wed, 11 Sep 2019 11:46:35 -0300
Message-Id: <20190911144636.226945-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190911144636.226945-1-andrealmeid@collabora.com>
References: <20190911144636.226945-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The name of the module is "null_blk", not "null". Make `pr_info()` follow
the pattern of `pr_err()` log messages.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 drivers/block/null_blk_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 99328ded60d1..7bc553ff7407 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1311,7 +1311,7 @@ static bool should_requeue_request(struct request *rq)
 
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
-	pr_info("null: rq %p timed out\n", rq);
+	pr_info("null_blk: rq %p timed out\n", rq);
 	blk_mq_complete_request(rq);
 	return BLK_EH_DONE;
 }
@@ -1803,7 +1803,7 @@ static int __init null_init(void)
 		}
 	}
 
-	pr_info("null: module loaded\n");
+	pr_info("null_blk: module loaded\n");
 	return 0;
 
 err_dev:
-- 
2.23.0

