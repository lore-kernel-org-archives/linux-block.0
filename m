Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D68C4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 09:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D938761050
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 09:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhHBJWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:22:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2573 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhHBJWK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 05:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627896121; x=1659432121;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=eaHgdGMoAMKvAu0DYAhOf7vCPoF7H0Ce7MiwFwY91mU=;
  b=B9sK05/AtBo1QMfkzVNnEtbgRs39pGKOdr9yWOHblj8HcDu52ixG2Ffe
   0pxDOpkOazkBEO89FtWCNyvVG+yvl1GZHDyMDGSXpvuYGljj7wsYulrFu
   /YiqSv3XI+gDPGd9cnDiYFUfbUqn3LWI0vMpTRHGra1KKT/ZgyajCu3Nm
   thkUWmpS4RtW6jTsrh0oa1Li3UK0JHZGfXSyCRenJi/w3DkVKOLV//dQN
   DkUrrV4w2wFZ2aFqQQoYRq/m23eY/34ty3EqArxGOOJrzuAwNTESAlRDn
   QGeIxkpZSJOr4i0sBpG81em0oIUiGDN8vtQQG6r/RxcivPWnw4JsyNDo/
   A==;
X-IronPort-AV: E=Sophos;i="5.84,288,1620662400"; 
   d="scan'208";a="175287155"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2021 17:22:01 +0800
IronPort-SDR: /HqXZwhpVRUnfXStoforlY67qVUSwE08yT8BS6pBTHkQ9Vi7FDrmOnHSXD81Vd09EmrKRPElSp
 tNnv2tZ01WM9kPvMatRiBIYMhNM98sn6xoe1eEcFHpDe+bpPvL+aGDntCFlXvZU7SOV64Hto7Y
 As/QWH8Iw4HnPabeT57W1JdsRcSefX38DEXR2JkKkEe//+RtWt9cru+6+FTW50RO8QKpzCeeZU
 HmgFm9tsvECq8xmtWbwysGvqjEnlK1sRPAipvmvayR0Zf8tHaErxSBTY8kRxUAbNKDYctvmgy9
 4uSI0QVOWgAknNdtzlnYy7we
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 01:57:42 -0700
IronPort-SDR: ZwQ0axXi6WMK/JBPqhkY6A8+RqjFJUJwlH5vurWcUIgRGq2ZKNyb5D5Z1WPn5hP3H5q3IhqpvD
 DYaKX5F3/Zage9y247jpxk7lQn2KKRVv7VvbxtlPcYM9KnwYTFWpemgO/X2iJouiwVV8wVdJuL
 V0o66/YyFVLI+6df7RGGHneBIBChrZp6DMGUQ6hm3asmkBZeAJlr5pi4g748mOtL5/5/UhO6BX
 3vNDrJTdQpYKzpmi6M6vtvYVFmFZlf3ntoQ0p9Xsx1Vo6snQy6YFr5jldppq1VyV70rWOzCYPx
 rXw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Aug 2021 02:22:00 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 3/3] block: rename IOPRIO_BE_NR
Date:   Mon,  2 Aug 2021 18:21:57 +0900
Message-Id: <20210802092157.1260445-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210802092157.1260445-1-damien.lemoal@wdc.com>
References: <20210802092157.1260445-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The BFQ scheduler and ioprio_check_cap() both assume that the RT
priority class (IOPRIO_CLASS_RT) can have up to 8 different priority
levels. This is controlled using the macro IOPRIO_BE_NR, which is badly
named as the number of levels applies to the RT class too.

Rename IOPRIO_BE_NR to IOPRIO_NR_LEVELS to make things clear.

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
index 27dc7fb0ba12..fe47b58c4274 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -37,9 +37,9 @@ static inline bool ioprio_valid(unsigned short ioprio)
 }
 
 /*
- * 8 best effort priority levels are supported
+ * The RT an BE priority classes support up to 8 priority levels.
  */
-#define IOPRIO_BE_NR	(8)
+#define IOPRIO_NR_LEVELS	(8)
 
 enum {
 	IOPRIO_WHO_PROCESS = 1,
-- 
2.31.1

