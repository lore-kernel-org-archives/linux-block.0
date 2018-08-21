Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725731AbeHUFWz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Aug 2018 01:22:55 -0400
Date: Tue, 21 Aug 2018 10:04:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Steve Wise <swise@opengridcomputing.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v2] block: fix rdma queue mapping
Message-ID: <20180821020434.GA24247@ming.t460p>
References: <20180820205420.25908-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180820205420.25908-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 20, 2018 at 01:54:20PM -0700, Sagi Grimberg wrote:
> nvme-rdma attempts to map queues based on irq vector affinity.
> However, for some devices, completion vector irq affinity is
> configurable by the user which can break the existing assumption
> that irq vectors are optimally arranged over the host cpu cores.
> 
> So we map queues in two stages:
> First map queues according to corresponding to the completion
> vector IRQ affinity taking the first cpu in the vector affinity map.
> if the current irq affinity is arranged such that a vector is not
> assigned to any distinct cpu, we map it to a cpu that is on the same
> node. If numa affinity can not be sufficed, we map it to any unmapped
> cpu we can find. Then, map the remaining cpus in the possible cpumap
> naively.

I guess this way still can't fix the request allocation crash issue
triggered by using blk_mq_alloc_request_hctx(), in which one hw queue may
not be mapped from any online CPU.

Maybe this patch isn't for this issue, but it is closely related.

Thanks,
Ming
