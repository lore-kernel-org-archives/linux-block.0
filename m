Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393D3C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 07:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C0C20863
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 07:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C0C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeK2SRz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:17:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbeK2SRz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 13:17:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 124B3C060214;
        Thu, 29 Nov 2018 07:13:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9531A601B9;
        Thu, 29 Nov 2018 07:13:28 +0000 (UTC)
Date:   Thu, 29 Nov 2018 15:13:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/7] blk-mq: use plug for devices that implement
 ->commits_rqs()
Message-ID: <20181129071322.GC27186@ming.t460p>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-8-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128133538.20329-8-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 29 Nov 2018 07:13:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 06:35:38AM -0700, Jens Axboe wrote:
> If we have that hook, we know the driver handles bd->last == true in
> a smart fashion. If it does, even for multiple hardware queues, it's
> a good idea to flush batches of requests to the device, if we have
> batches of requests from the submitter.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9e1045152e45..091557a43d53 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1945,7 +1945,12 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		/* bypass scheduler for flush rq */
>  		blk_insert_flush(rq);
>  		blk_mq_run_hw_queue(data.hctx, true);
> -	} else if (plug && q->nr_hw_queues == 1) {
> +	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops->commit_rqs)) {
> +		/*
> +		 * Use plugging if we have a ->commit_rqs() hook as well,
> +		 * as we know the driver uses bd->last in a smart
> +		 * fashion.
> +		 */
>  		unsigned int request_count = plug->rq_count;
>  		struct request *last = NULL;
>  
> -- 
> 2.17.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming
