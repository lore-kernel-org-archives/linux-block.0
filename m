Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952A9C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9A060F13
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhHKDhi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 23:37:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34651 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhHKDhc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 23:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628653030; x=1660189030;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=j0s33+d09cJLd2qYDmoWRU5cJ5eobt/aSkEuXaJrC6o=;
  b=K1c30+dsvxSxLq4Yc9sB1E/YvDa6P4FZD1A2FOpjEs+aZ/ow+waCoUxc
   fkAlpT/tVeBj95Q9CCrMgsBXDfVIrAaF/ATx+SmMIxXJGyGmRipqOA7tO
   iuSF0cvsU1vHyevqcQ4m3wPORZIVKagy8U4TS0k7chSAgrNSpy+66lReF
   eurO7quGyFnN3iE1a7baQm3kjPyBAtRHddrH8D9lf1mtUKOMFzfz6uo+c
   VyeHAkvWaxvsH7crzPc2rNUTNONdn71sITRsrxwqKff7mnLYPvZ1SezRl
   zAb85oqwcbMiC+CRGgC05n/m4IXrAnqzG8GEZk1oWo4e9gRsueYgQOXri
   g==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="177454816"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 11:37:09 +0800
IronPort-SDR: O924dDbu7HD8iR8zm07rBT29zKjYrKkiDxGlYdtfqEPv/lFwMZXc7VRhgzBADBpejRAqUoELzC
 5GIMZiWcQ1LJogOaUm2w7OtZbbucus+Ah0Vh/b5WlMqkymDKy2vW+3xr7wfZAzHAMdNsHVMFJl
 3PA6d7RQpaRbPfHMCoEK+dHP/3o6FAsHiMwlQ0dtAYc+bwiIDe9+e55RNaFWhM4GtnI79975bI
 2zluDp5V5Wq/dndGLzXI09ZqNsfmaQiZnIrclokEmkyKXFkiGG/Rd9JpQH5i2dlVfIHOpAVJ6t
 +wkxJebbcLLiDhlLfLMlSX1L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 20:14:29 -0700
IronPort-SDR: QeCHXqY/a+FukCgR81BdGDYdIyE+0w1AzjKJpMCShWexbiAx90FnRJ+V+isIko4lu+mbaplzmz
 oA7DjAgMs62UPnzMYSmnsht6YtMeZ2iBp/bI6NSwVuKuft8oiKSX2vTV7/bPGz5Tf3mypEolOq
 +89DW0cpmueqKaxItD2d2DjFQDT6woxqHugcdKRmNKtYqSPKPRNkYP52qlFEUDoh1V1GDCW0OW
 I7gNI5Zk1cE8IpvSwlaBfNTxuw/emiu2I25LFYlOK2SU2crMvZYnPkjrgmIjmDS4+WiKBVWuRe
 wzo=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2021 20:37:07 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4 3/6] block: change ioprio_valid() to an inline function
Date:   Wed, 11 Aug 2021 12:36:59 +0900
Message-Id: <20210811033702.368488-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811033702.368488-1-damien.lemoal@wdc.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the ioprio_valid() macro in include/usapi/linux/ioprio.h to an
inline function declared on the kernel side in include/linux/ioprio.h.
Also improve checks on the class value by checking the upper bound
value.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/linux/ioprio.h      | 10 ++++++++++
 include/uapi/linux/ioprio.h |  2 --
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index ef9ad4fb245f..2ee3373684b1 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -8,6 +8,16 @@
 
 #include <uapi/linux/ioprio.h>
 
+/*
+ * Check that a priority value has a valid class.
+ */
+static inline bool ioprio_valid(unsigned short ioprio)
+{
+	unsigned short class = IOPRIO_PRIO_CLASS(ioprio);
+
+	return class > IOPRIO_CLASS_NONE && class <= IOPRIO_CLASS_IDLE;
+}
+
 /*
  * if process has set io priority explicitly, use that. if not, convert
  * the cpu scheduler nice value to an io priority
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index 6b735854aebd..5064e230374c 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -27,8 +27,6 @@ enum {
 	IOPRIO_CLASS_IDLE,
 };
 
-#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
-
 /*
  * 8 best effort priority levels are supported
  */
-- 
2.31.1

