Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B45DC43460
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17082611B0
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhDNMYh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhDNMYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9743C06138D
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d21so3333826edv.9
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dUT1GNhkzIs4KMdUcaLBHxt9noYnFY4GBGwC4fHfsvc=;
        b=ARSZV/Pr22Zue2JaULzVPEKA4jjXe7PHjUFsd7eXOP+0VUBmz/c8sbFNtMzdjsWPQ8
         1LlHqjA4Nwzt/vU68ffUCY3aPL6zNvgkKWd/TsOixLXQPgHLIcgKOaqrz8+MWjXgKbB9
         neijdnwFDyQX+X+JsEDVjRASHigGP7hH0WXv9osMVcrT7bJ0X0Jl+0GIBpHuR9pAOvXK
         R/SOZzr7dUrX2JDcd51JqVz16vZwEcJ+VQliSvgR6fGQCJMo9F7/EPowkrV9LS9hqAGq
         LjBCo7uEd5ZSTmvvv3xss1ymZv3OBjQB7XvROyFxD4qER+NEd40x9GkMaAuPabTXVMx3
         EXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dUT1GNhkzIs4KMdUcaLBHxt9noYnFY4GBGwC4fHfsvc=;
        b=os+wytH4Jyhtyf9nAAGpsYBng0pYNXNupqImr8GLt6db7868OyYWytqQPwh4exbqV8
         MCxuaX/pfieOCGnifBaNzvLBgm84zPFt4kTDQ4pTXzLxEWjetY7S54dwVJ/aFosoZKdU
         SELfrOxKHV6s2eTRE3Wx0shsX6Ug8WoILgWHfM8bQyeKGqpZ9aXhG1pEn/mK0UFelFG6
         jE8m3FvUEvG26uy63PpxldLl0gvxaalcG4djBHZaXbL/JLIto1ODB3Ep4/0g86RzQXNO
         4kkJmiDLllAbLxFV900NF2NecmlQFJcAMEZsIH9UTXr7Ax8yhwCPK06xUHglqnZkeNKr
         2kgg==
X-Gm-Message-State: AOAM532rICGqPCzL9fBXHBOSe/mwPA+gCngJmKisCDpjee0xO20JZUtG
        I2i+rPUp4XVy2YJrvH9noSkeXYGtNmz9+zkw
X-Google-Smtp-Source: ABdhPJwOcmYNdnp9ZhxjCD4jeOXMD/F6raE14BcT4A5GSksc13Wi8AjZxemO9GPhgHDDYiwZ91kAvQ==
X-Received: by 2002:a05:6402:1109:: with SMTP id u9mr41388986edv.174.1618403052569;
        Wed, 14 Apr 2021 05:24:12 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:12 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCHv4 for-next 04/19] block/rnbd-clt: Remove some arguments from rnbd_client_setup_device
Date:   Wed, 14 Apr 2021 14:23:47 +0200
Message-Id: <20210414122402.203388-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@gmx.com>

Remove them since both sess and idx can be dereferenced from dev. And
sess is not used in the function.

Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>
Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/rnbd/rnbd-clt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 5a5c8dea38dc..ecb83c10013d 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1354,10 +1354,9 @@ static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, dev->queue);
 }
 
-static int rnbd_client_setup_device(struct rnbd_clt_session *sess,
-				     struct rnbd_clt_dev *dev, int idx)
+static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
 {
-	int err;
+	int err, idx = dev->clt_device_id;
 
 	dev->size = dev->nsectors * dev->logical_block_size;
 
@@ -1535,7 +1534,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	mutex_lock(&dev->lock);
 	pr_debug("Opened remote device: session=%s, path='%s'\n",
 		 sess->sessname, pathname);
-	ret = rnbd_client_setup_device(sess, dev, dev->clt_device_id);
+	ret = rnbd_client_setup_device(dev);
 	if (ret) {
 		rnbd_clt_err(dev,
 			      "map_device: Failed to configure device, err: %d\n",
-- 
2.25.1

