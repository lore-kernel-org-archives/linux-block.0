Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-he1eur01on0061.outbound.protection.outlook.com ([104.47.0.61]:51712
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751566AbdF1O4Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 10:56:24 -0400
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
To: Sagi Grimberg <sagi@grimberg.me>, <axboe@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
 <37fea86b-ce87-ac03-e465-5daf62a456c4@grimberg.me>
CC: <vladimirk@mellanox.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <1cc73f8d-3e9d-0f9f-2b71-60d2bc6ce7b5@mellanox.com>
Date: Wed, 28 Jun 2017 17:55:19 +0300
MIME-Version: 1.0
In-Reply-To: <37fea86b-ce87-ac03-e465-5daf62a456c4@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 6/28/2017 5:38 PM, Sagi Grimberg wrote:
> Hi Max,

Hi Sagi,

>
>> This patch performs sequential mapping between CPUs and queues.
>> In case the system has more CPUs than HWQs then there are still
>> CPUs to map to HWQs. In hyperthreaded system, map the unmapped CPUs
>> and their siblings to the same HWQ.
>> This actually fixes a bug that found unmapped HWQs in a system with
>> 2 sockets, 18 cores per socket, 2 threads per core (total 72 CPUs)
>> running NVMEoF (opens upto maximum of 64 HWQs).
>
> The explanation can be a bit clearer...
>
> I still need to take a look at the patch itself, but do note that
> ideally we will never get to blk_mq_map_queues since we prefer
> to map queues based on MSIX assignments. for nvme-rdma, this is
> merely a fallback. And looking ahead, MSIX based mapping should
> be the primary mapping logic.

we still have a fallback option in your series so we surly need some fix 
to the blk_mq_map_queues (also for stable kernel IMO. Jens/Christoph ?).

>
> Can you please test with my patchset on converting nvme-rdma to
> MSIX based mapping (I assume you are testing with mlx5 yes)?

Sure. does V6 is the last version of the patchset ?
I'll test it with ConnectX-5 adapter and send the results.

> I'd be very much interested to know if the original problem
> exists with this applied.

it will exist in case set->nr_hw_queues > dev->num_comp_vectors.

>
> I'll take a closer look into the patch.

Thanks.
