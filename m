Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B271C07E95
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A5D610A7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 18:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhGTRlK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:41:10 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:42673 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhGTRk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 13:40:26 -0400
Received: by mail-pl1-f174.google.com with SMTP id v14so11823870plg.9;
        Tue, 20 Jul 2021 11:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZ31eD4t5dq2nfz4xn+WsopS243sTMmY3fpSxyRz71U=;
        b=fqaItfAvLnZ6HS9tEzRostpY7261eLoOEjbfrATZx4Z7ykDdKpZp6TlhcgY7vIXybp
         Ez3Kqg8UPy9YkaXcycYaR2QxFX7QoWGRxq+gDuD4YfYtnu1GcnShVEPd9MvOWvrADZoU
         4va3Irqbwu7eGMQEK8mHdFOo/TmhiioxwJ7gsSvVCN7QBW74NGZoLnC69+NMX4rwZo4K
         fMBhLgK3zR7CP05gBoc+AbPQ+WF6ZzgoixMlzWuaX3TD2CSDiZIM698j8Fd/YOca5Z7h
         JVtyg/KMISj76XUak1Go7WCf8N+KzYUbbwkjuqjiIjQKash8enHo7WhIOLsY8usKcYrm
         U5Sg==
X-Gm-Message-State: AOAM530SjyzdtN66EXIEArwKhkCtU0qXx/3vNtpSrl4cM03pAcNbqkQ8
        60g7mc39ZAa/RZEjq7FElYs=
X-Google-Smtp-Source: ABdhPJwwODfcD0s1Eu+3gsvCnW1LsZYhFzYoyYL58tkwevVSuiWEaBMbJLhhkxKoP7hFxXmuGggjOg==
X-Received: by 2002:a17:90a:3d0d:: with SMTP id h13mr31663687pjc.20.1626805264463;
        Tue, 20 Jul 2021 11:21:04 -0700 (PDT)
Received: from localhost ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id e2sm27930763pgh.5.2021.07.20.11.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 11:21:03 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5/5] fs/block_dev: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
Date:   Tue, 20 Jul 2021 11:20:48 -0700
Message-Id: <20210720182048.1906526-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720182048.1906526-1-mcgrof@kernel.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The GENHD_FL_DISK_ADDED flag is what we really want, as the
flag GENHD_FL_UP could be set on a semi-initialized device.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/block_dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0c424a0cadaa..0b77f9be8e28 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1338,7 +1338,8 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 	disk = bdev->bd_disk;
 	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj))
 		goto bdput;
-	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
+	if ((disk->flags &
+	    (GENHD_FL_DISK_ADDED | GENHD_FL_HIDDEN)) != GENHD_FL_DISK_ADDED)
 		goto put_disk;
 	if (!try_module_get(bdev->bd_disk->fops->owner))
 		goto put_disk;
@@ -1407,7 +1408,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 
 	mutex_lock(&disk->open_mutex);
 	ret = -ENXIO;
-	if (!(disk->flags & GENHD_FL_UP))
+	if (!blk_disk_added(disk))
 		goto abort_claiming;
 	if (bdev_is_partition(bdev))
 		ret = blkdev_get_part(bdev, mode);
-- 
2.27.0

