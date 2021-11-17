Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AFAC433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 06:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2046563215
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 06:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhKQGnB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 01:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbhKQGnB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 01:43:01 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6CAC061570;
        Tue, 16 Nov 2021 22:40:03 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id np3so1524940pjb.4;
        Tue, 16 Nov 2021 22:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23DZ3iIdGzk1P10uRoetsQDReb8uo3ZlcyfurCNqrqM=;
        b=Zi3Zi6fkCm+QZWqHotNyg6YSMQViNCC1dBI3ht0vmyocCNJwulFxLNtmYpOBWn1I8m
         7IvSWT1UdTQ9AifM0OLHxWdbdQdrn7kJrWnYH7Eobwtmsp/S5nO7Pp6l+tllViThTFdP
         PtOSrFfOeTJjAQPduQDBBwFoSfplWkke2AFsKFWiobdbrwbL/0loIa8aLuRfOM3mDGz2
         ycMpWlZoWxYRWxDvhHYQJyLbLlfOvQCqnZ5wu0K5u+QDAfXCv7QxzICXJatVbgYTBLUG
         FtFB3+QVD1s/u+cAdjPjr8f5SiwbhPTkyKDn8itTYGyfjWVRJY0zPUjJ6GUNYCcZ5pvK
         mtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23DZ3iIdGzk1P10uRoetsQDReb8uo3ZlcyfurCNqrqM=;
        b=FEwiM1wpBOeTdzhfAD7t3HF6Z+3ZlnD9ZhfQf5OkFB87KNbuK97LgiaOq5497vcR/q
         VhFO9kHocIDMWTTI58sVusfPnKtHPN/Cg9dxCwTZsHRFHxCP89vSXji6Sm8mlbHQM4UH
         zGpRx+Up2keBtQHx84WYoLJg2KPRm19OPGD+sun6L0ImrMH9cO6+XuupKhBYrpQP+B3+
         mz4ogZnsqT7jrIr/gqygzYIwl0vO1A/chu1DUkh9+m8Y4ca/C1CltmP3fJ5MNSMtppit
         Awh0zVqC6/MSzRAxekcyPB4boSGE8QqB28hNjLqFAVTXaNw5MjdKy8bbBD52tyLZaIZH
         x5Ag==
X-Gm-Message-State: AOAM533Gc1XSXq/B0r1hcw0GOMCtgNhO4dNkzbrSiXlbLvgj/xcaKa4Q
        P42zjlqjD2sk6LVGyLZzLoI=
X-Google-Smtp-Source: ABdhPJyfueaTOQAqOYDuFul8c8Io6QnyMkAffJZN7aZo9EnFF2VfGsLS8Dd//Lo0wTMrKy8dAx3f+w==
X-Received: by 2002:a17:90b:33cf:: with SMTP id lk15mr6587997pjb.85.1637131202636;
        Tue, 16 Nov 2021 22:40:02 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l4sm22889435pfc.121.2021.11.16.22.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 22:40:02 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     mst@redhat.com
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] virtio-blk: modify the value type of num in virtio_queue_rq()
Date:   Wed, 17 Nov 2021 06:39:55 +0000
Message-Id: <20211117063955.160777-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

This was found by coccicheck:
./drivers/block/virtio_blk.c, 334, 14-17, WARNING Unsigned expression
compared with zero  num < 0

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 97bf051a50ce..eed1666eff31 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -316,7 +316,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *req = bd->rq;
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 	unsigned long flags;
-	unsigned int num;
+	int num;
 	int qid = hctx->queue_num;
 	bool notify = false;
 	blk_status_t status;
-- 
2.25.1

