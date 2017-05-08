Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbdEHM1w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 May 2017 08:27:52 -0400
Date: Mon, 8 May 2017 20:27:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Large latency on blk_queue_enter
Message-ID: <20170508122738.GC5696@ming.t460p>
References: <1656B440-3ECA-4F2B-B95C-418CF0F347E9@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1656B440-3ECA-4F2B-B95C-418CF0F347E9@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 08, 2017 at 01:54:58PM +0200, Javier Gonz�lez wrote:
> Hi,
> 
> I find an unusual added latency(~20-30ms) on blk_queue_enter when
> allocating a request directly from the NVMe driver through
> nvme_alloc_request. I could use some help confirming that this is a bug
> and not an expected side effect due to something else.
> 
> I can reproduce this latency consistently on LightNVM when mixing I/O
> from pblk and I/O sent through an ioctl using liblightnvm, but I don't
> see anything on the LightNVM side that could impact the request
> allocation.
> 
> When I have a 100% read workload sent from pblk, the max. latency is
> constant throughout several runs at ~80us (which is normal for the media
> we are using at bs=4k, qd=1). All pblk I/Os reach the nvme_nvm_submit_io
> function on lightnvm.c., which uses nvme_alloc_request. When we send a
> command from user space through an ioctl, then the max latency goes up
> to ~20-30ms. This happens independently from the actual command
> (IN/OUT). I tracked down the added latency down to the call
> percpu_ref_tryget_live in blk_queue_enter. Seems that the queue
> reference counter is not released as it should through blk_queue_exit in
> blk_mq_alloc_request. For reference, all ioctl I/Os reach the
> nvme_nvm_submit_user_cmd on lightnvm.c
> 
> Do you have any idea about why this might happen? I can dig more into
> it, but first I wanted to make sure that I am not missing any obvious
> assumption, which would explain the reference counter to be held for a
> longer time.

You need to check if the .q_usage_counter is working at atomic mode.
This counter is initialized as atomic mode, and finally switchs to
percpu mode via percpu_ref_switch_to_percpu() in blk_register_queue().

Thanks,
Ming
