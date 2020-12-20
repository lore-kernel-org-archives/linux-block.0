Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1133C3526C
	for <linux-block@archiver.kernel.org>; Sun, 20 Dec 2020 15:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7437023104
	for <linux-block@archiver.kernel.org>; Sun, 20 Dec 2020 15:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgLTP3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Dec 2020 10:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgLTP3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Dec 2020 10:29:32 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75178C0613CF;
        Sun, 20 Dec 2020 07:28:52 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 11so4983185pfu.4;
        Sun, 20 Dec 2020 07:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bE45RQX8On0q+1ZjN2GQUTHY9G5SB7p2r5QxuZer+K4=;
        b=sW5DNDtJ7kx0uhhutIqUM5rYy05w/sFq1D3nMoJxvqdIZimpByuZkpQjCgYN1eOYN6
         JglfuDwTnuoElKQqkPAznuD4RW4NasNI5/kI4VALeFptRnH9Wbu5TZRB7sjKn0avfy0u
         uI2XwOCLeRHZxn7Z5+vXyFaTjsSO59qhbTy/fjoeUAZu2jtde81gR3UueK+x80zgXOUO
         X2H4j59ORCJN0w3Jh3cjEoV38NyMF/eXW2+H6JBgA9gDCIGZbsS1t7WtFBLljdhGNgIP
         PxuJ2DGBQ8EgPKbf+Rztq2UYnoznMzU74Ac1wqjVZpi5ZE7PBo3UmpQ1Z93PuhT44ioD
         RdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bE45RQX8On0q+1ZjN2GQUTHY9G5SB7p2r5QxuZer+K4=;
        b=ulzSrJX423zqoSTzhqbATsJjG3O8W58/vPw81vkICdcZMMUP/wtB4pQbIrzwwebBud
         6wLRMu/5zbS+2sSslYZ64qVGoO4MZyNstn3iqNCsoYWnHQQU1T/HL56vf4cKQO1Hu0yc
         Ef5txuWNO6UnqUDWWSLSEvZ9AnArqRrllfxRKpz2rIqzr1I4PF1ae4DQynt/V1P3JIz+
         Mfb6kPCO4pAb9mZ5lJ3oBrK34SnFuwf7rAhdNZmTtwMEXBjyKM70FO3887mvukboBL6M
         EawT9CF3NxaRXftJ+QegEE9G85XqmSC6VLLX9DKX6PS+q+umQhZsgjmTbqfeipQcqBI+
         3UmA==
X-Gm-Message-State: AOAM53233020zzFt9oVBfu9FsNkVbsL9hp9tLfL1vwzKJtGgifObPmtj
        jQz0J79E7fPuVDUUDAul60c=
X-Google-Smtp-Source: ABdhPJxF0gSQR6N4VSqvUdXZfBH4u7HUqGCHhvDLaSb2rQxOR9ZGjnJwp/R6zp/yQb375T6+RHGd2g==
X-Received: by 2002:a63:e849:: with SMTP id a9mr11702832pgk.300.1608478132043;
        Sun, 20 Dec 2020 07:28:52 -0800 (PST)
Received: from localhost.localdomain ([103.248.31.152])
        by smtp.googlemail.com with ESMTPSA id j3sm12981625pjs.50.2020.12.20.07.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 07:28:51 -0800 (PST)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     justin@coraid.com
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH] block: aoe: Use seq_putc() if possible
Date:   Sun, 20 Dec 2020 20:58:29 +0530
Message-Id: <20201220152829.65094-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a single character that is printed out. Use seq_putc() for
it to simplify the code.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/block/aoe/aoeblk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index c34e71b0c4a9..742c353aff54 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -147,7 +147,7 @@ static int aoedisk_debugfs_show(struct seq_file *s, void *ignored)
 			seq_printf(s, "%c%s", c, ifp->nd->name);
 			c = ',';
 		}
-		seq_puts(s, "\n");
+		seq_putc(s, '\n');
 	}
 	spin_unlock_irqrestore(&d->lock, flags);

@@ -465,4 +465,3 @@ aoeblk_init(void)
 	aoe_debugfs_dir = debugfs_create_dir("aoe", NULL);
 	return 0;
 }
-
--
2.29.2
