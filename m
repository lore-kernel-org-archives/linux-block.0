Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84199C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 09:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575A72339F
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 09:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHUJP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:15:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45355 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbfHUJP3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 05:15:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69F821801580;
        Wed, 21 Aug 2019 09:15:29 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29A455D9E1;
        Wed, 21 Aug 2019 09:15:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2 2/6] block: don't hold q->sysfs_lock in elevator_init_mq
Date:   Wed, 21 Aug 2019 17:15:02 +0800
Message-Id: <20190821091506.21196-3-ming.lei@redhat.com>
In-Reply-To: <20190821091506.21196-1-ming.lei@redhat.com>
References: <20190821091506.21196-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Wed, 21 Aug 2019 09:15:29 +0000 (UTC)
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
based driver. However, queue's kobject is just exposed added to sysfs
in blk_register_queue(). So there isn't such race between elevator_switch()
and elevator_init_mq().

So avoid to hold q->sysfs_lock in elevator_init_mq().

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 2f17d66d0e61..37b918dc4676 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -608,22 +608,22 @@ int elevator_init_mq(struct request_queue *q)
 		return 0;
 
 	/*
-	 * q->sysfs_lock must be held to provide mutual exclusion between
-	 * elevator_switch() and here.
+	 * We are called from blk_mq_init_allocated_queue() only, at that
+	 * time the request queue isn't registered yet, so the queue
+	 * kobject isn't exposed to userspace. No need to worry about race
+	 * with elevator_switch(), and no need to hold q->sysfs_lock.
 	 */
-	mutex_lock(&q->sysfs_lock);
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

