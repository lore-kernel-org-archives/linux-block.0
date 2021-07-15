Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61857C636CA
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFF3613D4
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhGOVDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:03:11 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:34540 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhGOVCp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:45 -0400
Received: by mail-pf1-f174.google.com with SMTP id o201so6712074pfd.1;
        Thu, 15 Jul 2021 13:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqmQTgkBRpmWMg0yfS7sVgm7RNMrAIBkaY+MOepqYKs=;
        b=UqqpNYBlmyOPIOTrwpOkjX44EEs4T35vUZ6O6wKewFZX7AhSSOkHUrCArEOxe+5xD0
         2rVG3cmwhJR0LW8QgVhYNPcSyqKBcEJk7X0Q1vjBOEjJTn0DIg3dlZUiggNOnQ62cORq
         xfzAQFJ5gb50/rGALxjmhdMuT3O14q7ufRaoxKU9doyAzLQGRzAYGNzwuufsuZd/m8qW
         ZccXcNtkLAeitmcaxRtLhqetkaxTtXegiMHLu8gHNkXHlQUsV1QmPW1E8o/xRd/Tb1Tx
         8omjgLDBF0cwyYLzP4bdEt4aMi6oHDW5sg40uElDnxrHaxCvz2/+ywoClUwGWzib8ns7
         j/GQ==
X-Gm-Message-State: AOAM532ET0k7clIZx3h6DgnqcqPBTdYPTW4Eaej8kv932sgjfzSsuazg
        COoxeYinVYhINYQs7HMsLAY=
X-Google-Smtp-Source: ABdhPJxcMLzvFdqNYKT7Tq81OxvFslLarcy23ysTyw/EzXlQDYZHzZjG6LXc3cM7T3YMQVnn7j31eg==
X-Received: by 2002:aa7:8509:0:b029:2e5:8cfe:bc17 with SMTP id v9-20020aa785090000b02902e58cfebc17mr6699115pfn.2.1626382791516;
        Thu, 15 Jul 2021 13:59:51 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id 123sm7766994pfw.33.2021.07.15.13.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:50 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 10/12] block/ataflop add error handling support for add_disk()
Date:   Thu, 15 Jul 2021 13:59:18 -0700
Message-Id: <20210715205920.2023980-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715205920.2023980-1-mcgrof@kernel.org>
References: <20210715205920.2023980-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

We reuse the atari_floppy_disk_remove() call.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/ataflop.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 73eb80b58888..4b3f1158fa04 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2081,7 +2081,9 @@ static int __init atari_floppy_init (void)
 	for (i = 0; i < FD_MAX_UNITS; i++) {
 		unit[i].track = -1;
 		unit[i].flags = 0;
-		add_disk(unit[i].disk[0]);
+		ret = add_disk(unit[i].disk[0]);
+		if (ret)
+			goto err_out_dma;
 	}
 
 	printk(KERN_INFO "Atari floppy driver: max. %cD, %strack buffering\n",
@@ -2091,13 +2093,10 @@ static int __init atari_floppy_init (void)
 
 	return 0;
 
+err_out_dma:
+	atari_stram_free(DMABuffer);
 err:
-	while (--i >= 0) {
-		blk_cleanup_disk(unit[i].disk[0]);
-		blk_mq_free_tag_set(&unit[i].tag_set);
-	}
-
-	unregister_blkdev(FLOPPY_MAJOR, "fd");
+	atari_floppy_disk_remove();
 out_unlock:
 	mutex_unlock(&ataflop_probe_lock);
 	return ret;
-- 
2.27.0

