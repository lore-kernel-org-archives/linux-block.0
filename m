Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F36C2B9FC
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D86761C78
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhELPV6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 11:21:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:52552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233254AbhELPRu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 11:17:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3242DB0B3;
        Wed, 12 May 2021 15:16:40 +0000 (UTC)
Subject: Re: [PATCH v1 7/8] null_blk: add error handling support for
 add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-8-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <842b6a8d-8880-a0da-a38b-39378dc6ebb9@suse.de>
Date:   Wed, 12 May 2021 17:16:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512064629.13899-8-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/block/null_blk/main.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 5f006d9e1472..2346d1292b26 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1699,6 +1699,7 @@ static int init_driver_queues(struct nullb *nullb)
>   
>   static int null_gendisk_register(struct nullb *nullb)
>   {
> +	int ret;
>   	sector_t size = ((sector_t)nullb->dev->size * SZ_1M) >> SECTOR_SHIFT;
>   	struct gendisk *disk;
>   
> @@ -1719,13 +1720,17 @@ static int null_gendisk_register(struct nullb *nullb)
>   	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
>   
>   	if (nullb->dev->zoned) {
> -		int ret = null_register_zoned_dev(nullb);
> +		ret = null_register_zoned_dev(nullb);
>   
>   		if (ret)
>   			return ret;
>   	}
>   
> -	add_disk(disk);
> +	ret = add_disk(disk);
> +	if (ret) {

unregister_zoned_device() ?

> +		put_disk(disk);
> +		return ret;
> +	}
>   	return 0;
>   }
>   
> Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
