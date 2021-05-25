Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F4C47085
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A646135F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhEYIJh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 04:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232030AbhEYIJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 04:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621930051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfbH5K2Li7C6JOcU0ZHr9pnyMBOIBWyuDHESoquF3rc=;
        b=cF+S/tgZbWm+L2QpsSn06zD10UkFDvVOxUyygPWBwCce3zt3JrfLgjYarssz4czjtKmcX7
        d/Scv2s/vpfvBovoit5MQ34WzdwY0hzbbWgGkuxkX2ogFRNYXjt0rNUpFtjUupvrFPF0nl
        G51h/DHj9K1PFWObc17g0IaxoXEtQXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-rfH4WQqdOfGTUe-rv6GEwA-1; Tue, 25 May 2021 04:05:25 -0400
X-MC-Unique: rfH4WQqdOfGTUe-rv6GEwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06CCC107ACE8;
        Tue, 25 May 2021 08:05:24 +0000 (UTC)
Received: from localhost (ovpn-13-203.pek2.redhat.com [10.72.13.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 151856E53E;
        Tue, 25 May 2021 08:05:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 4/4] block: mark queue init done at the end of blk_register_queue
Date:   Tue, 25 May 2021 16:04:42 +0800
Message-Id: <20210525080442.1896417-5-ming.lei@redhat.com>
In-Reply-To: <20210525080442.1896417-1-ming.lei@redhat.com>
References: <20210525080442.1896417-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mark queue init done when everything is done well in blk_register_queue(),
so that wbt_enable_default() can be run quickly without any RCU period
involved.

Also no any side effect by delaying to mark queue init done.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 925043f926c5..aef7bfd8e600 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -847,20 +847,6 @@ int blk_register_queue(struct gendisk *disk)
 		  "%s is registering an already registered queue\n",
 		  kobject_name(&dev->kobj));
 
-	/*
-	 * SCSI probing may synchronously create and destroy a lot of
-	 * request_queues for non-existent devices.  Shutting down a fully
-	 * functional queue takes measureable wallclock time as RCU grace
-	 * periods are involved.  To avoid excessive latency in these
-	 * cases, a request_queue starts out in a degraded mode which is
-	 * faster to shut down and is made fully functional here as
-	 * request_queues for non-existent devices never get registered.
-	 */
-	if (!blk_queue_init_done(q)) {
-		blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
-		percpu_ref_switch_to_percpu(&q->q_usage_counter);
-	}
-
 	blk_queue_update_readahead(q);
 
 	ret = blk_trace_init_sysfs(dev);
@@ -920,6 +906,21 @@ int blk_register_queue(struct gendisk *disk)
 	ret = 0;
 unlock:
 	mutex_unlock(&q->sysfs_dir_lock);
+
+	/*
+	 * SCSI probing may synchronously create and destroy a lot of
+	 * request_queues for non-existent devices.  Shutting down a fully
+	 * functional queue takes measureable wallclock time as RCU grace
+	 * periods are involved.  To avoid excessive latency in these
+	 * cases, a request_queue starts out in a degraded mode which is
+	 * faster to shut down and is made fully functional here as
+	 * request_queues for non-existent devices never get registered.
+	 */
+	if (!blk_queue_init_done(q)) {
+		blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
+		percpu_ref_switch_to_percpu(&q->q_usage_counter);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_register_queue);
-- 
2.29.2

