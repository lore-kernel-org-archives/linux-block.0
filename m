Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556FAC432BE
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35ECB611B0
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbhHFLTY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:19:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39963 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbhHFLTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 07:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628248742; x=1659784742;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=hDDi7vXfsrDlHCkMc281gJJnA9RDGTzvWYwvp67gk0g=;
  b=i3U1xG1WVK0qOolqT/g2gJMET2HdtHJ9v2BtFjOOa1Nipfd4vlmMlwA/
   ImkvbdIphznUDMN9zsIeoNeY115UCOTlyF7FH2y8c3wed6LqXs7xoQzri
   U3Hcfgdze3CZjfSx6E7SggSswvU58GyCKpGBzKboDs+YkED3eTuaMyXvG
   FIhw7kKFYXjesDB1NaygZ9V6anO2xp65J2TviSykABdiKw8pc2ywZWyjf
   gwfigRvLMLlosAXCOBOtjd2HolXwd1FJifjHw9y52Ez2ffs4OkWWfJdQx
   omflq7aAM24EQZiK5yyW1GOKLq5sGUb6fKD7Y2MmoPs8haOnCbikqA4yq
   g==;
X-IronPort-AV: E=Sophos;i="5.84,300,1620662400"; 
   d="scan'208";a="181309766"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 19:19:02 +0800
IronPort-SDR: 3KY3QzK+3Teiua3hJKpmaThU3UGxso2cYpsYADIZvJZrFeSNuMXh7UKtzNlXiKbb1qGJG/bWlB
 7aM9fyyXNrrRa8Yhr9M/in0qmUqgo7crHhP7sZTRXBQXDbMRGYjPLnhgfCtHgVcTY6z5R4PLNB
 vu80/7iEFY5/XhMMcCYUXhF55wx0RWDCLJZMbeCDSvnohJZrCZO8di/Ysds+n/8HkqLOMzMYbN
 snLbBg57+ok8SuMqUL//Qge/B0HVSE/+tAvcV0vHLFVj3NHAtqI2mDtmnDAA7os2xrYWhT4YuW
 KUnazDB6iGmslDqRjayV5EEA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 03:54:39 -0700
IronPort-SDR: 2K3V6hxI0acVop5thmOZuQTW7omntvz7SUcp3sKWpFCgqFHrCn3WxD73ccSiewenY1xcJues6h
 GZpUYKyl84WsBr0jfUJRKdTCkXlnjLzuetvKyHB53kP4mWIpfBt1JqY+jSIBdApNX0cr46KWdc
 wLavhIGyc/PE57WXf6mdMaXTRiPBzkoXjQiCMg88UylNYrAQ2FzYKEuN24HAdKxKSUWVnVvqA6
 e7Low8nSJ0d8x4Er3ouWkMKPsLzVTi3d4Q/wMq2FqrU6m7DLEjigNrjObvXncka8QDfTQKwK/p
 g84=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2021 04:19:03 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 3/4] block: rename IOPRIO_BE_NR
Date:   Fri,  6 Aug 2021 20:18:56 +0900
Message-Id: <20210806111857.488705-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806111857.488705-1-damien.lemoal@wdc.com>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The BFQ scheduler and ioprio_check_cap() both assume that the RT
priority class (IOPRIO_CLASS_RT) can have up to 8 different priority
levels. This is controlled using the macro IOPRIO_BE_NR, which is badly
named as the number of levels also applies to the RT class.

Rename IOPRIO_BE_NR to the class independent IOPRIO_NR_LEVELS to make
things clear.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/bfq-iosched.c         | 8 ++++----
 block/bfq-iosched.h         | 4 ++--
 block/bfq-wf2q.c            | 6 +++---
 block/ioprio.c              | 3 +--
 fs/f2fs/sysfs.c             | 2 +-
 include/uapi/linux/ioprio.h | 4 ++--
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1f38d75524ae..d5824cab34d7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2505,7 +2505,7 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 	int i, j;
 
 	for (i = 0; i < 2; i++)
-		for (j = 0; j < IOPRIO_BE_NR; j++)
+		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
 			if (bfqg->async_bfqq[i][j])
 				bfq_bfqq_end_wr(bfqg->async_bfqq[i][j]);
 	if (bfqg->async_idle_bfqq)
@@ -5290,10 +5290,10 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 		break;
 	}
 
-	if (bfqq->new_ioprio >= IOPRIO_BE_NR) {
+	if (bfqq->new_ioprio >= IOPRIO_NR_LEVELS) {
 		pr_crit("bfq_set_next_ioprio_data: new_ioprio %d\n",
 			bfqq->new_ioprio);
-		bfqq->new_ioprio = IOPRIO_BE_NR - 1;
+		bfqq->new_ioprio = IOPRIO_NR_LEVELS - 1;
 	}
 
 	bfqq->entity.new_weight = bfq_ioprio_to_weight(bfqq->new_ioprio);
@@ -6822,7 +6822,7 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 	int i, j;
 
 	for (i = 0; i < 2; i++)
-		for (j = 0; j < IOPRIO_BE_NR; j++)
+		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
 			__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j]);
 
 	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 99c2a3cb081e..385e28a843d1 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -931,7 +931,7 @@ struct bfq_group {
 
 	void *bfqd;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
 	struct bfq_queue *async_idle_bfqq;
 
 	struct bfq_entity *my_entity;
@@ -948,7 +948,7 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
 	struct bfq_queue *async_idle_bfqq;
 
 	struct rb_root rq_pos_tree;
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 7a462df71f68..b74cc0da118e 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -505,7 +505,7 @@ static void bfq_active_insert(struct bfq_service_tree *st,
  */
 unsigned short bfq_ioprio_to_weight(int ioprio)
 {
-	return (IOPRIO_BE_NR - ioprio) * BFQ_WEIGHT_CONVERSION_COEFF;
+	return (IOPRIO_NR_LEVELS - ioprio) * BFQ_WEIGHT_CONVERSION_COEFF;
 }
 
 /**
@@ -514,12 +514,12 @@ unsigned short bfq_ioprio_to_weight(int ioprio)
  *
  * To preserve as much as possible the old only-ioprio user interface,
  * 0 is used as an escape ioprio value for weights (numerically) equal or
- * larger than IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF.
+ * larger than IOPRIO_NR_LEVELS * BFQ_WEIGHT_CONVERSION_COEFF.
  */
 static unsigned short bfq_weight_to_ioprio(int weight)
 {
 	return max_t(int, 0,
-		     IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight);
+		     IOPRIO_NR_LEVELS * BFQ_WEIGHT_CONVERSION_COEFF - weight);
 }
 
 static void bfq_get_entity(struct bfq_entity *entity)
diff --git a/block/ioprio.c b/block/ioprio.c
index bee628f9f1b2..ca6b136c5586 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -74,9 +74,8 @@ int ioprio_check_cap(int ioprio)
 			fallthrough;
 			/* rt has prio field too */
 		case IOPRIO_CLASS_BE:
-			if (data >= IOPRIO_BE_NR || data < 0)
+			if (data >= IOPRIO_NR_LEVELS || data < 0)
 				return -EINVAL;
-
 			break;
 		case IOPRIO_CLASS_IDLE:
 			break;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 6642246206bd..daad532a4e2b 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -378,7 +378,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		ret = kstrtol(name, 10, &data);
 		if (ret)
 			return ret;
-		if (data >= IOPRIO_BE_NR || data < 0)
+		if (data >= IOPRIO_NR_LEVELS || data < 0)
 			return -EINVAL;
 
 		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, data);
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index abc40965aa96..99d37d4807b8 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -31,9 +31,9 @@ enum {
 };
 
 /*
- * 8 best effort priority levels are supported
+ * The RT and BE priority classes both support up to 8 priority levels.
  */
-#define IOPRIO_BE_NR	8
+#define IOPRIO_NR_LEVELS	8
 
 enum {
 	IOPRIO_WHO_PROCESS = 1,
-- 
2.31.1

