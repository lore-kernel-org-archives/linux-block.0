Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D60C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 08:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiBNIaE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:30:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiBNIaD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 03:30:03 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018F925C61
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 00:29:55 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jxy4D5pH9z8wd3;
        Mon, 14 Feb 2022 16:26:36 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 16:29:53 +0800
Subject: Re: [PATCH] dm: make sure dm_table is binded before queue request
To:     <dm-devel@redhat.com>
CC:     <linux-block@vger.kernel.org>, <agk@redhat.com>,
        <snitzer@redhat.com>, <axboe@kernel.dk>, <yukuai3@huawei.com>
References: <20220209093751.2986716-1-yi.zhang@huawei.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <0410123a-5da5-073a-fa08-f0038870b464@huawei.com>
Date:   Mon, 14 Feb 2022 16:29:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220209093751.2986716-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Friendly ping.

On 2022/2/9 17:37, Zhang Yi wrote:
> We found a NULL pointer dereference problem when using dm-mpath target.
> The problem is if we submit IO between loading and binding the table,
> we could neither get a valid dm_target nor a valid dm table when
> submitting request in dm_mq_queue_rq(). BIO based dm target could
> handle this case in dm_submit_bio(). This patch fix this by checking
> the mapping table before submitting request.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  drivers/md/dm-rq.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index 579ab6183d4d..af2cf71519e9 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -499,8 +499,15 @@ static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	if (unlikely(!ti)) {
>  		int srcu_idx;
> -		struct dm_table *map = dm_get_live_table(md, &srcu_idx);
> -
> +		struct dm_table *map;
> +
> +		map = dm_get_live_table(md, &srcu_idx);
> +		if (!map) {
> +			DMERR_LIMIT("%s: mapping table unavailable, erroring io",
> +				    dm_device_name(md));
> +			dm_put_live_table(md, srcu_idx);
> +			return BLK_STS_IOERR;
> +		}
>  		ti = dm_table_find_target(map, 0);
>  		dm_put_live_table(md, srcu_idx);
>  	}
> 
