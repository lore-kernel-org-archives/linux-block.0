Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF07C4332F
	for <linux-block@archiver.kernel.org>; Fri, 14 Oct 2022 02:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJNCJU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 22:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJNCJT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 22:09:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8BE5ECC
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 19:09:17 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MpV7z1WsczVj6t;
        Fri, 14 Oct 2022 10:04:47 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 10:09:15 +0800
Subject: Re: [PATCH v2 2/2] nvme: use blk_mq_[un]quiesce_tagset
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <kbusch@kernel.org>, <ming.lei@redhat.com>,
        <axboe@kernel.dk>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-3-lengchao@huawei.com>
 <0b28653b-b133-ec4b-b09e-54090f374086@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <0eb9f561-fcab-f2a0-a129-0953de50f6d2@huawei.com>
Date:   Fri, 14 Oct 2022 10:09:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0b28653b-b133-ec4b-b09e-54090f374086@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/13 18:22, Sagi Grimberg wrote:
> 
> 
> On 10/13/22 12:44, Chao Leng wrote:
>> All controller namespaces share the same tagset, so we can use this
>> interface which does the optimal operation for parallel quiesce based on
>> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
>>
>> Now use NVME_NS_STOPPED to ensure pairing quiescing and unquiescing.
>> If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be invalided,
>> so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
>>
>> nvme connect_q should be never quiesced, so set QUEUE_FLAG_NOQUIESCED
>> when init connect_q.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   drivers/nvme/host/core.c | 42 +++++++++++++-----------------------------
>>   drivers/nvme/host/nvme.h |  2 +-
>>   2 files changed, 14 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 059737c1a2c1..0d07a07e02ff 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4890,6 +4890,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>>               ret = PTR_ERR(ctrl->connect_q);
>>               goto out_free_tag_set;
>>           }
>> +        blk_queue_flag_set(QUEUE_FLAG_NOQUIESCED, ctrl->connect_q);
>>       }
>>       ctrl->tagset = set;
>> @@ -5089,20 +5090,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_init_ctrl);
>> -static void nvme_start_ns_queue(struct nvme_ns *ns)
>> -{
>> -    if (test_and_clear_bit(NVME_NS_STOPPED, &ns->flags))
>> -        blk_mq_unquiesce_queue(ns->queue);
>> -}
>> -
>> -static void nvme_stop_ns_queue(struct nvme_ns *ns)
>> -{
>> -    if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
>> -        blk_mq_quiesce_queue(ns->queue);
>> -    else
>> -        blk_mq_wait_quiesce_done(ns->queue);
>> -}
>> -
>>   /*
>>    * Prepare a queue for teardown.
>>    *
>> @@ -5111,13 +5098,14 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>>    * holding bd_butex.  This will end buffered writers dirtying pages that can't
>>    * be synced.
>>    */
>> -static void nvme_set_queue_dying(struct nvme_ns *ns)
>> +static void nvme_set_queue_dying(struct nvme_ns *ns, bool start_queue)
>>   {
>>       if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
>>           return;
>>       blk_mark_disk_dead(ns->disk);
>> -    nvme_start_ns_queue(ns);
>> +    if (start_queue)
>> +        blk_mq_unquiesce_queue(ns->queue);
>>       set_capacity_and_notify(ns->disk, 0);
>>   }
>> @@ -5132,6 +5120,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>>   void nvme_kill_queues(struct nvme_ctrl *ctrl)
>>   {
>>       struct nvme_ns *ns;
>> +    bool start_queue = false;
>>       down_read(&ctrl->namespaces_rwsem);
>> @@ -5139,8 +5128,11 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>>       if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>>           nvme_start_admin_queue(ctrl);
>> +    if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>> +        start_queue = true;
> 
> Why can't we just start the queues here? just call nvme_start_queues()?
If we move the unquiesce of nvme_set_queue_dying out, this may destroys
the functional atomicity of nvme_set_queue_dying.
Of course, from the current code, It can work well.
If others don't object, I'll modify it in patch v3.
> Why does it need to happen only after we mark the disk dead?
> The documentation only says that we need to set the capacity to 0
> after we unquiesce, but it doesn't say that we can't unquiesce erliear.
> 
> Something like this:
> -- 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7e840549a940..27dc393eed97 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5127,8 +5127,6 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>                  return;
> 
>          blk_mark_disk_dead(ns->disk);
> -       nvme_start_ns_queue(ns);
> -
>          set_capacity_and_notify(ns->disk, 0);
>   }
> 
> @@ -5149,6 +5147,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>          if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>                  nvme_start_admin_queue(ctrl);
> 
> +       if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
> +               nvme_start_queues(ctrl);
> +
>          list_for_each_entry(ns, &ctrl->namespaces, list)
>                  nvme_set_queue_dying(ns);
> -- 
> 
> .
