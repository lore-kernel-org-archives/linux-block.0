Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A52C3A59B
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 03:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CBF2087E
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 03:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfHSD6T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Aug 2019 23:58:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfHSD6T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Aug 2019 23:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 425D43082B13;
        Mon, 19 Aug 2019 03:58:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9175E1001B11;
        Mon, 19 Aug 2019 03:58:14 +0000 (UTC)
Date:   Mon, 19 Aug 2019 11:58:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH] block: remove queue_head
Message-ID: <20190819035808.GD3086@ming.t460p>
References: <20190816211233.22414-1-junxiao.bi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816211233.22414-1-junxiao.bi@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 19 Aug 2019 03:58:19 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 16, 2019 at 02:12:33PM -0700, Junxiao Bi wrote:
> The dispatch list was not used any more as lagency block gone.
> 
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>  block/blk-core.c       | 1 -
>  include/linux/blkdev.h | 4 ----
>  2 files changed, 5 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d0cc6e14d2f0..82c9c1ef1de6 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -479,7 +479,6 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
>  	if (!q)
>  		return NULL;
>  
> -	INIT_LIST_HEAD(&q->queue_head);
>  	q->last_merge = NULL;
>  
>  	q->id = ida_simple_get(&blk_queue_ida, 0, 0, gfp_mask);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1ef375dafb1c..680c4d08f1a2 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -391,10 +391,6 @@ static inline int blkdev_reset_zones_ioctl(struct block_device *bdev,
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  
>  struct request_queue {
> -	/*
> -	 * Together with queue_head for cacheline sharing
> -	 */
> -	struct list_head	queue_head;
>  	struct request		*last_merge;
>  	struct elevator_queue	*elevator;
>  
> -- 
> 2.17.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming
