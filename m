Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D74C433EB
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0235D61A1A
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhCYPae (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhCYPaA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:30:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E520C06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id jy13so3622136ejc.2
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nb98K5yr7Hr81H1xM1HbveTdnjGZy9hyYyfNIs0ucDU=;
        b=WnD4lSj/Emowr6dXNt2FsbXHKG9b43biD6ypdKw5w9gzQh9A1dLF/bYhLUAOA4ye3n
         c44VJ+SwaC6MrkjD4Y+7+wXxRCWZcSh7Cv+5quPE6PIuUZg64+jV7lM9LBfTBXcSEGlV
         +mTdrcTfGy5kTq4iBPbKXXoVKlsJHe6zfvnUZwbKga51qOY9kguvMZDUr164HsKUaCz+
         5ByW58k45N+jCwY1Pz2/o7PRY/s9vbniEAsYKPSJWiC/YHPILf6gLqxuzMC1GCyKHdfA
         cVTq4Ak2lDOSNohw11on0jYWEQ3o2kXggZtkfT+geNFqbunpWCd2lO052fQKBptZ9d5w
         jL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nb98K5yr7Hr81H1xM1HbveTdnjGZy9hyYyfNIs0ucDU=;
        b=hbha0pP45xVOerr1IzU5DUQr9Q3RNstNjBFKQ2BShEtI9l3vubbY02WStlxNqvjfNa
         IgTcgtd1QWwZRFE2FRVDVcIkgNaeYfBnenHwrNO+QdEFCrcGUr37K5TJqLWKRFNMhvig
         8tr1KOjxp/v02WDBz36bv2TB+89oLW3cB/xQvfqd30NQBcnFdxmHfLrGSeMrPya+q8kh
         cv7OCOSR0kV6H5WM/tSNSx86ZoU3tLo9mjK0A66swW4NkC5vs5shJBZkxSzWDzh3gZPe
         FTuPm17fPJFdKOU64p+UX6JtWO5hJTqKi+3aBvf4VaZHIsBnvUuDmV9E0ewg8igFH0tZ
         DX6Q==
X-Gm-Message-State: AOAM531RXGIsNETt1+Tu6hiP6qIn4Y7Fw3uilpeJXler0+ejsLDSMnra
        XpQmwY0ymavHc+oLUhO9V+a05WdrzyeQkQ==
X-Google-Smtp-Source: ABdhPJygOr1zSzrJrHMgx+fl7LMsr5BYRlCJpiMsVkDgqhNhfNXmVA/OPzkFM5VqLA4BHmTte8oYBQ==
X-Received: by 2002:a17:907:2112:: with SMTP id qn18mr9840281ejb.220.1616686198043;
        Thu, 25 Mar 2021 08:29:58 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:29:57 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-rc 09/24] block/rnbd-clt: Remove some arguments from rnbd_client_setup_device
Date:   Thu, 25 Mar 2021 16:28:56 +0100
Message-Id: <20210325152911.1213627-10-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
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
---
 drivers/block/rnbd/rnbd-clt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index c8de016553a9..5d085bc80e24 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1360,10 +1360,9 @@ static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, dev->queue);
 }
 
-static int rnbd_client_setup_device(struct rnbd_clt_session *sess,
-				     struct rnbd_clt_dev *dev, int idx)
+static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
 {
-	int err;
+	int err, idx = dev->clt_device_id;
 
 	dev->size = dev->nsectors * dev->logical_block_size;
 
@@ -1541,7 +1540,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
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

