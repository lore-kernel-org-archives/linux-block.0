Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984DBC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D9E60560
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhIVMjX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbhIVMjW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 08:39:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F475C061757
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:37:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so2157577pjb.4
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9H/YcNe1Su6v+wAcfOK/V9t4tOEyD2Zp8GPh0hUJH8=;
        b=GVylT1NldRLz2LWSYbYrzix54Fy6cssx1KG0Dlymj6MxJf5fs1Jg/WPQfp6AR/UWrJ
         4G9vxn5QQRv7gjG30oBMcK14+KG7tpTQBo+IlRzMfN81+Qr1QTZEiZd0Wv1YA1L73+CG
         NGNYV4mLo82OVz95Ed+EH2Vgl/xQx41F+dhEbkQD5DvdpUYiMovYkui6z6s/8+Y5SfdT
         pilKqxBfZHq/iN2yShFzoWy8vF3xtyPGl8t8lC+1pXJou4jq+HpqyG6BrMma4VN+xfin
         keXVfHLPD0iRvDCux0gJL5OHfNobmbxn2daGazJe2axRZQ3JrIRmbVslKAzJXKJIxSae
         A8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9H/YcNe1Su6v+wAcfOK/V9t4tOEyD2Zp8GPh0hUJH8=;
        b=LAPvj9Et8Whx2G1uoZ5/qrz671r2aABndNTqTdVvG4LZsD2Qtctv5NQKiz1aysm5CM
         iDqCIZXbVmVpy9uQGU+lFtEdrtcpkNW2XxLGwlOnNsItc38MMySLH72AM1JEsrSJT3ac
         8ErbN+kNIf9Z4LXXdy0dG/KTNC3jqwIh50cmFLZJebP7k0gR43OrKxfNbh+4tWVnjjPW
         Ker+D9DB9ukS7Rd+7rVORptdROUszhhVpOyQEDks0amWGRXlaNprRPKMfcm/qZ+Y9SBz
         XcC+cHpmGLjS4CjlqOW5xcisrCs4l1KAwGVPgZTAaBaLgwzZmff5vSVDdFIfOnqdsaTl
         WsSQ==
X-Gm-Message-State: AOAM5318O6AdcVS4984bfqVmxFO5mOGmRrzsETROnt45LVAVnFcPZRuH
        CE3gmbFJR5qEVgnhfAsY05Hh
X-Google-Smtp-Source: ABdhPJzWj6ckkva6gfc1tWPCOz5uAGu3XwQ4XiAYiv1dEbfGvfJxZFTKKZFBnIjJnRW/D0FprXn7gg==
X-Received: by 2002:a17:902:e153:b0:13b:63ba:7288 with SMTP id d19-20020a170902e15300b0013b63ba7288mr31284297pla.33.1632314271853;
        Wed, 22 Sep 2021 05:37:51 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id g8sm2477038pfv.51.2021.09.22.05.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:37:51 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: [PATCH v2 1/4] block: Add invalidate_disk() helper to invalidate the gendisk
Date:   Wed, 22 Sep 2021 20:37:08 +0800
Message-Id: <20210922123711.187-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922123711.187-1-xieyongji@bytedance.com>
References: <20210922123711.187-1-xieyongji@bytedance.com>
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
 block/genhd.c         | 20 ++++++++++++++++++++
 include/linux/genhd.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 7b6e5e1cf956..876c0e478baf 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -601,6 +601,26 @@ void del_gendisk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(del_gendisk);
 
+/**
+ * invalidate_disk - invalidate the disk
+ * @disk: the struct gendisk to invalidate
+ *
+ * A helper to invalidates the disk. It will clean the disk's associated
+ * buffer/page caches and reset its internal states so that the disk
+ * can be reused by the drivers.
+ *
+ * Context: can sleep
+ */
+void invalidate_disk(struct gendisk *disk)
+{
+	struct block_device *bdev = disk->part0;
+
+	invalidate_bdev(bdev);
+	bdev->bd_inode->i_mapping->wb_err = 0;
+	set_capacity(disk, 0);
+}
+EXPORT_SYMBOL(invalidate_disk);
+
 /* sysfs access to bad-blocks list. */
 static ssize_t disk_badblocks_show(struct device *dev,
 					struct device_attribute *attr,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index c68d83c87f83..ea815feb3626 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -222,6 +222,8 @@ static inline int add_disk(struct gendisk *disk)
 }
 extern void del_gendisk(struct gendisk *gp);
 
+void invalidate_disk(struct gendisk *disk);
+
 void set_disk_ro(struct gendisk *disk, bool read_only);
 
 static inline int get_disk_ro(struct gendisk *disk)
-- 
2.11.0

