Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54BDC433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 03:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKVDIG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 22:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiKVDIE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 22:08:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66076DEB5
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 19:08:02 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NGThM1QzHzmWJn;
        Tue, 22 Nov 2022 11:07:31 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 11:08:00 +0800
Received: from [10.174.177.133] (10.174.177.133) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 11:08:00 +0800
Subject: Re: [RESEND PATCH] drbd: destroy workqueue when drbd device was freed
To:     Jens Axboe <axboe@kernel.dk>
CC:     <liwei391@huawei.com>, <linux-block@vger.kernel.org>,
        <drbd-dev@lists.linbit.com>, <christoph.boehmwalder@linbit.com>
References: <20221121115047.3828385-1-bobo.shaobowang@huawei.com>
 <c0e639ea-caa0-f76c-c369-0d22a49047ca@kernel.dk>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <5b3ff507-7cc7-cb9d-1c9c-f497cb19cafb@huawei.com>
Date:   Tue, 22 Nov 2022 11:08:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c0e639ea-caa0-f76c-c369-0d22a49047ca@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.133]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


在 2022/11/21 22:30, Jens Axboe 写道:
> On 11/21/22 4:50 AM, Wang ShaoBo wrote:
>> A submitter workqueue is dynamically allocated by init_submitter()
>> called by drbd_create_device(), we should destroy it when this
>> device is not needed or destroyed.
>>
>> Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>> ---
>>
>> Changes in RESEND:
>>    put destroy_workqueue() before memset(device, ...)
>>
>>   drivers/block/drbd/drbd_main.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
>> index 8532b839a343..082bc34cd317 100644
>> --- a/drivers/block/drbd/drbd_main.c
>> +++ b/drivers/block/drbd/drbd_main.c
>> @@ -2217,7 +2217,12 @@ void drbd_destroy_device(struct kref *kref)
>>   		kref_put(&peer_device->connection->kref, drbd_destroy_connection);
>>   		kfree(peer_device);
>>   	}
>> +
>> +	if (device->submit.wq)
>> +		destroy_workqueue(device->submit.wq);
>> +
>>   	memset(device, 0xfd, sizeof(*device));
>> +
>>   	kfree(device);
> Maybe you can send a separate patch killing that very odd (and useless)
> memset as well?

I have sent v2 version adding a new patch for killing that memset.^-^

-- Wang ShaoBo

