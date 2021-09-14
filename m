Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D911BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 09:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5ACC61157
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 09:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhINJNx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:13:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9038 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhINJNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 05:13:43 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7yJY4Y9NzVgQ5;
        Tue, 14 Sep 2021 17:11:25 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 17:12:25 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 14 Sep 2021 17:12:24 +0800
Subject: Re: [PATCH v5 5/6] nbd: convert to use blk_mq_find_and_get_req()
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yi.zhang@huawei.com>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-6-yukuai3@huawei.com> <YT/2z4PSeW5oJWMq@T590>
 <c6af73a2-f12d-eeef-616e-ae0cdb4f6f2d@huawei.com> <YUBE4BJ7+kN1c4l8@T590>
 <374c6b37-b4b2-fe01-66be-ca2dbbc283e9@huawei.com> <YUBTVBioqJ7qas2R@T590>
 <39e628cc-496c-ba20-b53a-fbeecc1d7e4e@huawei.com>
Message-ID: <bd8d29eb-e9ba-a356-b972-18b7406f75bd@huawei.com>
Date:   Tue, 14 Sep 2021 17:12:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <39e628cc-496c-ba20-b53a-fbeecc1d7e4e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/14 17:08, yukuai (C) wrote:
> On 2021/09/14 15:46, Ming Lei wrote:
>> On Tue, Sep 14, 2021 at 03:13:38PM +0800, yukuai (C) wrote:
>>> On 2021/09/14 14:44, Ming Lei wrote:
>>>> On Tue, Sep 14, 2021 at 11:11:06AM +0800, yukuai (C) wrote:
>>>>> On 2021/09/14 9:11, Ming Lei wrote:
>>>>>> On Thu, Sep 09, 2021 at 10:12:55PM +0800, Yu Kuai wrote:
>>>>>>> blk_mq_tag_to_rq() can only ensure to return valid request in
>>>>>>> following situation:
>>>>>>>
>>>>>>> 1) client send request message to server first
>>>>>>> submit_bio
>>>>>>> ...
>>>>>>>     blk_mq_get_tag
>>>>>>>     ...
>>>>>>>     blk_mq_get_driver_tag
>>>>>>>     ...
>>>>>>>     nbd_queue_rq
>>>>>>>      nbd_handle_cmd
>>>>>>>       nbd_send_cmd
>>>>>>>
>>>>>>> 2) client receive respond message from server
>>>>>>> recv_work
>>>>>>>     nbd_read_stat
>>>>>>>      blk_mq_tag_to_rq
>>>>>>>
>>>>>>> If step 1) is missing, blk_mq_tag_to_rq() will return a stale
>>>>>>> request, which might be freed. Thus convert to use
>>>>>>> blk_mq_find_and_get_req() to make sure the returned request is not
>>>>>>> freed.
>>>>>>
>>>>>> But NBD_CMD_INFLIGHT has been added for checking if the reply is
>>>>>> expected, do we still need blk_mq_find_and_get_req() for covering
>>>>>> this issue? BTW, request and its payload is pre-allocated, so there
>>>>>> isn't real use-after-free.
>>>>>
>>>>> Hi, Ming
>>>>>
>>>>> Checking NBD_CMD_INFLIGHT relied on the request founded by tag is 
>>>>> valid,
>>>>> not the other way round.
>>>>>
>>>>> nbd_read_stat
>>>>>    req = blk_mq_tag_to_rq()
>>>>>    cmd = blk_mq_rq_to_pdu(req)
>>>>>    mutex_lock(cmd->lock)
>>>>>    checking NBD_CMD_INFLIGHT
>>>>
>>>> Request and its payload is pre-allocated, and either req->ref or 
>>>> cmd->lock can
>>>> serve the same purpose here. Once cmd->lock is held, you can check 
>>>> if the cmd is
>>>> inflight or not. If it isn't inflight, just return -ENOENT. Is there 
>>>> any
>>>> problem to handle in this way?
>>>
>>> Hi, Ming
>>>
>>> in nbd_read_stat:
>>>
>>> 1) get a request by tag first
>>> 2) get nbd_cmd by the request
>>> 3) hold cmd->lock and check if cmd is inflight
>>>
>>> If we want to check if the cmd is inflight in step 3), we have to do
>>> setp 1) and 2) first. As I explained in patch 0, blk_mq_tag_to_rq()
>>> can't make sure the returned request is not freed:
>>>
>>> nbd_read_stat
>>>             blk_mq_sched_free_requests
>>>              blk_mq_free_rqs
>>>    blk_mq_tag_to_rq
>>>    -> get rq before clear mapping
>>>               blk_mq_clear_rq_mapping
>>>               __free_pages -> rq is freed
>>>    blk_mq_request_started -> UAF
>>
>> If the above can happen, blk_mq_find_and_get_req() may not fix it too, 
>> just
> 
> Hi, Ming
> 
> Why can't blk_mq_find_and_get_req() fix it? I can't think of any
> scenario that might have problem currently.
> 
>> wondering why not take the following simpler way for avoiding the UAF?
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 5170a630778d..dfa5cce71f66 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -795,9 +795,13 @@ static void recv_work(struct work_struct *work)
>>                                work);
>>       struct nbd_device *nbd = args->nbd;
>>       struct nbd_config *config = nbd->config;
>> +    struct request_queue *q = nbd->disk->queue;
>>       struct nbd_cmd *cmd;
>>       struct request *rq;
>> +    if (!percpu_ref_tryget(&q->q_usage_counter))
>> +                return;
>> +
> 
> We can't make sure freeze_queue is called before this, thus this approch
> can't fix the problem, right?
>   nbd_read_stat
>      blk_mq_tag_to_rq
>              elevator_switch
>               blk_mq_freeze_queue(q);
>               elevator_switch_mq
>                elevator_exit
>                 blk_mq_sched_free_requests
>      blk_mq_request_started -> UAF

Hi, Ming

I forgot that if percpu_ref_tryget succeed here, blk_mq_free_queue()
will block untill blk_queue_exit() in nbd_read_stat().

Thanks,
Kuai
> 
> Thanks,
> Kuai
> 
>>       while (1) {
>>           cmd = nbd_read_stat(nbd, args->index);
>>           if (IS_ERR(cmd)) {
>> @@ -813,6 +817,7 @@ static void recv_work(struct work_struct *work)
>>           if (likely(!blk_should_fake_timeout(rq->q)))
>>               blk_mq_complete_request(rq);
>>       }
>> +    blk_queue_exit(q);
>>       nbd_config_put(nbd);
>>       atomic_dec(&config->recv_threads);
>>       wake_up(&config->recv_wq);
>>
>> Thanks,
>> Ming
>>
>> .
>>
