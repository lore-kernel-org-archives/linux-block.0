Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076E0C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 01:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCC22075E
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 01:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfC0BZt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:25:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfC0BZs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 21:25:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D16E7307D844;
        Wed, 27 Mar 2019 01:25:48 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 913FA60BE5;
        Wed, 27 Mar 2019 01:25:43 +0000 (UTC)
Date:   Wed, 27 Mar 2019 09:25:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] block: don't call blk_mq_run_hw_queues() for dead or
 dying queues
Message-ID: <20190327012538.GA4882@ming.t460p>
References: <20190326120712.41657-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326120712.41657-1-hare@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 27 Mar 2019 01:25:48 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 26, 2019 at 01:07:12PM +0100, Hannes Reinecke wrote:
> When a queue is dying or dead there is no point in calling
> blk_mq_run_hw_queues() in blk_mq_unquiesce_queue(); in fact, doing
> so might crash the machine as the queue structures are in the
> process of being deleted.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a9c181603cbd..b1eeba38bc79 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -258,7 +258,8 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>  	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>  
>  	/* dispatch requests which are inserted during quiescing */
> -	blk_mq_run_hw_queues(q, true);
> +	if (!blk_queue_dying(q) && !blk_queue_dead(q))
> +		blk_mq_run_hw_queues(q, true);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);

Per previous protocol in legacy io path, the LLD should handle requests
when queue is dying.

Also now, the request queue has become frozen before setting DEAD, so
not necessary to add the DEAD check before run queue.

Thanks,
Ming
