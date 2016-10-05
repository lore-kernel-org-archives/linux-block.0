Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] [RFC] nvme: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <9faa7607-eb3e-ce41-b09e-1e10492a5f45@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <94f3c8ab-9f62-889b-78a0-93f32a20c4e0@grimberg.me>
Date: Wed, 5 Oct 2016 20:43:39 +0300
MIME-Version: 1.0
In-Reply-To: <9faa7607-eb3e-ce41-b09e-1e10492a5f45@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

> Make nvme_requeue_req() check BLK_MQ_S_STOPPED instead of
> QUEUE_FLAG_STOPPED. Remove the QUEUE_FLAG_STOPPED manipulations
> that became superfluous because of this change. This patch fixes
> a race condition: using queue_flag_clear_unlocked() is not safe
> if any other function that manipulates the queue flags can be
> called concurrently, e.g. blk_cleanup_queue(). Untested.

This looks good to me, but I know keith had all sort of
creative ways to challenge this are so I'd wait for his
input...
