Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A65C636C9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 19:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0E2613C4
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 19:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbhGOTzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:55:42 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:39469 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344939AbhGOTyl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 15:54:41 -0400
Received: by mail-pf1-f176.google.com with SMTP id b12so6525758pfv.6;
        Thu, 15 Jul 2021 12:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5J4xjtFnDYruSN/ZXrs/qzKjWSmRmgInJ+MeQlMWoK4=;
        b=t97RnKmcTUI1W57WPxq7IzlI0Y1i46i9+ESUNqqDubvfXXDLuIU5geZELC33zsCPd+
         2b2FxMiM0LMmW48+JiKy0US5fCgV8NpVwX22YGc+TYU56maBymFBhESd4uwB8lnwWUO0
         25vo/uK9EJiQmx2rgJSHFWrtzG4La0WIegMCXM9IiX8RnIRrww3kyv/iGmnrPIA8QZci
         Yp4hWzZTiTMfRrJe+NQ/+SxITX/Iu+yYh9kAPcxjcoCAbQL8HQFLe6xzWsxrAkkLl+/9
         3U2cch/b10UT11yvR0JFU+Ay3Xy7SrgBgSUam9tTLBL91JLB8gTxYZu6ZsPfhlBHNpnz
         jQ9g==
X-Gm-Message-State: AOAM533CYDdO+25Benbs5LI68minBMvKEc/BNp39HWYRbFbMjfkzEUAy
        zErcMnK1aUROECEreptgTyg=
X-Google-Smtp-Source: ABdhPJweQ+nPM22EKIW5Ufy33HaXh3f2+DxXnFtFPyMIuVkbm2Ed7VOfEluv3VPbG8AHPwMsx6o/Tw==
X-Received: by 2002:a63:1324:: with SMTP id i36mr6279793pgl.8.1626378706491;
        Thu, 15 Jul 2021 12:51:46 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id g141sm7469517pfb.210.2021.07.15.12.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 12:51:45 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/3] loop: add error handling support for add_disk()
Date:   Thu, 15 Jul 2021 12:51:39 -0700
Message-Id: <20210715195141.1882285-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715195141.1882285-1-mcgrof@kernel.org>
References: <20210715195141.1882285-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/loop.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f37b9e3d833c..efbd8e29aca7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2326,10 +2326,17 @@ static int loop_add(int i)
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
-	add_disk(disk);
+
+	err = add_disk(disk);
+	if (err)
+		goto out_cleanup_disk;
+
 	mutex_unlock(&loop_ctl_mutex);
+
 	return i;
 
+out_cleanup_disk:
+	blk_cleanup_disk(disk);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&lo->tag_set);
 out_free_idr:
-- 
2.27.0

