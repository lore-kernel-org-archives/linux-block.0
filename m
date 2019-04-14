Return-Path: <SRS0=vbI/=SQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B897AC10F11
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 03:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560D42084E
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 03:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAGESXIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDNDL3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 23:11:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38090 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDNDL3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 23:11:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id g1so7981574qki.5;
        Sat, 13 Apr 2019 20:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rQQOlENLvv4KpM9p3RTTWDhnHxph1fAzjp1JzmNsB6U=;
        b=UAGESXIGbcWFiHPRJjyGj1lov7n8aNXRVtmETZvkmrKkv0bFMrr7J2K7m2rUhbQlBp
         i+dPXH3Vok0S516L0XC9nNv3t6p3FLX2HsdZs6vx809ZpkBtoxS3W4oj75uh/EhXH7Al
         XL62nY+e0d4XBapcrYyhA7GLH3eTT17gIadybkQQ5DU731jP00bBkThiTv3XCH5WTkBh
         Eph5RJxe3eIwZxYdgMEADNvfHr07TZMOn38CuqfRZbhjm+f0HSbC7OkDYJjYojzeiMcF
         wPCyHu4rObaYJXG0ijyCSl2C7+knJamiqHN8Fo1tjLPMJswhuHuF4sZ8rocftaTvI9Vd
         1bFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rQQOlENLvv4KpM9p3RTTWDhnHxph1fAzjp1JzmNsB6U=;
        b=iF/SkuZspYDNmcqT9uTecV4abrmfIsyQNKKjTHxQaWPOTlWvJPREoNpr0GxaNyyELH
         avlK8ySzhOV6qHCP16bo3+ZcgfbRBr8GWjRz0KiBlNRR4ZAPuO5VkGHTqUGjrz5NlV8b
         wDHj2TiP12FSwnn0UzVe158osdUvGW47jIlH1IykxFKGEIBmXWSkFpTijzKVWahS5yRq
         sHvsp+TlgRymYYvMbzilonuiCp/XiemLpxSULxVAW5a8ocNQ7ShCIsOK7OqO7kIgNdHe
         oAqakNtjN2ltxXR+sv65CU36w3e4Ih0jvdARRKF4sYv5uZ1mCzwaFB6AV+/1m/fLsnsQ
         18ng==
X-Gm-Message-State: APjAAAXWRkWwhIGaraGkRC/y95NirztrAcfg+FbVzARBh6zzqcy5PwS7
        pZ0sB1lJrquVO617rBM4KSrdim7TU18=
X-Google-Smtp-Source: APXvYqy5qMuSefUrzoBzUZMGIaWcHwuNLdn/+rsia0VkFLhpV0CMGB8RxcqNNAOzj9R2Wcs3O+8bbQ==
X-Received: by 2002:a37:6c84:: with SMTP id h126mr52903072qkc.168.1555211487510;
        Sat, 13 Apr 2019 20:11:27 -0700 (PDT)
Received: from localhost.localdomain ([191.35.237.58])
        by smtp.gmail.com with ESMTPSA id u44sm24668430qte.40.2019.04.13.20.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 20:11:26 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH 1/3] blk-mq.c: Add documention of function blk_mq_init_queue
Date:   Sun, 14 Apr 2019 00:10:52 -0300
Message-Id: <20190414031055.26350-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 block/blk-mq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9516304a38ee..4a8277a54c03 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2650,6 +2650,15 @@ void blk_mq_release(struct request_queue *q)
 	blk_mq_sysfs_deinit(q);
 }
 
+/**
+ * blk_mq_init_queue - Create a new request queue associating a blk_mq_tag_set
+ * @set: tag_set to be associated with the request queue
+ *
+ * Description:
+ * This function creates a new request queue, associating @set with it.
+ *
+ * Returns a new request queue on success, or ERR_PTR() on failure.
+ */
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 {
 	struct request_queue *uninit_q, *q;
-- 
2.16.4

