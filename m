Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A73C433B4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 02:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FBB6141C
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 02:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhDWCjE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 22:39:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230367AbhDWCjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 22:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619145508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2B7PS9Z9jmK4oM7oJlfU1Y4jVCmagutMUGxxnVW+Td8=;
        b=R0iX+LSAuCVeQZX9zW2Z0TFFiyAtfMHhkcHbuF9djYgytHNMyLh+W8Qz2egz9giUCXSXE3
        IYiEOlE7fLalj/hpS463cjb3tn66jGDYjnDnEARfYA4S3sr8ONWenV7melfzrH+3Q8binH
        jx+H/DoN1pmUdYMrj5PGlO5RW/Z/6hU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-IFWWALKcPfiXHj2olnQNNA-1; Thu, 22 Apr 2021 22:38:24 -0400
X-MC-Unique: IFWWALKcPfiXHj2olnQNNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B51F7343A9;
        Fri, 23 Apr 2021 02:38:23 +0000 (UTC)
Received: from T590 (ovpn-13-78.pek2.redhat.com [10.72.13.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 969F960939;
        Fri, 23 Apr 2021 02:38:09 +0000 (UTC)
Date:   Fri, 23 Apr 2021 10:38:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V7 12/12] dm: support IO polling for bio-based dm device
Message-ID: <YIIzEmUV5GB5I13N@T590>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
 <20210422122038.2192933-13-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422122038.2192933-13-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From 98a73d99c3c663a3cfaadfec2825d6d88289a102 Mon Sep 17 00:00:00 2001
From: Jeffle Xu <jefflexu@linux.alibaba.com>
Date: Mon, 8 Feb 2021 16:52:41 +0800
Subject: [PATCH V7 12/12] dm: support IO polling for bio-based dm device

IO polling is enabled when all underlying target devices are capable
of IO polling. The sanity check supports the stacked device model, in
which one dm device may be build upon another dm device. In this case,
the mapped device will check if the underlying dm target device
supports IO polling.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V7:
	- don't export dm_table_supports_poll, as suggested by Jeffle

 drivers/md/dm-table.c | 24 ++++++++++++++++++++++++
 drivers/md/dm.c       |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 95391f78b8d5..0b3e34cbe241 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1509,6 +1509,12 @@ struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector)
 	return &t->targets[(KEYS_PER_NODE * n) + k];
 }
 
+static int device_not_poll_capable(struct dm_target *ti, struct dm_dev *dev,
+				   sector_t start, sector_t len, void *data)
+{
+	return !blk_queue_poll(bdev_get_queue(dev->bdev));
+}
+
 /*
  * type->iterate_devices() should be called when the sanity check needs to
  * iterate and check all underlying data devices. iterate_devices() will
@@ -1559,6 +1565,11 @@ static int count_device(struct dm_target *ti, struct dm_dev *dev,
 	return 0;
 }
 
+static int dm_table_supports_poll(struct dm_table *t)
+{
+	return !dm_table_any_dev_attr(t, device_not_poll_capable, NULL);
+}
+
 /*
  * Check whether a table has no data devices attached using each
  * target's iterate_devices method.
@@ -2079,6 +2090,19 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 
 	dm_update_keyslot_manager(q, t);
 	blk_queue_update_readahead(q);
+
+	/*
+	 * Check for request-based device is remained to
+	 * dm_mq_init_request_queue()->blk_mq_init_allocated_queue().
+	 * For bio-based device, only set QUEUE_FLAG_POLL when all underlying
+	 * devices supporting polling.
+	 */
+	if (__table_type_bio_based(t->type)) {
+		if (dm_table_supports_poll(t))
+			blk_queue_flag_set(QUEUE_FLAG_POLL, q);
+		else
+			blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
+	}
 }
 
 unsigned int dm_table_get_num_targets(struct dm_table *t)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 50b693d776d6..1b160e4e6446 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2175,6 +2175,8 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 		}
 		break;
 	case DM_TYPE_BIO_BASED:
+		/* tell block layer we are capable of bio polling */
+		md->disk->flags |= GENHD_FL_CAP_BIO_POLL;
 	case DM_TYPE_DAX_BIO_BASED:
 		break;
 	case DM_TYPE_NONE:
-- 
2.29.2

