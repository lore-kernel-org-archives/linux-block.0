Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42152 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHYFyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Aug 2018 01:54:53 -0400
Subject: Re: [PATCH v2] block: fix rdma queue mapping
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Steve Wise <swise@opengridcomputing.com>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
Date: Fri, 24 Aug 2018 19:17:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180822131130.GC28149@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> nvme-rdma attempts to map queues based on irq vector affinity.
>> However, for some devices, completion vector irq affinity is
>> configurable by the user which can break the existing assumption
>> that irq vectors are optimally arranged over the host cpu cores.
> 
> IFF affinity is configurable we should never use this code,
> as it breaks the model entirely.  ib_get_vector_affinity should
> never return a valid mask if affinity is configurable.

I agree that the model intended initially doesn't fit. But it seems
that some users like to write into their nic's
/proc/irq/$IRP/smp_affinity and get mad at us for not letting them with
using managed affinity.

So instead of falling back to the block mapping function we try
to do a little better first:
1. map according to the device vector affinity
2. map vectors that end up without a mapping to cpus that belong
    to the same numa-node
3. map all the rest of the unmapped cpus like the block layer
    would do.

We could have device drivers that don't use managed affinity to never
return a valid mask but that would never allow affinity based mapping
which is optimal at least for users that do not mangle with device
irq affinity (which is probably the majority of users).

Thoughts?
