Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA6AC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 01:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3007264E8D
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 01:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhBBBhl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:37:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11657 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBBBhk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 20:37:40 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DV6p26rrnz162xB;
        Tue,  2 Feb 2021 09:35:38 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 09:36:54 +0800
Subject: Re: [PATCH v2] nbd: Fix NULL pointer in flush_workqueue
To:     Markus Elfring <Markus.Elfring@web.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <nbd@other.debian.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20210201081918.558905-1-sunke32@huawei.com>
 <ebe7beb2-336d-35d4-48af-8f8cad7b868b@web.de>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <68668f92-b605-3abf-9e9a-cddf6444f478@huawei.com>
Date:   Tue, 2 Feb 2021 09:36:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ebe7beb2-336d-35d4-48af-8f8cad7b868b@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi，Markus

在 2021/2/2 3:05, Markus Elfring 写道:
> …
>> +++ b/drivers/block/nbd.c
>> @@ -2011,12 +2011,14 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>>   		       index);
>>   		return -EINVAL;
>>   	}
>> +	mutex_lock(&nbd->config_lock);
>>   	if (!refcount_inc_not_zero(&nbd->refs)) {
>> -		mutex_unlock(&nbd_index_mutex);
>> -		printk(KERN_ERR "nbd: device at index %d is going down\n",
>> -		       index);
>> -		return -EINVAL;
>> +		goto unlock;
>>   	}
>> +	if (!nbd->recv_workq) {
>> +		goto unlock;
>> +	}
> How do you think about to use the following patch variant
> (so that unwanted curly brackets would be avoided for proposed single statements
> in two if branches)?
>
> +	mutex_lock(&nbd->config_lock);
> -	if (!refcount_inc_not_zero(&nbd->refs)) {
> +	if (!refcount_inc_not_zero(&nbd->refs) || !nbd->recv_workq) {
> +		mutex_unlock(&nbd->config_lock);
>   		mutex_unlock(&nbd_index_mutex);
>   		printk(KERN_ERR "nbd: device at index %d is going down\n",tter
>   		       index);
>   		return -EINVAL;
>   	}
It looks better,  thanks for your suggestion.
>
> By the way:
> Would you like to replace the following two statements by the statement
> “goto put_nbd;” in another update step for this function implementation?
>
> 		nbd_put(nbd);
> 		return 0;
Sure, I will do it.
>
> Regards,
> Markus

Thanks,

Sun Ke

> .
