Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36386 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbdF1PBv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 11:01:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id y5so12026227wmh.3
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2017 08:01:50 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
To: Max Gurtovoy <maxg@mellanox.com>, axboe@fb.com, hch@lst.de,
        bvanassche@acm.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc: vladimirk@mellanox.com
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
 <37fea86b-ce87-ac03-e465-5daf62a456c4@grimberg.me>
 <1cc73f8d-3e9d-0f9f-2b71-60d2bc6ce7b5@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <81fe8f2a-1fba-730e-a4af-047a4e06bd1a@grimberg.me>
Date: Wed, 28 Jun 2017 18:01:47 +0300
MIME-Version: 1.0
In-Reply-To: <1cc73f8d-3e9d-0f9f-2b71-60d2bc6ce7b5@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> Can you please test with my patchset on converting nvme-rdma to
>> MSIX based mapping (I assume you are testing with mlx5 yes)?
> 
> Sure. does V6 is the last version of the patchset ?
> I'll test it with ConnectX-5 adapter and send the results.

Yes.

>> I'd be very much interested to know if the original problem
>> exists with this applied.
> 
> it will exist in case set->nr_hw_queues > dev->num_comp_vectors.

We don't ask for more hw queues than num_comp_vectors.
