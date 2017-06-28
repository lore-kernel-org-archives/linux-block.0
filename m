Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35020 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdF1OiP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 10:38:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id 131so11889333wmq.2
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2017 07:38:15 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
To: Max Gurtovoy <maxg@mellanox.com>, axboe@fb.com, hch@lst.de,
        bvanassche@acm.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc: vladimirk@mellanox.com
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <37fea86b-ce87-ac03-e465-5daf62a456c4@grimberg.me>
Date: Wed, 28 Jun 2017 17:38:12 +0300
MIME-Version: 1.0
In-Reply-To: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Max,

> This patch performs sequential mapping between CPUs and queues.
> In case the system has more CPUs than HWQs then there are still
> CPUs to map to HWQs. In hyperthreaded system, map the unmapped CPUs
> and their siblings to the same HWQ.
> This actually fixes a bug that found unmapped HWQs in a system with
> 2 sockets, 18 cores per socket, 2 threads per core (total 72 CPUs)
> running NVMEoF (opens upto maximum of 64 HWQs).

The explanation can be a bit clearer...

I still need to take a look at the patch itself, but do note that
ideally we will never get to blk_mq_map_queues since we prefer
to map queues based on MSIX assignments. for nvme-rdma, this is
merely a fallback. And looking ahead, MSIX based mapping should
be the primary mapping logic.

Can you please test with my patchset on converting nvme-rdma to
MSIX based mapping (I assume you are testing with mlx5 yes)?
I'd be very much interested to know if the original problem
exists with this applied.

I'll take a closer look into the patch.
