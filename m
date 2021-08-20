Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C073EC4320A
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF1C61165
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 18:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhHTSFO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 14:05:14 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:34597 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbhHTSFM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 14:05:12 -0400
Received: by mail-pg1-f176.google.com with SMTP id x4so9940092pgh.1
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 11:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KRTEMX6lTbJ77UXm0fEfpoMQnoluwg08AXz5zK4smD4=;
        b=p3f4jUHulCGBVhSWJ6+Yd2PR0bVZ8/zvVoJe/JhmMha2M4Vk9PK8pURrNbHTD+XNPk
         m1ejJaVm4CrRcDRkUEAUrBXoyYoJFvWHrafhRKU3Tu5adMvIBRnUvctqF8fq8RDKGJdE
         8UzHF6ipMbBUja8JTqyx0V3lsi75zJX4aYdOXuIXiam2jHoHzyCfm6GN8DVn2DS4P+jP
         5/AnmBauHUcX2YittmAC8nNMvPn9zrTqxTyuurNr4oX376YcejuorjPSwQR2C5AhEMjU
         NrAVcLj224/Y8vXlLbQVm9zoexfMXQLd1U3PQiyHv2IBGXbg12xGSXmPIBq4Kika2tz5
         RGlw==
X-Gm-Message-State: AOAM5306M/ew7N+NDwjUbZy8EW15aCRRMHaAZWZpWMU/eUZ8WT9QMn3B
        YaNnUdBSWqCBeqgjIvSgeuY=
X-Google-Smtp-Source: ABdhPJzJI9w691D38tlX41RL0HmQwJewA46VH6MoegugxSW6+qR6JwBYUO1enwJYQ3BQHskvlcnDsA==
X-Received: by 2002:a65:644e:: with SMTP id s14mr19877266pgv.410.1629482674250;
        Fri, 20 Aug 2021 11:04:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ddfe:8579:6783:9ed8])
        by smtp.gmail.com with ESMTPSA id b9sm7673567pfo.175.2021.08.20.11.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 11:04:33 -0700 (PDT)
Subject: Re: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority
 requests
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-17-bvanassche@acm.org> <YR77J/aE6sWZ6Els@x1-carbon>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5aa99b39-c342-abd4-00a4-dc0fbfac96aa@acm.org>
Date:   Fri, 20 Aug 2021 11:04:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YR77J/aE6sWZ6Els@x1-carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/21 5:45 PM, Niklas Cassel wrote:
 > dd_queued() calls dd_sum() which has this comment:
 >
 > /*
 >   * Returns the total number of dd_count(dd, event_type, prio) calls across all
 >   * CPUs. No locking or barriers since it is fine if the returned sum is slightly
 >   * outdated.
 >   */
 >
 > Perhaps not so got to use an accounting that is not accurate to determine
 > if we should process IOs belonging to a certain priority class or not.
 >
 > Perhaps we could use e.g. atomics instead of per cpu counters without
 > locking?

First of all, thanks for the detailed report.

Using atomics is an option but an option we should only choose if there are no
better options since every atomic operation in the hot path has a measurable
negative performance impact.

 >    kworker/u64:11-628     [026] ....    13.650123: dd_finish_request: dd prio: 1 prio class: 0
 >    kworker/u64:11-628     [026] ....    13.650125: dd_queued_print: ins: 0 comp: 1 queued: 4294967295

4294967295 is the unsigned representation of -1. This indicates a bug - the
"queued" number should never be negative.

 > What appears to be happening here is that dd_finish_request() gets called a bunch of times,
 > without any preceeding dd_insert_requests() call.
 >
 > Reading the comment above dd_finish_request():
 >
 >   * Callback from inside blk_mq_free_request().
 >
 > Could it be that this callback is done on certain requests that was never
 > sent down to mq-deadline?
 > Perhaps blk_mq_request_bypass_insert() or blk_mq_try_issue_directly() was
 > called, and therefore dd_insert_requests() was never called for some of the
 > ealiest requests in the system, but since e->type->ops.finish_request() is
 > set, dd_finish_request() gets called on free anyway.
 >
 > Since dd_queued() is defined as:
 > 	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
 > And since we can see that we have several calls to dd_finish_request()
 > that has increased the completed counter, dd_queued() returns a
 > very high value, since 0 - 19 = 4294967277.
 >
 > This is probably the bug that causes the bogus accouting of BE reqs.
 > However, looking at the comment for dd_sum(), it also doesn't feel good
 > to rely on something that is "slightly outdated" to determine if we
 > should process a whole io class or not.
 > Letting requests wait for 10 seconds when there are no other outstanding
 > requests in the scheduler doesn't seem like the right thing to do.

The "slightly outdated" in that comment is not what causes the I/O delays -
these are caused by updating statistics in dd_finish_request() for requests
that have not been seen by dd_insert_requests(). Please note that
dd_insert_request() and dd_dispatch_request() access the I/O statistics
while dd->lock is held. Only dd_finish_request() updates the I/O statistics
without holding dd->lock. So the dd_queued() call from inside
dd_dispatch_request() can return a number that is too big but not a number
that is too small. Hence, I don't think that updating the I/O statistics
without locking in the deadline scheduler can cause an I/O delay.

Does the patch below help?

Thanks,

Bart.


Subject: [PATCH] mq-deadline: Fix request accounting

The block layer may call the I/O scheduler .finish_request() callback
without having called the .insert_requests() callback. Make sure that the
mq-deadline I/O statistics are correct if the block layer inserts an I/O
request that bypasses the I/O scheduler. This patch prevents that lower
priority I/O is delayed longer than necessary for mixed I/O priority
workloads.

Fixes: 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")
Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  block/mq-deadline-main.c | 14 ++++++++++++--
  1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
index 294be0c0db65..933be9c82ec4 100644
--- a/block/mq-deadline-main.c
+++ b/block/mq-deadline-main.c
@@ -743,6 +743,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
  	blkcg = dd_blkcg_from_bio(rq->bio);
  	ddcg_count(blkcg, inserted, ioprio_class);
  	rq->elv.priv[0] = blkcg;
+	rq->elv.priv[1] = (void *)(uintptr_t)1;

  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
  		blk_mq_free_requests(&free);
@@ -795,6 +796,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
  static void dd_prepare_request(struct request *rq)
  {
  	rq->elv.priv[0] = NULL;
+	rq->elv.priv[1] = NULL;
  }

  /*
@@ -822,8 +824,16 @@ static void dd_finish_request(struct request *rq)
  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
  	struct dd_per_prio *per_prio = &dd->per_prio[prio];

-	dd_count(dd, completed, prio);
-	ddcg_count(blkcg, completed, ioprio_class);
+	/*
+	 * The block layer core may call dd_finish_request() without having
+	 * called dd_insert_requests(). Hence only update statistics for
+	 * requests for which dd_insert_requests() has been called. See also
+	 * blk_mq_request_bypass_insert().
+	 */
+	if (rq->elv.priv[1]) {
+		dd_count(dd, completed, prio);
+		ddcg_count(blkcg, completed, ioprio_class);
+	}

  	if (blk_queue_is_zoned(q)) {
  		unsigned long flags;
