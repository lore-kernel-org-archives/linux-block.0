Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09A5C433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 06:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9263761969
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 06:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhC3G1U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 02:27:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:42742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhC3G0t (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 02:26:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F99FAE86;
        Tue, 30 Mar 2021 06:26:48 +0000 (UTC)
Subject: Re: [PATCH V4 11/12] block: add poll_capable method to support
 bio-based IO polling
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210329152622.173035-1-ming.lei@redhat.com>
 <20210329152622.173035-12-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <162f000f-7f86-8988-4a15-2c3bf70de1b7@suse.de>
Date:   Tue, 30 Mar 2021 08:26:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210329152622.173035-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/21 5:26 PM, Ming Lei wrote:
> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> This method can be used to check if bio-based device supports IO polling
> or not. For mq devices, checking for hw queue in polling mode is
> adequate, while the sanity check shall be implementation specific for
> bio-based devices. For example, dm device needs to check if all
> underlying devices are capable of IO polling.
> 
> Though bio-based device may have done the sanity check during the
> device initialization phase, cacheing the result of this sanity check
> (such as by cacheing in the queue_flags) may not work. Because for dm
> devices, users could change the state of the underlying devices through
> '/sys/block/<dev>/io_poll', bypassing the dm device above. In this case,
> the cached result of the very beginning sanity check could be
> out-of-date. Thus the sanity check needs to be done every time 'io_poll'
> is to be modified.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>   block/blk-sysfs.c      | 14 +++++++++++---
>   include/linux/blkdev.h |  1 +
>   2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index db3268d41274..c8e7e4af66cb 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -426,9 +426,17 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
>   	unsigned long poll_on;
>   	ssize_t ret;
>   
> -	if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
> -	    !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
> -		return -EINVAL;
> +	if (queue_is_mq(q)) {
> +		if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
> +		    !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
> +			return -EINVAL;
> +	} else {
> +		struct gendisk *disk = queue_to_disk(q);
> +
> +		if (!disk->fops->poll_capable ||
> +		    !disk->fops->poll_capable(disk))
> +			return -EINVAL;
> +	}
>   
>   	ret = queue_var_store(&poll_on, page, count);
>   	if (ret < 0)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bfab74b45f15..a46f975f2a2f 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1881,6 +1881,7 @@ struct block_device_operations {
>   	int (*report_zones)(struct gendisk *, sector_t sector,
>   			unsigned int nr_zones, report_zones_cb cb, void *data);
>   	char *(*devnode)(struct gendisk *disk, umode_t *mode);
> +	bool (*poll_capable)(struct gendisk *disk);
>   	struct module *owner;
>   	const struct pr_ops *pr_ops;
>   };
> 
I really wonder how this would work for nvme multipath; but I guess it 
doesn't change the current situation.

So:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
