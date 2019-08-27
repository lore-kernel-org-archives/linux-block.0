Return-Path: <SRS0=A22s=WX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEEDC3A5A3
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 11:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD2620656
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 11:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfH0LCO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:02:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfH0LCO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 07:02:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14D92307D915;
        Tue, 27 Aug 2019 11:02:14 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AC155D6B0;
        Tue, 27 Aug 2019 11:02:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH V4 2/5] block: don't hold q->sysfs_lock in elevator_init_mq
Date:   Tue, 27 Aug 2019 19:01:45 +0800
Message-Id: <20190827110148.808-3-ming.lei@redhat.com>
In-Reply-To: <20190827110148.808-1-ming.lei@redhat.com>
References: <20190827110148.808-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 27 Aug 2019 11:02:14 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The original comment says:

	q->sysfs_lock must be held to provide mutual exclusion between
	elevator_switch() and here.

Which is simply wrong. elevator_init_mq() is only called from
blk_mq_init_allocated_queue, which is always called before the request
queue is registered via blk_register_queue(), for dm-rq or normal rq
based driver. However, queue's kobject is only exposed and added to sysfs
in blk_register_queue(). So there isn't such race between elevator_switch()
and elevator_init_mq().

So avoid to hold q->sysfs_lock in elevator_init_mq().

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 2f17d66d0e61..33c15fb54ed1 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -607,23 +607,19 @@ int elevator_init_mq(struct request_queue *q)
 	if (q->nr_hw_queues != 1)
 		return 0;
 
-	/*
-	 * q->sysfs_lock must be held to provide mutual exclusion between
-	 * elevator_switch() and here.
-	 */
-	mutex_lock(&q->sysfs_lock);
+	WARN_ON_ONCE(test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags));
+
 	if (unlikely(q->elevator))
-		goto out_unlock;
+		goto out;
 
 	e = elevator_get(q, "mq-deadline", false);
 	if (!e)
-		goto out_unlock;
+		goto out;
 
 	err = blk_mq_init_sched(q, e);
 	if (err)
 		elevator_put(e);
-out_unlock:
-	mutex_unlock(&q->sysfs_lock);
+out:
 	return err;
 }
 
-- 
2.20.1

