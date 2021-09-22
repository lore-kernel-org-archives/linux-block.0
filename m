Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD4C433FE
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC34360555
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhIVMjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbhIVMjf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 08:39:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FEBC061757
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:38:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso2164152pjb.3
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxSMi77DP/81jKfTEyWRr1K8Oy1BynKy6PZ+nkMR/NE=;
        b=i7Qu7NgdNZ6RLlYTl5HwdYyKLFUUokhle63auwvY/o9uWGH3zslNRAh4icmrRMioyo
         aYRTd3/apd9tN32dkNhTpPQMv2avl21JepItcO49BdXEhRYIghJzhhXqQrX7nrQI/jZr
         p012ZmpeS1swvfT7hG7T1ynlviTV5HtGW8bRUuOQf6OXB5KUkRYINKizcypSp8IVNJMF
         HOcTEjqyFAcC8MxzG/BBG1dGU6uVLff9ZzRkw38pj6H8qqDGTVzkVIxG7w8rDUs1c/5l
         y55oroHBOwS9WSEuSd8HS9icctgh7+5Y5yIXflC6lU2ao++zOaJ2lmdsJSZ0D8yeGaw6
         VyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxSMi77DP/81jKfTEyWRr1K8Oy1BynKy6PZ+nkMR/NE=;
        b=6bRJXdQyOJ04e3yvVcRJhAX2ieV+GAVkD0dELBmdghaOjVjmyd5ddi8N3n2rEDPkp4
         Dg8oCh/WodpUnQt9OTyXLBUirXXkkcEWZKMkfw6lrH6APPsl9OGsYRJpMukhn6ro1ES4
         XPB0Dt6KalD5H3znMUfoXhEpiDLnWk/wlx9QWRZkeubQnPcVJxRBAPSKHO8aWrfR0QvV
         4/Ijt4K2vwGTbs6rjOK0ap4vsWE0TAe0GykUXTUekZWlzNBEjKpTmmDn9jQZ5PseX9a8
         wAd3iLQRir2bCMjYbqlFUnuCvSeLqpErc/ENXovP7bIlnUkgmZ3pqvnzdc9f5DFCOgSL
         pPEA==
X-Gm-Message-State: AOAM532K7A2OZhJ5utu3SF+ekVYGxSxetJg54Gj4qE3Pm7spzKQhXVgv
        kajxatbYI5K5GDq1wl4/2qq5O6Ch0yK9sgM=
X-Google-Smtp-Source: ABdhPJy+3Mex0kY5GqqwrN4uXAbiWworu3QHnc2a3ZRbxnAO3m2HSgYPhCM0u48o74Do/MXWFigPtQ==
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr11053495pjs.38.1632314284894;
        Wed, 22 Sep 2021 05:38:04 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 23sm2859018pfw.97.2021.09.22.05.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:38:04 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: [PATCH v2 4/4] nbd: Use invalidate_disk() helper on disconnect
Date:   Wed, 22 Sep 2021 20:37:11 +0800
Message-Id: <20210922123711.187-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922123711.187-1-xieyongji@bytedance.com>
References: <20210922123711.187-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a nbd device encounters a writeback error, that error will
get propagated to the bd_inode's wb_err field. Then if this nbd
device's backend is disconnected and another is attached, we will
get back the previous writeback error on fsync, which is unexpected.

To fix it, let's use invalidate_disk() helper to invalidate the
disk on disconnect instead of just setting disk's capacity to zero.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/nbd.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5170a630778d..19f2e1247416 100644
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
+		invalidate_disk(nbd->disk);
+		if (nbd->config->bytesize)
+			kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 		if (test_and_clear_bit(NBD_RT_HAS_PID_FILE,
 				       &config->runtime_flags))
 			device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
-- 
2.11.0

