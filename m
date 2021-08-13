Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA010C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 14:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865B360F00
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 14:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhHMOrh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbhHMOrg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 10:47:36 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB95C061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 07:47:10 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 14so11009257qkc.4
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pJUAeuT5dql7SLbNjaubRSET7ltdy9O4i1dg9BO//tA=;
        b=JDv5ki/1sxSbU7ZwM+tiXT7s1oV87pX6XrIMJSlTG+75fdgGHGabiZ07E6zUPxRqtB
         dZa1kAOLhm5YCgXxrowEg6P+LxAYZ6k2/VRq7x1ykS23q9WbM7JQ9ZpMMNzKSNJzrHDF
         EPQ8yhmBsgOhVQz+pMUvOyiS6oB26CYN/tczi36HxDhFks4/gjQf/auDWf8yXwqA78jv
         qupzqjLpiw8Si4hb1dvvGIGIS/I+cCRU0Tt9xNUrH9lxAjoEtZNmvGh189pmMO3yXEVz
         7Mlhs9wmQG8BDUZ8Xk8JSybsJhXgYSxRM3Hze2kXHDBpxiP+RzMRhmXqO00VC/AcKJqg
         5a8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pJUAeuT5dql7SLbNjaubRSET7ltdy9O4i1dg9BO//tA=;
        b=pJA7RrY1EskHr+19Nfsc8nliug5rN/TV8cqJowPMZlcl5mhytbAq0+8j9vM80HXyzN
         zrgo6HBOzbJJgF/2ZBBBq3GbLRyMv9jHwQJ+lzjqRyy2yEfRUYX8U2FOH3AHcD4lifzr
         4JPP3bI442A0V+BO3dIfODB9y/2ybEDGVh4ZXd1UrDDZ5Q8bhbcaMvK+Iqx/C727e66F
         cisZhCnSdowujxmxzaDULg+Ln4qQ9hyCq3MmxAaqG/wtNW+ZsnxTswZcp78ew3ygj559
         lnKm2JayoHUBSHWB8ZwIb433IUjzIaYmMGKpJlPsog1fwBM4Xi9AmaMNx8ADF7bN7nzO
         DxEg==
X-Gm-Message-State: AOAM533VVuQXzdRIZmI8G19n6qcvvU/jr0Lb5+WQtqSt0Oy6uhc/q94R
        j8btc27mqiW2klw6p7vJvbz5gtp3Qw3heA==
X-Google-Smtp-Source: ABdhPJx5kN1RkqRHoEePn16yTxBHjudVhJVbO3/Q43sdjV0l6jLJKyNapALDMeOF3R3TaVv0AQMIKw==
X-Received: by 2002:a05:620a:13c8:: with SMTP id g8mr2511824qkl.258.1628866029169;
        Fri, 13 Aug 2021 07:47:09 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j18sm981673qke.75.2021.08.13.07.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 07:47:08 -0700 (PDT)
Subject: Re: [PATCH 6/6] nbd: reduce the nbd_index_mutex scope
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Tao <houtao1@huawei.com>
References: <20210811124428.2368491-1-hch@lst.de>
 <20210811124428.2368491-7-hch@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <be56a424-7599-77f5-3f57-1f4609b3a0e6@toxicpanda.com>
Date:   Fri, 13 Aug 2021 10:47:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210811124428.2368491-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/21 8:44 AM, Christoph Hellwig wrote:
> nbd_index_mutex is currently held over add_disk and inside ->open, which
> leads to lock order reversals.  Refactor the device creation code path
> so that nbd_dev_add is called without nbd_index_mutex lock held and
> only takes it for the IDR insertation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/nbd.c | 55 +++++++++++++++++++++++----------------------
>   1 file changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 0b46a608f879..4054cc33fc1e 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1681,7 +1681,7 @@ static const struct blk_mq_ops nbd_mq_ops = {
>   	.timeout	= nbd_xmit_timeout,
>   };
>   
> -static struct nbd_device *nbd_dev_add(int index)
> +static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
>   {
>   	struct nbd_device *nbd;
>   	struct gendisk *disk;
> @@ -1707,6 +1707,7 @@ static struct nbd_device *nbd_dev_add(int index)
>   	if (err)
>   		goto out_free_nbd;
>   
> +	mutex_lock(&nbd_index_mutex);
>   	if (index >= 0) {
>   		err = idr_alloc(&nbd_index_idr, nbd, index, index + 1,
>   				GFP_KERNEL);
> @@ -1717,6 +1718,7 @@ static struct nbd_device *nbd_dev_add(int index)
>   		if (err >= 0)
>   			index = err;
>   	}
> +	mutex_unlock(&nbd_index_mutex);
>   	if (err < 0)
>   		goto out_free_tags;
>   	nbd->index = index;
> @@ -1743,7 +1745,7 @@ static struct nbd_device *nbd_dev_add(int index)
>   
>   	mutex_init(&nbd->config_lock);
>   	refcount_set(&nbd->config_refs, 0);
> -	refcount_set(&nbd->refs, 1);
> +	refcount_set(&nbd->refs, refs);
>   	INIT_LIST_HEAD(&nbd->list);
>   	disk->major = NBD_MAJOR;
>   	disk->first_minor = index << part_shift;
> @@ -1847,34 +1849,35 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>   		nbd = idr_find(&nbd_index_idr, index);
>   	}
>   
> -	if (!nbd) {
> -		nbd = nbd_dev_add(index);
> -		if (IS_ERR(nbd)) {
> +	if (nbd) {
> +		if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
> +		    test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) {
> +			nbd->destroy_complete = &destroy_complete;
>   			mutex_unlock(&nbd_index_mutex);
> -			pr_err("nbd: failed to add new device\n");
> -			return PTR_ERR(nbd);
> +
> +			/* wait until the nbd device is completely destroyed */
> +			wait_for_completion(&destroy_complete);
> +			goto again;
>   		}
> -	}
>   
> -	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
> -	    test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) {
> -		nbd->destroy_complete = &destroy_complete;
> +		if (!refcount_inc_not_zero(&nbd->refs)) {
> +			mutex_unlock(&nbd_index_mutex);
> +			if (index == -1)
> +				goto again;
> +			pr_err("nbd: device at index %d is going down\n",
> +		       		index);

Errant whitespace here.  Thanks,

Josef
