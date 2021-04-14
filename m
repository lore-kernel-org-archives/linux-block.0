Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE9DC43470
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2653610E8
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhDNMYh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhDNMYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C03C061574
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id e14so31065782ejz.11
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcFIBYzW1CLQzDq2mLrfCJg6alD/5v7YUQZWb1fw1bg=;
        b=hHZExSGQ4LTk3DzffoAOHlR/5WLJBQtzWuaVHUM6Nrzxh65w6+oGAmc8V27DglYgN9
         4QtOIHJkg3mjqsxyRKBgqDkcwMfVw5PLZviooPoH0jn7bd2uviknt90EROGkCuhaKE2f
         19Vsx85r3RlNraF1xA9Kb19uKnMc4aFw6ODT1pBVcr2Fy3yt9ygX2UckBEElpEF1RfQo
         q3Zr7lWyaYmTEKOJvL7qAjit/bpcLso5bqChz/I6r+gvzNGgNxgoBcrJh44ObvoFX2QQ
         dhk0D/PIV+MamfdhJbmmevU4sUUhS+cKq276MREsm5nSL6Jb0F/muv3UqsjyidNyNJ5o
         A1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcFIBYzW1CLQzDq2mLrfCJg6alD/5v7YUQZWb1fw1bg=;
        b=s4MqscHvMUcsj6rmKpiQymqqfbbza8OdxWLJNUlGH4SQtfBuq2RBIMQVCd5HT3eFlO
         uP4IQotBTWud+J8JTBGSNXGZkbWZCLKFBwJdi0O3CwGJ0iLg/ddcZcoeGiY+7UdwSxd8
         nLxiIRxz2rHSVoqtTv7UCNzgb0X0OabxXWWtBmMGpaaX0p+DUxsD9UTKikUu6RGCurIt
         MbBmBB76oDkddhZwr4cqDUYfoLQmXUbPyS3F7Jyetg2Ezuk77pyl0OseovB8cq5SD0RN
         uAvpO5pAESvo+hWsxSVLv5XNF/pgoVmYe/OelOyldgtl0CdZmhnseo2I1M5ruv35khxu
         eI4g==
X-Gm-Message-State: AOAM530cnND3zN7QPIxDyOKKH6PAdHygOApI5a9huu/NbvJxwwlpO6pd
        0JRnnzNXfqqXt+WifSZeJo/5KQIDxzBFkxQX
X-Google-Smtp-Source: ABdhPJzmF6MKWETzRmp39f/Iay8nY/+3Mgqz+/ZlG7dtuVz5KGR9DRz6S7lPdTQvJDoVU9gaeh78vw==
X-Received: by 2002:a17:906:7f0e:: with SMTP id d14mr20524226ejr.487.1618403053412;
        Wed, 14 Apr 2021 05:24:13 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:13 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCHv4 for-next 05/19] block/rnbd-clt: Move add_disk(dev->gd) to rnbd_clt_setup_gen_disk
Date:   Wed, 14 Apr 2021 14:23:48 +0200
Message-Id: <20210414122402.203388-6-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@gmx.com>

It makes more sense to add gendisk in rnbd_clt_setup_gen_disk, instead
of do it in rnbd_clt_map_device.

Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>
Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/rnbd/rnbd-clt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index ecb83c10013d..f864f06a49b3 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1352,6 +1352,7 @@ static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 
 	if (!dev->rotational)
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, dev->queue);
+	add_disk(dev->gd);
 }
 
 static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
@@ -1553,8 +1554,6 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		       dev->max_hw_sectors, dev->rotational, dev->wc, dev->fua);
 
 	mutex_unlock(&dev->lock);
-
-	add_disk(dev->gd);
 	rnbd_clt_put_sess(sess);
 
 	return dev;
-- 
2.25.1

