Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:10277 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbeCNPHn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Mar 2018 11:07:43 -0400
Message-ID: <1521040056.20980.229.camel@gmail.com>
Subject: Re: [PATCH V5 2/5] scsi: megaraid_sas: fix selection of reply queue
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Date: Wed, 14 Mar 2018 17:07:36 +0200
In-Reply-To: <20180313094243.8710-3-ming.lei@redhat.com>
References: <20180313094243.8710-1-ming.lei@redhat.com>
         <20180313094243.8710-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2018-03-13 at 17:42 +0800, Ming Lei wrote:
> From 84676c1f21 (genirq/affinity: assign vectors to all possible CPUs),
> one msix vector can be created without any online CPU mapped, then
> command may be queued, and won't be notified after its completion.
> 
> This patch setups mapping between cpu and reply queue according to irq
> affinity info retrived by pci_irq_get_affinity(), and uses this info
> to choose reply queue for queuing one command.
> 
> Then the chosen reply queue has to be active, and fixes IO hang caused
> by using inactive reply queue which doesn't have any online CPU mapped.
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
> Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: Don Brace <don.brace@microsemi.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Meelis Roos <mroos@linux.ee>
> Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> Fixes: 84676c1f21e8 ("genirq/affinity: assign vectors to all possible CPUs")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Checked v5 my Skylake Xeon and with this patch the regression that I reported is fixed.

Tested-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
Link: https://lkml.kernel.org/r/1519311270.2535.53.camel@intel.com
