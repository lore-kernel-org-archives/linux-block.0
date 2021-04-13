Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0615C43461
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB584613C0
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbhDMKxc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbhDMKxb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 06:53:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB80BC061574
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:53:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n2so25148071ejy.7
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1p4UuWXUcDL5Md++SwHU7dqkkEr/TBzQyQcjlzcBQw=;
        b=tcSQR0S/SU9me1Ajo2o9ergyObgc7OaQXSgtS+l+5miEnb42187A7whMd2BofZL4v/
         7T5juKjej5UrUgs0rD9mnrz8ra3o+h4eYWb/aggLkPJGZ7hLHTiIrEGE7qhPomiRg8xP
         CcgKTVlZYuw4bXXyiw+jSt7XZpwqAUUQ0igbuXtSY1s/cKYShWy8GXdsRnvrE3HcmrT4
         pUb/4fvCMbE2RSKO6vSqiNIN5iRFowbGTWctm6tPT7LRf1He2GW1Fbg98l77tU6FEiDw
         RiX+Y6dBdtYXy2aNeJBnHMAUoR5Sp3RvssduUZgD+tKOze090rUKlNyIbygeS0S3e3vD
         Bjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1p4UuWXUcDL5Md++SwHU7dqkkEr/TBzQyQcjlzcBQw=;
        b=I8oe3iUl6Rrm8JO92RgOOWEbJ6k6Z/roSXjbn71Zkdx0kRvT8pjyvg+PhTpddOBd2x
         oMOCKMzm0YJ83NCpIpp6ghr2QXbdWHC9F8O/WfoIHlzmIhCcIzrYiCd9LUwgYsXcioih
         7AtKMB+0a6R+9yNm80sBQlj3wMzF6Y9tIx3fGetcWva+usMqAu6fJEZZtIM6XdiJi11j
         ag32Cbbav6CnZ8+eS7GGonHET2CxP2nJkxaB0SkY536DT6/DYiJS+RRBkjr/uena+V9l
         zruQVWvcG02RA4XrJd/F9QDrCHcEX6kUfLFbf+PBf0H+feif7q9elt3WCG8eloeSlpww
         JJ7g==
X-Gm-Message-State: AOAM531nkSDY7RMNM+7Umd2zCOTpl/sN/qx1u4+yILO4fiyu0eSSEvWr
        Sc32eq6DFxOAa697E6z+mExHZg==
X-Google-Smtp-Source: ABdhPJxfZ4hijsdEAW+lZn8dtQ7MQBoHW9ksx6ii3MScJYyhatBmARFjMSoyh6EulIVTjAh7IS9RKA==
X-Received: by 2002:a17:907:118c:: with SMTP id uz12mr23436488ejb.308.1618311190614;
        Tue, 13 Apr 2021 03:53:10 -0700 (PDT)
Received: from dellx1.cphwdc ([87.116.37.42])
        by smtp.googlemail.com with ESMTPSA id m5sm9140064edi.52.2021.04.13.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:53:10 -0700 (PDT)
From:   "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <mb@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH 4/4] lightnvm: deprecated OCSSD support and schedule it for removal in Linux 5.15
Date:   Tue, 13 Apr 2021 10:52:57 +0000
Message-Id: <20210413105257.159260-5-matias.bjorling@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413105257.159260-1-matias.bjorling@wdc.com>
References: <20210413105257.159260-1-matias.bjorling@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Lightnvm was an innovative idea to expose more low-level control over SSDs.
But it failed to get properly standardized and remains a non-standarized
extension to NVMe that requires vendor specific quirks for a few now mostly
obsolete SSD devices.  The standardized ZNS command set for NVMe has take
over a lot of the approaches and allows for fully standardized operation.

Remove the Linux code to support open channel SSDs as the few production
deployments of the above mentioned SSDs are using userspace driver stacks
instead of the fairly limited Linux support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/Kconfig | 4 +++-
 drivers/lightnvm/core.c  | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 4c2ce210c123..04caa0f2d445 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -4,7 +4,7 @@
 #
 
 menuconfig NVM
-	bool "Open-Channel SSD target support"
+	bool "Open-Channel SSD target support (DEPRECATED)"
 	depends on BLOCK
 	help
 	  Say Y here to get to enable Open-channel SSDs.
@@ -15,6 +15,8 @@ menuconfig NVM
 	  If you say N, all options in this submenu will be skipped and disabled
 	  only do this if you know what you are doing.
 
+	  This code is deprecated and will be removed in Linux 5.15.
+
 if NVM
 
 config NVM_PBLK
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 42774beeba94..40a948c08a0b 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1174,6 +1174,8 @@ int nvm_register(struct nvm_dev *dev)
 {
 	int ret, exp_pool_size;
 
+	pr_warn_once("lightnvm support is deprecated and will be removed in Linux 5.15.\n");
+
 	if (!dev->q || !dev->ops) {
 		kref_put(&dev->ref, nvm_free);
 		return -EINVAL;
-- 
2.25.1

