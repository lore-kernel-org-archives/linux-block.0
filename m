Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7F5C636C8
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A5B61360
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhGOVC4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:02:56 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:37785 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhGOVCn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:43 -0400
Received: by mail-pf1-f170.google.com with SMTP id 17so6695690pfz.4;
        Thu, 15 Jul 2021 13:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPCwdzjVkB8a86TpWD6v/0UKVQ7/RSMX74SBoJLREos=;
        b=QfHUhZ9BGNvCnlcB8p74hDTSKThbUM17ga+rYQWyrZnSNqP4AHg+X/PcEJCZeEnlXK
         vVVurahiroFl0bqSEEnmfVCUWxwJ2g6leCm9dHxmumpV/IM/irkWZA25OSkyIION4QCg
         jLBXTIzcZsbQGlLGlajpa0RLRKBoxy3v4jQTxWbtf9sthGhw3XP/W+i6SfKAg/We1PEV
         3IXtmia17Qk+7jIaeHxjpxC66TFpPIOUjQ2PFqWOxgVTuUqsVZfT4tXc7x0Cw+XG7k4v
         XL0nenDUN5BjlzWcvTpANgVTBr6LnGKgZBBZFHrjaqCHuge2cuDYPvcZmXokkmRNGhCC
         mktw==
X-Gm-Message-State: AOAM531JRN0GmT3JJpZ5hMzb4fTZmcfi5r07XmcotGBcSkaNzvApE8UO
        IX2m745ZIaU7oZmeR7ZbbZs=
X-Google-Smtp-Source: ABdhPJxSZA9TfgWsPNk7Vo1VBfXiYIaNrwru6A0NH36fUf3BwqZ1E+E08UJ8ngqj2nHYkf9gIlsFdA==
X-Received: by 2002:a63:5118:: with SMTP id f24mr6452444pgb.34.1626382789473;
        Thu, 15 Jul 2021 13:59:49 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id k4sm6113514pjs.55.2021.07.15.13.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:48 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 09/12] block/ataflop: add a helper for removing disks
Date:   Thu, 15 Jul 2021 13:59:17 -0700
Message-Id: <20210715205920.2023980-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715205920.2023980-1-mcgrof@kernel.org>
References: <20210715205920.2023980-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The del_gendisk() can be used now safely even if add_disk()
did not complete, and so using a helper allows other code to
use this later.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/ataflop.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index abb6fde0bd81..73eb80b58888 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1988,6 +1988,23 @@ static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
 
 static DEFINE_MUTEX(ataflop_probe_lock);
 
+static void atari_floppy_disk_remove(void)
+{
+	int i, type;
+
+	for (i = 0; i < FD_MAX_UNITS; i++) {
+		for (type = 0; type < NUM_DISK_MINORS; type++) {
+			if (!unit[i].disk[type])
+				continue;
+			del_gendisk(unit[i].disk[type]);
+			blk_cleanup_disk(unit[i].disk[0]);
+		}
+		blk_mq_free_tag_set(&unit[i].tag_set);
+	}
+	unregister_blkdev(FLOPPY_MAJOR, "fd");
+
+}
+
 static void ataflop_probe(dev_t dev)
 {
 	int drive = MINOR(dev) & 3;
@@ -2127,19 +2144,7 @@ __setup("floppy=", atari_floppy_setup);
 
 static void __exit atari_floppy_exit(void)
 {
-	int i, type;
-
-	for (i = 0; i < FD_MAX_UNITS; i++) {
-		for (type = 0; type < NUM_DISK_MINORS; type++) {
-			if (!unit[i].disk[type])
-				continue;
-			del_gendisk(unit[i].disk[type]);
-			blk_cleanup_disk(unit[i].disk[0]);
-		}
-		blk_mq_free_tag_set(&unit[i].tag_set);
-	}
-	unregister_blkdev(FLOPPY_MAJOR, "fd");
-
+	atari_floppy_disk_remove();
 	del_timer_sync(&fd_timer);
 	atari_stram_free( DMABuffer );
 }
-- 
2.27.0

