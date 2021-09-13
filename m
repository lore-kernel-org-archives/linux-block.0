Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADABBC433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 11:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9540D60FE6
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 11:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhIML2K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbhIML2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 07:28:04 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1622AC061574
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 04:26:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d17so5568762plr.12
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOUrEPU1RAiMUpJWgGMiqNI1+8Thp1guW0tyQ2fxpY0=;
        b=Fu0UAv941kwXqg7yLEK03aUgpBq6hiFPc7EKKRDLBj4nFifiTQux01wDhXFHLnAASH
         KvfEBpMRNGZSg92TMvQ0JJ7pkec2YT9uzVvEtzVlX0gdbRpUwVLcPA3VjXFqrIqoFIrY
         vo/xi7/UQon9bTWVVChQajJ0+o19hURSy+r/8EVRmwEf/iisdG/BoWWjwvwpkL48mkLR
         IxL/8E5wG6T3JK+cNUom86rwe6QA4hjWBzvxWlnt/8LlhVqhpBnsQRpLUNK0/OMnuofT
         nA2b6zl/uWMKHxvRJt/FqrigQumcUQJGnUlR+yUMfX7g6IELutlO+CYa9PZ6O6tc+YVw
         8LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOUrEPU1RAiMUpJWgGMiqNI1+8Thp1guW0tyQ2fxpY0=;
        b=IA60/2GWjjzdBuVvFV8VnWbjVToENUYY+38QiyWxDPZOh41jGV9ZGLgy7ivBY64YgC
         Z05KcIfs387HKhBSDrZhdWgBjbo1Ao85Vc5ZpXULLyhe01HDKMldcl8TT6llWLAXGDAT
         nlfhAMxrCTXtc4fGtkjqkbLH0baijKWkT2yIx3Mi+xJlxRXskjoaoBl7T/hoGCsxAf6d
         ZFiKWMnp8Nu3o2DVUZTAd40hxyZF4upE2oxvIk1IDJs3dm/piApP9HJI8E7tkzFVjt3U
         BAol9MlQawvs/cMNLjYXoDZ3SnsH50UKil8nGP+DNscIADYd+FNnmZk9i4tbJ9OoKJVt
         2saw==
X-Gm-Message-State: AOAM530VdhnM5Way6tIWiOh6d0LwDWclKW/8bJcS1kjGKoYZcrpq19Lq
        h0rx4CnAH2+mknEJ26eM8XB8
X-Google-Smtp-Source: ABdhPJxHAvsQ1aTiYldZ0sJEF7Pb1x4vYPa8mF7ejOdqFR98gj6CjGFdFuwln1VsKk5qRY9Rq/467w==
X-Received: by 2002:a17:90a:182:: with SMTP id 2mr12601785pjc.107.1631532408657;
        Mon, 13 Sep 2021 04:26:48 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id j17sm1951180pfe.35.2021.09.13.04.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:26:48 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: [PATCH 3/3] nbd: Use invalidate_gendisk() helper on disconnect
Date:   Mon, 13 Sep 2021 19:25:57 +0800
Message-Id: <20210913112557.191-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913112557.191-1-xieyongji@bytedance.com>
References: <20210913112557.191-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a nbd device encounters a writeback error, that error will
get propagated to the bd_inode's wb_err field. Then if this nbd
device's backend is disconnected and another is attached, we will
get back the previous writeback error on fsync, which is unexpected.

To fix it, let's use invalidate_gendisk() helper to invalidate the
disk on disconnect instead of just setting disk's capacity to zero.

Reported-by: Yi Xingchen <yixingchen@bytedance.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/nbd.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5170a630778d..64ae087d8767 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -305,14 +305,6 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 	nsock->sent = 0;
 }
 
-static void nbd_size_clear(struct nbd_device *nbd)
-{
-	if (nbd->config->bytesize) {
-		set_capacity(nbd->disk, 0);
-		kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
-	}
-}
-
 static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 		loff_t blksize)
 {
@@ -1232,7 +1224,9 @@ static void nbd_config_put(struct nbd_device *nbd)
 					&nbd->config_lock)) {
 		struct nbd_config *config = nbd->config;
 		nbd_dev_dbg_close(nbd);
-		nbd_size_clear(nbd);
+		invalidate_gendisk(nbd->disk);
+		if (nbd->config->bytesize)
+			kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 		if (test_and_clear_bit(NBD_RT_HAS_PID_FILE,
 				       &config->runtime_flags))
 			device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
-- 
2.11.0

