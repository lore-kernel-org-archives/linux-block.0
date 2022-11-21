Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93267C4332F
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 11:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiKUL6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiKUL6J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 06:58:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166ABCC5
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 03:58:01 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NG5QQ5c87zqSYr;
        Mon, 21 Nov 2022 19:54:06 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:58:00 +0800
Received: from [10.174.177.133] (10.174.177.133) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:57:59 +0800
Subject: Re: [PATCH] drbd: destroy workqueue when drbd device was freed
To:     =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
CC:     <liwei391@huawei.com>, <linux-block@vger.kernel.org>,
        <drbd-dev@lists.linbit.com>, <axboe@kernel.dk>
References: <20221121111138.3665586-1-bobo.shaobowang@huawei.com>
 <3603e71c-cd9d-fd27-7c52-1eed263e8717@linbit.com>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <ff347eb2-d36a-480c-8de7-cb01a2ee35e0@huawei.com>
Date:   Mon, 21 Nov 2022 19:57:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <3603e71c-cd9d-fd27-7c52-1eed263e8717@linbit.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.133]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


在 2022/11/21 19:51, Christoph Böhmwalder 写道:
> Am 21.11.22 um 12:11 schrieb Wang ShaoBo:
>> A submitter workqueue is dynamically allocated by init_submitter()
>> called by drbd_create_device(), we should destroy it when this
>> device was not needed or destroyed.
>>
>> Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>> ---
>>   drivers/block/drbd/drbd_main.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
>> index 8532b839a343..467c498e3add 100644
>> --- a/drivers/block/drbd/drbd_main.c
>> +++ b/drivers/block/drbd/drbd_main.c
>> @@ -2218,6 +2218,9 @@ void drbd_destroy_device(struct kref *kref)
>>   		kfree(peer_device);
>>   	}
>>   	memset(device, 0xfd, sizeof(*device));
>> +
>> +	if (device->submit.wq)
>> +		destroy_workqueue(device->submit.wq);
>>   	kfree(device);
>>   	kref_put(&resource->kref, drbd_destroy_resource);
>>   }
>> @@ -2810,6 +2813,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>>   	put_disk(disk);
>>   out_no_disk:
>>   	kref_put(&resource->kref, drbd_destroy_resource);
>> +	if (device->submit.wq)
>> +		destroy_workqueue(device->submit.wq);
>>   	kfree(device);
>>   	return err;
>>   }
> Thanks for the patch.
>
> Unfortunately, (at least) the first hunk is buggy: we memset() the
> device to all 0xfd, and try to access it immediately afterwards.
>
> This obviously leads to invalid memory access.

Hi Christoph,

I found that error, so I have sent a RESEND version, i would be appreciated

if you could help check my patch.^-^

-- Wang ShaoBo

>
