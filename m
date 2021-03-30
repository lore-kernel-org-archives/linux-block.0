Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C53C433E9
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FB16199A
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhC3Hik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhC3HiF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF600C061762
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e7so16991937edu.10
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nb98K5yr7Hr81H1xM1HbveTdnjGZy9hyYyfNIs0ucDU=;
        b=Hug8apLsGdflPUJT5Gyc9Ti7pTmviziJ2UiK6uSwGxXH4eRS8OGvRPJRYM9lgIJk6B
         QkQrVzoUENN5X6Ut4L44ZG4EzpdSF8NtfHapOvWmJnTHFxHx1bYim0DgpiSEy+4tHYbN
         Z/YUx7ZlJD1pDj7e3nDIMgTWMNJazJlqJh27PCaR6FLVNwoqwjl3uTsWGwskY3Ls1129
         ve47dNKYN5u0vSN3EklPgSM/HLH18DmQSnvkTa+xrZr6g29NFYA3uU8T17uPUt/oxUtg
         De68nB7KKP/0v+16Yp3PohKJspT9jyejzXU7zcfaum3l0cpnNlyM4RLMEKLccRauML6d
         Ud0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nb98K5yr7Hr81H1xM1HbveTdnjGZy9hyYyfNIs0ucDU=;
        b=FGQ7Jv5Jz5bExDsY9Yb4sIrTepHpDBVw2haPcqimEwhhbKDlwBTekZrZPRDdeGZDzd
         m+IQbZ3hUqv9aViAkPPq7/6R3+Os20cnOG6Xl/196WgXA0ZuOn90bjQdgWzHP2SvExwk
         hz7f3TMXgy57eS8FW0PCl8n882SFLjJKfuN/uI+qb+qH9eXa4cZg/6ka5Bl2l1rrQPta
         V8lOiuWr2ky4lcUU/WjDlNuQEmmHynsRtRcRnNKnAgIbNjMLtLJ1CRf8blLucpWzZgDS
         ZOHmeyPehF2UwgMQTGiARWkdoz8B3EUdJVCEOQAhjQlI1yrVzv6oMsmTKaG99SJfgssE
         z2Jg==
X-Gm-Message-State: AOAM530mlvK1jK75fvNqsRXwKR3trXa6w05L2RVmPvA+Rxk4lwKjaepy
        RGwh9qbuui0k8k+jCYYfw8hgGGvPJziB93MA
X-Google-Smtp-Source: ABdhPJzeruynk0sLA/xtToJf28maRiWsuPEjqfOZ+6pU0qUruRFH2womp0cMcnWxXYzFDAGmavNraQ==
X-Received: by 2002:a05:6402:2076:: with SMTP id bd22mr31761449edb.378.1617089883350;
        Tue, 30 Mar 2021 00:38:03 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:03 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv2 for-next 09/24] block/rnbd-clt: Remove some arguments from rnbd_client_setup_device
Date:   Tue, 30 Mar 2021 09:37:37 +0200
Message-Id: <20210330073752.1465613-10-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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

