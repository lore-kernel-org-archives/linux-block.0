Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D480C35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 04:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FB620838
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 04:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBKENA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 23:13:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727728AbgBKENA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 23:13:00 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0053940FAABA12F48003;
        Tue, 11 Feb 2020 12:12:54 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.66) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Feb 2020
 12:12:49 +0800
Subject: Re: [v3] nbd: fix potential NULL pointer fault in nbd_genl_disconnect
To:     Mike Christie <mchristi@redhat.com>, <josef@toxicpanda.com>,
        <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
References: <20200210073241.41813-1-sunke32@huawei.com>
 <5E418D62.8090102@redhat.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <c3531fc5-73b3-6ef4-816e-97f491f45c18@huawei.com>
Date:   Tue, 11 Feb 2020 12:12:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5E418D62.8090102@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2020/2/11 1:05, Mike Christie 写道:
> On 02/10/2020 01:32 AM, Sun Ke wrote:
>> Open /dev/nbdX first, the config_refs will be 1 and
>> the pointers in nbd_device are still null. Disconnect
>> /dev/nbdX, then reference a null recv_workq. The
>> protection by config_refs in nbd_genl_disconnect is useless.
>>
>> To fix it, just add a check for a non null task_recv in
>> nbd_genl_disconnect.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>> v1 -> v2:
>> Add an omitted mutex_unlock.
>>
>> v2 -> v3:
>> Add nbd->config_lock, suggested by Josef.
>> ---
>>   drivers/block/nbd.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index b4607dd96185..870b3fd0c101 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -2008,12 +2008,20 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>>   		       index);
>>   		return -EINVAL;
>>   	}
>> +	mutex_lock(&nbd->config_lock);
>>   	if (!refcount_inc_not_zero(&nbd->refs)) {
>> +		mutex_unlock(&nbd->config_lock);
>>   		mutex_unlock(&nbd_index_mutex);
>>   		printk(KERN_ERR "nbd: device at index %d is going down\n",
>>   		       index);
>>   		return -EINVAL;
>>   	}
>> +	if (!nbd->recv_workq) {
>> +		mutex_unlock(&nbd->config_lock);
>> +		mutex_unlock(&nbd_index_mutex);
>> +		return -EINVAL;
>> +	}
>> +	mutex_unlock(&nbd->config_lock);
>>   	mutex_unlock(&nbd_index_mutex);
>>   	if (!refcount_inc_not_zero(&nbd->config_refs)) {
>>   		nbd_put(nbd);
>>
> 
> With my other patch then we will not need this right? It handles your
> case by just being integrated with the existing checks in:
> 
> nbd_disconnect_and_put->nbd_clear_sock->sock_shutdown
> 
> ...
> 
> static void sock_shutdown(struct nbd_device *nbd)
> {
> 
> ....
> 
>          if (config->num_connections == 0)
>                  return;
> 
> 
> num_connections is zero for your case since we never did a
> nbd_genl_disconnect so we would return here.
> 
> 
> .
> 
Hi Mike

Your point is not right totally.

Yes, config->num_connections is 0 and will return in sock_shutdown. Then 
it will back to nbd_disconnect_and_put and do flush_workqueue 
(nbd->recv_workq).

nbd_disconnect_and_put
	->nbd_clear_sock
		->sock_shutdown
	->flush_workqueue

Thanks,
Sun Ke

