Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99635C54E4A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 15:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5F920838
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 15:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgEGPJ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 11:09:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:53276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgEGPJ6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 11:09:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9D43AF5C;
        Thu,  7 May 2020 15:09:59 +0000 (UTC)
Subject: Re: [PATCH v6 2/5] block: save previous hardware queue count before
 udpate
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        hch@infradead.org, linux-block@vger.kernel.org
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
 <ada06eff50f5a9efb821210ad514df39d6868bd7.1588856361.git.zhangweiping@didiglobal.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <cea39245-dfe5-cebb-58e1-e6e3bfaabd93@suse.de>
Date:   Thu, 7 May 2020 17:09:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ada06eff50f5a9efb821210ad514df39d6868bd7.1588856361.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/7/20 3:03 PM, Weiping Zhang wrote:
> blk_mq_realloc_tag_set_tags will update set->nr_hw_queues, so
> save old set->nr_hw_queues before call this function.
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f789b3e1b3ab..a79afbe60ca6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3347,11 +3347,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   		blk_mq_sysfs_unregister(q);
>   	}
>   
> +	prev_nr_hw_queues = set->nr_hw_queues;
>   	if (blk_mq_realloc_tag_set_tags(set, set->nr_hw_queues, nr_hw_queues) <
>   	    0)
>   		goto reregister;
>   
> -	prev_nr_hw_queues = set->nr_hw_queues;
>   	set->nr_hw_queues = nr_hw_queues;
>   	blk_mq_update_queue_map(set);
>   fallback:
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
