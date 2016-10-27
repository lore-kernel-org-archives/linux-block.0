Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46269 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751303AbcJ0Fwo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 01:52:44 -0400
Subject: Re: [PATCH 05/12] blk-mq: Introduce blk_mq_quiesce_queue()
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <5143c240-39af-9fe2-d3e6-ed69f9c20531@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f1661bd2-12ca-20d1-ece2-5c7fe5987035@suse.de>
Date: Thu, 27 Oct 2016 07:52:41 +0200
MIME-Version: 1.0
In-Reply-To: <5143c240-39af-9fe2-d3e6-ed69f9c20531@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/27/2016 12:53 AM, Bart Van Assche wrote:
> blk_mq_quiesce_queue() waits until ongoing .queue_rq() invocations
> have finished. This function does *not* wait until all outstanding
> requests have finished (this means invocation of request.end_io()).
> The algorithm used by blk_mq_quiesce_queue() is as follows:
> * Hold either an RCU read lock or an SRCU read lock around
>   .queue_rq() calls. The former is used if .queue_rq() does not
>   block and the latter if .queue_rq() may block.
> * blk_mq_quiesce_queue() calls synchronize_srcu() or
>   synchronize_rcu() to wait for .queue_rq() invocations that
>   started before blk_mq_quiesce_queue() was called.
> * The blk_mq_hctx_stopped() calls that control whether or not
>   .queue_rq() will be called are called with the (S)RCU read lock
>   held. This is necessary to avoid race conditions against
>   the "blk_mq_stop_hw_queues(q); blk_mq_quiesce_queue(q);"
>   sequence from another thread.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <tom.leiming@gmail.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/Kconfig          |  1 +
>  block/blk-mq.c         | 69 +++++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/blk-mq.h |  3 +++
>  include/linux/blkdev.h |  1 +
>  4 files changed, 67 insertions(+), 7 deletions(-)
> 
Hmm. Can't say I like having to have two RCU structure for the same
purpose, but I guess that can't be helped.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
