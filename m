Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55483 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752887AbcI2Fyc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2016 01:54:32 -0400
Subject: Re: [PATCH v2 6/7] SRP transport: Port srp_wait_for_queuecommand() to
 scsi-mq
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <bedf4b45-00b0-6844-047d-f1e05bb1092f@sandisk.com>
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
Message-ID: <c0cae8d1-c82e-5089-3f93-cd03511b45cc@suse.de>
Date: Thu, 29 Sep 2016 07:54:29 +0200
MIME-Version: 1.0
In-Reply-To: <bedf4b45-00b0-6844-047d-f1e05bb1092f@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/29/2016 02:01 AM, Bart Van Assche wrote:
> Ensure that if scsi-mq is enabled that srp_wait_for_queuecommand()
> waits until ongoing shost->hostt->queuecommand() calls have finished.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: James Bottomley <jejb@linux.vnet.ibm.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Doug Ledford <dledford@redhat.com>
> ---
>  drivers/scsi/scsi_transport_srp.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
