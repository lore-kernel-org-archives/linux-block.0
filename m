Return-Path: <SRS0=AW5R=4G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280DFC34022
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 03:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18D9206EF
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 03:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkElhUPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgBRDRC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:17:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48141 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726292AbgBRDRC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Feb 2020 22:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581995821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0TfAceTAmNi4x+lEahYp6wyTb6h2pauf+LJBnECmVsg=;
        b=hkElhUPxKYgRu7ROAcOAlBB13KYQdwRnbYkS551F0BMBmEJqN6ZPKGVYRxbATvIbAD8Rld
        PSZlLF0UgCLJ+1X7tqK/+qi0H2al4v+jD9I0Whv7RhE1ZWxGz6aWcSWoND2CqYkGyJ0jbe
        ziC4KaGMjyRv9x1B5jWEYDG3Mn7jpUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-sKD9vLeIM6iH3B4v_5cuEQ-1; Mon, 17 Feb 2020 22:16:57 -0500
X-MC-Unique: sKD9vLeIM6iH3B4v_5cuEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D32BE107ACC9;
        Tue, 18 Feb 2020 03:16:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADC2290765;
        Tue, 18 Feb 2020 03:16:48 +0000 (UTC)
Date:   Tue, 18 Feb 2020 11:16:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/5] blk-mq: Keep set->nr_hw_queues and
 set->map[].nr_queues in sync
Message-ID: <20200218031643.GB30750@ming.t460p>
References: <20200217210839.28535-1-bvanassche@acm.org>
 <20200217210839.28535-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217210839.28535-3-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 17, 2020 at 01:08:36PM -0800, Bart Van Assche wrote:
> This patch fixes the following kernel warning:
> 
> WARNING: CPU: 0 PID: 2501 at include/linux/cpumask.h:137
> Call Trace:
>  blk_mq_run_hw_queue+0x19d/0x350 block/blk-mq.c:1508
>  blk_mq_run_hw_queues+0x112/0x1a0 block/blk-mq.c:1525
>  blk_mq_requeue_work+0x502/0x780 block/blk-mq.c:775
>  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
>  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
>  kthread+0x361/0x430 kernel/kthread.c:255
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jth@kernel.org>
> Reported-by: syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
> Fixes: ed76e329d74a ("blk-mq: abstract out queue map") # v5.0
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f298500e6dda..2b9f490f5a64 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3050,6 +3050,16 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
>  	}
>  }
>  
> +static void blk_mq_set_nr_hw_queues(struct blk_mq_tag_set *set,
> +				    int new_nr_hw_queues)
> +{
> +	int i;
> +
> +	set->nr_hw_queues = new_nr_hw_queues;
> +	for (i = 0; i < set->nr_maps; i++)
> +		set->map[i].nr_queues = new_nr_hw_queues;
> +}
> +
>  static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
>  				  int cur_nr_hw_queues, int new_nr_hw_queues)
>  {
> @@ -3068,7 +3078,7 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
>  		       sizeof(*set->tags));
>  	kfree(set->tags);
>  	set->tags = new_tags;
> -	set->nr_hw_queues = new_nr_hw_queues;
> +	blk_mq_set_nr_hw_queues(set, new_nr_hw_queues);
>  
>  	return 0;
>  }
> @@ -3330,7 +3340,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		goto reregister;
>  
>  	prev_nr_hw_queues = set->nr_hw_queues;
> -	set->nr_hw_queues = nr_hw_queues;
> +	blk_mq_set_nr_hw_queues(set, nr_hw_queues);
>  	blk_mq_update_queue_map(set);
>  fallback:
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> @@ -3338,7 +3348,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		if (q->nr_hw_queues != set->nr_hw_queues) {
>  			pr_warn("Increasing nr_hw_queues to %d fails, fallback to %d\n",
>  					nr_hw_queues, prev_nr_hw_queues);
> -			set->nr_hw_queues = prev_nr_hw_queues;
> +			blk_mq_set_nr_hw_queues(set, prev_nr_hw_queues);
>  			blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
>  			goto fallback;
>  		}
> 

I guess the issue can be fixed by the following change, and we do not
need to touch each queue map:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5f5c43ae3792..f7340afb89ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3046,6 +3046,7 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
                return set->ops->map_queues(set);
        } else {
                BUG_ON(set->nr_maps > 1);
+               set->map[HCTX_TYPE_DEFAULT].nr_queues = set->nr_hw_queues;
                return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
        }
 }


Thanks,
Ming

