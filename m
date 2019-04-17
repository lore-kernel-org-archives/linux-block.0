Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E7C10F14
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 02:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337722075B
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 02:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLbL2WxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfDQCKr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:10:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40119 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfDQCKq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 22:10:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so25694693qts.7;
        Tue, 16 Apr 2019 19:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8E78349DtaExhsNzU6Me959vfhX7B7zUGIpotLMFF2I=;
        b=ZLbL2WxKC4V8eUvL4j4y8/cfMt4imMzxpgnSW8TT/W1Lk1S0XHv4A90dsU4pa+9XLj
         dfk7PKpWE2TJssTV6hc2G9ysXYJvwvmrM+y9DMMt2FENm+YPjhWbWm7mxuqQtbAGT6fl
         mjOtBR0nQlCj7K2RTNaxvE1MEsBzAgE1z9cm8yAV4gJV6awLKUTd2BH53VDXucIVUyk6
         Ow6DDGkgK0RrvwIu4N7okFaKx4OB+vNkrZE0dDNyKYht9q7WolVXr5r5Z4wTwje/8yQ8
         t1MIq4Ts9Vtaie+FFeo1U0tMnf9tN3m1qM0QG9wbORenQUKAMaGXQ6Bxg//MnFY3w1mf
         3M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8E78349DtaExhsNzU6Me959vfhX7B7zUGIpotLMFF2I=;
        b=bZQmMMW11ZmkUTBysaiBYoynkHpwOEUzsfD5PxbIms4GHGsS7u0r5JPysj/QMPdays
         24RdzFTO0Ixni8kKX622D/Us/R0izIF7caFr4RpziVMJndlbbFwON+IcrJqUiT6hfOG5
         mEBAnKbciLOoVh2gAOseSIZ3I136fnl2yPIDZXVpVu9fVU/Dg5szIYlCilSZs4ZjGN65
         THxn/QuCa+VeByhmIfR68NeW/v2vjyublUgMmznQwieFlHMMPEhuals7T2Ybff5qbxhy
         G5LkEBSx+iECvaWSlK9c3tPEky7FzRprYMQmFXKb7VNTwbGWbFBtN1F8W4yK8ycY+64y
         KB9A==
X-Gm-Message-State: APjAAAWaOj5XosiheetBmmbONMPsHCvNKdVaRhijWhyY21CYPr2w6GKc
        kTD9wrn4zqDchZy+6bZFlqn4+aFeH8M=
X-Google-Smtp-Source: APXvYqxvxUqxORYbV1jyE1YtjRpHEvYpjR4KSxpxdf6ROl3/ctKbGDhNSUX457PyJiQE03oH9Jus9A==
X-Received: by 2002:ac8:2f11:: with SMTP id j17mr69439487qta.334.1555467045293;
        Tue, 16 Apr 2019 19:10:45 -0700 (PDT)
Received: from localhost.localdomain (179.187.200.226.dynamic.adsl.gvt.net.br. [179.187.200.226])
        by smtp.gmail.com with ESMTPSA id s55sm1497228qte.17.2019.04.16.19.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 19:10:44 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, marcos.souza.org@gmail.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com
Subject: [PATCH v3 1/3] blk-mq.c: Add documention of function blk_mq_init_queue
Date:   Tue, 16 Apr 2019 23:10:28 -0300
Message-Id: <20190417021030.82998-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190417021030.82998-1-marcos.souza.org@gmail.com>
References: <20190417021030.82998-1-marcos.souza.org@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 block/blk-mq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9516304a38ee..4a8277a54c03 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2650,6 +2650,15 @@ void blk_mq_release(struct request_queue *q)
 	blk_mq_sysfs_deinit(q);
 }
 
+/**
+ * blk_mq_init_queue - Create a new request queue associating a blk_mq_tag_set
+ * @set: tag_set to be associated with the request queue
+ *
+ * Description:
+ * This function creates a new request queue, associating @set with it.
+ *
+ * Returns a new request queue on success, or ERR_PTR() on failure.
+ */
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 {
 	struct request_queue *uninit_q, *q;
-- 
2.16.4

