Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05003C4360C
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17E9610CC
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbhDSHiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbhDSHiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:38:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99858C061760
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j12so14396026edy.3
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcFIBYzW1CLQzDq2mLrfCJg6alD/5v7YUQZWb1fw1bg=;
        b=UhWvML/82thPeOFST1dZd7zwSUOXUG0oZwHSdLovxLdSPgNATmODj6gESEoNy/Db84
         7MKv8RMbhPrhTsf0ohSqy7f2lXlucqkxKsKcMVYZAe6p764mZ8F8CeUb59FRn35ACmRC
         ai5JstLR6wQUuyVqrOtRZynGBpuuKgqA7p5vJxSGSxnHOO1qtyX9C+AIkHTW9XFBkBAG
         eOo199orznjDjXN46vWrFM9vVWQmkrafmKmDwTerbxuoD7+TstEM5U0hxvSVOUtOc1I2
         CPlEpFQ3RWsLgeqC37oUuUuHAtkUCl6Z9WBNLElYzVjP1W72qoL3sqmQlxXYSoHHITko
         ub9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcFIBYzW1CLQzDq2mLrfCJg6alD/5v7YUQZWb1fw1bg=;
        b=NGcTpmrL+mk7WcEk+zxfgJb3xmKW1LYcAltSwA3U7mL8Ecr0G+9x8LCNCyP/sMpww3
         Dd+hotjKaycWCVEM85cA6UnxOzRxRLQF2MocWZ1uz7qm/3qIRipRF75zO1p3S910o3s/
         qwjVlCGNeAFZlNVqruyoE8ljJ8mqxKWt6RD+SjJObhfDxNZGYhzrixNXyMpVcnTJOCxY
         CC5B8MIIeySH8kEB5J1M2aLI75apTZZuveg3+6zL5vgXA4XJMDBoJHsavhYh4PWp/abr
         IG+zjSqFVtFRDeOsMeTTAk8VLc6GVs0WhDPKT0Zxs2S4OQFP16L8hK4LJhACFs9DnDSs
         8/jg==
X-Gm-Message-State: AOAM533mmokQYtKWhRjKLRk8b7bGsdSuf/eW5/OljkLQ8xoKpADOEpKW
        ypFPCe4x69rQ9a8hrgLHAyMtu3YKotXUNrqX
X-Google-Smtp-Source: ABdhPJzIdOnNJqsq4ghh2FgiXJbAXJ1XFUWmLU4e+jKpL+GwNyjs2En+HoagiszxLsU9OAQmaBHhmw==
X-Received: by 2002:aa7:d355:: with SMTP id m21mr5860016edr.270.1618817872215;
        Mon, 19 Apr 2021 00:37:52 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:37:52 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCHv5 for-next 05/19] block/rnbd-clt: Move add_disk(dev->gd) to rnbd_clt_setup_gen_disk
Date:   Mon, 19 Apr 2021 09:37:08 +0200
Message-Id: <20210419073722.15351-6-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
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

