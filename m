Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6254C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75521613BD
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbhDFHHf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbhDFHHd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2F0C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n2so13952186ejy.7
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXtiFaknX7PqfpQnvD4MDPFOwWT0t3CzA0AxdcLxxxA=;
        b=Wwx3mB6x5kifMTw6ZzO+x/KxitBV9dZ8rhD8uSfVpnhPNKXAFYh2qDdbdVjEgViMCu
         bn/W36TDxt8X1XasdG2BHJ+EAIDKK8SmKGmWY8hbWXIywV2Pshiii2lY1tP2mpIzt0Wa
         TOtc2HvUnxR7SJX1Fsr5flo/HwKul0V6bN4jzgeuHXNKTlsmlLV+W0aNN3dn56bgJHUB
         XQKnvROc35f2Or+hc6P2wKA4zzfe0k2+0p9LDFFlB/q1WeJV+oiHEDfQqFg4yCMjCGaL
         MIJuytFes2V6NOuDuKWMws/q+9C6/ZfABd4k4dzWJdM0DnfU+zj9hs+yAZIWy6zFyiMn
         CC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXtiFaknX7PqfpQnvD4MDPFOwWT0t3CzA0AxdcLxxxA=;
        b=legt012T2G5lNZVIad/7owWyPJkgH+PU3Gn2WDqNhuf4W8BYDTxIJ2nsj8z3bm0OHW
         0mzIt2KJAZxnAOZiqql+9dRdDeGk95+eiorX+9KaEm5RRP6Q/XDqK9FjP9QvX8FkrZT6
         JfGI6hSiQuoUjoIGDUaMUua1YQ0+5LwyaR8nOfomic765xYISBtw3Vi9yvuyBwSbna8K
         so7AF7+CbiilwEL06YLY/h98wQ6jmvbgGlfSatIUFBwVrd/IJv1aC/Pj+FuU0R1I+kHd
         AyragFhs1dJNFGp8QBUO3xlLZp+LJDhi8kxKtWbZEyCuOGf1MHxDJpTiW+1CZRY4IMdl
         7DTQ==
X-Gm-Message-State: AOAM533E0WUR9WHXKiuwliCq5ndPpYON0aigfj0DLK4gUxY5UOn6ci1C
        4SrfkiZvy1WQNMnJN723q+WvLENzs85C6sYT
X-Google-Smtp-Source: ABdhPJwnbBY47yW42pJUzo1yBEqdQzQ2MVwYGvXT6Ywaj0KNFNjXRKR+KyQYcSmba8PxTIDjVOrYFw==
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr31745144ejb.91.1617692845111;
        Tue, 06 Apr 2021 00:07:25 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:24 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 07/19] block/rnbd: Kill destroy_device_cb
Date:   Tue,  6 Apr 2021 09:07:04 +0200
Message-Id: <20210406070716.168541-8-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
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
index a6a68d44f517..a4fd9f167c18 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -178,8 +178,10 @@ static int process_rdma(struct rtrs_srv *sess,
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
@@ -198,18 +200,9 @@ static void destroy_device(struct rnbd_srv_dev *dev)
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

