Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD967C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhKWQsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbhKWQsX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:48:23 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15BC061785
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:44:20 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id l8so22367847ilv.3
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3gfnd5JgZB58yg7qUG6FcYjJerJIuw97EDNwQOE2r1M=;
        b=iaI1JJATnSCL6bxuXu1+xJVn/rqLF86G57RM6nmmRP0Bgu+f+qdW5NKeZ/ymiXdVlf
         xVkkE0BatMSArCJbnx0nBu1F3XlO9+prg0k61PDk2ZvIos4dFd9KYy8GuKl1iEzWWW03
         YLnppoEAp3BGfPiPKQVm851QSBCcT9b3SLNxx7Cpqbtjofs5UcbukV89L6vzih+MQemH
         nlr+uupay022AsUG3bDXZYZ8JAMhENPMXbYZIxAa4uCXe1ierfYEiFeJWJVedpnjpztw
         ISU0GIEBWNJBdHdh+Hi4bWAOErk9KGa8mDoYb8YUHTBanzxm7Gk40QEG8FykhGhUwUOL
         2KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3gfnd5JgZB58yg7qUG6FcYjJerJIuw97EDNwQOE2r1M=;
        b=fRyRT1dzuOVyIlALq5wAAW0hf1WONb0dkbRF6t1KK4vlSDib+RJO9NmEvBa6OTZVUi
         0qQ/24RMI3oNT79Wig+tuugzlIoNzXNWp9qO9qi+0zTuGa1t9izWambvXQArf0iDerCr
         nf5InvFBT+EKPzw7fl85SA/PCdOG+AF3NA1yqTaYHos2nFyhj5kR1OpLCUX5gctgUjjX
         RAZQi1oMy5b/p0nUVFnaT4fm15LocTUX89MTcru8O6gmp2EoIRfI0/GdRw0tZ81sBEvh
         NrtGfGa1ITkVSZ5fW6ePFkO/cDnp95bXAQI4sJN8GvsidMS/TGk8el1CVh5lQJbAKFzy
         0gOQ==
X-Gm-Message-State: AOAM530msvXd8warAgOmuA4rKx8lvHvSXEIao7sqZC3vwbhc/eRe8KMB
        lfnXJqFmxy3oSEQPGRqNsgdlyRvA1tyy85TX
X-Google-Smtp-Source: ABdhPJz74EHZjGF/hEN8f4K9tqxXCPIDSeuyAnU1FAev0d8sOeVIpjlW/f8oy02pX/vBrhAGWODGfA==
X-Received: by 2002:a92:cad0:: with SMTP id m16mr6835340ilq.86.1637685859626;
        Tue, 23 Nov 2021 08:44:19 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f15sm7450892ila.68.2021.11.23.08.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 08:44:18 -0800 (PST)
Subject: Re: [PATCH 3/3] block: only allocate poll_stats if there's a user of
 them
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211123161813.326307-1-axboe@kernel.dk>
 <20211123161813.326307-4-axboe@kernel.dk> <YZ0ZvJMKlHOjMckv@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e1a46189-0b83-42ea-4488-4b6ccb3132e0@kernel.dk>
Date:   Tue, 23 Nov 2021 09:44:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZ0ZvJMKlHOjMckv@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 9:41 AM, Christoph Hellwig wrote:
> On Tue, Nov 23, 2021 at 09:18:13AM -0700, Jens Axboe wrote:
>> This is essentially never used, yet it's about 1/3rd of the total
>> queue size. Allocate it when needed, and don't embed it in the queue.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-mq.c         | 20 ++++++++++++++++++--
>>  block/blk-stat.c       |  6 ------
>>  block/blk-sysfs.c      |  1 +
>>  include/linux/blkdev.h |  9 +++++++--
>>  4 files changed, 26 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 20a6445f6a01..cb41c441aa8f 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4577,9 +4577,25 @@ EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
>>  /* Enable polling stats and return whether they were already enabled. */
>>  static bool blk_poll_stats_enable(struct request_queue *q)
>>  {
>> -	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
>> -	    blk_queue_flag_test_and_set(QUEUE_FLAG_POLL_STATS, q))
>> +	struct blk_rq_stat *poll_stat;
>> +
>> +	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
>>  		return true;
> 
> Can't we replace the checks for QUEUE_FLAG_POLL_STATS with checks for
> q->poll_stat now?

I think so:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index f011fa3ebcc7..af4580bdf931 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4593,7 +4593,7 @@ static bool blk_poll_stats_enable(struct request_queue *q)
 {
 	struct blk_rq_stat *poll_stat;
 
-	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
+	if (q->poll_stat)
 		return true;
 
 	poll_stat = kzalloc(BLK_MQ_POLL_STATS_BKTS * sizeof(*poll_stat),
@@ -4602,7 +4602,7 @@ static bool blk_poll_stats_enable(struct request_queue *q)
 		return false;
 
 	spin_lock_irq(&q->stats->lock);
-	if (blk_queue_flag_test_and_set(QUEUE_FLAG_POLL_STATS, q)) {
+	if (q->poll_stat) {
 		spin_unlock_irq(&q->stats->lock);
 		kfree(poll_stat);
 		return true;
@@ -4620,8 +4620,7 @@ static void blk_mq_poll_stats_start(struct request_queue *q)
 	 * We don't arm the callback if polling stats are not enabled or the
 	 * callback is already active.
 	 */
-	if (!test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
-	    blk_stat_is_active(q->poll_cb))
+	if (!q->poll_stat || blk_stat_is_active(q->poll_cb))
 		return;
 
 	blk_stat_activate_msecs(q->poll_cb, 100);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e1b846ec58cb..c079be1c58a3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -785,7 +785,7 @@ static void blk_release_queue(struct kobject *kobj)
 
 	might_sleep();
 
-	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
+	if (q->poll_stat)
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3d558cb397d5..20cf877d6627 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -414,7 +414,6 @@ struct request_queue {
 #define QUEUE_FLAG_FUA		18	/* device supports FUA writes */
 #define QUEUE_FLAG_DAX		19	/* device supports DAX */
 #define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
-#define QUEUE_FLAG_POLL_STATS	21	/* collecting stats for hybrid polling */
 #define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */

-- 
Jens Axboe

