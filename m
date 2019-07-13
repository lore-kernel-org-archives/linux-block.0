Return-Path: <SRS0=xoF3=VK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF11C742A7
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 03:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECCA217D4
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 03:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZO/2nJnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfGMDvm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jul 2019 23:51:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39110 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfGMDvm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 23:51:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so10351508qtu.6;
        Fri, 12 Jul 2019 20:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIrfInZig2JFWZrOWBTKrHopPohB0GRCvYl01XlQKZc=;
        b=ZO/2nJnHNQ2qP7JqBYlDAInlXCZ42/Lr3cAJKTE93dAAc/YgOLRcmj3tDxyRcoEFTM
         nF0Y0r5lIq4pw5sa1jcqBPj2UPtRMCvUlwqD9P2XJ9HL+S1X8lahHheSUETAlHka3hoh
         cP+sSXgtayChoSFmJS8kBRUIUtQOqBG7CDDO6JN4YdQ1XD3HLlLOk/MVG8XXehMKMTsI
         zPZE1NJirzf/BWokbBh2V4uT1XX8ZX6H7zVrA9sOXNAwqTlIEm9epxwnU+Iqyucf+NMO
         BiFzeCG+qRzjQooz7Pkx5Q0VNsq9sMKjVw7XSDtxCtsf7AZ/kPTB8yPUW3VC6pPZUB84
         dm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIrfInZig2JFWZrOWBTKrHopPohB0GRCvYl01XlQKZc=;
        b=GVQXOTtoZxCUQj8EBsKFejjBBdhSwDFGjJmdTQFO96KHXG4uj6MtE36zQrkxiahT9x
         vA4848B9Y0I3TMgXXx41AphxbpbLfi1P4j1csW1VKKx1F+qruaZpbvnviol0itEcT5sb
         +s+ZYV0kK80MWfANuN7HRVUI9YJXYa3Q/aDly83M/L9AkXBo/jdCWpdTE1xxUuvXmkmn
         gnMHXSrbtZ+0HhOrKe+uk+iTrLONZssMJSJWjZjC0nwHzm3tXnGXCzq9ge+3K0S+lPLW
         knsrudVQI0cJ2e440rKP/F7Jy/XPkC3YJAVZMiRqipKv5dqhCP3DIbfX1Ym8SZ12GCxs
         QlwQ==
X-Gm-Message-State: APjAAAUHE+CV6r/fs9iXxA3EreXr1yjcYi12IZ6GzdtFpsWMKVI3IlSA
        iGPllAlDKNNtUorsGACheWme6Cq2IS8=
X-Google-Smtp-Source: APXvYqx0Bqx9PNV/NH77bSGg/D0QxTXGktkqhu5Gw5ZEee0AX3Kg3fl6hyGKoI7XJsr3xK/YvlXbag==
X-Received: by 2002:ac8:40cc:: with SMTP id f12mr9063427qtm.256.1562989900733;
        Fri, 12 Jul 2019 20:51:40 -0700 (PDT)
Received: from localhost.localdomain ([186.212.49.5])
        by smtp.gmail.com with ESMTPSA id j2sm4823692qtb.89.2019.07.12.20.51.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 20:51:39 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH] block: elevator.c: Check elevator kernel argument again
Date:   Sat, 13 Jul 2019 00:52:21 -0300
Message-Id: <20190713035221.31508-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the inclusion of blk-mq, elevator= kernel argument was not being
considered anymore, making it impossible to specify a specific elevator
at boot time as it was used before.

This is done by checking chosen_elevator global variable, which is
populated once elevator= kernel argument is passed. Without this patch,
mq-deadline is the only elevator that is can be used at boot time.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---

 I found this issue while inspecting why noop scheduler was gone, and so I found
 that was now impossible to use a scheduler different from mq-deadeline.

 Am I missing something? Is this a desirable behavior?

 One more question: currently we can't specify a "none" scheduler, like it used
 to be "noop". This is also on purpose? If it's not, I can provide a patch for
 it.

 block/elevator.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 2f17d66d0e61..41ce7ba099ba 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -601,7 +601,7 @@ int elevator_switch_mq(struct request_queue *q,
  */
 int elevator_init_mq(struct request_queue *q)
 {
-	struct elevator_type *e;
+	struct elevator_type *e = NULL;
 	int err = 0;
 
 	if (q->nr_hw_queues != 1)
@@ -615,9 +615,18 @@ int elevator_init_mq(struct request_queue *q)
 	if (unlikely(q->elevator))
 		goto out_unlock;
 
-	e = elevator_get(q, "mq-deadline", false);
-	if (!e)
-		goto out_unlock;
+	/* if elevator was used as kernel argument, try to load it */
+	if (*chosen_elevator) {
+		e = elevator_get(q, chosen_elevator, false);
+		if (!e)
+			pr_err("io scheduler %s not found", chosen_elevator);
+	}
+
+	if (!e) {
+		e = elevator_get(q, "mq-deadline", false);
+		if (!e)
+			goto out_unlock;
+	}
 
 	err = blk_mq_init_sched(q, e);
 	if (err)
-- 
2.22.0

