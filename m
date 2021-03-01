Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE86C43142
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 19:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EDA60231
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 19:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhCATaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Mar 2021 14:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhCATZm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Mar 2021 14:25:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9C6C06178B
        for <linux-block@vger.kernel.org>; Mon,  1 Mar 2021 11:25:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bm21so11547093ejb.4
        for <linux-block@vger.kernel.org>; Mon, 01 Mar 2021 11:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kYRIiLyDMId2Rp0AnLAOvAVnCnG2eyfpP+wggOi7534=;
        b=t0NEsHeMFDC+3rFYfmCP52Ag/+/Uj5tK3zSXfNB53f/9NllBkVv5ZxnwltpVtggVhB
         sL2nnybvGz2Yn/XOJqQNzAhVgO+t6wDU6Ptx0QJoGzMbQIuWrXHwHzL3JARwqdkc9z5m
         DIPTlEEuFR+N0I9h/e4MUUF/hRkL3F0u0xCD3Nbu4Wmz9pXK/nWebKQ0YJhIIEhyn5Rn
         bJ9b1cKaH/P6sShW5BhQ/vNMG+MCGuRPU/LkjWZ1Hv89RNrVcO0VNE1O0L+b8TH3UEoU
         cqyLAwaqWm5hhBZidMiDdv8a2oe7XsdBu8OauvBXGth7kn0b7l/+Vh0tf/iPNt/e4iGk
         KExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kYRIiLyDMId2Rp0AnLAOvAVnCnG2eyfpP+wggOi7534=;
        b=W9kyIuXlAPgm5UD/qct/7DC7lmEWh9h+Fn89ND7/O/ky8z5jzv75Lc5LYGYx5JpLZc
         XtZ3GyLzL7BdnvGcVLEhTmMhdGEdh25N3BltUhV+zaA0JoUf8ppKo/sUHBN6+udL52yl
         ctva5AJbxBChCijogKPPkrYzhCEk3tIvWTOMYtCbK9kHk0InM1CevjJ9rqU4MD5brQ2o
         qAhBn4JGg2NnCMfC3JLgDCt5FgsAKxPSwtMLwF4tqVW9eJJv8J1vk6pG6Vv+v8rjXM2/
         alhwIO40w1+qv9OOs6A2M+ermTdZUP0CcTdJ1feiAuV75WIri3ADihgnqdLVDTSb2ku7
         WwNg==
X-Gm-Message-State: AOAM530RavQe97FiTYMT+Tuk5i+yEGRNxCfv7cIL/yWodaheueaH+Zd8
        KT82T7MZcGgnjh78jlNwkuiZfg==
X-Google-Smtp-Source: ABdhPJw5ruyiuZTKNYqKN5wCZs7s5BVahTA0+7Xm1CmPmL3eQHfwU3T06wA+8zxqfzKkajHZWpQE1g==
X-Received: by 2002:a17:906:33d9:: with SMTP id w25mr17008142eja.413.1614626697804;
        Mon, 01 Mar 2021 11:24:57 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id i4sm14107110eje.90.2021.03.01.11.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 11:24:57 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: [PATCH V6 2/2] nvme: allow open for nvme-generic char device
Date:   Mon,  1 Mar 2021 20:24:52 +0100
Message-Id: <20210301192452.16770-3-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210301192452.16770-1-javier.gonz@samsung.com>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Minwoo Im <minwoo.im.dev@gmail.com>

Keep rejecting the hidden device access via open, but allow cases
through the nvme-generic char device by moving check for head namespace
to nvme_open() from nvme_ns_open().

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b94609bc92f4..ed66ff33a85a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1887,11 +1887,6 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 static int nvme_ns_open(struct nvme_ns *ns)
 {
-#ifdef CONFIG_NVME_MULTIPATH
-	/* should never be called due to GENHD_FL_HIDDEN */
-	if (WARN_ON_ONCE(ns->head->disk))
-		goto fail;
-#endif
 	if (!kref_get_unless_zero(&ns->kref))
 		goto fail;
 	if (!try_module_get(ns->ctrl->ops->module))
@@ -1913,7 +1908,15 @@ static void nvme_ns_release(struct nvme_ns *ns)
 
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
-	return nvme_ns_open(bdev->bd_disk->private_data);
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+
+#ifdef CONFIG_NVME_MULTIPATH
+	/* should never be called due to GENHD_FL_HIDDEN */
+	if (WARN_ON_ONCE(ns->head->disk))
+		return -ENXIO;
+#endif
+
+	return nvme_ns_open(ns);
 }
 
 static void nvme_release(struct gendisk *disk, fmode_t mode)
-- 
2.17.1

