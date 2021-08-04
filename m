Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6AEC4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 02:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93B661029
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 02:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhHDCoT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 22:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhHDCoT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Aug 2021 22:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628045046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bgYEfKHml5l3JmIqsBfQ2Zvdb8bUlQBtsbXqWhAYYsk=;
        b=hVyNvxkNnd06ZUY9oK9ERL4jj1indLEbmFogXaw2X9OoZJfeB/euGtFwtrXRoHustL6tj5
        Cbp+38MhPFH8MSqW1GmPNGiM7h3rbZm8IAo8fn7vrefc1W9hBCuU/CoMBtzd2uRXucB1Ad
        P1lG/NjBvOxHcn3J08NXy8PyvaYlgko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-J14zPQyKPfiN8hZASCv-3A-1; Tue, 03 Aug 2021 22:39:27 -0400
X-MC-Unique: J14zPQyKPfiN8hZASCv-3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F375A1074661;
        Wed,  4 Aug 2021 02:39:25 +0000 (UTC)
Received: from T590 (ovpn-13-3.pek2.redhat.com [10.72.13.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2209660C05;
        Wed,  4 Aug 2021 02:39:16 +0000 (UTC)
Date:   Wed, 4 Aug 2021 10:39:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v2 2/3] loop: Select I/O scheduler 'none' from inside
 add_disk()
Message-ID: <YQn924DHk4axOUso@T590>
References: <20210803182304.365053-1-bvanassche@acm.org>
 <20210803182304.365053-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803182304.365053-3-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 03, 2021 at 11:23:03AM -0700, Bart Van Assche wrote:
> We noticed that the user interface of Android devices becomes very slow
> under memory pressure. This is because Android uses the zram driver on top
> of the loop driver for swapping, because under memory pressure the swap
> code alternates reads and writes quickly, because mq-deadline is the
> default scheduler for loop devices and because mq-deadline delays writes by

Maybe we can bypass io scheduler always for request with REQ_SWAP, such as:

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 0f006cabfd91..d86709ac9d1f 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -420,7 +420,8 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
 	 * passthrough request is added to scheduler queue, there isn't any
 	 * chance to dispatch it given we prioritize requests in hctx->dispatch.
 	 */
-	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
+	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq) ||
+			blk_rq_is_swap(rq))
 		return true;
 
 	return false;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d3afea47ade6..71aaa99614ab 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -251,6 +251,11 @@ static inline bool blk_rq_is_passthrough(struct request *rq)
 	return blk_op_is_passthrough(req_op(rq));
 }
 
+static inline bool blk_rq_is_swap(struct request *rq)
+{
+	return rq->cmd_flags & REQ_SWAP;
+}
+
 static inline unsigned short req_get_ioprio(struct request *req)
 {
 	return req->ioprio;


Thanks, 
Ming

