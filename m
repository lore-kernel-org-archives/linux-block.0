Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72A5C10F0E
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 03:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46222086A
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 03:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+lHZ2E+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfDPD2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:28:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33109 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDPD2S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 23:28:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id k14so21808908qtb.0;
        Mon, 15 Apr 2019 20:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qxR/VSmhVAnwQ7CoAhaj16Ah5GAR8GCDmtbF4pt8Ue4=;
        b=U+lHZ2E+zRh/11+fSX4FJT6ebmwA50tTUJemVw70a8ffC6MHrSQY7NK8AuLOjlQ4xf
         1h+uCX2LBB270AHxAphYhKR1t6idZ9abRtFnHImS14r1q02HF8v3StYivpSIJLutLpGH
         /ObgWxVWzhV723RbGBEVsRLzCI+X5m0l4+5dAz4T11V/bZ1u5en3gInV/f1m6Jep8qo7
         LnJKBi98kJxfuKiv49atqXMfx/4P0cfTM8ScedlMxV4H0C++ChsVneFvlyHiXDLbvcQV
         ma5RSl8XIyH38riZK0vajExDp50I8Th2oJIdoxr02JfBvXLc38M9jSE9fuT2SEyZsctF
         R9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qxR/VSmhVAnwQ7CoAhaj16Ah5GAR8GCDmtbF4pt8Ue4=;
        b=P6ItaC/Aaw+IoRM/Ixev5yTLZEa+DK/ltFWIQu9uXHIT4OsPJcTHViAnFuaLONrA5y
         oZR80Gz9FJh9hs1EgLeWF5xAyh1QrgPt3GRuJl4CV5AH7M17BSxMKa6pZMwElmiPtg8Q
         G8zRd2IwvzTF9UCv4DvlRsIQsiv65iOLtOp+4x08SuPVGKAYqrGaeWq/spljT0fN7CRj
         BgQEMm4wtwT0j7ZCt/JlBywM67bgyKx7aBx6f/bJ1vUFYlwguz1SETScSgxtbvo/7DCy
         v4fJrOM9RWnkpMQsABJikjS3QpVSZk3ElX8GsBKAMg8Ww1SuI8JXtWJN903uw6NcKMzW
         galw==
X-Gm-Message-State: APjAAAWZBPPJXaAcnTjZCeWW82HNxWM+kjV+n84MhWpHuXzoq4x4Mdsq
        guBaArlNffcNVjOa9aBLiFc82DXHKPw=
X-Google-Smtp-Source: APXvYqxuE9tZNeTZxaZ0azv8uAxH02LqYdULUpujIt9WSflaBRb4aiJ2IQh+CqlDyyWjnNVngAW2Mg==
X-Received: by 2002:ac8:1638:: with SMTP id p53mr62158582qtj.257.1555385297197;
        Mon, 15 Apr 2019 20:28:17 -0700 (PDT)
Received: from localhost.localdomain (189.26.177.132.dynamic.adsl.gvt.net.br. [189.26.177.132])
        by smtp.gmail.com with ESMTPSA id z16sm21501299qti.53.2019.04.15.20.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 20:28:15 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, marcos.souza.org@gmail.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com
Subject: [PATCH v2 1/3] blk-mq.c: Add documention of function blk_mq_init_queue
Date:   Tue, 16 Apr 2019 00:27:59 -0300
Message-Id: <20190416032801.200694-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---

 No changes from v1.

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

