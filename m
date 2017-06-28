Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-he1eur01on0054.outbound.protection.outlook.com ([104.47.0.54]:33829
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751581AbdF1RLd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 13:11:33 -0400
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
To: Sagi Grimberg <sagi@grimberg.me>, <axboe@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
 <37fea86b-ce87-ac03-e465-5daf62a456c4@grimberg.me>
 <1cc73f8d-3e9d-0f9f-2b71-60d2bc6ce7b5@mellanox.com>
 <81fe8f2a-1fba-730e-a4af-047a4e06bd1a@grimberg.me>
CC: <vladimirk@mellanox.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <a681644a-95ed-c9c0-99fe-96f8529ec991@mellanox.com>
Date: Wed, 28 Jun 2017 20:11:23 +0300
MIME-Version: 1.0
In-Reply-To: <81fe8f2a-1fba-730e-a4af-047a4e06bd1a@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 6/28/2017 6:01 PM, Sagi Grimberg wrote:
>
>>> Can you please test with my patchset on converting nvme-rdma to
>>> MSIX based mapping (I assume you are testing with mlx5 yes)?
>>
>> Sure. does V6 is the last version of the patchset ?
>> I'll test it with ConnectX-5 adapter and send the results.
>
> Yes.
>
>>> I'd be very much interested to know if the original problem
>>> exists with this applied.
>>
>> it will exist in case set->nr_hw_queues > dev->num_comp_vectors.
>
> We don't ask for more hw queues than num_comp_vectors.


I've tested Sagi's patches and they fix the connection establishment bug 
for NVMEoF.

here are the results:

fio 72 jobs, 128 iodepth.
NVMEoF register_always=N
1 Subsystem, 1 namespace

num_comp_vector is 60 and therefore num_queues is 60.
I run a comparison to my original patch with 60 queues and also for 64 
queues (possible in my patch because no limitation of num_comp_vectors)

bs      IOPS(read queues=60(Sagi)/60(Max)/64(Max))
-----  --------------------------------------------
512    3424.9K/3587.8K/3619.2K
1k     3421.8K/3613.5K/3630.6K
2k     3416.4K/3605.7K/3630.2K
4k     2361.6K/2399.9K/2404.1K
8k     1368.7K/1370.7K/1370.6K
16k    692K/691K/692K
32k    345K/348K/348K
64k    175K/174K/174K
128k   88K/87K/87K

bs     IOPS(write queues=60(Sagi)/60(Max)/64(Max))
----- ------------------------------
512    3243.6K/3329.7K/3392.9K
1k     3249.7K/3341.2K/3379.2K
2k     3251.2K/3336.9K/3385.9K
4k     2685.8K/2683.9K/2683.3K
8k     1336.6K/1355.1K/1361.6K
16k    690K/690K/691K
32k    348K/348K/348K
64k    174K/174K/174K
128k   87K/87K/87K

My conclusion is that Sagi's patch is correct (although we see little 
bit less performance: 100K-200K less for small block sizes) so you can add:

Tested-by: Max Gurtovoy <maxg@mellanox.com>

Nevertheless, we should review and consider pushing my fixes to the 
block layer for other users of this mapping function.
