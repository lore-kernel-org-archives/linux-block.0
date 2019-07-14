Return-Path: <SRS0=YXNx=VL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5DEC74A4B
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 05:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DA320C01
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 05:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elpp8sVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfGNFeL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jul 2019 01:34:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33696 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfGNFeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jul 2019 01:34:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id r6so8242601qtt.0;
        Sat, 13 Jul 2019 22:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BR8N0y9B3pgp139nlwH3tnMuCXEDUEYHvhUCnhBuoVE=;
        b=elpp8sVVu2sYrXAuMxLosbd55gwBFR0Snap2UybLzz7qwIzHcE6wnfeGC7bnJ+oLJP
         QnDfH57HXzsyeDaQeHgeHJwzNdyIoJepg0o/KPKj+fm8QNBcZHEh3/8UFEbOCWOzf7i2
         bKHFdXEncjVXWR+upSDIZ2vnog3mM2Oe0BRSjMFlEgzrq6tOx2bIIVDlRo/KjeHF48/B
         v6ZDOGfBh6nDcoK+ZYBedDVuCo/1sZXEmDQOlaxSFIKodISqvY6CvV1pgrxwk4Tf+YSS
         zwKz1u/dw/ylGniR3aRBNLSyw2D3Qz48Prk1GQb8IQfxLss4swgZiZ2CtasQw2S/QNI+
         401w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BR8N0y9B3pgp139nlwH3tnMuCXEDUEYHvhUCnhBuoVE=;
        b=LhwXK3UkMklZF3cR6uiKCIjseSr2DNDMgWJG+vcVfuitSp3+JV1LkQAm2b3DFtEckD
         ubrpm6m9KiGFsGSfd8mazA0X6FNWi7HgYOKd8nKGRvnMpiX3k1Ob3RqA7CKlaLG9RoOk
         RaMJ/28t3A3lkWl6kehjpw8ixK7CZTqAk4jidGxOS5XK/ml0s4M95UxoV7QTYLGwjeUh
         Pd7VnK70QDgsfHVkkn5EULhQ6pM9P4N9pqiVkXbwh6y6SKQLxmPPV0qf7Sc774caQlVL
         WLMUKE75yREtnJnfbOoJRmS2kX0Jpy4aQ1N8x7NSLtydCSv/uGO42/26Mv7LyM5sXwS+
         w0Ww==
X-Gm-Message-State: APjAAAUBXX2oPw2a8VkB2fnQTc2xY6okJAzfay2dTXkWf/NFu4mGC3yR
        Pl473o4GHhbPfZ5rcoTB6sbOIw2QuPI=
X-Google-Smtp-Source: APXvYqznwz3idP9r7C3X9gCKa/NgSL2/x34+XTmTGQ0LjoyBzQqdgdQ6AkO5WqfnXlh9GDmvnL6/Cg==
X-Received: by 2002:ac8:3811:: with SMTP id q17mr12446777qtb.315.1563082449938;
        Sat, 13 Jul 2019 22:34:09 -0700 (PDT)
Received: from localhost.localdomain ([191.35.237.35])
        by smtp.gmail.com with ESMTPSA id f133sm6308808qke.62.2019.07.13.22.34.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 22:34:09 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] block: elevator.c: Remove now unused elevator= argument
Date:   Sun, 14 Jul 2019 02:34:50 -0300
Message-Id: <20190714053453.1655-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190714053453.1655-1-marcos.souza.org@gmail.com>
References: <20190714053453.1655-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the inclusion of blk-mq, elevator argument was not being
considered anymore, and it's utility died long with the legacy IO path,
now removed too.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 block/elevator.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 2f17d66d0e61..f56d9c7d5cbc 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -135,20 +135,6 @@ static struct elevator_type *elevator_get(struct request_queue *q,
 	return e;
 }
 
-static char chosen_elevator[ELV_NAME_MAX];
-
-static int __init elevator_setup(char *str)
-{
-	/*
-	 * Be backwards-compatible with previous kernels, so users
-	 * won't get the wrong elevator.
-	 */
-	strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
-	return 1;
-}
-
-__setup("elevator=", elevator_setup);
-
 static struct kobj_type elv_ktype;
 
 struct elevator_queue *elevator_alloc(struct request_queue *q,
-- 
2.22.0

