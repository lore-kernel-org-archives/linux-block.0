Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEF8C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 14:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5621019
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 14:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFoYhRrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfAVOvD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:51:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42573 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbfAVOvD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 09:51:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so11860698pfr.9
        for <linux-block@vger.kernel.org>; Tue, 22 Jan 2019 06:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K0AUWxcEykrdBqiSSJAm5NVxaqUnEol3wEUxyemTzn8=;
        b=lFoYhRrE1Tr8gVrZoWXsndFNXQFRuZvySBjflcmWRvcT/xDdtGBwHw+RxarYElWazU
         E/47Nv777xC0NctbxGRJDYUog6KykO60qleLvjVF3R2YEJ+/Mx0ROEHcarBjHMAZVVaB
         xNMFOzNJvDJW2y1Bp9Ax6yx3moZIRMDKXre3NYtHejrtNoIjXDFCE1TPPXrHE4483ccA
         eR+9TjMolgC8/kgQ6kgWoC+YmSN3caO80kQlbFEUAeaXgwV/eAqVerrpkUb3lgQ8P+wp
         6yxJ5d+y/ofabkGJ6nJ5NkUE4L/lOq302rtE2khD9suyGkVhoMljn5G8POf3GUmCZheP
         Q9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K0AUWxcEykrdBqiSSJAm5NVxaqUnEol3wEUxyemTzn8=;
        b=bYJQccEnQIN6czkI24Xpl8vYfQKjoPxw5rDeNQuRBCiyumQ/0FhOzb0YleXlkmdzNy
         6SJtvm5CBc7C7GQoUoEfvvbG+C9HLowNpHObttAc+sgffr8fhyxXy839jewSE8+V33V+
         RvVZCyVESKNU4aEd4soQAr9aKLWLFBBr4a+9cJhh+njiq9vK+GqNfLV0pWMVrn2gZ8zR
         u1M5gkFeFb7d5GpBeFzJvslfBxeD33oMvCgBkw8XY/KJDGkv7jHWvA5Og8cJnCBVcUjs
         VkxOpogTho6YytliCsvqJVTd3ToAO4DayAujFNicoxOCuxX05qxBuoSynSKZIT149mdl
         jabw==
X-Gm-Message-State: AJcUukfobE+s2V/9mTiXbEXEXY1JegEHEhyb7XymF/DPTEi0y82VWaXf
        gzOPIwAhxtXC7F9EVSQJdhM=
X-Google-Smtp-Source: ALg8bN5fo76XmtezSDcsY/osN+zh30hNfkpSWtAugr6pdrRATjq6S5r6BWRa46Tid3oxgdRQgwhwXg==
X-Received: by 2002:a65:5387:: with SMTP id x7mr32366956pgq.412.1548168662679;
        Tue, 22 Jan 2019 06:51:02 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id h9sm21216945pgd.53.2019.01.22.06.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:51:01 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     josef@toxicpanda.com, axboe@fb.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        shaoyafang@didiglobal.com, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] nbd: fix possible memory leak in nbd_add_socket()
Date:   Tue, 22 Jan 2019 22:50:43 +0800
Message-Id: <1548168643-13981-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If kzalloc() fails, the memory allocated for the new nbd_sock by krealloc()
will not be used until the next nbd_add_socket() call.
That's a memory leak.
We can fix it by adjusting the order.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 drivers/block/nbd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 08696f5..a197109 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -944,14 +944,16 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 		return -EBUSY;
 	}
 
-	socks = krealloc(config->socks, (config->num_connections + 1) *
-			 sizeof(struct nbd_sock *), GFP_KERNEL);
-	if (!socks) {
+	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
+	if (!nsock) {
 		sockfd_put(sock);
 		return -ENOMEM;
 	}
-	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
-	if (!nsock) {
+
+	socks = krealloc(config->socks, (config->num_connections + 1) *
+			 sizeof(struct nbd_sock *), GFP_KERNEL);
+	if (!socks) {
+		kfree(nsock);
 		sockfd_put(sock);
 		return -ENOMEM;
 	}
-- 
1.8.3.1

