Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B70C433DB
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BC665094
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhCPDTa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Mar 2021 23:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233371AbhCPDTU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Mar 2021 23:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615864759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjaGyaqA/Zc0rF6PsrYol9YHFVkAp/HbPbJkCZlDhpw=;
        b=Wp4wuLsOn//8+j8A58zQ0oKfsw7i7yvgTdggTUy20t51OeNuNg6MDaYunH0PoqUVDpZMyw
        uW+XVo03oqL2E6ttO32oZJGP8GuHiX1plJwNWNFDP47hT4+kuTCrRL16q3RUsVz/3wdRy0
        inYVdD/fSK+AOntyO2nmcHvnHuV/Xkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-odpdhO4xM0uZ-mY2_NzR7A-1; Mon, 15 Mar 2021 23:19:17 -0400
X-MC-Unique: odpdhO4xM0uZ-mY2_NzR7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7420100C61F;
        Tue, 16 Mar 2021 03:19:15 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB54860C0F;
        Tue, 16 Mar 2021 03:19:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: [RFC PATCH 10/11] block: add poll_capable method to support bio-based IO polling
Date:   Tue, 16 Mar 2021 11:15:22 +0800
Message-Id: <20210316031523.864506-11-ming.lei@redhat.com>
In-Reply-To: <20210316031523.864506-1-ming.lei@redhat.com>
References: <20210316031523.864506-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jeffle Xu <jefflexu@linux.alibaba.com>

This method can be used to check if bio-based device supports IO polling
or not. For mq devices, checking for hw queue in polling mode is
adequate, while the sanity check shall be implementation specific for
bio-based devices. For example, dm device needs to check if all
underlying devices are capable of IO polling.

Though bio-based device may have done the sanity check during the
device initialization phase, cacheing the result of this sanity check
(such as by cacheing in the queue_flags) may not work. Because for dm
devices, users could change the state of the underlying devices through
'/sys/block/<dev>/io_poll', bypassing the dm device above. In this case,
the cached result of the very beginning sanity check could be
out-of-date. Thus the sanity check needs to be done every time 'io_poll'
is to be modified.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 block/blk-sysfs.c      | 14 +++++++++++---
 include/linux/blkdev.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0f4f0c8a7825..367c1d9a55c6 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -426,9 +426,17 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	unsigned long poll_on;
 	ssize_t ret;
 
-	if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
-	    !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
-		return -EINVAL;
+	if (queue_is_mq(q)) {
+		if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
+		    !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
+			return -EINVAL;
+	} else {
+		struct gendisk *disk = queue_to_disk(q);
+
+		if (!disk->fops->poll_capable ||
+		    !disk->fops->poll_capable(disk))
+			return -EINVAL;
+	}
 
 	ret = queue_var_store(&poll_on, page, count);
 	if (ret < 0)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bfab74b45f15..a46f975f2a2f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1881,6 +1881,7 @@ struct block_device_operations {
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
+	bool (*poll_capable)(struct gendisk *disk);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 };
-- 
2.29.2

