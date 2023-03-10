Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAE6C6FA99
	for <linux-block@archiver.kernel.org>; Fri, 10 Mar 2023 16:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCJQuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Mar 2023 11:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjCJQuH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Mar 2023 11:50:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A3835A5;
        Fri, 10 Mar 2023 08:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678466827; x=1710002827;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/kOQRfx48buUCjwXu/j7ksx4tbQ+zxTXCOpFFp2eFmg=;
  b=I/0WWyI7a8hbZyFS1rHbFmLVANmvk7IP1LZPFE/VJhvdVoCimLGCV5Tw
   OPfb+OXIu3tIime5nq49TgtgSKRrYB57NES/BhivbPfxgSpukSMDA2/TS
   jRzmoWv3ENLmmWgwtl1J7QqvgAk9/RKtmBh9PBuLLL/2AT9S1JDmlz1Re
   GW52xkcNKBV2Wy55gLheoT2AOgnC6lzN6frhc0d/MiCdmUebLH4AHSpSg
   lpnxRDAkHbsoFf6GyMKQ23iRwYGuFWXICo0uHujzYNz/IULVk6W8Yhmbh
   GNohNKXTNuXNP3Dgvdfe/ytNxafLIfDeuB5gMuP1l82PixhXiDE+e8lbH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320621129"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320621129"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:45:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746778623"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="746778623"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 08:45:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 18D3314F; Fri, 10 Mar 2023 18:45:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] pktcdvd: replace sscanf() by kstrtoul()
Date:   Fri, 10 Mar 2023 18:45:42 +0200
Message-Id: <20230310164549.22133-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
References: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The checkpatch.pl warns: "Prefer kstrto<type> to single variable sscanf".
Fix the code accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/block/pktcdvd.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 0ec8dc8ee5ed..ad4336ae9927 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -236,15 +236,16 @@ static ssize_t congestion_off_store(struct device *dev,
 				    const char *buf, size_t len)
 {
 	struct pktcdvd_device *pd = dev_get_drvdata(dev);
-	int val;
+	int val, ret;
 
-	if (sscanf(buf, "%d", &val) == 1) {
-		spin_lock(&pd->lock);
-		pd->write_congestion_off = val;
-		init_write_congestion_marks(&pd->write_congestion_off,
-					&pd->write_congestion_on);
-		spin_unlock(&pd->lock);
-	}
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	spin_lock(&pd->lock);
+	pd->write_congestion_off = val;
+	init_write_congestion_marks(&pd->write_congestion_off, &pd->write_congestion_on);
+	spin_unlock(&pd->lock);
 	return len;
 }
 static DEVICE_ATTR_RW(congestion_off);
@@ -266,15 +267,16 @@ static ssize_t congestion_on_store(struct device *dev,
 				   const char *buf, size_t len)
 {
 	struct pktcdvd_device *pd = dev_get_drvdata(dev);
-	int val;
+	int val, ret;
 
-	if (sscanf(buf, "%d", &val) == 1) {
-		spin_lock(&pd->lock);
-		pd->write_congestion_on = val;
-		init_write_congestion_marks(&pd->write_congestion_off,
-					&pd->write_congestion_on);
-		spin_unlock(&pd->lock);
-	}
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	spin_lock(&pd->lock);
+	pd->write_congestion_on = val;
+	init_write_congestion_marks(&pd->write_congestion_off, &pd->write_congestion_on);
+	spin_unlock(&pd->lock);
 	return len;
 }
 static DEVICE_ATTR_RW(congestion_on);
-- 
2.39.1

