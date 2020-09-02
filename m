Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD499C433E7
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 12:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E59320829
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 12:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDZL5yv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIBM1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgIBM1N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Sep 2020 08:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599049632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhuWg5yaRSbWZ9+qCdO6TohhfR79PQ775qn+13Xd+ag=;
        b=JDZL5yv9RGxtNrdYP5+9ghfdzCXMI6nqjxot3eNUzMZdNKVJZho8ILoOSIQ9+VFvI/4EG6
        rEYiZiHw4LaZWizhkxU0uTcKsJs5Tlo6aUVMCQwelLWqQB8Rk/0RNfX8l128bWLZFgbKWn
        swOdSa8M3F4MkUkPHk+8hFipnRecLrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-z-lzd0VTO9SonTWpGtHcew-1; Wed, 02 Sep 2020 08:27:09 -0400
X-MC-Unique: z-lzd0VTO9SonTWpGtHcew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DF361005504;
        Wed,  2 Sep 2020 12:27:07 +0000 (UTC)
Received: from localhost (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5E1E78B3C;
        Wed,  2 Sep 2020 12:27:03 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2 2/2] block: move 'q_usage_counter' into front of 'request_queue'
Date:   Wed,  2 Sep 2020 20:26:43 +0800
Message-Id: <20200902122643.634143-3-ming.lei@redhat.com>
In-Reply-To: <20200902122643.634143-1-ming.lei@redhat.com>
References: <20200902122643.634143-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The field of 'q_usage_counter' is always fetched in fast path of every
block driver, and move it into front of 'request_queue', so it can be
fetched into 1st cacheline of 'request_queue' instance.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d0d61bc81615..7575fa0aae6e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -397,6 +397,8 @@ struct request_queue {
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
 
+	struct percpu_ref	q_usage_counter;
+
 	struct blk_queue_stats	*stats;
 	struct rq_qos		*rq_qos;
 
@@ -567,7 +569,6 @@ struct request_queue {
 	 * percpu_ref_kill() and percpu_ref_reinit().
 	 */
 	struct mutex		mq_freeze_lock;
-	struct percpu_ref	q_usage_counter;
 
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
-- 
2.25.2

