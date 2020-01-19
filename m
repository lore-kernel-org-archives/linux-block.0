Return-Path: <SRS0=3pRW=3I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF06AC33CB1
	for <linux-block@archiver.kernel.org>; Sun, 19 Jan 2020 07:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE591205F4
	for <linux-block@archiver.kernel.org>; Sun, 19 Jan 2020 07:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgASHKu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jan 2020 02:10:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46534 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbgASHKt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jan 2020 02:10:49 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 98AB3E170DCDEDF383EB;
        Sun, 19 Jan 2020 15:10:47 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.66) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 15:10:44 +0800
Subject: Re: [PATCH] nbd: fix potential NULL pointer fault in connect and
 disconnect process
To:     Mike Christie <mchristi@redhat.com>, <josef@toxicpanda.com>,
        <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>
References: <20200117115005.37006-1-sunke32@huawei.com>
 <5E21EF96.1010204@redhat.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <c15baa64-ef8d-970f-f4e0-ecd10cc0b0a0@huawei.com>
Date:   Sun, 19 Jan 2020 15:10:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5E21EF96.1010204@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Thanks for your detailed suggestions.

在 2020/1/18 1:32, Mike Christie 写道:
> On 01/17/2020 05:50 AM, Sun Ke wrote:
>> Connect and disconnect a nbd device repeatedly, will cause
>> NULL pointer fault.
>>
>> It will appear by the steps:
>> 1. Connect the nbd device and disconnect it, but now nbd device
>>     is not disconnected totally.
>> 2. Connect the same nbd device again immediately, it will fail
>>     in nbd_start_device with a EBUSY return value.
>> 3. Wait a second to make sure the last config_refs is reduced
>>     and run nbd_config_put to disconnect the nbd device totally.
>> 4. Start another process to open the nbd_device, config_refs
>>     will increase and at the same time disconnect it.
> 
> Just to make sure I understood this, for step 4 the process is doing:
> 
> open(/dev/nbdX);
> ioctl(NBD_DISCONNECT, /dev/nbdX) or nbd_genl_disconnect(for /dev/nbdX)
> 
> ?
> 
do nbd_genl_disconnect(for /dev/nbdX)；
I tested it. Connect /dev/nbdX
through ioctl interface by nbd-client -L -N export localhost /dev/nbdX and
through netlink interface by nbd-client localhost XXXX /dev/nbdX,
disconnect /dev/nbdX by nbd-client -d /dev/nbdX.
Both call nbd_genl_disconnect(for /dev/nbdX) and both contain the same 
null pointer dereference.
> There is no successful NBD_DO_IT / nbd_genl_connect between the open and
> disconnect calls at step #4, because it would normally be done at #2 and
> that failed. nbd_disconnect_and_put could then reference a null
> recv_workq. If we are also racing with a close() then that could free
> the device/config from under nbd_disconnect_and_put.
> 
Yes, nbd_disconnect_and_put could then reference a null recv_workq.
>>
>> To fix it, add a NBD_HAS_STARTED flag. Set it in nbd_start_device_ioctl
> 
> I'm not sure if we need the new bit. We could just add a check for a non
> null task_recv in nbd_genl_disconnect like how nbd_start_device and
> nbd_genl_disconnect do.
> 
I am also not very sure which is better.
because in nbd_config_put, not only recv_workq is null,
nbd->task_recv and nbd->config the same.
so I doubt that if step 4 do something else will also reference a null 
pointer.
> The new bit might be more clear which is nice. If we got this route,
> should the new bit be a runtime_flag like other device state bits?
> 
> 
Yes, I realize it. Just add a check for a non null task_recv in 
nbd_genl_disconnect is better, right?
>> and nbd_genl_connect if nbd device is started successfully.
>> Clear it in nbd_config_put. Test it in nbd_genl_disconnect and
>> nbd_genl_reconfigure.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   drivers/block/nbd.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index b4607dd96185..ddd364e208ab 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -83,6 +83,7 @@ struct link_dead_args {
>>   
>>   #define NBD_DESTROY_ON_DISCONNECT	0
>>   #define NBD_DISCONNECT_REQUESTED	1
>> +#define NBD_HAS_STARTED				2
>>   
>>   struct nbd_config {
>>   	u32 flags;
>> @@ -1215,6 +1216,7 @@ static void nbd_config_put(struct nbd_device *nbd)
>>   		nbd->disk->queue->limits.discard_alignment = 0;
>>   		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
>>   		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, nbd->disk->queue);
>> +		clear_bit(NBD_HAS_STARTED, &nbd->flags);
>>   
>>   		mutex_unlock(&nbd->config_lock);
>>   		nbd_put(nbd);
>> @@ -1290,6 +1292,8 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
>>   	ret = nbd_start_device(nbd);
>>   	if (ret)
>>   		return ret;
>> +	else
>> +		set_bit(NBD_HAS_STARTED, &nbd->flags);
>>   
>>   	if (max_part)
>>   		bdev->bd_invalidated = 1;
>> @@ -1961,6 +1965,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>>   	mutex_unlock(&nbd->config_lock);
>>   	if (!ret) {
>>   		set_bit(NBD_RT_HAS_CONFIG_REF, &config->runtime_flags);
>> +		set_bit(NBD_HAS_STARTED, &nbd->flags);
>>   		refcount_inc(&nbd->config_refs);
>>   		nbd_connect_reply(info, nbd->index);
>>   	}
>> @@ -2008,6 +2013,14 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>>   		       index);
>>   		return -EINVAL;
>>   	}
>> +
>> +	if (!test_bit(NBD_HAS_STARTED, &nbd->flags)) {
>> +		mutex_unlock(&nbd_index_mutex);
>> +		printk(KERN_ERR "nbd: device at index %d failed to start\n",
>> +		       index);
>> +		return -EBUSY;
>> +	}
>> +
>>   	if (!refcount_inc_not_zero(&nbd->refs)) {
>>   		mutex_unlock(&nbd_index_mutex);
>>   		printk(KERN_ERR "nbd: device at index %d is going down\n",
>> @@ -2049,6 +2062,14 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>>   		       index);
>>   		return -EINVAL;
>>   	}
>> +
>> +	if (!test_bit(NBD_HAS_STARTED, &nbd->flags)) {
>> +		mutex_unlock(&nbd_index_mutex);
>> +		printk(KERN_ERR "nbd: device at index %d failed to start\n",
>> +		       index);
>> +		return -EBUSY;
>> +	}
>> +
>>   	if (!refcount_inc_not_zero(&nbd->refs)) {
>>   		mutex_unlock(&nbd_index_mutex);
>>   		printk(KERN_ERR "nbd: device at index %d is going down\n",
>>
I thought the changes in nbd_genl_reconfigure is necessary althought my 
test do not call it. but now I think it is superfluous, 
nbd_genl_reconfigure checks for a non null task_recv.

Thanks,

Ke
> 
> 
> .
> 

