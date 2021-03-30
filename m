Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB103C433EC
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94EC61959
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhC3Him (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhC3HiI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93CDC0613DC
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hq27so23297594ejc.9
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFSHDt2a4UMse8UCqMOLtSx70A+SNRfPmGCXQKYuQAY=;
        b=faceGjifndcv1IRDoE48i5dDQkGM+fMgsgFlgzHevrjPnx6HzRoDhfuNDIJcrAtqdk
         3jOqzkRdQmCG5RmfWhD7Yu6oT0b+ZtDiLBx9rzEbgQKuhDEs325jnjoL3923p9JWrR4e
         zkOLf7yCgt0dvduwcTmBMjXOyWBRZtP1QKWGrSKJhvlUNn3I0UkEyBJsJ3CjUwi6hEx7
         KQ7skCTRuBzXBX5ROxKsXjsLYTKc7Lk+3is1jc6kpxgCy8O3Mu4xThTcOa7v0G3X0Wcr
         6PcYBIvounywtcX5VOpWTpoF5RsV30+1MjTBqQUVUxJ97JyyO8EnqemetzNP9RLToO7N
         XASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFSHDt2a4UMse8UCqMOLtSx70A+SNRfPmGCXQKYuQAY=;
        b=XEnbbGFyxlffMyX3C9R1W9AapZA2emrJJq1Fk9AtkJ8nlNBk2+6eiC1RL2wn+/6FlA
         a2lPXVfXNgKwcxfzhlHU/R0uEk0isNKFMNGQw2sPuS9uxuNXUQ3QrSWDwKM2KqTkZknR
         DKIm5A1jjTJ8gpklBTPwCDTZjj/vbdZzaIUJHyn1oCUJ6QVkJJ6Ozdhn8zyefI75wmpK
         r/8zTwZ7D+/BFE1HjX6d0sLvekhlfxC0whATHhsMAhcbbDcJQUMwu7flQs9EHmaCLhfe
         9ef/LYZoclKkBD4DswoHWgGRtWMB0S2QUNmAY610y8nZ29so/HlKmZYiXMov5tbUnFcI
         XyWg==
X-Gm-Message-State: AOAM533L4Gfo9nfUANXa0uzMRFzdRJWwf8d3UxtvRwfLL4RCpxVq1kOE
        hm8FNFJUvlLg0S8+LFRTIdF6Pv4llQ841Liq
X-Google-Smtp-Source: ABdhPJwWRICxQjoTNQvgwrEe5cBMwNa8uNHj48wmkcz7RT+1C5//6GEPPJ+w6ewG6KdS/aSvhea6sA==
X-Received: by 2002:a17:906:3b48:: with SMTP id h8mr31778644ejf.261.1617089886501;
        Tue, 30 Mar 2021 00:38:06 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:06 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 12/24] block/rnbd: Kill destroy_device_cb
Date:   Tue, 30 Mar 2021 09:37:40 +0200
Message-Id: <20210330073752.1465613-13-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

We can use destroy_device directly since destroy_device_cb is just the
wrapper of destroy_device.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 447fb0718525..895e9c313ff0 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -183,8 +183,10 @@ static int process_rdma(struct rtrs_srv *sess,
 	return err;
 }
 
-static void destroy_device(struct rnbd_srv_dev *dev)
+static void destroy_device(struct kref *kref)
 {
+	struct rnbd_srv_dev *dev = container_of(kref, struct rnbd_srv_dev, kref);
+
 	WARN_ONCE(!list_empty(&dev->sess_dev_list),
 		  "Device %s is being destroyed but still in use!\n",
 		  dev->id);
@@ -203,18 +205,9 @@ static void destroy_device(struct rnbd_srv_dev *dev)
 		kfree(dev);
 }
 
-static void destroy_device_cb(struct kref *kref)
-{
-	struct rnbd_srv_dev *dev;
-
-	dev = container_of(kref, struct rnbd_srv_dev, kref);
-
-	destroy_device(dev);
-}
-
 static void rnbd_put_srv_dev(struct rnbd_srv_dev *dev)
 {
-	kref_put(&dev->kref, destroy_device_cb);
+	kref_put(&dev->kref, destroy_device);
 }
 
 void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
-- 
2.25.1

