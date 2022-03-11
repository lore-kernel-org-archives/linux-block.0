Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EC1C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 02:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbiCKCoU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiCKCoQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 21:44:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F1F3907;
        Thu, 10 Mar 2022 18:43:14 -0800 (PST)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KF9DC1HJPzBrKj;
        Fri, 11 Mar 2022 10:41:15 +0800 (CST)
Received: from [10.174.176.103] (10.174.176.103) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 11 Mar 2022 10:43:11 +0800
Message-ID: <0e5faf35-5adb-3ea1-9f7f-7c4f61a623b2@huawei.com>
Date:   Fri, 11 Mar 2022 10:43:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH -next] nbd: fix possible overflow on 'first_minor' in
 nbd_dev_add()
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>
References: <20220310093224.4002895-1-zhangwensheng5@huawei.com>
From:   "zhangwensheng (E)" <zhangwensheng5@huawei.com>
In-Reply-To: <20220310093224.4002895-1-zhangwensheng5@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.103]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

friendly ping...

在 2022/3/10 17:32, Zhang Wensheng 写道:
> When 'index' is a big numbers, it may become negative which forced
> to 'int'. then 'index << part_shift' might overflow to a positive
> value that is not greater than '0xfffff', then sysfs might complains
> about duplicate creation. Because of this, move the 'index' judgment
> to the front will fix it and be better.
>
> Fixes: b0d9111a2d53 ("nbd: use an idr to keep track of nbd devices")
> Fixes: 940c264984fd ("nbd: fix possible overflow for 'first_minor' in nbd_dev_add()")
> Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
> ---
>   drivers/block/nbd.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 5a1f98494ddd..b3cdfc0ffb98 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1800,17 +1800,6 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
>   	refcount_set(&nbd->refs, 0);
>   	INIT_LIST_HEAD(&nbd->list);
>   	disk->major = NBD_MAJOR;
> -
> -	/* Too big first_minor can cause duplicate creation of
> -	 * sysfs files/links, since index << part_shift might overflow, or
> -	 * MKDEV() expect that the max bits of first_minor is 20.
> -	 */
> -	disk->first_minor = index << part_shift;
> -	if (disk->first_minor < index || disk->first_minor > MINORMASK) {
> -		err = -EINVAL;
> -		goto out_free_work;
> -	}
> -
>   	disk->minors = 1 << part_shift;
>   	disk->fops = &nbd_fops;
>   	disk->private_data = nbd;
> @@ -1915,8 +1904,19 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>   	if (!netlink_capable(skb, CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> -	if (info->attrs[NBD_ATTR_INDEX])
> +	if (info->attrs[NBD_ATTR_INDEX]) {
>   		index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
> +
> +		/*
> +		 * Too big first_minor can cause duplicate creation of
> +		 * sysfs files/links, since index << part_shift might overflow, or
> +		 * MKDEV() expect that the max bits of first_minor is 20.
> +		 */
> +		if (index < 0 || index > MINORMASK >> part_shift) {
> +			printk(KERN_ERR "nbd: illegal input index %d\n", index);
> +			return -EINVAL;
> +		}
> +	}
>   	if (!info->attrs[NBD_ATTR_SOCKETS]) {
>   		printk(KERN_ERR "nbd: must specify at least one socket\n");
>   		return -EINVAL;
