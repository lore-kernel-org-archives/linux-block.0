Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482ECC433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Feb 2022 12:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiBWMfF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiBWMfE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Feb 2022 07:35:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB528AE46
        for <linux-block@vger.kernel.org>; Wed, 23 Feb 2022 04:34:36 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K3b696cgkz9svL;
        Wed, 23 Feb 2022 20:32:49 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 20:34:33 +0800
Subject: Re: dm: make sure dm_table is binded before queue request
To:     Mike Snitzer <snitzer@redhat.com>
CC:     <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <agk@redhat.com>, <axboe@kernel.dk>, <yukuai3@huawei.com>
References: <20220209093751.2986716-1-yi.zhang@huawei.com>
 <YhUrH7UfBN3Uw5HP@redhat.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <dc2af2ca-5e4c-d149-46fc-ae82dd56a121@huawei.com>
Date:   Wed, 23 Feb 2022 20:34:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YhUrH7UfBN3Uw5HP@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/2/23 2:27, Mike Snitzer wrote:
> On Wed, Feb 09 2022 at  4:37P -0500,
> Zhang Yi <yi.zhang@huawei.com> wrote:
> 
>> We found a NULL pointer dereference problem when using dm-mpath target.
>> The problem is if we submit IO between loading and binding the table,
>> we could neither get a valid dm_target nor a valid dm table when
>> submitting request in dm_mq_queue_rq(). BIO based dm target could
>> handle this case in dm_submit_bio(). This patch fix this by checking
>> the mapping table before submitting request.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  drivers/md/dm-rq.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
>> index 579ab6183d4d..af2cf71519e9 100644
>> --- a/drivers/md/dm-rq.c
>> +++ b/drivers/md/dm-rq.c
>> @@ -499,8 +499,15 @@ static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  
>>  	if (unlikely(!ti)) {
>>  		int srcu_idx;
>> -		struct dm_table *map = dm_get_live_table(md, &srcu_idx);
>> -
>> +		struct dm_table *map;
>> +
>> +		map = dm_get_live_table(md, &srcu_idx);
>> +		if (!map) {
>> +			DMERR_LIMIT("%s: mapping table unavailable, erroring io",
>> +				    dm_device_name(md));
>> +			dm_put_live_table(md, srcu_idx);
>> +			return BLK_STS_IOERR;
>> +		}
>>  		ti = dm_table_find_target(map, 0);
>>  		dm_put_live_table(md, srcu_idx);
>>  	}
>> -- 
>> 2.31.1
>>
> 
> I think both dm_submit_bio() and now dm_mq_queue_rq() should _not_
> error the IO.  This is such a narrow race during device setup that it
> best to requeue the IO.
> 

Yes，make sense, thanks for the fix.

Thanks,
Yi.

> I'll queue this for 5.18:
> 
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index 6948d5db9092..3dd040a56318 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -491,8 +491,13 @@ static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	if (unlikely(!ti)) {
>  		int srcu_idx;
> -		struct dm_table *map = dm_get_live_table(md, &srcu_idx);
> +		struct dm_table *map;
>  
> +		map = dm_get_live_table(md, &srcu_idx);
> +		if (unlikely(!map)) {
> +			dm_put_live_table(md, srcu_idx);
> +			return BLK_STS_RESOURCE;
> +		}
>  		ti = dm_table_find_target(map, 0);
>  		dm_put_live_table(md, srcu_idx);
>  	}
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 082366d0ad49..c70be6e5ed55 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1533,15 +1533,10 @@ static void dm_submit_bio(struct bio *bio)
>  	struct dm_table *map;
>  
>  	map = dm_get_live_table(md, &srcu_idx);
> -	if (unlikely(!map)) {
> -		DMERR_LIMIT("%s: mapping table unavailable, erroring io",
> -			    dm_device_name(md));
> -		bio_io_error(bio);
> -		goto out;
> -	}
>  
> -	/* If suspended, queue this IO for later */
> -	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
> +	/* If suspended, or map not yet available, queue this IO for later */
> +	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags)) ||
> +	    unlikely(!map)) {
>  		if (bio->bi_opf & REQ_NOWAIT)
>  			bio_wouldblock_error(bio);
>  		else if (bio->bi_opf & REQ_RAHEAD)
> 
> .
> 
