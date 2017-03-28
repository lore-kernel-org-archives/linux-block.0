Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37530 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754563AbdC1Ifk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 04:35:40 -0400
Received: by mail-it0-f51.google.com with SMTP id 190so10689525itm.0
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2017 01:35:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170327091419.GD6879@infradead.org>
References: <1490002801-16280-1-git-send-email-jitendra.bhivare@broadcom.com> <20170327091419.GD6879@infradead.org>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Tue, 28 Mar 2017 14:05:18 +0530
Message-ID: <CAOBf=mudsgLcBkG0PGDwAr5FfaQfWuPgg-gpNM3vaXMVQjyeKQ@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Add NULL pointer check for HW dispatch queue
To: Christoph Hellwig <hch@infradead.org>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 27, 2017 at 2:44 PM, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Mar 20, 2017 at 03:10:01PM +0530, Jitendra Bhivare wrote:
> > As part of blk_mq_realloc_hw_ctx(), if the init_hctx() ops is
> > failed by the underyling transport, the hctx pointer is freed and
> > initialized to NULL.
> > However, functions down the line, access this hwctx pointer without
> > a NULL pointer check, which could lead to a kernel crash.
>
> Shouldn't we fail initializing the queue if any of the hctx allocations
> fail?

Well, just to give a better background of the issue, here is the
dump_stack of where/when the failure happens

Mar 18 08:27:31 dhcp-10-192-204-6 kernel: [<ffffffffa05d42d6>]
ib_alloc_mr+0x26/0x50 [ib_core]
Mar 18 08:27:31 dhcp-10-192-204-6 kernel: [<ffffffffa0a37691>]
__nvme_rdma_init_request+0xc1/0x230 [nvme_rdma]
Mar 18 08:27:31 dhcp-10-192-204-6 kernel: [<ffffffffa0a37831>]
nvme_rdma_init_request+0x11/0x20 [nvme_rdma]
Mar 18 08:27:31 dhcp-10-192-204-6 kernel: [<ffffffff813429bb>]
blk_mq_init_rq_map+0x23b/0x2b0
Mar 18 08:27:31 dhcp-10-192-204-6 kernel: [<ffffffff81342e25>]
blk_mq_alloc_tag_set+0x135/0x2c0
Mar 18 08:27:31 dhcp-10-192-204-6 kernel: [<ffffffffa0a37cc3>]
nvme_rdma_create_ctrl+0x483/0x710 [nvme_rdma]
Mar 18 08:27:31 dhcp-10-192-204-6 kernel: [<ffffffffa0a2c127>]
nvmf_dev_write+0x727/0x93c [nvme_fabrics]
Mar 18 08:27:31 dhcp-10-192-204-6 kernel: [<ffffffff812320e7>]
__vfs_write+0x37/0x160

the ctrl->queue_count in nvme_rdma_create_ctrl() is initialized like so:

ctrl->queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */

where opts->nr_io_queues is typically set to num_online_cpus() which
in my case turned out to be 16, while the failure i encountered was
for the 14th CPU , the failure being alloc_mr() because we reached the
limitation of MRs in our chip.

The point is that post this failure, functions like
blk_mq_init_cpu_queues() and blk_mq_map_swqueue() use code snippet
like below to access the hctxs:

for_each_possible_cpu(i) {
....
 hctx = blk_mq_map_queue(q, i);
 hctx->....                                          // crash if ptr is NULL
..
}

I'm not that familiar with the blk code itself, so perhaps there is a
better way of fixing it, but have pointed out the problem and a
possible fix, this is more of a bug
in the error-handling path?

Thanks
Som
