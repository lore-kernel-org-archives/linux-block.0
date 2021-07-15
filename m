Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40957C47E48
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A9361396
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbhGOE6e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 00:58:34 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:36353 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbhGOE6e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 00:58:34 -0400
Received: by mail-pg1-f170.google.com with SMTP id s18so4777405pgq.3;
        Wed, 14 Jul 2021 21:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RwWOR0IhmOLWqkK1O+cYkuwCpPGb+kOKJBNKG5jnTpU=;
        b=LE9wWrqhfKrZn0VU411WAHANZIErX4fRvj2MHVL1yzFV48+DrUe6Pcl5teh0pX6HW1
         HmWfbqBt679mMvZCOuxfBqv1DonNStN3zlh8dTKwFigiygrngq8MF+Lu+EcBs2KU/kBn
         UxNaVATRmsFKiQR5PBHwtF+AKY57H2a7hP6krMurgNVZ5ON79HZ6tDVz1haZLvjCpxKx
         O+z6sxwEJJj6YLVb5m/PwD3rKby29NeZNow1bbneKFjiV8t3bxsvCyVm+RRmiFLiAHWB
         8No0gKxtkUoIWu4LfGE25wLqWKuPCCPW3HjJZVo01TbzY35GQoMeXDcOmzbfm/gbqCDF
         cS5g==
X-Gm-Message-State: AOAM530i3/MM15qKxpbQpaFSZIcilZC0/9KT9o2OYgqN40qOExfRnsx8
        lheUx+72gEDVs3AXMVAV2+w=
X-Google-Smtp-Source: ABdhPJxFKtIYg8/oXrVU/5djMsZbWQlaJM2lU7R9GYHkOBQe9vzWrdPOCBqgGCp0ivlpcsSc0Ec02w==
X-Received: by 2002:aa7:8d56:0:b029:327:6dc:d254 with SMTP id s22-20020aa78d560000b029032706dcd254mr2376165pfe.69.1626324938050;
        Wed, 14 Jul 2021 21:55:38 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id d2sm4665819pfa.84.2021.07.14.21.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 21:55:37 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 1/6] block: refcount the request_queue early in __device_add_disk()
Date:   Wed, 14 Jul 2021 21:55:26 -0700
Message-Id: <20210715045531.420201-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715045531.420201-1-mcgrof@kernel.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We refcount the request_queue right now towards the end of the
__device_add_disk(), however when we add error handling on this
function we'll want to refcount the request_queue first, so that
we can simply bail right away on error. No point in doing any
work on the queue if its invalid. Otherwise we'd also be
unwinding all the work we had done towards the very end.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index af4d2ab4a633..4dd6db3618f2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -464,6 +464,15 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 {
 	int ret;
 
+	/*
+	 * Take an extra ref on queue which will be put on disk_release()
+	 * so that it sticks around as long as @disk is there.
+	 */
+	if (blk_get_queue(disk->queue))
+		set_bit(GD_QUEUE_REF, &disk->state);
+	else
+		WARN_ON_ONCE(1);
+
 	/*
 	 * The disk queue should now be all set with enough information about
 	 * the device for the elevator code to pick an adequate default
@@ -528,15 +537,6 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	if (register_queue)
 		blk_register_queue(disk);
 
-	/*
-	 * Take an extra ref on queue which will be put on disk_release()
-	 * so that it sticks around as long as @disk is there.
-	 */
-	if (blk_get_queue(disk->queue))
-		set_bit(GD_QUEUE_REF, &disk->state);
-	else
-		WARN_ON_ONCE(1);
-
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
-- 
2.27.0

