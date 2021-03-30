Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E65C433E2
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C0561990
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhC3Hik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhC3HiG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C5EC061765
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a7so23326879ejs.3
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2yp/UBdxAZOVqKqqU3/o+Z/JLidVsfOi1IBQ0gDYP8=;
        b=dpFE5WU4Nxw5eGidDDVsfZ1/SyIA9qWdO6iNgx3ZVKjv9jECj+UTycjrqRHQVWFp9n
         3T4nK+XnLECDA5g0Vdg6MxtJMndsF189LvyGN3rA37RQe0yCiIwh7RBmFrZGNxZV4ATp
         iAKc1fnE9Fcn9nNuS5xWUn71BqJcjz5PmWRDzNxKBSvo4Osts91aBLNE8CcnI/R3FWR9
         j4MJ9nHZIV1TD9MKhTB72z8mcNiPZlwNwoqRmwvsoezPLG5HCA0J4vEKMywXOKeYILgQ
         lV2BPsykQSiaUsk/FcfBc6jPEbPAvyJJM2v3T+A6GIeZ4zoMwv8WI/5+QBnk21jBUspW
         7gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2yp/UBdxAZOVqKqqU3/o+Z/JLidVsfOi1IBQ0gDYP8=;
        b=dFhukTfhSEevcdMwz7E7oTk9DdGGbzK5QqesRBqBQN0IQLKNA/pprjDgyio48lIyN2
         dMSeUarhiM3orN7ttJ54EZOEw+o0KBT8rSEs2XyMPWnRWh1fJcXAqQViCICMEVs1GkcE
         cyfyuWZS4AEKa/sv1b+hHUg+d+c0eV2CRE9tzHJWCXReh4tp3igCc/mSUeiJQh6FJe9i
         wosUr6WCK7PbfSV1TZ+2e6r4k4joWlzaeK/w0FCBm+ttDynAiwG2tEic5MxLTVb54caD
         YHfQXPLr+gqT+t7zRIR46GBr0DvAe+8jXlFseXjpdySUHRG1sQa/THax3WiOOH68YpSF
         eMsg==
X-Gm-Message-State: AOAM533+rmJf3WNhXdORbMo9LR1YlYegqxeaI//fOLMMT4PYck+1Bm2V
        80jwc8To85wavCf2FLwBwSC9C2g4AMrweu/o
X-Google-Smtp-Source: ABdhPJw5A0OC4jMYxSKh0Fmw59HSXwdvIrRm8G+ssUd5dXNXB9wsWN10h97n01NWzOxIb3j1mZIUnA==
X-Received: by 2002:a17:906:70d:: with SMTP id y13mr31221749ejb.170.1617089884438;
        Tue, 30 Mar 2021 00:38:04 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:04 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv2 for-next 10/24] block/rnbd-clt: Move add_disk(dev->gd) to rnbd_clt_setup_gen_disk
Date:   Tue, 30 Mar 2021 09:37:38 +0200
Message-Id: <20210330073752.1465613-11-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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
---
 drivers/block/rnbd/rnbd-clt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 5d085bc80e24..d8b9c552271c 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1358,6 +1358,7 @@ static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 
 	if (!dev->rotational)
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, dev->queue);
+	add_disk(dev->gd);
 }
 
 static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
@@ -1561,8 +1562,6 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		       dev->max_hw_sectors, dev->rotational, dev->wc, dev->fua);
 
 	mutex_unlock(&dev->lock);
-
-	add_disk(dev->gd);
 	rnbd_clt_put_sess(sess);
 
 	return dev;
-- 
2.25.1

