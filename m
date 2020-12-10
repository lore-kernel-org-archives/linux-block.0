Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6CEC0018C
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFB923AC4
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgLJKTX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgLJKTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 05:19:11 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4D6C061793
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:30 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id g20so6575094ejb.1
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZj2H/4ea4ki/8QS6r4ZPiAvzyYfSVv6rdGzABwADaU=;
        b=A5MUOk0qIJDVs10H7gO8T+rzfFRIqSwrlemrbV8MSM/uy4EaS2I2dUlK1U0L7eFOwu
         0EJzh/qw6sJq2yt3Pm9xEb0O+dJHQ5bKk8pPrcr5nYQHx5VVkQBR8CRulBD/O39hPtkF
         jMcUtL+S2KVo8Ar+urn4AHWseCDrzofW34PqlfVkvc19fCZmmcXOQwym5pVL/NEXtJEI
         f4pZlsVMCG1X2Qs50NA7V3kwUOkk5TYiZzuMZg+Ubk4940z9tgpV5r8yPFUHumcGJ0Sg
         jjKOtMn9OV6KmC9x9S6pf3ytCxMP+gF0dBLPKZAruS4LFT3Fl8owzB0JUvn2YfFGy7CL
         YaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZj2H/4ea4ki/8QS6r4ZPiAvzyYfSVv6rdGzABwADaU=;
        b=GXC2ylTeFX1lvXKlI+GkpMIoZRQCsF4vY/LvsctJ3PchbMUdVGkg+YKKo6Mf6zZmE6
         CnIqzH50G0vg4R4s1wEhLoHrzLekmBoiOpDT9HIwL0+xnZZ46xDe2HZI2vTkBKTRtaYd
         Gau+sTDTg/uIgPi1p48mJFj9Ux3lR68g1dwYBeYnFnuRFi1RO6JNI+ENhGl1Sf4Ef99d
         Tmt05QVgn3b9LcJOhU4+v/dS4sSIj11oRiUWN8duPHGlVwdkzbyE8CTxXqEhOcgbMMC1
         YQoWKQwUbVnZH6dgYRipr9Zl4AvOhckWQq/z1t8X8G6higG9AUGxXlHROfbrUc2OObxs
         QsHQ==
X-Gm-Message-State: AOAM533ck40EUaCpngTC/YzGTKTYeKwgOF1v7j6MuU/KIGwyp5JIhfAp
        7jU0cAkKpHScx+jOZ7MSgL2Sv8UCNZ4NQg==
X-Google-Smtp-Source: ABdhPJxNg6PMre1lQA2bWVN4aZfR0DU2omI2V/L75uIA6Gacodu/kUQc2yxnanbMDRJlzCdRviQPmw==
X-Received: by 2002:a17:907:2061:: with SMTP id qp1mr5542437ejb.222.1607595508790;
        Thu, 10 Dec 2020 02:18:28 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4938:300:58f0:963a:32b2:ff05])
        by smtp.gmail.com with ESMTPSA id s24sm3955878ejb.20.2020.12.10.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:18:28 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCHv2 for-next 1/7] block/rnbd-clt: Get rid of warning regarding size argument in strlcpy
Date:   Thu, 10 Dec 2020 11:18:20 +0100
Message-Id: <20201210101826.29656-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
References: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

The kernel test robot triggerred the following warning,

>> drivers/block/rnbd/rnbd-clt.c:1397:42: warning: size argument in
'strlcpy' call appears to be size of the source; expected the size of the
destination [-Wstrlcpy-strlcat-size]
	strlcpy(dev->pathname, pathname, strlen(pathname) + 1);
					      ~~~~~~~^~~~~~~~~~~~~

To get rid of the above warning, use a kstrdup as Bart suggested.

Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index a199b190c73d..d63f0974bd04 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1388,12 +1388,11 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 		goto out_queues;
 	}
 
-	dev->pathname = kzalloc(strlen(pathname) + 1, GFP_KERNEL);
+	dev->pathname = kstrdup(pathname, GFP_KERNEL);
 	if (!dev->pathname) {
 		ret = -ENOMEM;
 		goto out_queues;
 	}
-	strlcpy(dev->pathname, pathname, strlen(pathname) + 1);
 
 	dev->clt_device_id	= ret;
 	dev->sess		= sess;
-- 
2.25.1

