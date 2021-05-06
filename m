Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C6C43460
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 14:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A347610FA
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 14:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbhEFO7i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbhEFO7i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 10:59:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2C2C061574
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 07:58:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x19so8233753lfa.2
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pMkfZ9EIibr4K3KFH7NDHi8SFeCMCdnE2OEuvOfMmWI=;
        b=ropSb77Z7ZrvZWrWv2bmJfXeH/HzlRDinr63ZcMxxBBVdHQotkVsjMZbDvofMAONzz
         qT8r+iXzXXOD01g+ip5mkthcRroRfqlQbSrm3pmVcFQ9EzTCPTHCYgg7uvt47fHJm1AM
         dO4PbF9DwlRbrtRTMQfnLLtWxfp1ZksVh4bnjzwQHUyWsjr1zmL1EQS3DL2VoDPLOOLX
         4SZlpMdyET23pLEL0Mln9+bsUfsMn6qbv9JFMjw1nP48U31xrY6uDocaCh29tO2BZTGt
         z4toTYgG2gLPmxQGkYlCDC1IWGiWlsY/evMJY1Hp+UAtsSB2HM4rhl2/ve4bhnQgZhfx
         Gheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pMkfZ9EIibr4K3KFH7NDHi8SFeCMCdnE2OEuvOfMmWI=;
        b=gXQ08oDrF4kpcG5RqFSEiGD37AUC+YW+5DF1oKbZu+RzRWpIbN1ubwg4i6P4CkLjpm
         ae7ltoUYN+XDSSIuD6qNMltEIfHhAq/G1AW+535BrFYdCFmFGQV/tK/6Py/C2n2YDaWk
         26KI06ev67OAXmNo00cQuLHK51aHuDavdkdVaD7muh2I2gMLIsRVzsuYscE/RQ9Hc6c1
         SgDSMpkbj7fInFOVD2+EblOb3zZaKQxJYLimPfj54zTQX5xCq9/6YZ0V61HKzBVwRDbS
         t8VY5z7kwunFGlci8Zmed0EMUgi+dzb4VUCXfRdOGw/7Iu2Cx9QlnxayxDxp1gkg07eL
         0Mnw==
X-Gm-Message-State: AOAM5302Xtp5+ehIr83KZGi/CwxewZhugG0uNSjvGRsrnLjdZ0Nm8f+a
        5dqZTI8fS9DVHt/LoOmIkxv6sg==
X-Google-Smtp-Source: ABdhPJxqAiOCtWASA9ZL0VYB9iWkxgoY7P6chLaBXA9n4TxQrVRKBX1sDd549LroNkvZ/HS6sG43Ug==
X-Received: by 2002:ac2:48a5:: with SMTP id u5mr3244496lfg.346.1620313118333;
        Thu, 06 May 2021 07:58:38 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id g24sm968774ljl.44.2021.05.06.07.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:58:37 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: core: Move eMMC cache flushing to a new bus_ops callback
Date:   Thu,  6 May 2021 16:58:28 +0200
Message-Id: <20210506145829.198823-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506145829.198823-1-ulf.hansson@linaro.org>
References: <20210506145829.198823-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To prepare to add internal cache management for SD cards, let's start by
moving the eMMC specific code into a new ->flush_cache() bus_ops callback.

In this way, it becomes straight forward to add the SD specific parts,
as subsequent changes are about to show.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c   |  2 +-
 drivers/mmc/core/core.h    |  9 +++++++++
 drivers/mmc/core/mmc.c     | 25 +++++++++++++++++++++++--
 drivers/mmc/core/mmc_ops.c | 21 ---------------------
 drivers/mmc/core/mmc_ops.h |  1 -
 5 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 689eb9afeeed..d73d7be1af2f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1159,7 +1159,7 @@ static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	struct mmc_card *card = md->queue.card;
 	int ret = 0;
 
-	ret = mmc_flush_cache(card);
+	ret = mmc_flush_cache(card->host);
 	blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
 }
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index db3c9c68875d..0c4de2030b3f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -30,6 +30,7 @@ struct mmc_bus_ops {
 	int (*hw_reset)(struct mmc_host *);
 	int (*sw_reset)(struct mmc_host *);
 	bool (*cache_enabled)(struct mmc_host *);
+	int (*flush_cache)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
@@ -172,4 +173,12 @@ static inline bool mmc_cache_enabled(struct mmc_host *host)
 	return false;
 }
 
+static inline int mmc_flush_cache(struct mmc_host *host)
+{
+	if (host->bus_ops->flush_cache)
+		return host->bus_ops->flush_cache(host);
+
+	return 0;
+}
+
 #endif
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 13074aa1f605..838726b68ff3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -28,6 +28,7 @@
 
 #define DEFAULT_CMD6_TIMEOUT_MS	500
 #define MIN_CACHE_EN_TIMEOUT_MS 1600
+#define CACHE_FLUSH_TIMEOUT_MS 30000 /* 30s */
 
 static const unsigned int tran_exp[] = {
 	10000,		100000,		1000000,	10000000,
@@ -2036,6 +2037,25 @@ static bool _mmc_cache_enabled(struct mmc_host *host)
 	       host->card->ext_csd.cache_ctrl & 1;
 }
 
+/*
+ * Flush the internal cache of the eMMC to non-volatile storage.
+ */
+static int _mmc_flush_cache(struct mmc_host *host)
+{
+	int err = 0;
+
+	if (_mmc_cache_enabled(host)) {
+		err = mmc_switch(host->card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_FLUSH_CACHE, 1,
+				 CACHE_FLUSH_TIMEOUT_MS);
+		if (err)
+			pr_err("%s: cache flush error %d\n",
+			       mmc_hostname(host), err);
+	}
+
+	return err;
+}
+
 static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 {
 	int err = 0;
@@ -2047,7 +2067,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	if (mmc_card_suspended(host->card))
 		goto out;
 
-	err = mmc_flush_cache(host->card);
+	err = _mmc_flush_cache(host);
 	if (err)
 		goto out;
 
@@ -2188,7 +2208,7 @@ static int _mmc_hw_reset(struct mmc_host *host)
 	 * In the case of recovery, we can't expect flushing the cache to work
 	 * always, but we have a go and ignore errors.
 	 */
-	mmc_flush_cache(host->card);
+	_mmc_flush_cache(host);
 
 	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->hw_reset &&
 	     mmc_can_reset(card)) {
@@ -2216,6 +2236,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.shutdown = mmc_shutdown,
 	.hw_reset = _mmc_hw_reset,
 	.cache_enabled = _mmc_cache_enabled,
+	.flush_cache = _mmc_flush_cache,
 };
 
 /*
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index b1da8f1950ee..af423acc4c88 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -20,7 +20,6 @@
 #include "mmc_ops.h"
 
 #define MMC_BKOPS_TIMEOUT_MS		(120 * 1000) /* 120s */
-#define MMC_CACHE_FLUSH_TIMEOUT_MS	(30 * 1000) /* 30s */
 #define MMC_SANITIZE_TIMEOUT_MS		(240 * 1000) /* 240s */
 
 static const u8 tuning_blk_pattern_4bit[] = {
@@ -964,26 +963,6 @@ void mmc_run_bkops(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_run_bkops);
 
-/*
- * Flush the cache to the non-volatile storage.
- */
-int mmc_flush_cache(struct mmc_card *card)
-{
-	int err = 0;
-
-	if (mmc_cache_enabled(card->host)) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 EXT_CSD_FLUSH_CACHE, 1,
-				 MMC_CACHE_FLUSH_TIMEOUT_MS);
-		if (err)
-			pr_err("%s: cache flush error %d\n",
-					mmc_hostname(card->host), err);
-	}
-
-	return err;
-}
-EXPORT_SYMBOL(mmc_flush_cache);
-
 static int mmc_cmdq_switch(struct mmc_card *card, bool enable)
 {
 	u8 val = enable ? EXT_CSD_CMDQ_MODE_ENABLED : 0;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 2b1d730e56bf..c3c1d9c2577e 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -51,7 +51,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms);
 void mmc_run_bkops(struct mmc_card *card);
-int mmc_flush_cache(struct mmc_card *card);
 int mmc_cmdq_enable(struct mmc_card *card);
 int mmc_cmdq_disable(struct mmc_card *card);
 int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms);
-- 
2.25.1

