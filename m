Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F986C433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6ED613C4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbhDMKxa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbhDMKx3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 06:53:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9BCC061756
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:53:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id x12so4379182ejc.1
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWYBsQ0iIq/Mj+dRpMPNfNZQS2gmrRMV8eFiQixkTZE=;
        b=0clnAYrPNJhATfqG5vCSG9fDtOQIfLlRqZjM4+Abz4WEMrqgE4+Y+NypYdOhgbi9kJ
         gHYqRGAU3I8vA+3oB83bsQX/MJ6inaWg5kBiKUQo86v5btc7RbMSoUXoXgE/xgTeUQ8M
         aSk333uJE5HyfmG8UT9usWeNaR14MacX5AtZ/8ymeUpX9FNH/8xNnAtGWa0oZP+aH7FR
         lfhVBOa61R53eI51scpntevUuai7ffqUvhfLuLsFl4dGeQicmNSpPJOcQbx5w5XgCCez
         pbg3Tfo776dz2XZdFL/d9Yqt+Bmdn0vvMx9pNFrpl8nGpmfKdRNHt5HGFPOamFiLwzoa
         xk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWYBsQ0iIq/Mj+dRpMPNfNZQS2gmrRMV8eFiQixkTZE=;
        b=ufiFpeSja9BbGP02JcTnAuHd8HKWy3gP4o7h0wJiFOfU+8pQeCVL/kVzJPL07UB52M
         pFQnDBQO9MLZGKSvc9pkwZVL15StqGPZCd6ZAMOf2OdjsLNivV1WCXB0h8U+l92Yuxv3
         7EeV+RDyc/9Cmg8rCwBekboHZjzfZt1FnbtRjGmFuGiH+1NktfTJ2bcmF9nk7JRf4v9L
         6Mq5+0IhpbWqc9PDuh8wuSSMAKkv2fvyxZeA4GdNk0mg8plccquYiI0mtSIxTAExGdCa
         X/dq9Y2HNRa81BWQicfAVZz4DQoxm3A7VdUSxxNnXjRNngDxy6AZMEKDfQqsPP1Wu2P3
         ok6w==
X-Gm-Message-State: AOAM533uFDuz6WwpRPIRBlIvv2mYypv6qmzbV+OAdiKMzfh4PNDEgJa7
        W5cbvcUHAEXsXj/gZGTT6kQPMw==
X-Google-Smtp-Source: ABdhPJxk07JKXg2XdwRQTV7d5YrDGj3/9ZD3LgBOKXrdRJC6juUrACqk4uX4e6jIzehU50tLw3WJcw==
X-Received: by 2002:a17:906:80d6:: with SMTP id a22mr9859867ejx.277.1618311188262;
        Tue, 13 Apr 2021 03:53:08 -0700 (PDT)
Received: from dellx1.cphwdc ([87.116.37.42])
        by smtp.googlemail.com with ESMTPSA id m5sm9140064edi.52.2021.04.13.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:53:07 -0700 (PDT)
From:   "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <mb@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 1/4] lightnvm: use kobj_to_dev()
Date:   Tue, 13 Apr 2021 10:52:54 +0000
Message-Id: <20210413105257.159260-2-matias.bjorling@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413105257.159260-1-matias.bjorling@wdc.com>
References: <20210413105257.159260-1-matias.bjorling@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This fixs coccicheck warning:

drivers/nvme//host/lightnvm.c:1243:60-61: WARNING opportunity for
kobj_to_dev()

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index b705988629f2..e3240d189093 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -1240,7 +1240,7 @@ static struct attribute *nvm_dev_attrs[] = {
 static umode_t nvm_dev_attrs_visible(struct kobject *kobj,
 				     struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct gendisk *disk = dev_to_disk(dev);
 	struct nvme_ns *ns = disk->private_data;
 	struct nvm_dev *ndev = ns->ndev;
-- 
2.25.1

