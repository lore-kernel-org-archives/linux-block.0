Return-Path: <SRS0=sRwj=WW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53042C3A5A1
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 02:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D952173E
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 02:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfHZCwH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Aug 2019 22:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbfHZCwH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Aug 2019 22:52:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DAB95AFE3;
        Mon, 26 Aug 2019 02:52:07 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FDE15C28C;
        Mon, 26 Aug 2019 02:52:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH V3 2/5] block: don't hold q->sysfs_lock in elevator_init_mq
Date:   Mon, 26 Aug 2019 10:51:43 +0800
Message-Id: <20190826025146.31158-3-ming.lei@redhat.com>
In-Reply-To: <20190826025146.31158-1-ming.lei@redhat.com>
References: <20190826025146.31158-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 26 Aug 2019 02:52:07 +0000 (UTC)
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

