Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714A8C433EA
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA0761A46
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhCYPaf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhCYPaA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:30:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AA7C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u21so3543585ejo.13
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2yp/UBdxAZOVqKqqU3/o+Z/JLidVsfOi1IBQ0gDYP8=;
        b=DWoCjn50UvcIfjPcfZl0U5vqDJbzP2059USRNCQ4pIslC5T3bmmtxCWT8TramDkS7F
         G2kC1Fo9RaVQ98q5DcQeVT0Vy5vjOd18o3iyGShPAhXu31vY+s//XT0Q5Sa4CVXDLFqj
         li2hxFsuKXz6zGggg/zDpkpk7BoW6kVrPHuPMfsmpz8aqwUEkNE3oibuliP8cO3BcyVJ
         dvSHeOr5ClX7u5LGseWEfsyoSftKR381bXYtrOotyMAu9XL5QP0pD1NgZd6YuqpxZV8/
         lrEBy92ayiTn2tOTakzZ5S6pCSvCCOA6hzxfInja5tH5xkazo/NQq1tslG5CsokVOtYM
         HTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2yp/UBdxAZOVqKqqU3/o+Z/JLidVsfOi1IBQ0gDYP8=;
        b=EfrjRJAn1z9BNmqfY7uPMVv5WLfDR15gH5SUeOPEv0gLdQOIhX4Esw3hOw2P7iEip7
         wzMEpGMjAHAmLjxiQHOHacOQMgX4LVO8j9iZ3Q9mkMYspuZLDrTCNRBs6imoUSglJunl
         swFKXoCpeqHsB+v6wkcbq+xZRGps+fkSpDV/9CwJR9s6nUdjVRpc/+AXwGz5xTwdEIQ+
         qSHDODljCJZKRzyG5TZGX1j/3eLFRu1pwCgSEVGHkSb/bA89/QNMts2aWPQo7dOZQcqL
         GW/2n3i//k2EjWLg/1g++pbu4xacO9gNlzgvbpLUVh1jhk6hBm8DGBFn1jPdcsud9KCe
         dRyg==
X-Gm-Message-State: AOAM53272WHUnes40LxaRdhaD27We+g2f7tDVw8oh0yAcF1ZMqZ9IzBv
        WpEeiTSLoIGh3JeG8Z8E0kb5UZU/+wG0HA==
X-Google-Smtp-Source: ABdhPJxCWVmRjtk9ofAbcBw5M2/WwkOPdbPix6xxC+8nZH/vEdA++wZUpNWUyNgmTM2Un7/6Wfc5Ng==
X-Received: by 2002:a17:906:8583:: with SMTP id v3mr10285252ejx.361.1616686198791;
        Thu, 25 Mar 2021 08:29:58 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:29:58 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-rc 10/24] block/rnbd-clt: Move add_disk(dev->gd) to rnbd_clt_setup_gen_disk
Date:   Thu, 25 Mar 2021 16:28:57 +0100
Message-Id: <20210325152911.1213627-11-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
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

