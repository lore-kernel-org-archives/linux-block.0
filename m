Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED2EC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 15:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5892C22CF7
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 15:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfHUPxz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:53:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36637 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfHUPxz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 11:53:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so1551430plr.3
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2019 08:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vXnKN3aF2g26REmtHFRosgONbbSvPjCH8Kfcpho0HlE=;
        b=hOYZHOALDBzijccEl5SX4IxHwpJZyoI6+3ZZzZMZc3DgNRouErxE3yjWcB/TVqCapK
         vQFsFYVaw7P/vM+wPTjt//+DUW/fpG+EUi2dTJwS1eu149otQjByAa1Yj0AOdeDoBAT/
         v4l+9ReaPmbFJ/HwA+oCN5SDpUe5SoOXJe51+oOJAg76r+aExBf3L6tvQYenqQiWsWb0
         x5BM9YLbkY3sOQB2OIhDVizlC32bhgFc/xH8HaW/qhp81LsD92gMhW1cq4buHNbfKf7I
         pcLnLBVL7Dwb+5KIw2YVM+GEEcVtIaj2NivtKzrpLV3R/CdhHOj+Rx5FzVFJIN606Yun
         g5aQ==
X-Gm-Message-State: APjAAAXB96IGJbnT02INAwH2L9hb2ztNiAa5/UHN1s8dW2JCy8rC1bj0
        sq0ZwXFVjV7iUwp4YWfEZV0=
X-Google-Smtp-Source: APXvYqwWsjvm0ndJLicef1i7qUnvPm20UXoxaidVLlAqyEn70PoCS8mLJDVLFLk6QHN1jC2H6uZXUQ==
X-Received: by 2002:a17:902:7797:: with SMTP id o23mr34656147pll.102.1566402834708;
        Wed, 21 Aug 2019 08:53:54 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 136sm35869557pfz.123.2019.08.21.08.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 08:53:53 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] blk-mq: don't hold q->sysfs_lock in
 blk_mq_map_swqueue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-4-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3a48b5cb-0618-598c-3087-c6c939b6353b@acm.org>
Date:   Wed, 21 Aug 2019 08:53:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821091506.21196-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/19 2:15 AM, Ming Lei wrote:
> blk_mq_map_swqueue() is called from blk_mq_init_allocated_queue()
> and blk_mq_update_nr_hw_queues(). For the former caller, the kobject
> isn't exposed to userspace yet. For the latter caller, sysfs/debugfs
> is un-registered before updating nr_hw_queues.
> 
> On the other hand, commit 2f8f1336a48b ("blk-mq: always free hctx after
> request queue is freed") moves freeing hctx into queue's release
> handler, so there won't be race with queue release path too.
> 
> So don't hold q->sysfs_lock in blk_mq_map_swqueue().
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6968de9d7402..b0ee0cac737f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2456,11 +2456,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>   	struct blk_mq_ctx *ctx;
>   	struct blk_mq_tag_set *set = q->tag_set;
>   
> -	/*
> -	 * Avoid others reading imcomplete hctx->cpumask through sysfs
> -	 */
> -	mutex_lock(&q->sysfs_lock);
> -
>   	queue_for_each_hw_ctx(q, hctx, i) {
>   		cpumask_clear(hctx->cpumask);
>   		hctx->nr_ctx = 0;
> @@ -2521,8 +2516,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>   					HCTX_TYPE_DEFAULT, i);
>   	}
>   
> -	mutex_unlock(&q->sysfs_lock);
> -
>   	queue_for_each_hw_ctx(q, hctx, i) {
>   		/*
>   		 * If no software queues are mapped to this hardware queue,
> 

How about adding WARN_ON_ONCE(test_bit(QUEUE_FLAG_REGISTERED, 
&q->queue_flags)) ?

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
