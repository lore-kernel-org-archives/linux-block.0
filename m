Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A926AC7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 09:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDLJlX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 05:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjDLJlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 05:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABD112F
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 02:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCD0461041
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 09:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D035C433EF;
        Wed, 12 Apr 2023 09:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681292474;
        bh=nibgNWFyZ9eTQjNxcFFfKIDFVH8StaJAVG0kTyKrzu0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jn3PWeuWT20C/Vl/QSZbEGMlDZtVTTd5xSJ1BWtJNOfCGUJbjBdPwjQJ4jMgG8hL3
         /xGi7ECmDYU+2UsWypZYDoZoFbeq1dSOd1bQLlGB8Tl6+UdmsdFiryk2k4IRazWMcG
         m7TNDYdck+EPvI2/NpPAJC3f0XnCo8srtbU7nWMi4G9EliC56YYplHdG3HnXEhEubg
         r3XPiG+pooPfjQa7SIJ6crh6TK0QtSK1sc5Zs7UawE7YApf0qddyzgfhN68R5g3ouQ
         LKz1uIy0OIPOQsG3UgU1HhY77dZ//f0tKjkdIJ6UVf4XYHGW5A8ZGQIFHXydPQI2o6
         iES2Iw0W+tCXw==
Message-ID: <5f2abec9-6d5c-7590-5ba9-f2886d98f1ae@kernel.org>
Date:   Wed, 12 Apr 2023 18:41:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, bvanassche@acm.org, vincent.fu@samsung.com,
        shinichiro.kawasaki@wdc.com, yukuai3@huawei.com
References: <20230412084730.51694-1-kch@nvidia.com>
 <20230412084730.51694-2-kch@nvidia.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412084730.51694-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 17:47, Chaitanya Kulkarni wrote:
> QUEUE_FLAG_NOWAIT is set by default to mq drivers such null_blk when
> it is used with NULL_Q_MQ mode as a part of QUEUE_FLAG_MQ_DEFAULT that
> gets assigned in following code path see blk_mq_init_allocated_queue():-

Can you fix the grammar/punctuation in this sentence ? Looks like some words are
missing, making it hard to read.

> 
> null_add_dev()
> if (dev->queue_mode == NULL_Q_MQ) {
>         blk_mq_alloc_disk()
>           __blk_mq_alloc_disk()
> 	    blk_mq_init_queue_data()
>               blk_mq_init_allocated_queue()
>                 q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
> }
> 
> But it is not set when null_blk is loaded with NULL_Q_BIO mode in following
> code path like other bio drivers do e.g. nvme-multipath :-
> 
> if (dev->queue_mode == NULL_Q_BIO) {
>         nullb->disk = blk_alloc_disk(nullb->dev->home_node);
>         	blk_alloc_disk()
>         	  blk_alloc_queue()
>         	  __alloc_disk_nodw()
> }
> 
> Add a new module parameter nowait and respective configfs attr that will
> set or clear the QUEUE_FLAG_NOWAIT based on a value set by user in
> null_add_dev() irrespective of the queue mode, by default keep it
> enabled to retain the original behaviour for the NULL_Q_MQ mode.

Nope. You are changing the behavior. See below.

> 
> Depending on nowait value use GFP_NOWAIT or GFP_NOIO for the alloction
> in the null_alloc_page() for alloc_pages() and in null_insert_page()
> for radix_tree_preload().   
> 
> Observed performance difference with this patch for fio iouring with
> configfs and non configfs null_blk with queue modes NULL_Q_BIO and
> NULL_Q_MQ:-

[...]

> @@ -983,11 +990,11 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
>  
>  	spin_unlock_irq(&nullb->lock);
>  
> -	t_page = null_alloc_page();
> +	t_page = null_alloc_page(nullb->dev->nowait ? GFP_NOWAIT : GFP_NOIO);

This can potentially result in failed allocations, so IO errors, which otherwise
would not happen without this change. Not nice. Memory backing also sets
BLK_MQ_F_BLOCKING, which I am not sure is compatible with QUEUE_FLAG_NOWAIT...
Would need to check that again.


