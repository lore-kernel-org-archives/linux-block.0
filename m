Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC0AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128ED60555
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhIVMjb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhIVMjb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 08:39:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA970C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:38:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g14so2630997pfm.1
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nthaXLO1pUhxWAYzWmco/CUDncYPG0iIDRSeW2wjCys=;
        b=Bv9JrIKc99jr4kID589LR62frfgMjCf7yTda/VnS3vnki/zl7mPBUcbKaqoe19L8Ex
         E8QPyk4Bv+BJy47Z6X9tZ9Js/zSN6jlGtgtZ9pTAnY5AWc0UeLrtpoibs7YekMDY7cNu
         OylIULU6ZaFHBi4Lfn6k/Szy4sVCO5SlHeOegFdRnKoZiODvryVVLBppI/fc00yKB2PI
         B827cZqqR4nTHJ08uNKnQdyCPy8fGfpEJFwKFqIjC19u4zTKjldR7m0hAMxjOSVfdDyh
         CWcGdH30f+Fi7jqtemjvYSQugo9DCkviNSQiNyMWKQjsCgPyfEfpfBCfYONEo0SSs4gw
         Ljbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nthaXLO1pUhxWAYzWmco/CUDncYPG0iIDRSeW2wjCys=;
        b=29wEkEjrZpix54M8SAlWMh45tpe0Q8OS1yxw4olDtOnuStl2W+Z/wzUWovZqBIIRdd
         SH+zrbL8XbrggrhA/+7JEVnixIwL5Vik3PkPEvNNyKXbpsBicbQe6Vaw8flO0IGU1sKk
         J77z8ggqP6LJ84iU/bgboaveYOFmdBripUXEkAGBJXIXXCY32BXrsPeKbUTmM4EnK8J8
         h570dZv3ZjdQNdaowNreldcQRF8m8ElcbZl6jVtzivvRMqSJ5pegBk9rIGiTE/q7b7+W
         iwWJojFKSyUyZnDtLAdmfXLMuRd/Lj4YstWPuOgqyDeAlbWza5iIRXd/mFIy7qAyQxp0
         mpcg==
X-Gm-Message-State: AOAM532TQgnk7siEasLK3c9wxg2PAXZuPSXNPVnpw8tTLF7TpydBGHPd
        5AXi8yepyUoYseVQdY7RnQoo
X-Google-Smtp-Source: ABdhPJxywywpVzFTIQSCfO7YtvabvDBtkA5BSFrMFfPv8nJh+DNNVDsMrLYdcoJNAdiBv74yp/IHEg==
X-Received: by 2002:aa7:950e:0:b0:444:b01a:9dd1 with SMTP id b14-20020aa7950e000000b00444b01a9dd1mr28612740pfp.72.1632314279151;
        Wed, 22 Sep 2021 05:37:59 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id h9sm6135932pjg.9.2021.09.22.05.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:37:58 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: [PATCH v2 3/4] loop: Remove the unnecessary bdev checks and unused bdev variable
Date:   Wed, 22 Sep 2021 20:37:10 +0800
Message-Id: <20210922123711.187-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922123711.187-1-xieyongji@bytedance.com>
References: <20210922123711.187-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The lo->lo_device can't be null if the lo->lo_backing_file is set.
So let's remove the unnecessary bdev checks and the entire bdev
variable in __loop_clr_fd() since the lo->lo_backing_file is already
checked before.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/loop.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index eab6906326cc..980b538c008a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1329,7 +1329,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 {
 	struct file *filp = NULL;
 	gfp_t gfp = lo->old_gfp_mask;
-	struct block_device *bdev = lo->lo_device;
 	int err = 0;
 	bool partscan = false;
 	int lo_number;
@@ -1397,16 +1396,14 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	blk_queue_io_min(lo->lo_queue, 512);
 	invalidate_disk(lo->lo_disk);
 	loop_sysfs_exit(lo);
-	if (bdev) {
-		/* let user-space know about this change */
-		kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
-	}
+	/* let user-space know about this change */
+	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
+	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	lo_number = lo->lo_number;
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 out_unlock:
-- 
2.11.0

