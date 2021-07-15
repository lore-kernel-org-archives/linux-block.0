Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFD5C636C8
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2AAA613D4
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhGOVCZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:02:25 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:34390 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhGOVCY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:24 -0400
Received: by mail-pg1-f169.google.com with SMTP id 62so7803071pgf.1;
        Thu, 15 Jul 2021 13:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGT+ghC1hpVCiIIQ0oRQHMxPfyR1Tgyc8TzaGb0wsdg=;
        b=bIL0ad1WpolGamHRJAAs9T2ejrtX7E5+sV2mo7sGslyW62Qvbh6UwodXNo35Vl+CaL
         gAXbOUFXnn0ADXD27+/dxoKJ4ArjdPKVP+imc5mkRpzaP2B1DVM8AYZ+q1ygQAuf5mE9
         c8fpcy4HhuNcj3hJrxt+rX+CKG2jWh0gG0mvcrZqRSIGTW2qLw+gYFUHDzdk7gR/yfeJ
         DEEEfZB6T3tNC2PUVTPuQNbQ568sJvwRbF8kft2hiRgK7RxAN/ZZF306SJwoEOOroq5O
         JipxGROQge/2/BO3EPnV/LDdLLdskC427dZ+u6Dp3b5DMU/qklc1Vy3x2kpqduj7sazy
         Ojlg==
X-Gm-Message-State: AOAM530j55hrnYjoqTXfWchT5txMUYl9uEYKRcjZZ70R0OXbZ9HAB2XW
        8di3W6p5rSd+Ug5IDiZ+L/DXamqXFW36Mg==
X-Google-Smtp-Source: ABdhPJxExgdA9PU52mRNJV/ruiZUIuczVQXGMcoaP9YwU81zGA+CMxXccjyP7hPO1VkeU63bO10kvw==
X-Received: by 2002:a65:498a:: with SMTP id r10mr6445689pgs.7.1626382770641;
        Thu, 15 Jul 2021 13:59:30 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id t5sm9011006pgb.58.2021.07.15.13.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:29 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 01/12] floppy: fix add_disk() assumption on exit
Date:   Thu, 15 Jul 2021 13:59:09 -0700
Message-Id: <20210715205920.2023980-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715205920.2023980-1-mcgrof@kernel.org>
References: <20210715205920.2023980-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Even if the queue was cleaned up on exit,
putting the disk *is* still required, and
likewise, blk_cleanup_queue() on a null queue
should be a no-op now, after the patch titled
"block: skip queue if NULL on blk_cleanup_queue()"
so it is safe to use even if the queue is NULL.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/floppy.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 87460e0e5c72..b68f4b6bf737 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4953,19 +4953,6 @@ static void __exit floppy_module_exit(void)
 				blk_cleanup_queue(disks[drive][i]->queue);
 		}
 		blk_mq_free_tag_set(&tag_sets[drive]);
-
-		/*
-		 * These disks have not called add_disk().  Don't put down
-		 * queue reference in put_disk().
-		 */
-		if (!(allowed_drive_mask & (1 << drive)) ||
-		    fdc_state[FDC(drive)].version == FDC_NONE) {
-			for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
-				if (disks[drive][i])
-					disks[drive][i]->queue = NULL;
-			}
-		}
-
 		for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
 			if (disks[drive][i])
 				put_disk(disks[drive][i]);
-- 
2.27.0

