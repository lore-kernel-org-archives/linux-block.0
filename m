Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0998C282DA
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988D621019
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 21:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDFV1Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 17:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDFV1Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Apr 2019 17:27:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B37046289;
        Sat,  6 Apr 2019 21:27:24 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A4DA1975D;
        Sat,  6 Apr 2019 21:27:15 +0000 (UTC)
Date:   Sun, 7 Apr 2019 05:27:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <keith.busch@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
Message-ID: <20190406212709.GA29871@ming.t460p>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
 <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
 <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 06 Apr 2019 21:27:24 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 05, 2019 at 05:36:32PM -0600, Keith Busch wrote:
> On Fri, Apr 5, 2019 at 5:04 PM Jens Axboe <axboe@kernel.dk> wrote:
> > Looking at current peak testing, I've got around 1.2% in queue enter
> > and exit. It's definitely not free, hence my question. Probably safe
> > to assume that we'll double that cycle counter, per IO.
> 
> Okay, that's not negligible at all. I don't know of a faster reference
> than the percpu_ref, but that much overhead would have to rule out
> having a per hctx counter.

Or not using any refcount in fast path, how about the following one?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ff3d7b49969..6fe334e12236 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2199,6 +2199,23 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
 
+static void blk_mq_wait_hctx_become_idle(struct blk_mq_hw_ctx *hctx,
+		int dead_cpu)
+{
+	unsigned long msecs_left = 1000 * 10;
+
+	while (msecs_left > 0) {
+		if (blk_mq_hctx_idle(hctx))
+			break;
+		msleep(5);
+		msecs_left -= 5;
+	}
+
+	if (msecs_left > 0)
+		printk(KERN_WARNING "requests not completed from "
+			"CPU %d\n", dead_cpu);
+}
+
 /*
  * 'cpu' is going away. splice any existing rq_list entries from this
  * software queue to the hw queue dispatch list, and ensure that it
@@ -2230,6 +2247,14 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	spin_unlock(&hctx->lock);
 
 	blk_mq_run_hw_queue(hctx, true);
+
+	/*
+	 * Interrupt for this queue will be shutdown, so wait until all
+	 * requests from this hctx is done or timeout.
+	 */
+	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) >= nr_cpu_ids)
+		blk_mq_wait_hctx_become_idle(hctx, cpu);
+
 	return 0;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d704fc7766f4..935cf8519bf2 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -240,4 +240,15 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 		qmap->mq_map[cpu] = 0;
 }
 
+static inline bool blk_mq_hctx_idle(struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_tags *tags = hctx->sched_tags ?: hctx->tags;
+
+	if (!tags)
+		return true;
+
+	return !sbitmap_any_bit_set(&tags->bitmap_tags.sb) &&
+                       !sbitmap_any_bit_set(&tags->bitmap_tags.sb);
+}
+
 #endif

Thanks,
Ming
