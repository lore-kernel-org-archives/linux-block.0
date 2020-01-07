Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBB2C32771
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 02:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9D62072E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 02:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgAGCiT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:38:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727405AbgAGCiT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Jan 2020 21:38:19 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E7EBFD25E457392EBDF9;
        Tue,  7 Jan 2020 10:38:16 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 7 Jan 2020
 10:38:06 +0800
Subject: Re: [PATCH] blk-map: add kernel address validation in blk_rq_map_kern
 func
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <jens.axboe@oracle.com>, <namhyung@gmail.com>,
        <bharrosh@panasas.com>, renxudong <renxudong1@huawei.com>
CC:     Mingfangsen <mingfangsen@huawei.com>, <zhengbin13@huawei.com>,
        Guiyao <guiyao@huawei.com>, <ming.lei@redhat.com>
References: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
Message-ID: <6b282b91-b157-5260-57d9-774be223998c@huawei.com>
Date:   Tue, 7 Jan 2020 10:38:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Friendly ping...

On 2019/12/30 20:17, Zhiqiang Liu wrote:
> From: renxudong <renxudong1@huawei.com>
> 
> Blk_rq_map_kern func is used to map kernel data to a request,
> in which kbuf par should be a valid kernel buffer. However,
> kbuf par is only checked whether it is null in blk_rq_map_kern func.
> 
> If users pass a non kernel address to blk_rq_map_kern func in the
> non-aligned scenario, the invalid kbuf will be set to bio->bi_private.
> When the request is completed, bio_copy_kern_endio_read will be called
> to copy data to the kernel address in bio->bi_private. If the bi_private
> is not a valid kernel address, the system will oops. In this case, we
> cannot judge whether the bio structure is damaged or the kernel address is
> invalid.
> 
> Here, we add kernel address validation by calling virt_addr_valid.
> 
> Signed-off-by: renxudong <renxudong1@huawei.com>
> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  block/blk-map.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 3a62e471d81b..7deb1b44d1e3 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -229,7 +229,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
> 
>  	if (len > (queue_max_hw_sectors(q) << 9))
>  		return -EINVAL;
> -	if (!len || !kbuf)
> +	if (!len || !virt_addr_valid(kbuf))
>  		return -EINVAL;
> 
>  	do_copy = !blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf);
> 

