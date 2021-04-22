Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D94C433B4
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 12:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4443F6142F
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 12:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbhDVMXh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235795AbhDVMXh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 08:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619094182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bP22PF44dyrWJ/kkVc0qKvDS0NCMTD26lj+tKt6n6Rk=;
        b=NFtFNzUXd30hireH3nQ1QZkniK676/R5hHX5Qlnte+TilGu2jxe1tH6xM3r7e9LN/8oeia
        Sin7cgCOW+NQcdM7T4KHGMOCf4Ysei9LkHz8KvHsA4Y/Y3EqVzyKKICMBdjmqeMIHNarZz
        dfsSwEKKZ+bF/KQMkZv7+knP0GvFuXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-B3tnp8xuPymUbbI1jFektg-1; Thu, 22 Apr 2021 08:23:01 -0400
X-MC-Unique: B3tnp8xuPymUbbI1jFektg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B783410C40CB;
        Thu, 22 Apr 2021 12:22:59 +0000 (UTC)
Received: from localhost (ovpn-13-243.pek2.redhat.com [10.72.13.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF8965C1D5;
        Thu, 22 Apr 2021 12:22:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 11/12] block: allow to control FLAG_POLL via sysfs for bio poll capable queue
Date:   Thu, 22 Apr 2021 20:20:37 +0800
Message-Id: <20210422122038.2192933-12-ming.lei@redhat.com>
In-Reply-To: <20210422122038.2192933-1-ming.lei@redhat.com>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for supporting bio based io polling. If one disk is capable of
bio polling, we allow user to control FLAG_POLL via sysfs.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c     | 14 ++++++++++++--
 include/linux/genhd.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fed4981b1f7a..3620db390658 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -430,9 +430,14 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 {
 	unsigned long poll_on;
 	ssize_t ret;
+	struct gendisk *disk = queue_to_disk(q);
 
-	if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
-	    !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
+	if (!queue_is_mq(q) && !(disk->flags & GENHD_FL_CAP_BIO_POLL))
+		return -EINVAL;
+
+	if (queue_is_mq(q) && (!q->tag_set ||
+	    q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
+	    !q->tag_set->map[HCTX_TYPE_POLL].nr_queues))
 		return -EINVAL;
 
 	ret = queue_var_store(&poll_on, page, count);
@@ -442,6 +447,11 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	if (poll_on) {
 		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
 	} else {
+		/*
+		 * For bio queue, it is safe to just freeze bio submission
+		 * activity because we don't read FLAG_POLL after bio is
+		 * submitted.
+		 */
 		blk_mq_freeze_queue(q);
 		blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
 		blk_mq_unfreeze_queue(q);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 7e9660ea967d..e5ae77cba853 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -104,6 +104,8 @@ struct partition_meta_info {
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
+/* only valid for bio based disk */
+#define GENHD_FL_CAP_BIO_POLL			0x0800
 
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
-- 
2.29.2

