Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6381DC636C9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B771613DF
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhGOVCa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:02:30 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:38510 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhGOVC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:29 -0400
Received: by mail-pg1-f179.google.com with SMTP id h4so7772785pgp.5;
        Thu, 15 Jul 2021 13:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2wFxUXdbghFJMPTwcg5/hhMr2SELHvKFsnd/NGpC88=;
        b=A7nxjbmf+SOaHeWF6IGVaT8f5201abzqiUY2lchSoPoG5VmwRQdQ7+4JNzWZd0oITE
         1NpQBFfcVy3uJAZSAHu1q6vvC87aQljaXErd1s1G+L8O18KRuQhhwiVOmIDoovvS7eIX
         9Gq3MZk9Mr1ILh/dmqZu0V2N56A9Y2Rx/cdf4FMSnCNwgvvRuFdWjZdnlu5Xcy5fnH0w
         QkyUpN33lHN2sWIHjaTaQRCDDNYdT2ad1JFD+bUlyglmpwrhCSlYt+tdpUTs7Euh2nXD
         tWHTLtEPR9rS9Qt4o88ESjp3dVdcLqN2KayW3lfBghSVUaiHE8aMtR2tqDKZonhhXwLU
         reVg==
X-Gm-Message-State: AOAM533v6230VRuORFZa2SC8Jzf9JRSZQjaGSRGoYDkpcaLu/jPaapHx
        W1cC7tFPlx0fz4hAxByFeCo=
X-Google-Smtp-Source: ABdhPJzlgX1Cvbg+yQUW1/jCYW2i+b9XT0a+4LENyfzL8wVtnwO0gGxMYge9AoLvADGTBm5CAbWSQQ==
X-Received: by 2002:a63:582:: with SMTP id 124mr6294339pgf.299.1626382775049;
        Thu, 15 Jul 2021 13:59:35 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id t6sm9680147pjo.4.2021.07.15.13.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:34 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 03/12] floppy: add error handling support for add_disk()
Date:   Thu, 15 Jul 2021 13:59:11 -0700
Message-Id: <20210715205920.2023980-4-mcgrof@kernel.org>
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

We take advantage of the new ability of del_gendisk() ...

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/floppy.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index ba690affc751..cad17b49e700 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4478,6 +4478,7 @@ static const struct blk_mq_ops floppy_mq_ops = {
 };
 
 static struct platform_device floppy_device[N_DRIVE];
+static bool registered[N_DRIVE];
 
 static bool floppy_available(int drive)
 {
@@ -4693,8 +4694,12 @@ static int __init do_floppy_init(void)
 		if (err)
 			goto out_remove_drives;
 
-		device_add_disk(&floppy_device[drive].dev, disks[drive][0],
-				NULL);
+		registered[drive] = true;
+
+		err = device_add_disk(&floppy_device[drive].dev,
+				      disks[drive][0], NULL);
+		if (err)
+			goto out_remove_drives;
 	}
 
 	return 0;
@@ -4703,7 +4708,8 @@ static int __init do_floppy_init(void)
 	while (drive--) {
 		if (floppy_available(drive)) {
 			del_gendisk(disks[drive][0]);
-			platform_device_unregister(&floppy_device[drive]);
+			if (registered[drive])
+				platform_device_unregister(&floppy_device[drive]);
 		}
 	}
 out_release_dma:
@@ -4946,7 +4952,8 @@ static void __exit floppy_module_exit(void)
 				if (disks[drive][i])
 					del_gendisk(disks[drive][i]);
 			}
-			platform_device_unregister(&floppy_device[drive]);
+			if (registered[drive])
+				platform_device_unregister(&floppy_device[drive]);
 		}
 		for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
 			if (disks[drive][i])
-- 
2.27.0

