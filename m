Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3B8C2D0FD
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D61A22384
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="TL34dow3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbgEMNjd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 09:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388314AbgEMNi7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 09:38:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E75C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:38:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so7006711wrt.5
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1sTXqRGguAy+llg7dGLJYj6/VWdX40SKxOhmoNPZP0=;
        b=TL34dow3AFECXbJ22HTyK9KKsX1QdBLwrxktF/YGJpH66oiAUsx7m2rSbf4mCCs9hF
         EKiFq6v7JUV8pbTRNRzyQnks+IUVQHjODPEWyzMhtxz9+TuVguf5lZmFyjKiwEHZOiSm
         tfII4L7jNTinj5cOB6qyKXFZwCAUv86HZgmazcxq5qiBwQTOy8O4AA7A5rZ53w/H3fuT
         QxFD4l2FAMJHWSUU5Z3C/ujQjAux3oO8X/oM02mUh7nUSTEjdm8xq9bCMZ8g1iXs9cjd
         2mQPyA6X7tC7DWS7nDgyEh6Rw/gwO8+aHyjeKa/mWri0IRS2H5XbWhghK874x1RGkCcI
         1Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1sTXqRGguAy+llg7dGLJYj6/VWdX40SKxOhmoNPZP0=;
        b=DeNjkis7UO1CwISyquT1A/psverxiAUzxh0qLbmzpRKLbMi8T/eTRByyr/DMG+Z+Af
         Lve5eGh/9cE2fkOcVSyrh5Xz9iVgTHjiJU12UYRLS7wX0ENc1fU0m6Fv5T0wXXFTsTy/
         Jg+Wa89IMdttB4GAsZ4a5uBhMwUcQ/WfEIrBJVx/PaT4xe/DzebmU28c9Y8CyLtSrCrW
         Qxzba0exyFqVnPw6k4ooQqFkieOXXAgv12pEaK85lQta80hS2lroD1KXX8dZSCfuh61T
         O+EIndGiAasZ3dbBYGBmuyA3ht4tOs+etNz81kbivSFcnak5NsPrSJrEzqG1so31QDLe
         I/Dw==
X-Gm-Message-State: AGi0Pub+RVTefyAi+K0s86cXAZynVLVW1Re1Xrlomt6O/TPBPyyvHWO1
        Kh5MZdT+JVeNvi5xEhj4Pau3Zg==
X-Google-Smtp-Source: APiQypJ07uWSubrJZfMnOBzOk7xCePBiIOR3e99yUMkYg7UnoXJyFS7B/1RkG5bqQAmhF6CRbEeeKA==
X-Received: by 2002:adf:e951:: with SMTP id m17mr25514589wrn.352.1589377134532;
        Wed, 13 May 2020 06:38:54 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:53 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 04/11] loop: Switch to set_capacity_revalidate_and_notify()
Date:   Wed, 13 May 2020 15:38:38 +0200
Message-Id: <20200513133845.244903-5-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This was recently added to block/genhd.c, and takes care of both
updating the capacity and notifying userspace of the new size.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e69ff3c19eff..d9a756f8abd5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -240,10 +240,9 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 {
 	struct block_device *bdev = lo->lo_device;
 
-	set_capacity(lo->lo_disk, size);
 	bd_set_size(bdev, size << SECTOR_SHIFT);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+
+	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
 }
 
 static void
-- 
2.26.2.645.ge9eca65c58-goog

