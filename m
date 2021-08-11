Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E21AC43214
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E466460F22
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhHKDhv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 23:37:51 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34666 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhHKDhf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 23:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628653033; x=1660189033;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=aIY39d4hgoXJ5yC909GBcv4Zo1XR4CYUFpg6offLqg4=;
  b=mkUytbje80TaCIAMY1x8mnNXFSkG959PhuCkkg0H9IvEWpxXAFl+nG5y
   8fNOLfMnC+jie0dwGY5ZszNxYC6YhRW7I4fxim6TlPXk+iVzufI3XDZJc
   9FEH8/wc+l97mtQR6K5RTMahnrdu2fBIlpA6aIyDy/8P6rqMmAgKITGdi
   Wmu3qTopd4Ol1vqZIwTXfZNc/lpI17bX87Tql/vId57QBR7Zq/yBrybUX
   UvzjfOnkK6aha6P+teG4bdRyKLZoHgqGYjNA9Il3Vu1x6UJ7ouw12dgz9
   n/HqGxI/khgKzhWoEdNflx9vuRjSDFAn2eTq1qEAEmA1R6Bj2WDeBrl9L
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="177454820"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 11:37:13 +0800
IronPort-SDR: +OrEXQfJqgiy6LbfaF5wDr8J6ZvnjnZFb6Davwx7xbjSPTvRqZZJr3FcMXCF1w6bCvQnW+6vSm
 k4IPrWzW2Zh5YG9H+bDXk7NIyrkn6+TY+TSn2S6nRN/J1wGRdrnY0wCMMhfPd+PWtPL/XCmNGx
 52rrxxnxQUSI8rznDpcOW1sm9m6Eng3GSMvyLoT+hjzbzH2DTx8KBLPAxcjwhso9xJsaxheVAl
 rjCHP2VmzozOmHzbsjolbcHQMevetz6rXbSCbV7/qhb3rPaWChTJfAVY10U/Usafd8wr+qutJw
 6/ZL61eJMmE9Raf2KYkHL4nF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 20:14:33 -0700
IronPort-SDR: Xb3/7ZlwUG+JnG3iXyej6Y9GLbcebGNIfPJy6Y8FRbvgl69fAikHEiz4PTscm0LpsRymbEL1M9
 YBnLe88i40M7lEwfZSYnJZKTIf1T9bN4cyxi7cYb4aqEOiLTy8dbisxhryK4ErmqWwTyfKy4hm
 A5LhpCiaYghAo2RB2Hs5jbkSF0+hw8AxP04tIZ8olrXMvGF9hzbP2zi1i03O1QPD6UllLz1nzJ
 XeEcq0aFesgKtspnyc6Qae6mQC4uMddcX/niF19d8OlOydIhjzGC+I4d6ahrUZx/iIeZcU/G20
 i/0=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2021 20:37:11 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4 6/6] block: fix default IO priority handling
Date:   Wed, 11 Aug 2021 12:37:02 +0900
Message-Id: <20210811033702.368488-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811033702.368488-1-damien.lemoal@wdc.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The default IO priority is the best effort (BE) class with the
normal priority level IOPRIO_NORM (4). However, get_task_ioprio()
returns IOPRIO_CLASS_NONE/IOPRIO_NORM as the default priority and
get_current_ioprio() returns IOPRIO_CLASS_NONE/0. Let's be consistent
with the defined default and have both of these functions return the
default priority IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM) when
the user did not define another default IO priority for the task.

In include/uapi/linux/ioprio.h, introduce the IOPRIO_BE_NORM macro as
an alias to IOPRIO_NORM to clarify that this default level applies to
the BE priotity class. In include/linux/ioprio.h, define the macro
IOPRIO_DEFAULT as IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM)
and use this new macro when setting a priority to the default.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/bfq-iosched.c          | 2 +-
 block/ioprio.c               | 6 +++---
 drivers/nvme/host/lightnvm.c | 2 +-
 include/linux/ioprio.h       | 7 ++++++-
 include/uapi/linux/ioprio.h  | 5 +++--
 5 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4b434369e411..e92bc0348433 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5411,7 +5411,7 @@ static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
 	case IOPRIO_CLASS_RT:
 		return &bfqg->async_bfqq[0][ioprio];
 	case IOPRIO_CLASS_NONE:
-		ioprio = IOPRIO_NORM;
+		ioprio = IOPRIO_BE_NORM;
 		fallthrough;
 	case IOPRIO_CLASS_BE:
 		return &bfqg->async_bfqq[1][ioprio];
diff --git a/block/ioprio.c b/block/ioprio.c
index ca6b136c5586..0e4ff245f2bf 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -170,7 +170,7 @@ static int get_task_ioprio(struct task_struct *p)
 	ret = security_task_getioprio(p);
 	if (ret)
 		goto out;
-	ret = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, IOPRIO_NORM);
+	ret = IOPRIO_DEFAULT;
 	task_lock(p);
 	if (p->io_context)
 		ret = p->io_context->ioprio;
@@ -182,9 +182,9 @@ static int get_task_ioprio(struct task_struct *p)
 int ioprio_best(unsigned short aprio, unsigned short bprio)
 {
 	if (!ioprio_valid(aprio))
-		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
+		aprio = IOPRIO_DEFAULT;
 	if (!ioprio_valid(bprio))
-		bprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
+		bprio = IOPRIO_DEFAULT;
 
 	return min(aprio, bprio);
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e9d9ad47f70f..0fbbff0b3edb 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -662,7 +662,7 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
 	if (rqd->bio)
 		blk_rq_append_bio(rq, rqd->bio);
 	else
-		rq->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
+		rq->ioprio = IOPRIO_DEFAULT;
 
 	return rq;
 }
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 2ee3373684b1..3f53bc27a19b 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -8,6 +8,11 @@
 
 #include <uapi/linux/ioprio.h>
 
+/*
+ * Default IO priority.
+ */
+#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM)
+
 /*
  * Check that a priority value has a valid class.
  */
@@ -51,7 +56,7 @@ static inline int get_current_ioprio(void)
 
 	if (ioc)
 		return ioc->ioprio;
-	return IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	return IOPRIO_DEFAULT;
 }
 
 /*
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index aac39338d02c..f70f2596a6bf 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -44,8 +44,9 @@ enum {
 };
 
 /*
- * Fallback BE priority
+ * Fallback BE priority level.
  */
-#define IOPRIO_NORM	(4)
+#define IOPRIO_NORM	4
+#define IOPRIO_BE_NORM	IOPRIO_NORM
 
 #endif /* _UAPI_LINUX_IOPRIO_H */
-- 
2.31.1

