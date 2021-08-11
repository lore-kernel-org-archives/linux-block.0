Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B27C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B65D60F22
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhHKDhg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 23:37:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34652 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhHKDha (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 23:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628653027; x=1660189027;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tda/wI1ZwrYqH4umND8+Og63Ye/tFaSza1oypzr1bnw=;
  b=ZoXfBHZG5tim3Zuc62cMSqvo5BSxlb7Eutnxy+JqraBcXlnuyLO7zR9F
   BjHVcAx7i17ChIzTz5smGOsmdi1yWtRZKRguQO5AbfoUxY2/XV0TwMSwE
   eVHQLqrXw9Xsl6IZbc3h2SvgyyrI2JcjwdTbVuh70hlVrwG7wl7d/BWvR
   DUKMnAVuDcHWdOJi3lAhyI1ncpEP9Y1QFthgx6i0w2VLhfB9q5ial8w2f
   Tn3QBrvZhHV6oHLKF2q4/NeU6/SZU7BQ+PioIvvEb84aZpbJLM/KB7iNq
   bCV0ISEBM3823e2Ho07148t8ddHWurEPNDfrihYQlo6BU5X51xW4TRVeb
   A==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="177454815"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 11:37:07 +0800
IronPort-SDR: HJeqTwh7r4Iq7C/NpQHtefspQmHCw9z5VxrwhPAQbcrUPzraXIg4x8rdQvf/JuErg3klyHNOP3
 f5N32B2GOQ6axg8QDF3zJDJTolEUY/NfCc8zTDsvsDg9wE5HxntXdcdpxvDrmJxcsqQTbQHnq1
 oxhytpKyE9gXO3eoEjUQhayv0rGqFxrT9GRpYtKM8rCUf7ASCelKGHcMkAWpsIlV8UCERW3JtS
 dPC6l28IBocEW1FWoa+8fTzOQArkNiIAsaISLMnPWhVE62qnpWmU5Rbd6eh+k+ZQNC+r7HZtS6
 Ikque6d2f59VHKVdFfm9D5c5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 20:14:27 -0700
IronPort-SDR: FEZpBFus5K4fWMAEN+mHd0TgFuIveatp72Uyh2x27MEW0zq4qojs02FF9Dxp3k7YSsNwfmtUkb
 LiYzfuXUFhBfjFGA77x1/YdMOkmVf2QTq3DXgVTMr3u5g6Im2G5lGNZMxOxkAZQvydmmhJOxY3
 cgbyqTsQTKluBApb9vli7rxpTAHQt4aLK0LEaFVlxn3o+6dpXxWkTqjlqx7dk1W/E+gNtFLwcS
 p9UY0rh+tKoLKXMAa9+IRCWk7+YVWTSQs9L1klQ4TzgGpkYCKz9g7QbcV2yurdj6ZWOW9icMNS
 GMo=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2021 20:37:06 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4 2/6] block: improve ioprio class description comment
Date:   Wed, 11 Aug 2021 12:36:58 +0900
Message-Id: <20210811033702.368488-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811033702.368488-1-damien.lemoal@wdc.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In include/usapi/linux/ioprio.h, change the ioprio class enum comment
to remove the outdated reference to CFQ and mention BFQ and mq-deadline
instead. Also document the high priority NCQ command use for RT class
IOs directed at ATA drives that support NCQ priority.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/uapi/linux/ioprio.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index 77b17e08b0da..6b735854aebd 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -13,10 +13,12 @@
 #define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
 
 /*
- * These are the io priority groups as implemented by CFQ. RT is the realtime
- * class, it always gets premium service. BE is the best-effort scheduling
- * class, the default for any process. IDLE is the idle scheduling class, it
- * is only served when no one else is using the disk.
+ * These are the io priority groups as implemented by the BFQ and mq-deadline
+ * schedulers. RT is the realtime class, it always gets premium service. For
+ * ATA disks supporting NCQ IO priority, RT class IOs will be processed using
+ * high priority NCQ commands. BE is the best-effort scheduling class, the
+ * default for any process. IDLE is the idle scheduling class, it is only
+ * served when no one else is using the disk.
  */
 enum {
 	IOPRIO_CLASS_NONE,
-- 
2.31.1

