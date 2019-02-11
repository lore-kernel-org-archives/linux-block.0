Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84485C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 10:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536A321479
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 10:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="PeXipHB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBKKvY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:51:24 -0500
Received: from forward101o.mail.yandex.net ([37.140.190.181]:34303 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbfBKKvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 05:51:24 -0500
Received: from mxback7j.mail.yandex.net (mxback7j.mail.yandex.net [IPv6:2a02:6b8:0:1619::110])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 79ED73C01F3A;
        Mon, 11 Feb 2019 13:51:21 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback7j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 8atKKXashl-pLleWW0X;
        Mon, 11 Feb 2019 13:51:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1549882281;
        bh=wy4azC8/jiDFBHmmm7QO1aVpS+tnhXwoIlAL3HJBjew=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=PeXipHB6kFE8SQqidEN8GjZ6qfv8Btj3GR9XNd0gmeetfnt/JDS1wC0NciDhDWzre
         PHy/6KGK+wj7kf+x3aHZkCsfDlWoNYnys6pTgfNyTebeNOIa3J61AdgEa+o+cOa0Xk
         bqsOiWCCseVOp5MfqPoAW75jmAF1V+wYtgpqkUhQ=
Authentication-Results: mxback7j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id tz9LJo3rX9-pKnGBhMb;
        Mon, 11 Feb 2019 13:51:20 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Aleksei Zakharov <zakharov.a.g@yandex.ru>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Aleksei Zakharov <zakharov.a.g@yandex.ru>
Subject: [PATCH] block: avoid setting none scheduler if it's already none
Date:   Mon, 11 Feb 2019 13:50:37 +0300
Message-Id: <1549882237-28183-1-git-send-email-zakharov.a.g@yandex.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's no reason to freeze queue and remove scheduler
if there's no scheduler already.

Signed-off-by: Aleksei Zakharov <zakharov.a.g@yandex.ru>
---
 block/elevator.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index f05e90d..d6d835a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -667,8 +667,11 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	/*
 	 * Special case for mq, turn off scheduling
 	 */
-	if (!strncmp(name, "none", 4))
+	if (!strncmp(name, "none", 4)) {
+		if (!q->elevator)
+			return 0;
 		return elevator_switch(q, NULL);
+	}
 
 	strlcpy(elevator_name, name, sizeof(elevator_name));
 	e = elevator_get(q, strstrip(elevator_name), true);
-- 
2.7.4

