Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD4C636CB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DF6613E4
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhGOVCy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:02:54 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:55133 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhGOVCl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:41 -0400
Received: by mail-pj1-f47.google.com with SMTP id g24so4973328pji.4;
        Thu, 15 Jul 2021 13:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLLNi9VXjJkWzzy68G2X0bcaGi+7hJjQeehmKMhLHEs=;
        b=XpIG46aHcoF3tFoQIxYvONH6RM/CIpqVoZbD8MgwHuzfaW6HGajjlpvPFi0HvZEgpt
         DvIXpjcKYdoJ/kwr2R36fXncyK0L2xhSXtIihTN9TaUix02F8ooXeJ5Qf1Zq+Tcl7cDX
         Nm+Cx1WqZDuzhH3LEVLE9LyTS67Ax+m/Hc6CGhUgT8TDF6+zYbD8ci9UAU9tebnGhBp8
         FSmxjwV3+xZiaoa1neyqfjFIm1gLq9b4JpEtPjTZ+UF4eCZCBOfGtJo/0tqpJ+HdLatA
         08iP4UNv4GzCN2LLrVRg8AHocEQWz3Bn+tUQmABBOWM3GbYgeGwvx1u/SpO4db52CoRx
         qL+Q==
X-Gm-Message-State: AOAM530HKI10yF88+YWRtrZtQsV7NqYZrOg3+a8EuZpChKjWoh6ifhgP
        OApzVyHSeF9XcQcWGdcCMSM=
X-Google-Smtp-Source: ABdhPJyuaYWeLHzMLwPAS1LMyRjn78JPUKvKvzC1reXvgqvU3pNH3xXZD5UhN7spEXoIMreX73YJKQ==
X-Received: by 2002:a17:90a:e288:: with SMTP id d8mr6297617pjz.226.1626382787073;
        Thu, 15 Jul 2021 13:59:47 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id b3sm7610292pfi.179.2021.07.15.13.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:46 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 08/12] block/ataflop: use the blk_cleanup_disk() helper
Date:   Thu, 15 Jul 2021 13:59:16 -0700
Message-Id: <20210715205920.2023980-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715205920.2023980-1-mcgrof@kernel.org>
References: <20210715205920.2023980-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the helper to replace two lines with one.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/ataflop.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index a093644ac39f..abb6fde0bd81 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2076,8 +2076,7 @@ static int __init atari_floppy_init (void)
 
 err:
 	while (--i >= 0) {
-		blk_cleanup_queue(unit[i].disk[0]->queue);
-		put_disk(unit[i].disk[0]);
+		blk_cleanup_disk(unit[i].disk[0]);
 		blk_mq_free_tag_set(&unit[i].tag_set);
 	}
 
@@ -2135,8 +2134,7 @@ static void __exit atari_floppy_exit(void)
 			if (!unit[i].disk[type])
 				continue;
 			del_gendisk(unit[i].disk[type]);
-			blk_cleanup_queue(unit[i].disk[type]->queue);
-			put_disk(unit[i].disk[type]);
+			blk_cleanup_disk(unit[i].disk[0]);
 		}
 		blk_mq_free_tag_set(&unit[i].tag_set);
 	}
-- 
2.27.0

