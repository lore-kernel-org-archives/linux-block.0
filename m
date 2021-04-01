Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBA5C433B4
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 09:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5979610A5
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 09:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhDAJHN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 05:07:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14665 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbhDAJHI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Apr 2021 05:07:08 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9y116pjhznXBy;
        Thu,  1 Apr 2021 17:04:21 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.117) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 17:06:52 +0800
Subject: Re: [PATCH] brd: fix integer overflow in brd_check_and_reset_par
To:     lixiaokeng <lixiaokeng@huawei.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     linfeilong <linfeilong@huawei.com>
References: <99e9da32-9372-ada2-8197-26602fe242c8@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <ce64c4a2-e90a-97f9-6334-74912dbcb958@huawei.com>
Date:   Thu, 1 Apr 2021 17:06:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <99e9da32-9372-ada2-8197-26602fe242c8@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

friendly ping.

On 2021/3/25 19:45, lixiaokeng wrote:
> The max_part may overflow. For example,
>
> modprobe brd rd_nr=3 rd_size=102400 max_part=1073741824(2^30)
>
> Expected result
> NAME             MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
> ram0               1:0    0   100M  0 disk
> ram1               1:256  0   100M  0 disk
> ram2               1:512  0   100M  0 disk
>
> Actual result
> NAME             MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
> ram0             259:0    0   100M  0 disk
> ram1             259:1    0   100M  0 disk
> ram2             259:2    0   100M  0 disk
>
> Fix it.
>
> Signed-off-by: Lixiaokeng <lixiaokeng@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  drivers/block/brd.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index c43a6ab4b1f3..c91831cd5d2a 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -457,21 +457,19 @@ static void brd_del_one(struct brd_device *brd)
>
>  static inline void brd_check_and_reset_par(void)
>  {
> -	if (unlikely(!max_part))
> +	if (unlikely(max_part <= 0))
>  		max_part = 1;
>
>  	/*
>  	 * make sure 'max_part' can be divided exactly by (1U << MINORBITS),
>  	 * otherwise, it is possiable to get same dev_t when adding partitions.
>  	 */
> -	if ((1U << MINORBITS) % max_part != 0)
> -		max_part = 1UL << fls(max_part);
> -
>  	if (max_part > DISK_MAX_PARTS) {
>  		pr_info("brd: max_part can't be larger than %d, reset max_part = %d.\n",
>  			DISK_MAX_PARTS, DISK_MAX_PARTS);
>  		max_part = DISK_MAX_PARTS;
> -	}
> +	} else if ((1U << MINORBITS) % max_part != 0)
> +		max_part = 1UL << fls(max_part);
>  }
>
>  static int __init brd_init(void)

