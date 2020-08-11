Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B975C433DF
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 02:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BED206DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 02:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgHKCAf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:00:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbgHKCAf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Aug 2020 22:00:35 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6D602DF9CC4D2F69D0CD;
        Tue, 11 Aug 2020 10:00:32 +0800 (CST)
Received: from [10.174.179.185] (10.174.179.185) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 11 Aug 2020 10:00:30 +0800
Subject: Re: [PATCH] blkcg: fix memleak for iolatency
From:   Yufen Yu <yuyufen@huawei.com>
To:     <jbacik@fb.com>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
References: <20200811015744.1823282-1-yuyufen@huawei.com>
Message-ID: <b296f6f2-3167-c562-fd42-bce6d9b609f4@huawei.com>
Date:   Tue, 11 Aug 2020 10:00:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200811015744.1823282-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.185]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ignore this. There is an obvious mistake. I will resend v2.

Thanks,
Yufen

On 2020/8/11 9:57, Yufen Yu wrote:
> Normally, blkcg_iolatency_exit() will free related memory in iolatency
> when cleanup queue. But if blk_throtl_init() return error and queue init
> fail, blkcg_iolatency_exit() will not do that for us. Then it cause
> memory leak.
> 
> Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>   block/blk-cgroup.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 619a79b51068..6f91b2ae0b27 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1152,15 +1152,17 @@ int blkcg_init_queue(struct request_queue *q)
>   	if (preloaded)
>   		radix_tree_preload_end();
>   
> -	ret = blk_iolatency_init(q);
> -	if (ret)
> -		goto err_destroy_all;
> -
>   	ret = blk_throtl_init(q);
>   	if (ret)
>   		goto err_destroy_all;
>   	return 0;
>   
> +	ret = blk_iolatency_init(q);
> +	if (ret) {
> +		blk_throtl_exit(q);
> +		goto err_destroy_all;
> +	}
> +
>   err_destroy_all:
>   	blkg_destroy_all(q);
>   	return ret;
> 
