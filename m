Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C22CEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 21:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjF2VXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 17:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjF2VXp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 17:23:45 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C6D2D4C
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 14:23:45 -0700 (PDT)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A0DFD3F32D
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688073823;
        bh=lBu3qM/V63MFPKIE8Q51C0JVShDE9+Oj/gb/00UQ8Pk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jCJ3qeoEAMh4uovG6sVYYxR8yplf95WzWOOVcjlaWrxWXMyQ5GxY6lYGvwpzfoZQx
         nr7pw3R4NCAOjTH25UW8RL13HI0tr/R0ZrIxF7dx7MgKf7FaRlYjcSzNZkyKv0vi2Z
         yAepuuy6uAUZ0ZApz4C2MO7jo9EwMTYbb1LiPH2iWDJf5GQYQb93XFuof61Az9RHKb
         SOKkdoIb4j8BH+CroL7TOf0Irb0IpDCJFyR0VviJBFcj1rOFQaxBLRPvEi4plJu5xX
         6J3nNXt854qNKl6YVHP58RZGuq/V+jl4SSZMJbH2XhNBtkyVxJrrn4Mo2L5kl1QTrS
         +PhS1tlJodMFQ==
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b89454af6cso1136674a34.3
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 14:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688073822; x=1690665822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBu3qM/V63MFPKIE8Q51C0JVShDE9+Oj/gb/00UQ8Pk=;
        b=fBDEv5g5qPLja0EuFLeOMvnXDg/ZEaGmujw311u9Kb1rED4r4ajqHR6JRQsJSx/AHw
         TBewtgacBIzgJpRMuvGGJcXt8SRjMU3OIpWCnkskYk2DJg2EZUj2poeZZaMI6jY4zpKB
         NeFmb/bDlidzRPBhp+K87A+T12j0yhP2AKVzEBNy+58CDz8FOBq1TLeRr00cxL6Fj1cA
         JCIvGcRudxWz+WPE8mnmJZn9jE/ZQVE+zPJSRpoSgfxoCJ9yRtFEAYYdYCThNKqrDFOw
         E+hsBYRc576AUm5eVMOSH3xjJ1ANLmWNUfHw1mwpn6y7XUVtZpDPc8EJmqQ52bCjG1gB
         lKMA==
X-Gm-Message-State: AC+VfDwQxtaa1JXw1lOnBP711y3Ka6KZmorDIJkbb6vQBhaUzW3Ghh8F
        hKkB00GbR92jOlKLPxo11LNAniNQ3p2HfS+mzT/yor/QkovPG1YVLNxffqxE226tN/CWx5vvMDr
        T5eBIUas4wTo/Be1qOHA9TxZD7WG8PlnCTRRHLIXj
X-Received: by 2002:a9d:7412:0:b0:6b3:70ee:3055 with SMTP id n18-20020a9d7412000000b006b370ee3055mr1118630otk.13.1688073822631;
        Thu, 29 Jun 2023 14:23:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5BSkQ14DJnLGsVYL3rkT1q6lTW+tOQ0ujOLMJuBmJHltoGd6bcezyTaH/cgHrQoi/rbwjVig==
X-Received: by 2002:a9d:7412:0:b0:6b3:70ee:3055 with SMTP id n18-20020a9d7412000000b006b370ee3055mr1118618otk.13.1688073822478;
        Thu, 29 Jun 2023 14:23:42 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4e1:83a2:7720:9030:a195:e622])
        by smtp.gmail.com with ESMTPSA id q6-20020a9d6646000000b006b871010cb1sm2711764otm.46.2023.06.29.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:23:42 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] loop: deprecate autoloading callback loop_probe()
Date:   Thu, 29 Jun 2023 18:22:55 -0300
Message-Id: <20230629212256.918239-2-mfo@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629212256.918239-1-mfo@canonical.com>
References: <20230629212256.918239-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 'probe' callback in __register_blkdev() is only used
under the CONFIG_BLOCK_LEGACY_AUTOLOAD deprecation guard.

The loop_probe() function is only used for that callback,
so guard it too, accordingly.

See commit fbdee71bb5d8 ("block: deprecate autoloading based on dev_t").

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 drivers/block/loop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bc31bb7072a2..21bcd6ffe241 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2095,6 +2095,7 @@ static void loop_remove(struct loop_device *lo)
 	put_disk(lo->lo_disk);
 }
 
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 static void loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
@@ -2103,6 +2104,7 @@ static void loop_probe(dev_t dev)
 		return;
 	loop_add(idx);
 }
+#endif
 
 static int loop_control_remove(int idx)
 {
@@ -2237,8 +2239,11 @@ static int __init loop_init(void)
 	if (err < 0)
 		goto err_out;
 
-
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 	if (__register_blkdev(LOOP_MAJOR, "loop", loop_probe)) {
+#else
+	if (register_blkdev(LOOP_MAJOR, "loop")) {
+#endif
 		err = -EIO;
 		goto misc_out;
 	}
-- 
2.39.2

