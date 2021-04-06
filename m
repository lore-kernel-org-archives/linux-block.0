Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A0BC43460
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA738613BD
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244158AbhDFHHd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbhDFHHc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70BBC06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dd20so7994290edb.12
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0U5h3qflJkPWgDXKbrDDU843EkMfjhOwR5MGRfmGtA=;
        b=drV85pQhJ1nViuyXKTgHvxSrloghRcHohutG1hfmFnJGDf7+cBrgoT78KZ6/ScT8LJ
         v50v0Nac46V3Z+LVAmKw5w4rnMOgyDxEg9+1Lvyc+Y73Nc84m6zh72WB1w8HfwGHa9An
         p2oV5hPoZnmM0ud1X+mUTOuuZTnT1/tBPkGb21OqNh554wsAW1oUuitrcKGUj3ZKoOeA
         80ZD32YQuVH3l6EWvk2uo7m3ROVVKUCc0HGKlRt7N++vld1ni3LbSJBcYAw0hwdE/pxK
         GSKRiD5NUjob8mFCb0O+KmuzeZUzT/Gg2x7CNKBoKDOMtLCaTrBC/R6eaYR5g+H+xsYn
         CULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0U5h3qflJkPWgDXKbrDDU843EkMfjhOwR5MGRfmGtA=;
        b=RWirvX/QLBmgB0iTTgqTzpjkzYh++TmiPVMDcVqp7aQSjXYRJCiOs29Y8t7VvWJofA
         CIK5lEennlt52sT+BmjFN6VwIHA7dh2IdJvqnNK+MVrpItLrm5gf2HT45yEiif5Bk0gP
         3sHnGzQI6h2o6veJJr+H4lF6bIy0IrtJCE+Q3BYLtwRILVPRdfdG/y5kGygxKzdSyc+9
         aptHYheb2QlPLrLLT4pCg4lKpBHbr8+k7XQriYyodx+ZZkn6ylTX0WboW74G78/HcNfb
         QZo7ph4BRVKZswXzbqOs7NIbFxvNl3elDcm1oiqGkiUiJYdWiyclqv+wQtiu51Aj1v+F
         UvEg==
X-Gm-Message-State: AOAM533I39RSVLNE7DnP9FVCjSR7KI9p8jJK2dQkTzymDtJ8wdtbuyo7
        QPIZaov2sKTmVMuLe5LAQqUV2+lyh0wTzQ==
X-Google-Smtp-Source: ABdhPJx94c8q3wUBk7ZpwHwclSOQ9CmDLDQArcsAOnZHkcrR/hdbZplH8nAz+XuzpKJ8NX+M+whHhA==
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr36472652edd.103.1617692843564;
        Tue, 06 Apr 2021 00:07:23 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:23 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv3 for-next 05/19] block/rnbd-clt: Move add_disk(dev->gd) to rnbd_clt_setup_gen_disk
Date:   Tue,  6 Apr 2021 09:07:02 +0200
Message-Id: <20210406070716.168541-6-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
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

