Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A687C433ED
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 01:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25478613DC
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 01:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhDWBdR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 21:33:17 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:53565 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230367AbhDWBdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 21:33:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UWS0UzP_1619141558;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UWS0UzP_1619141558)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 23 Apr 2021 09:32:38 +0800
Subject: Re: [PATCH V6 12/12] dm: support IO polling for bio-based dm device
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Hannes Reinecke <hare@suse.de>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
 <20210422122038.2192933-13-ming.lei@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <3681e443-0381-b916-101d-f5e6cc2c8d7a@linux.alibaba.com>
Date:   Fri, 23 Apr 2021 09:32:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210422122038.2192933-13-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/22/21 8:20 PM, Ming Lei wrote:
> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> IO polling is enabled when all underlying target devices are capable
> of IO polling. The sanity check supports the stacked device model, in
> which one dm device may be build upon another dm device. In this case,
> the mapped device will check if the underlying dm target device
> supports IO polling.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/md/dm-table.c         | 24 ++++++++++++++++++++++++
>  drivers/md/dm.c               |  2 ++
>  include/linux/device-mapper.h |  1 +
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 95391f78b8d5..a8f3575fb118 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1509,6 +1509,12 @@ struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector)
>  	return &t->targets[(KEYS_PER_NODE * n) + k];
>  }
>  
> +static int device_not_poll_capable(struct dm_target *ti, struct dm_dev *dev,
> +				   sector_t start, sector_t len, void *data)
> +{
> +	return !blk_queue_poll(bdev_get_queue(dev->bdev));
> +}
> +
>  /*
>   * type->iterate_devices() should be called when the sanity check needs to
>   * iterate and check all underlying data devices. iterate_devices() will
> @@ -1559,6 +1565,11 @@ static int count_device(struct dm_target *ti, struct dm_dev *dev,
>  	return 0;
>  }
>  
> +int dm_table_supports_poll(struct dm_table *t)
> +{
> +	return !dm_table_any_dev_attr(t, device_not_poll_capable, NULL);
> +}
> +

Since .poll_capable() has been dropped, dm_table_supports_poll() can be
declared as 'static' here.

>  /*
>   * Check whether a table has no data devices attached using each
>   * target's iterate_devices method.
> @@ -2079,6 +2090,19 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  
>  	dm_update_keyslot_manager(q, t);
>  	blk_queue_update_readahead(q);
> +
> +	/*
> +	 * Check for request-based device is remained to
> +	 * dm_mq_init_request_queue()->blk_mq_init_allocated_queue().
> +	 * For bio-based device, only set QUEUE_FLAG_POLL when all underlying
> +	 * devices supporting polling.
> +	 */
> +	if (__table_type_bio_based(t->type)) {
> +		if (dm_table_supports_poll(t))
> +			blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> +		else
> +			blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
> +	}
>  }
>  
>  unsigned int dm_table_get_num_targets(struct dm_table *t)
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 50b693d776d6..1b160e4e6446 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2175,6 +2175,8 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
>  		}
>  		break;
>  	case DM_TYPE_BIO_BASED:
> +		/* tell block layer we are capable of bio polling */
> +		md->disk->flags |= GENHD_FL_CAP_BIO_POLL;
>  	case DM_TYPE_DAX_BIO_BASED:
>  		break;
>  	case DM_TYPE_NONE:


> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 7f4ac87c0b32..31bfd6f70013 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -538,6 +538,7 @@ unsigned int dm_table_get_num_targets(struct dm_table *t);
>  fmode_t dm_table_get_mode(struct dm_table *t);
>  struct mapped_device *dm_table_get_md(struct dm_table *t);
>  const char *dm_table_device_name(struct dm_table *t);
> +int dm_table_supports_poll(struct dm_table *t);

Similarly, dm_table_supports_poll() doesn't need to be exported.

-- 
Thanks,
Jeffle
