Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.opengridcomputing.com ([72.48.136.20]:36944 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932362AbcI1OXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2016 10:23:00 -0400
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Bart Van Assche'" <bart.vanassche@sandisk.com>,
        "'James Bottomley'" <jejb@linux.vnet.ibm.com>,
        "'Jens Axboe'" <axboe@fb.com>
Cc: <linux-block@vger.kernel.org>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'Mike Snitzer'" <snitzer@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        "'Keith Busch'" <keith.busch@intel.com>,
        "'Doug Ledford'" <dledford@redhat.com>,
        <linux-scsi@vger.kernel.org>, "'Christoph Hellwig'" <hch@lst.de>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com> <9c372b04-a194-58c4-a64f-b155b52a5244@sandisk.com> <013c01d218dc$8a5406c0$9efc1440$@opengridcomputing.com> <9d8e0f32-6703-cf23-d424-bcecb65c2a26@sandisk.com> <1474995360.2716.19.camel@linux.vnet.ibm.com> <3fb86a78-de3a-b764-a493-cb5bc5b6d8b6@sandisk.com>
In-Reply-To: <3fb86a78-de3a-b764-a493-cb5bc5b6d8b6@sandisk.com>
Subject: RE: [PATCH 9/9] [RFC] nvme: Fix a race condition
Date: Wed, 28 Sep 2016 09:23:03 -0500
Message-ID: <009601d21993$d2d33670$7879a350$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> 
> Hello James and Steve,
> 
> I will add a comment.
> 
> Please note that the above patch does not change the behavior of
> nvme_stop_queues() except that it causes nvme_stop_queues() to wait
> until any ongoing nvme_queue_rq() calls have finished.
> blk_resume_queue() does not affect the value of the BLK_MQ_S_STOPPED bit
> that has been set by blk_mq_stop_hw_queues(). All it does is to resume
> pending blk_queue_enter() calls and to ensure that future
> blk_queue_enter() calls do not block. Even after blk_resume_queue() has
> been called if a new request is queued queue_rq() won't be invoked
> because the BLK_MQ_S_STOPPED bit is still set. Patch "dm: Fix a race
> condition related to stopping and starting queues" realizes a similar
> change in the dm driver and that change has been tested extensively.
> 

Thanks for the detailed explanation!  I think your code, then, is correct as-is.   And this series doesn't fix the issue I'm hitting, so I'll keep digging. :)

Steve.  

