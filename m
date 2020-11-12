Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6704CC56201
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 07:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0DF21D40
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 07:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uxt4bYm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKLHz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 02:55:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbgKLHz5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 02:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605167756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsAotUmAOeJ+J67Hd+8VkNC2AHSQC76cxUm+/CDDsK0=;
        b=Uxt4bYm+me3u7dWsxdZoXkhFS0DBOoZY3CW+QdTkytKcXpy+iygIvsReXVSBSl16Yz1g0G
        sG0K0gAZG4nesk5PvR0IRLoZnYJuA9JvDj+m9peQFUYKxnY/tYu4fDHE6XwBK2JUXwgqLm
        QRvfWOl1SSyKON0XQvOGIcF5sTo7Tm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-bJRgz6FvMfiLKET8DRTB5g-1; Thu, 12 Nov 2020 02:55:52 -0500
X-MC-Unique: bJRgz6FvMfiLKET8DRTB5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B41EB8015B1;
        Thu, 12 Nov 2020 07:55:50 +0000 (UTC)
Received: from localhost (ovpn-12-132.pek2.redhat.com [10.72.12.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E64EA55766;
        Thu, 12 Nov 2020 07:55:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvme-loop: use blk_mq_hctx_set_fq_lock_class to set loop's lock class
Date:   Thu, 12 Nov 2020 15:55:25 +0800
Message-Id: <20201112075526.947079-3-ming.lei@redhat.com>
In-Reply-To: <20201112075526.947079-1-ming.lei@redhat.com>
References: <20201112075526.947079-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set nvme-loop's lock class via blk_mq_hctx_set_fq_lock_class for avoiding
lockdep possible recursive locking, then we can remove the dynamically
allocated lock class for each flush queue, finally we can avoid horrible
SCSI probe delay.

This way may not address situation in which one nvme-loop is backed on
another nvme-loop. However, in reality, people seldom uses this way
for test. Even though someone played in this way, it is just one
recursive locking false positive, no real deadlock issue.

Reported-by: Qian Cai <cai@redhat.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/target/loop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f6d81239be21..07806016c09d 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -211,6 +211,8 @@ static int nvme_loop_init_request(struct blk_mq_tag_set *set,
 			(set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
 }
 
+static struct lock_class_key loop_hctx_fq_lock_key;
+
 static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
@@ -219,6 +221,14 @@ static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 	BUG_ON(hctx_idx >= ctrl->ctrl.queue_count);
 
+	/*
+	 * flush_end_io() can be called recursively for us, so use our own
+	 * lock class key for avoiding lockdep possible recursive locking,
+	 * then we can remove the dynamically allocated lock class for each
+	 * flush queue, that way may cause horrible boot delay.
+	 */
+	blk_mq_hctx_set_fq_lock_class(hctx, &loop_hctx_fq_lock_key);
+
 	hctx->driver_data = queue;
 	return 0;
 }
-- 
2.25.4

