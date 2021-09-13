Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C870C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 11:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612DA60ED8
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 11:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbhIML2A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbhIML15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 07:27:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B013CC061574
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 04:26:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w19so4100887pfn.12
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzLNfeO+n0foX98RPjWTA3+lfxpTVqBrYMUe0GRh7SU=;
        b=PG0vv+H5Za0VKb8uOvX3ipBRLKdvD5bl4aXDoQxNgWwDJGh1OEM8ueADiTW8IGQp7d
         2BG2vaztqzHdpuxL2R4IotR8WFmANrqW3fBHq/HWEcAhgX/rvaX0nZP1Ms6zNyoQBSs0
         eQC/wWg7kZJKx5C7YRfyTC8/JYaP6dISK98TH5qsn1E8fLNrayw+nFUnrmQ5x35qQSKj
         aNdHoTrUAD9c1qsHiXq+pMGe0AVcVnfxeUQkNj3usDKpRkW9rTpQ0JYKz4XnIizoDAtn
         SkJ8JaPPekPr5nOyrlGEqVDYxXpxqRot6qYnQNXv+KzyoUXg4+NucNiRo4XX19tZQkRs
         qC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzLNfeO+n0foX98RPjWTA3+lfxpTVqBrYMUe0GRh7SU=;
        b=hqeldduD/3KRdInYohzVhSvsMBMoZehQtH3SNGDyMpCZVa9hTboKMPYkxst3waDlWj
         RSwzREKpfPMhU2Uj5fd0BQ6+nprx7gAtBWzvBS/ckeXcwrxkJSHmnlD99CGO+vStRgGA
         FkMX2vnKYjSRB2VQ5BjIdOKzynAOgGJaY/LArgMrHovY/PbCdRtbW0CNcIf2PKEcMQGT
         hfgnVy+KY8x9MicdTHsxePfT9/kwKGmalKrWatoeVM/a2Qc3xCyST9K19puGx0q2rXL7
         3HbjmaeVMcGv2HM+uax8qcNfSx63EfWMx6rmXaZJKqGnpxwgpjZDQIiun2DAmL1XuiPH
         cKEQ==
X-Gm-Message-State: AOAM531zfWFF57qcdQPO+lj4mcIfXFbZYm63LxAtfJp2jL1t/S1fMD+l
        c8bjSufQJ6YM9ahWqu9r6FWfgs/RURvQJe8=
X-Google-Smtp-Source: ABdhPJzgSOxBcJDVxyO4TEFgwoDf4k/KwWRbBl0bbS+KaFcGrmhrZVRcUEICjnW1ouQe0OqHDEXIGQ==
X-Received: by 2002:a63:e40a:: with SMTP id a10mr10881599pgi.414.1631532401307;
        Mon, 13 Sep 2021 04:26:41 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id n26sm7009660pfq.44.2021.09.13.04.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:26:40 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: [PATCH 1/3] block: Add invalidate_gendisk() helper to invalidate the gendisk
Date:   Mon, 13 Sep 2021 19:25:55 +0800
Message-Id: <20210913112557.191-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913112557.191-1-xieyongji@bytedance.com>
References: <20210913112557.191-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To hide internal implementation and simplify some driver code,
this adds a helper to invalidate the gendisk. It will clean the
gendisk's associated buffer/page caches and reset its internal
states.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 block/genhd.c         | 21 +++++++++++++++++++++
 include/linux/genhd.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 7b6e5e1cf956..7d97fb93069a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -601,6 +601,27 @@ void del_gendisk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(del_gendisk);
 
+/**
+ * invalidate_gendisk - invalidate the gendisk
+ * @disk: the struct gendisk to invalidate
+ *
+ * A helper to invalidates the gendisk. It will clean the gendisk's associated
+ * buffer/page caches and reset its internal states so that the gendisk
+ * can be reused by the drivers.
+ *
+ * Context: can sleep
+ */
+
+void invalidate_gendisk(struct gendisk *disk)
+{
+	struct block_device *bdev = disk->part0;
+
+	invalidate_bdev(bdev);
+	bdev->bd_inode->i_mapping->wb_err = 0;
+	set_capacity(disk, 0);
+}
+EXPORT_SYMBOL(invalidate_gendisk);
+
 /* sysfs access to bad-blocks list. */
 static ssize_t disk_badblocks_show(struct device *dev,
 					struct device_attribute *attr,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index c68d83c87f83..a3b2f6b1b7e8 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -221,6 +221,7 @@ static inline int add_disk(struct gendisk *disk)
 	return device_add_disk(NULL, disk, NULL);
 }
 extern void del_gendisk(struct gendisk *gp);
+extern void invalidate_gendisk(struct gendisk *gp);
 
 void set_disk_ro(struct gendisk *disk, bool read_only);
 
-- 
2.11.0

