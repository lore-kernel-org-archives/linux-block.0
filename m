Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35446 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbdF2Fdg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 01:33:36 -0400
Received: by mail-wr0-f193.google.com with SMTP id z45so35932961wrb.2
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2017 22:33:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
To: Max Gurtovoy <maxg@mellanox.com>, axboe@fb.com, hch@lst.de,
        bvanassche@acm.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc: vladimirk@mellanox.com
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
 <e9cccad7-804a-f68b-b184-46cc5be2f01d@grimberg.me>
 <c0e5ca5d-f048-cf9c-27d6-6a2a98a48251@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4da1ee67-052f-a0a1-ac9c-a3cb5f39b750@grimberg.me>
Date: Thu, 29 Jun 2017 08:33:32 +0300
MIME-Version: 1.0
In-Reply-To: <c0e5ca5d-f048-cf9c-27d6-6a2a98a48251@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>>> +static int cpu_to_queue_index(unsigned int nr_queues, const int cpu,
>>> +                  const struct cpumask *online_mask)
>>>   {
>>> -    return cpu * nr_queues / nr_cpus;
>>> +    /*
>>> +     * Non online CPU will be mapped to queue index 0.
>>> +     */
>>> +    if (!cpumask_test_cpu(cpu, online_mask))
>>> +        return 0;
>>
>> Why not map offline cpus to what they would've map to if they were
>> online?
> 
> I didn't change logic for offline cpu's.
> Should it be done in this patch ?

The patch clearly treats offline cpus differently, maps them
to queue 0.
