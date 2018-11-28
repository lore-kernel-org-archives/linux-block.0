Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F051C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 09:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79FF2081C
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 09:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak7jraNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79FF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeK1UO4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:14:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35624 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeK1UO4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 15:14:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so9227375pgs.2;
        Wed, 28 Nov 2018 01:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mIhn5b88nPfB++aksqoU4m1MmmzgRXI4vZXrrvgBSv4=;
        b=Ak7jraNjXOavSitdp6vUUqqRNeGDsVXlt77DO+uX6yPqkg1LMG4ZASStfQi3xmG1lx
         mn4QbYe7DBSY8uY45gvXL5FhnTinvbajnFpQ8SYYLvbWdZgnWmoZm4VkXBEBy5F858/q
         rRL9F1LnmH54oiSuxSOhO3yyt8EkfSqXCzHrdhOITh8jKphY7mTY6PGL1g3unaJ8RoKm
         AScy/h5HSzTPVCgj2ZRLZoAZA4GnLfUgRv+wiCJosxZYuXI03WOwYrwLH6BrvV8DXOaG
         DAEhiCs7X3RLxtRiYlpm6LbWZA1tJ1hBj35rizBxkmxyRGv85r5zEKBVyBjonPJxEj57
         Qtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mIhn5b88nPfB++aksqoU4m1MmmzgRXI4vZXrrvgBSv4=;
        b=bdupwz77OMYRBOXDPWVzG+amzTz1xNKFQteMlxOxeVFsMTxmFz5G1BGnNu6+DeRGj0
         Q8AyJgc5hqGNuj7Mig1GLKE9bDHSEYtLJn9Wn47gCJmmO2m1puvjtL4UEZ6HeMq462iS
         YLE01qxtg6F8Lr6/ecweypneLJzmLWIapzFMNx6safI0pq1BOeRxFQ9IQROFvBn4fVrB
         +Gn5L/GMBnce4k1FSDmQ7krS3NUD98TczDqmIfS0q1/WusJfH3tW374fYjgV/HdwqDe8
         QIqx6Q/WNk8dYJNUtwV2YTerhRcKRuJkY5vGjuR2VzPGJhMGQYieyO4LOQvmTHTtNuxW
         M6qA==
X-Gm-Message-State: AA+aEWZJ426sOio1OupPWT4dU+pL7UWyoBZVd4oW+fjH9jjBwYLR2GFS
        kRsE4VbY5PfRP+VTVOd5ECE=
X-Google-Smtp-Source: AFSGD/X7QqYwUd3BkcCRTaH+WWxOTzk2zaavKU9FYoXl7B0UZcjCDMbCFF65vJpc38D9YO7CM8HXjQ==
X-Received: by 2002:a63:d846:: with SMTP id k6mr33075630pgj.251.1543396440268;
        Wed, 28 Nov 2018 01:14:00 -0800 (PST)
Received: from localhost.localdomain ([119.40.32.42])
        by smtp.gmail.com with ESMTPSA id l19sm11719259pfi.71.2018.11.28.01.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 01:13:59 -0800 (PST)
From:   Hua Su <suhua.tanke@gmail.com>
To:     mb@lightnvm.io
Cc:     javier@cnexlabs.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, suhua.tanke@gmail.com
Subject: [PATCH] lightnvm: pblk: add lock protection to list operations
Date:   Wed, 28 Nov 2018 17:13:52 +0800
Message-Id: <20181128091352.5088-1-suhua.tanke@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Protect the list_add on the pblk_line_init_bb() error
path in case this code is used for some other purpose
in the future.

Signed-off-by: Hua Su <suhua.tanke@gmail.com>
---
 drivers/lightnvm/pblk-core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6944aac43b01..247112e1db94 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1295,15 +1295,22 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 
 	ret = pblk_line_alloc_bitmaps(pblk, line);
 	if (ret)
-		return ret;
+		goto fail;
 
 	if (!pblk_line_init_bb(pblk, line, 0)) {
-		list_add(&line->list, &l_mg->free_list);
-		return -EINTR;
+		ret = -EINTR;
+		goto fail;
 	}
 
 	pblk_rl_free_lines_dec(&pblk->rl, line, true);
 	return 0;
+
+fail:
+	spin_lock(&l_mg->free_lock);
+	list_add(&line->list, &l_mg->free_list);
+	spin_unlock(&l_mg->free_lock);
+
+	return ret;
 }
 
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
-- 
2.19.1

