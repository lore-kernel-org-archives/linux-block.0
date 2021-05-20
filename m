Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276C2C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F9E600CD
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhETFxY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 01:53:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:45862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhETFxY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 01:53:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A0D3AF03;
        Thu, 20 May 2021 05:52:02 +0000 (UTC)
Subject: Re: [PATCH v2 03/11] block: introduce BIO_ZONE_WRITE_LOCKED bio flag
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
 <20210520042228.974083-4-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <cf0fdb6d-78f9-9dee-2462-5b9f9d5addc1@suse.de>
Date:   Thu, 20 May 2021 07:52:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520042228.974083-4-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 6:22 AM, Damien Le Moal wrote:
> Introduce the BIO flag BIO_ZONE_WRITE_LOCKED to indicate that a BIO owns
> the write lock of the zone it is targeting. This is the counterpart of
> the struct request flag RQF_ZONE_WRITE_LOCKED.
> 
> This new BIO flag is reserved for now for zone write locking control
> for device mapper targets exposing a zoned block device. Since in this
> case, the lock flag must not be propagated to the struct request that
> will be used to process the BIO, a BIO private flag is used rather than
> changing the RQF_ZONE_WRITE_LOCKED request flag into a common REQ_XXX
> flag that could be used for both BIO and request. This avoids conflicts
> down the stack with the block IO scheduler zone write locking
> (in mq-deadline).
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/blk_types.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index db026b6ec15a..e5cf12f102a2 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -304,6 +304,7 @@ enum {
>   	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
>   	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
>   	BIO_REMAPPED,
> +	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
>   	BIO_FLAG_LAST
>   };
>   
> 
I would have merged this with the patch actually using it, but this is 
probably a personal preference.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
