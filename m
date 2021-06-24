Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56518C49EA6
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 14:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFAD613B4
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 14:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFXOQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:16:54 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:37715 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXOQw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 10:16:52 -0400
Received: by mail-pj1-f42.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so6004769pjs.2
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 07:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6jkP4GYilnFqu4yckxY+C1lWZ5WUcJW26eSTRBlgnUw=;
        b=IqbLbqNwt3sBwWIJTgprOW8+1SlEccPjRRxC5C8pk3WwD8R8j7nmjYbvGXvkZgB62B
         gTMD3UQEpooBT4oRrBcv7Tcqkih7PcAh2i8pupdPssQI1JDTed/6NZDQUqL2l2LUsrwt
         9kpuIEkiJ68GVxJ2/rSNL0Uz2fXvR2rVhn8XMTPZqSC+PFWDs92MvmFU+YKFj2GP9eNF
         Of+zNkd+HBmVwhzOGoUavFt8JfDe/PAcjq6ZXKfJyhh+YvPczmjrYr2ghhfVohNX5eS0
         vnSVQ/I5fOvS7YM/ACpyj7xn5pWL5t2KG5ypZeGMvcq2UD5fZj1vxhLnzl3a0LSJuga/
         WrLA==
X-Gm-Message-State: AOAM530UdZIvQjzo7N7F3oJaxveSNkRU4yMIFplYI2swmfkWJCV/e7nR
        y3JV4wrwbZhyc+R/dDxbhSPh8LPZkxc=
X-Google-Smtp-Source: ABdhPJxCKbQcL4aIwoLtozh4SUXeNapoCuKzw6hIZfVI9sE+6sRLXBRmaUAbCohez4C9bAERh2rmWw==
X-Received: by 2002:a17:90b:4c41:: with SMTP id np1mr5844563pjb.69.1624544071212;
        Thu, 24 Jun 2021 07:14:31 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id l6sm2693963pgh.34.2021.06.24.07.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 07:14:30 -0700 (PDT)
Subject: Re: [PATCH 9/9] loop: allow user to set the queue depth
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
 <20210622231952.5625-10-chaitanya.kulkarni@wdc.com>
 <d433361c-f270-f1a4-4eb2-3c1c10e7e5ec@acm.org>
 <BYAPR04MB4965D4C98E4ACB32709A273886079@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <af677291-d4dd-e3a3-886e-3dc9e3779fd1@acm.org>
Date:   Thu, 24 Jun 2021 07:14:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965D4C98E4ACB32709A273886079@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/21 9:36 PM, Chaitanya Kulkarni wrote:
> On 6/22/21 4:27 PM, Bart Van Assche wrote:
>> On 6/22/21 4:19 PM, Chaitanya Kulkarni wrote:
>>> @@ -2094,7 +2097,7 @@ static int loop_add(struct loop_device **l, int i)
>>>  	err = -ENOMEM;
>>>  	lo->tag_set.ops = &loop_mq_ops;
>>>  	lo->tag_set.nr_hw_queues = 1;
>>> -	lo->tag_set.queue_depth = 128;
>>> +	lo->tag_set.queue_depth = hw_queue_depth;
>>>  	lo->tag_set.numa_node = NUMA_NO_NODE;
>>>  	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
>>>  	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
>> Is there any use case for which the performance improves by using
>> another queue depth than the default?
> 
> Unfortunately I don't have access to all the applications so I can come
> up with
> quantitative data, I can try synthetic applications such as fio.
> 
> This patch is more on the side of allowing user to change the qd value
> so they can
> experiment, making loop qd flexible like other block drivers which loop
> lacks right now.

Kernel module parameters are inflexible. If there is agreement that this
parameter should become configurable it probably should be made
configurable per loop device instead of introducing a single global
parameter.

Thanks,

Bart.
