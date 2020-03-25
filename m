Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFE9C54FD0
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 12:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8207B2080C
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 12:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCYMkN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:40:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727280AbgCYMkM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 08:40:12 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 83AF2CCC9D1FB7B3DC50;
        Wed, 25 Mar 2020 20:40:09 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Mar 2020
 20:40:07 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>, <hch@infradead.org>
Subject: [PATCH v4 3/6] bfq: fix potential kernel crash when print error info
Date:   Wed, 25 Mar 2020 20:38:40 +0800
Message-ID: <20200325123843.47452-4-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200325123843.47452-1-yuyufen@huawei.com>
References: <20200325123843.47452-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace bdi_dev_name() with bdi_get_dev_name(). Then, we can fix
potential use-after-free or NULL pointer reference for bdi->dev
when bdi unregister.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/bfq-iosched.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 94261b7d7181..a8a67a95006e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4971,6 +4971,7 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	struct task_struct *tsk = current;
 	int ioprio_class;
 	struct bfq_data *bfqd = bfqq->bfqd;
+	char dname[BDI_DEV_NAME_LEN];
 
 	if (!bfqd)
 		return;
@@ -4978,9 +4979,9 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
 	switch (ioprio_class) {
 	default:
-		pr_err("bdi %s: bfq: bad prio class %d\n",
-				bdi_dev_name(bfqq->bfqd->queue->backing_dev_info),
-				ioprio_class);
+		bdi_get_dev_name(bfqq->bfqd->queue->backing_dev_info, dname,
+				BDI_DEV_NAME_LEN);
+		pr_err("bdi %s: bfq: bad prio class %d\n", dname, ioprio_class);
 		/* fall through */
 	case IOPRIO_CLASS_NONE:
 		/*
-- 
2.17.2

