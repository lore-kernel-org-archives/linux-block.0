Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A535C43331
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 22:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F3321D6C
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 22:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfKGWdG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:33:06 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45869 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGWdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 17:33:06 -0500
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iSqKt-0004ox-LL; Thu, 07 Nov 2019 22:33:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: fix spelling mistake "requeueing" -> "requeuing"
Date:   Thu,  7 Nov 2019 22:33:02 +0000
Message-Id: <20191107223302.416745-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a94ee45440b3..aca67f8b48d1 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -936,7 +936,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	ret = nbd_send_cmd(nbd, cmd, index);
 	if (ret == -EAGAIN) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Request send failed, requeueing\n");
+				    "Request send failed, requeuing\n");
 		nbd_mark_nsock_dead(nbd, nsock, 1);
 		nbd_requeue_cmd(cmd);
 		ret = 0;
-- 
2.20.1

