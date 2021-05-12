Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7085C433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EB861289
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhELHDI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 03:03:08 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:33504 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhELHDI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 03:03:08 -0400
Received: by mail-pl1-f171.google.com with SMTP id b21so12075651plz.0;
        Wed, 12 May 2021 00:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRvFdmtkNzHaWAB0nQVi9b7sIc+ospqDVc0cm2z7RwQ=;
        b=o1HLi2samwuYvQDpF9p7OEJnM4E2sTrX+zoFnSJynTDfJMDz2YfTHvELFruZDhoC84
         QaBshc6KURrcQK6/DZ2GeI1ifJO9GNuSLUTcPfTgHOj9Y39mvuj2XKPr+wDT5pn+Inht
         DE5kaOL9SjuQlbYKom60kxDI8AnPLOVPGHrk1yVADNAw7hg5U7aZSp38aNl7ApLVh3en
         0PPA6WM2rLPZdvzBYBYh6zz25ToFprFkBrbWyoIbQG7KS7WhSW2vEDt4cXM85aRZTAr8
         KHKs9Qoq0hEm/V7VmdK9yNxCJZBDHvpQXSLCuoLZ8hcyLaNpHeIinMkMM91Fhkci0dWB
         TOYQ==
X-Gm-Message-State: AOAM5320d7NyjBSP6sci7kTfzSn0jthiM4QTpAtSUQar9DbrJWlUE8Xp
        ARkZp+pAHFtSRlUMBir3Osk=
X-Google-Smtp-Source: ABdhPJz/mcDgjq9Q+6dTMJ+kbfCKozHsXvM/8eX3n1CWnx/zV1ivTC68jejjox1Wqw30enC3VG8WtQ==
X-Received: by 2002:a17:903:244:b029:ec:9666:9fc6 with SMTP id j4-20020a1709030244b02900ec96669fc6mr33657368plh.63.1620802919597;
        Wed, 12 May 2021 00:01:59 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c195sm15186371pfb.5.2021.05.12.00.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:01:58 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 53A3642433; Wed, 12 May 2021 06:46:35 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 6/8] loop: add error handling support for add_disk()
Date:   Wed, 12 May 2021 06:46:27 +0000
Message-Id: <20210512064629.13899-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210512064629.13899-1-mcgrof@kernel.org>
References: <20210512064629.13899-1-mcgrof@kernel.org>
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
 drivers/block/loop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d58d68f3c7cd..a22d8c985bf3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2170,10 +2170,15 @@ static int loop_add(struct loop_device **l, int i)
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
-	add_disk(disk);
+	err = add_disk(disk);
+	if (err)
+		goto out_put_disk;
+
 	*l = lo;
 	return lo->lo_number;
 
+out_put_disk:
+	put_disk(lo->lo_disk);
 out_free_queue:
 	blk_cleanup_queue(lo->lo_queue);
 out_cleanup_tags:
-- 
2.30.2

