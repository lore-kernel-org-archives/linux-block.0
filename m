Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F706C4320E
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5902860F22
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhHKDhu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 23:37:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34665 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbhHKDhe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 23:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628653031; x=1660189031;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+YKFJGf1DXtdTGWfV/bu2IJ+KfNBXvFKm3zTlEpFKjU=;
  b=m1KQcYh/c8Fna1t8Lzuda09QAwg4bnaM9bWXwpeU7PXOKsUx5qqc4Bru
   UkC9IKCnQgjeCpWMpQpGvb7fc8usYIrJ7May+Jr6l6IO6jCEg8LvXFMdZ
   UWDVdnBuSEuvuveVjlIVTInI5QXihGc8T+GpM+Ho3ZK3cdxYpbaG5xqxp
   gNmk/rbtu/8JrTHn6yYKF8lYMCAriJ/u/CVNQ+cnjWY/NwgVJm0+HL/M2
   WffMZgPmjdHk4TdHF9nzj+g3KyhJ7FQYa7Og9/VYzYgAfJPrC1VqDpUSS
   Wmkhv8as4BG9a0qUcUG87d7uFdqBA+PEAHX2eututNGX8No+iKBPmhq3R
   A==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="177454818"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 11:37:11 +0800
IronPort-SDR: pwBmJ12pFdJQUuebDPiIRv/5H2fGQSQslHTrOpfS0/wWPvBtXBno1f6azhseORm4fMKZZxnJkc
 nUb9NA0U/rgf1IZ+uDnaZMDWwBlYmUd9VN3Y05vVrLvfrxlinpkeQh7yRAfQEqNs7dVrPrwaVv
 0Q0EtqG6FjO3ftgl1NXqErbpspT1BkSbvdCZ1SCf9DAIF5xWS9ey+UAeWIYz6RECqVzvWZhhk7
 UtpPKWWYHgTwzPY3hsTpjum9Sj+rwHPmajUpATYVm5wr6hlDn9qd+cUv3YvWvfvDVmWhfNY6VH
 NJ/QRW5VaoRX7yTSDXpTEl5R
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 20:14:31 -0700
IronPort-SDR: xNep8P0pzuh2eZT9WzcRvVAjSIspnFg1trw1UROtsdqh7v5PrbS+mSpP745Hl9b4WfPVtlOf1A
 kWtPfZHmO2iRVKMUMTPJ7BIiS1rR6tdxVaUAx0LiKeHRPaQbuxBj0aIa1O4+IS5knSWeLDHKwO
 GzYc3Kb+dvqicIs3Nnj0+6Oly/WiCKL6BsCva9pCbCOrA6ivGxp05d71oaz9rNOXDSE39/dPdy
 LV11YjlEMk4Bn2h+IvvY4QFIn7GYBe7XkEhEgt6ssT7iZF4Q/u0gl0w/mpnOO1bckq/32EbdwQ
 1ZA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2021 20:37:10 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4 5/6] block: Introduce IOPRIO_NR_LEVELS
Date:   Wed, 11 Aug 2021 12:37:01 +0900
Message-Id: <20210811033702.368488-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811033702.368488-1-damien.lemoal@wdc.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The BFQ scheduler and ioprio_check_cap() both assume that the RT
priority class (IOPRIO_CLASS_RT) can have up to 8 different priority
levels, similarly to the BE class (IOPRIO_CLASS_iBE). This is
controlled using the IOPRIO_BE_NR macro , which is badly named as the
number of levels also applies to the RT class.

Introduce the class independent IOPRIO_NR_LEVELS macro, defined to 8,
to make things clear. Keep the old IOPRIO_BE_NR macro definition as an
alias for IOPRIO_NR_LEVELS.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/bfq-iosched.c         | 8 ++++----
 block/bfq-iosched.h         | 4 ++--
 block/bfq-wf2q.c            | 6 +++---
 block/ioprio.c              | 3 +--
 fs/f2fs/sysfs.c             | 2 +-
 include/uapi/linux/ioprio.h | 5 +++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e546a5f4bff9..4b434369e411 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2508,7 +2508,7 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 	int i, j;
 
 	for (i = 0; i < 2; i++)
-		for (j = 0; j < IOPRIO_BE_NR; j++)
+		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
 			if (bfqg->async_bfqq[i][j])
 				bfq_bfqq_end_wr(bfqg->async_bfqq[i][j]);
 	if (bfqg->async_idle_bfqq)
@@ -5293,10 +5293,10 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
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
@@ -6825,7 +6825,7 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
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
index 936f0d8f30e1..aac39338d02c 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -32,9 +32,10 @@ enum {
 };
 
 /*
- * 8 best effort priority levels are supported
+ * The RT and BE priority classes both support up to 8 priority levels.
  */
-#define IOPRIO_BE_NR	(8)
+#define IOPRIO_NR_LEVELS	8
+#define IOPRIO_BE_NR		IOPRIO_NR_LEVELS
 
 enum {
 	IOPRIO_WHO_PROCESS = 1,
-- 
2.31.1

