Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB931C4332B
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 13:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29EF2072D
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 13:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgCWNrH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:47:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728355AbgCWNrH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 09:47:07 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A971EAEC47796DD83D5C;
        Mon, 23 Mar 2020 21:25:32 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 23 Mar 2020
 21:25:28 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>
Subject: [PATCH v3 1/4] bdi: use bdi_dev_name() to get device name
Date:   Mon, 23 Mar 2020 21:22:51 +0800
Message-ID: <20200323132254.47157-2-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200323132254.47157-1-yuyufen@huawei.com>
References: <20200323132254.47157-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the common interface bdi_dev_name() to get device name.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/bfq-iosched.c        | 5 +++--
 block/blk-cgroup.c         | 2 +-
 fs/ceph/debugfs.c          | 2 +-
 include/trace/events/wbt.h | 8 ++++----
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8c436abfaf14..94261b7d7181 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4978,8 +4978,9 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
 	switch (ioprio_class) {
 	default:
-		dev_err(bfqq->bfqd->queue->backing_dev_info->dev,
-			"bfq: bad prio class %d\n", ioprio_class);
+		pr_err("bdi %s: bfq: bad prio class %d\n",
+				bdi_dev_name(bfqq->bfqd->queue->backing_dev_info),
+				ioprio_class);
 		/* fall through */
 	case IOPRIO_CLASS_NONE:
 		/*
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a229b94d5390..be92405c6547 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -496,7 +496,7 @@ const char *blkg_dev_name(struct blkcg_gq *blkg)
 {
 	/* some drivers (floppy) instantiate a queue w/o disk registered */
 	if (blkg->q->backing_dev_info->dev)
-		return dev_name(blkg->q->backing_dev_info->dev);
+		return bdi_dev_name(blkg->q->backing_dev_info);
 	return NULL;
 }
 
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index fb7cabd98e7b..1f8f3b631adb 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -271,7 +271,7 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 				    &congestion_kb_fops);
 
 	snprintf(name, sizeof(name), "../../bdi/%s",
-		 dev_name(fsc->sb->s_bdi->dev));
+		 bdi_dev_name(fsc->sb->s_bdi));
 	fsc->debugfs_bdi =
 		debugfs_create_symlink("bdi",
 				       fsc->client->debugfs_dir,
diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index 37342a13c9cb..9996420d7ec4 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -33,7 +33,7 @@ TRACE_EVENT(wbt_stat,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, dev_name(bdi->dev),
+		strlcpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->rmean		= stat[0].mean;
 		__entry->rmin		= stat[0].min;
@@ -68,7 +68,7 @@ TRACE_EVENT(wbt_lat,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, dev_name(bdi->dev),
+		strlcpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->lat = div_u64(lat, 1000);
 	),
@@ -105,7 +105,7 @@ TRACE_EVENT(wbt_step,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, dev_name(bdi->dev),
+		strlcpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->msg	= msg;
 		__entry->step	= step;
@@ -141,7 +141,7 @@ TRACE_EVENT(wbt_timer,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, dev_name(bdi->dev),
+		strlcpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->status		= status;
 		__entry->step		= step;
-- 
2.17.2

