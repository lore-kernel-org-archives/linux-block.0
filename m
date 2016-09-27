Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752348AbcI0GVm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2016 02:21:42 -0400
Subject: Re: [PATCH 2/9] dm: Fix a race condition related to stopping and
 starting queues
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <ba8ddc16-b709-e7fb-1120-b6e1bd393540@sandisk.com>
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
From: Hannes Reinecke <hare@suse.de>
Message-ID: <34f2c5c0-1bae-7ce7-9f60-446412ec641e@suse.de>
Date: Tue, 27 Sep 2016 08:21:40 +0200
MIME-Version: 1.0
In-Reply-To: <ba8ddc16-b709-e7fb-1120-b6e1bd393540@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/26/2016 08:26 PM, Bart Van Assche wrote:
> Ensure that all ongoing dm_mq_queue_rq() and dm_mq_requeue_request()
> calls have stopped before setting the "queue stopped" flag. This
> allows to remove the "queue stopped" test from dm_mq_queue_rq() and
> dm_mq_requeue_request(). This patch fixes a race condition because
> dm_mq_queue_rq() is called without holding the queue lock and hence
> BLK_MQ_S_STOPPED can be set at any time while dm_mq_queue_rq() is
> in progress.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/md/dm-rq.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
