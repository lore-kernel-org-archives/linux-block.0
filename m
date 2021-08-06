Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893EDC432BE
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 05:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB0B611CB
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 05:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbhHFFME (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 01:12:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64546 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242906AbhHFFME (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 01:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628226708; x=1659762708;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+OpAXsVDLz2Ny3LQhVu0MrzvsDmzH5eHoGx5hiUXaJY=;
  b=G48dH7ta7e/hiAQXjzdktLCTRzGEXJrvt9tR3Dnk3pSdHL9q4rTyqdXg
   mOBw3+tXntvZ5FDVHZyT8EyB6eazZTDuX8P+Jlcu/jHvfvTB7Wuvq99q6
   V4wYNZG8WbfXwWfHxFNdu9fYC69Zi+DqIHq0P09fUfb7kdtUP9d1jChyw
   2+NeZHw0YWdnWWI9V0XN3p0qnEmRZajHnBnO/6ldolrBwDD3HlNq+4MZ5
   cEkmWRSuOEquzlFYN9SVsZu1+unn7QQgId/n6v7zEycSZfAOorFlws5yp
   Mbws4ciwbzj3AXoFZhFnro7e3DZzHsKg8WZqKTNzgEDtbXt0HkiO4pLBM
   g==;
X-IronPort-AV: E=Sophos;i="5.84,299,1620662400"; 
   d="scan'208";a="176473074"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 13:11:48 +0800
IronPort-SDR: 7f2qtgAj0s0QULeQa7Ase7slneF2kiwEZPQphsNk2yBvpLOSjfgrTIwutYxc9yAcSnHERjb/6m
 qFEtO/BzR5/dwVphtql2G17x+4ESSY2qeEEj3oMa2hx+aw64RruCnAnTQ8xcb6cjigoJyAU0D6
 f4jq6AeedpO9EGQHsMqP6FMPzpw0KnRQR1hW8QYg8lLP4gFB3mdxIIS5chEWGO8mMxVTl+4GrF
 Fk++1QF56oBvksulQS/ekMXookF/DAnsaWlC4+ioEOtWsyPOuXpPgATL3HSqshFT6VdBpIU/Nx
 F0UEHl5ncpdJAVhP/Y97fLVK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 21:49:17 -0700
IronPort-SDR: 22bMgQnoxG5sp7x2hvn2K3YHCdNwflGlEcDrZfWjwLRWYcRJ4BCbuBQwZ3OLjGwvJRCNSzuyof
 7pJoyx1EKVnbN9sT6Bu6L39GDZyMI/J09olBlnSXSzOsioMx8JK7ge3ACzu1gNPPAYmrl95UZr
 crUOI786zIhDAb7zXfX22KLKHLqMOwpyAqo2zplSvPRf25hel/17/oiDuLFO2OjJHgqG99euXU
 75uBR0CG10IJB0mf8PPOTUNSZZbxBeS6GfM5/fK3q1vgowHzDmxoyHVGSGxCQ27zJyOaJoH7/W
 dq4=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Aug 2021 22:11:48 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 4/4] block: fix default IO priority handling
Date:   Fri,  6 Aug 2021 14:11:40 +0900
Message-Id: <20210806051140.301127-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806051140.301127-1-damien.lemoal@wdc.com>
References: <20210806051140.301127-1-damien.lemoal@wdc.com>
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

In include/linux/ioprio.h, rename the IOPRIO_NORM macro to
IOPRIO_BE_NORM to clarify that this default level applies to the BE
priotity class. Also, define the macro IOPRIO_DEFAULT as
IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM) and use this new
macro when setting a priority to the default.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/bfq-iosched.c          | 2 +-
 block/ioprio.c               | 6 +++---
 drivers/nvme/host/lightnvm.c | 2 +-
 include/linux/ioprio.h       | 7 ++++++-
 include/uapi/linux/ioprio.h  | 4 ++--
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d5824cab34d7..a07d630c6972 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5408,7 +5408,7 @@ static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
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
index 9b3a6d8172b4..2837c3a0d2e1 100644
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
@@ -50,7 +55,7 @@ static inline int get_current_ioprio(void)
 
 	if (ioc)
 		return ioc->ioprio;
-	return IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	return IOPRIO_DEFAULT;
 }
 
 /*
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index b9d48744dacb..ccc633af44d5 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -42,8 +42,8 @@ enum {
 };
 
 /*
- * Fallback BE priority
+ * Fallback BE priority level.
  */
-#define IOPRIO_NORM	4
+#define IOPRIO_BE_NORM	4
 
 #endif /* _UAPI_LINUX_IOPRIO_H */
-- 
2.31.1

