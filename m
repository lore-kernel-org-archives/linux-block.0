Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01C9C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 06:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJUGtt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJUGtj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 02:49:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C2B1D2
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 23:49:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72D861F74D;
        Fri, 21 Oct 2022 06:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666334971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+oCJOWRzT7bRCiOMcDCqpe8bkKeLr3DWgxPnTd1uYE=;
        b=gj+uZJi1o43DU1hZ1/aRIgc3Kw1qwT/U/bKvFS8rToy22sWFgAKRkyY9rknQZIZrmaaXzO
        qGiNHHRw+JHO5P7acU1EFNW0Mp0K8tGqeF5jG9APJ2n6GBsFIjqkcuKfENVk1AUUoN4vNB
        3Ills5rUynWLUst/nMWq7KbR5q6flhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666334971;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+oCJOWRzT7bRCiOMcDCqpe8bkKeLr3DWgxPnTd1uYE=;
        b=h8n5MgLrPDnmJi+dKTxPH3mKi5wXvfrKoQRC5wwoQMrPgqA9RGR7CJYgKyv8fMMaQoPauq
        +Ubn/ayUZuXVEZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 431021331A;
        Fri, 21 Oct 2022 06:49:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0VGtD/tAUmMHHgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Oct 2022 06:49:31 +0000
Message-ID: <3aebc5d7-874d-ddeb-7383-79826e98fd9d@suse.de>
Date:   Fri, 21 Oct 2022 08:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/8] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221020105608.1581940-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 12:56, Christoph Hellwig wrote:
> nvme and xen-blkfront are already doing this to stop buffered writes from
> creating dirty pages that can't be written out later.  Move it to the
> common code.  Note that this follows the xen-blkfront version that does
> not send and uevent as the uevent is a bit confusing when the device is
> about to go away a little later, and the the size change is just to stop
> buffered writes faster.
> 
> This also removes the comment about the ordering from nvme, as bd_mutex
> not only is gone entirely, but also hasn't been used for locking updates
> to the disk size long before that, and thus the ordering requirement
> documented there doesn't apply any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c                | 3 +++
>   drivers/block/xen-blkfront.c | 1 -
>   drivers/nvme/host/core.c     | 7 +------
>   3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 17b33c62423df..2877b5f905579 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -555,6 +555,9 @@ void blk_mark_disk_dead(struct gendisk *disk)
>   {
>   	set_bit(GD_DEAD, &disk->state);
>   	blk_queue_start_drain(disk->queue);
> +
> +	/* stop buffered writers from dirtying pages that can't written out */
> +	set_capacity(disk, 0);
>   }
>   EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
>   
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 35b9bcad9db90..b28489290323f 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2129,7 +2129,6 @@ static void blkfront_closing(struct blkfront_info *info)
>   	if (info->rq && info->gd) {
>   		blk_mq_stop_hw_queues(info->rq);
>   		blk_mark_disk_dead(info->gd);
> -		set_capacity(info->gd, 0);
>   	}
>   
>   	for_each_rinfo(info, rinfo, i) {
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c19..44a5321743128 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5106,10 +5106,7 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   /*
>    * Prepare a queue for teardown.
>    *
> - * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
> - * the capacity to 0 after that to avoid blocking dispatchers that may be
> - * holding bd_butex.  This will end buffered writers dirtying pages that can't
> - * be synced.
> + * This must forcibly unquiesce queues to avoid blocking dispatch.
>    */
>   static void nvme_set_queue_dying(struct nvme_ns *ns)
>   {
> @@ -5118,8 +5115,6 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>   
>   	blk_mark_disk_dead(ns->disk);
>   	nvme_start_ns_queue(ns);
> -
> -	set_capacity_and_notify(ns->disk, 0);
>   }
>   
>   /**
I'm ever so slightly concerned about not sending the uevent anymore; MD 
for one relies on that event to figure out if a device is down.
And I'm also relatively sure that testing with MD on Xen had been 
relatively few.
What do we lose by using the 'notify' version instead?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

