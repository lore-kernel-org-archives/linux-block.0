Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2904C43610
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 07:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC3C208E4
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 07:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNbg3K/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC3C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbeKTRpD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:45:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37566 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbeKTRpD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 12:45:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id u3-v6so558648pfm.4;
        Mon, 19 Nov 2018 23:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HDxjroR+Qk57aPMTHSMkdRSmO3X58GNV4ZL5R8TjMQs=;
        b=YNbg3K/0oIjm1U10Z6BHywTNH+VmwXv3KbORhBPQumgfPdE0CSbkXr3tGWsLjHKKv1
         TP3gbAXpcvr6heQzCSKmOdz2VB++WCIDcZ6IlMmqrsXpu0WANZxPucZ2tCC2RcNzIeWa
         2VbVlxV1dv3CQj8fPLaBu9SGG22nVLwb/lJNyiNsRarxupw1hB0y+lwh5Nr951wNVFY6
         4A7O5CrdmQsJDm6+lH6UyqqPPDLSve6+LAuuYXgZL8m4vF+IvXVJ2tBcwSTa11emSmBg
         kyuCMM66Vifsizpvsw9kEMHKADr3Vzz5hvCGQfIK5XOHxKnC6V32n48TQ5pIzVy0X9PG
         wkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HDxjroR+Qk57aPMTHSMkdRSmO3X58GNV4ZL5R8TjMQs=;
        b=pl5ddVVrsgwWApGPLWOXh1lUqKp1aw6aJXyH5q3NtQpE7AaEKYeOLWezPR4/3KAwDg
         iy4JNOzhhqBN906xF4gS+Cpm1rBvoTbUpcBNHHWVtLCPBEoMd/1BmdXWnQ472hSweNmY
         ZWJv7PGpkI70g9pIRSsHA9gE0RqXB+g6arO3+i35KUt57TJ5j/Yi0OzYtyaPRwzRJ0EV
         0shctd0NsaHQYt84t3q9gA58jJQ9HT5yIuZ9O+q+PtmZb1a14Oj4jfMeIUfGuhusSUUd
         CF/hlxetGIR3xzP4drybl5s5uOaRNFE2+s51pkBpahcUauBVtrcJRvkXWDuiqivvYJuf
         8nNg==
X-Gm-Message-State: AA+aEWbJLKV8t1bsi8X8UnkCn7jiLwct5K8EtddXQ0QLtDVHWhP1VIGk
        sJmnjIumNi29ztC4M4msWYg=
X-Google-Smtp-Source: AFSGD/WOj0ipHLzkgfYZO+vBaWsW7mJHTpJgYrrzp4axpA5Fq9NVEC+ZRFScT4mVWwjfM5HT3NKOyA==
X-Received: by 2002:a65:48c4:: with SMTP id o4mr845219pgs.371.1542698245792;
        Mon, 19 Nov 2018 23:17:25 -0800 (PST)
Received: from localhost.localdomain ([119.40.32.42])
        by smtp.gmail.com with ESMTPSA id b5sm30638974pfc.150.2018.11.19.23.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 23:17:25 -0800 (PST)
From:   Hua Su <suhua.tanke@gmail.com>
To:     mb@lightnvm.io
Cc:     javier@cnexlabs.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, suhua.tanke@gmail.com
Subject: [PATCH] lightnvm: pblk: modify a comment
Date:   Tue, 20 Nov 2018 15:16:50 +0800
Message-Id: <20181120071650.5379-1-suhua.tanke@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Does the code want to express that it should be like this?

Signed-off-by: Hua Su <suhua.tanke@gmail.com>
---
 drivers/lightnvm/pblk-rb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index b1f4b51783f4..9f7fa0fe9c77 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -147,7 +147,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
 
 	/*
 	 * Initialize rate-limiter, which controls access to the write buffer
-	 * but user and GC I/O
+	 * by user and GC I/O
 	 */
 	pblk_rl_init(&pblk->rl, rb->nr_entries);
 
-- 
2.19.1

