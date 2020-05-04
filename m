Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8601C3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 12:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C100D20757
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 12:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hLvm3RVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgEDM5G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 08:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgEDM5F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 08:57:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63780C061A0F;
        Mon,  4 May 2020 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VaSRP0+2e/3POoOugBNHMHW6OeMcCBpID5jvzaLpt88=; b=hLvm3RVAsZCka07J41RaBivceZ
        Ov85WUkT1I6ZgYilGa+qbGPQo2cdT2LP2EmW0CzHQlfkDDVq53rs2POIVWss2ljkBj3dpE1WO9o99
        tcj1qx9FJicd4XAJbkb6z3eINy3Q38RUgh87Q33jg/23gbBJwyg6rCz+1c8NGLzZU9R3IcqWxpC0C
        Wspeg3NNyAivoTD8RlS7aw9p1TrhO8qOHTkCgLmEwQTxngSRkpeV/FNQLp5x8pBmb0Ix4Hr/ISpMH
        ytGtcRP3sufVUESDaQaAd9hwhRrgG9o9bF5TrYUSKJKeX6rovUp7OdEYS1uTzek80YRxvYpCb6eZ1
        7eqSUXAQ==;
Received: from 089144205116.atnat0014.highway.webapn.at ([89.144.205.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVaeT-0007U1-3Z; Mon, 04 May 2020 12:56:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] bdi: use bdi_dev_name() to get device name
Date:   Mon,  4 May 2020 14:47:55 +0200
Message-Id: <20200504124801.2832087-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504124801.2832087-1-hch@lst.de>
References: <20200504124801.2832087-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

Use the common interface bdi_dev_name() to get device name.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-iosched.c        | 5 +++--
 block/blk-cgroup.c         | 2 +-
 fs/ceph/debugfs.c          | 2 +-
 include/trace/events/wbt.h | 8 ++++----
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 78ba57efd16b5..4d4fe44a9eea6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4976,8 +4976,9 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
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
index 0a63c6cbbcb14..0ecc897b225c9 100644
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
index 481ac97b4d25b..dcaed75de9e6a 100644
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
index 784814160197b..9c66e59d859cb 100644
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
2.26.2

