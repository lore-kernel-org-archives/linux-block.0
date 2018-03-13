Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:37625 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeCMRNx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Mar 2018 13:13:53 -0400
Received: by mail-io0-f195.google.com with SMTP id d71so984819iog.4
        for <linux-block@vger.kernel.org>; Tue, 13 Mar 2018 10:13:53 -0700 (PDT)
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180313094243.8710-1-ming.lei@redhat.com> <20180313094243.8710-3-ming.lei@redhat.com>
In-Reply-To: <20180313094243.8710-3-ming.lei@redhat.com>
MIME-Version: 1.0
Date: Tue, 13 Mar 2018 22:43:50 +0530
Message-ID: <560d249dfe93281af03648652d1f3277@mail.gmail.com>
Subject: RE: [PATCH V5 2/5] scsi: megaraid_sas: fix selection of reply queue
To: Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> -----Original Message-----
> From: Ming Lei [mailto:ming.lei@redhat.com]
> Sent: Tuesday, March 13, 2018 3:13 PM
> To: James Bottomley; Jens Axboe; Martin K . Petersen
> Cc: Christoph Hellwig; linux-scsi@vger.kernel.org; linux-
> block@vger.kernel.org; Meelis Roos; Don Brace; Kashyap Desai; Laurence
> Oberman; Mike Snitzer; Paolo Bonzini; Ming Lei; Hannes Reinecke; James
> Bottomley; Artem Bityutskiy
> Subject: [PATCH V5 2/5] scsi: megaraid_sas: fix selection of reply queue
>
> From 84676c1f21 (genirq/affinity: assign vectors to all possible CPUs),
one
> msix vector can be created without any online CPU mapped, then command
> may be queued, and won't be notified after its completion.
>
> This patch setups mapping between cpu and reply queue according to irq
> affinity info retrived by pci_irq_get_affinity(), and uses this info to
choose
> reply queue for queuing one command.
>
> Then the chosen reply queue has to be active, and fixes IO hang caused
by
> using inactive reply queue which doesn't have any online CPU mapped.
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
> Fixes: 84676c1f21e8 ("genirq/affinity: assign vectors to all possible
CPUs")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>


Side note - For a max performance, your below proposed patch/series is
required.  Without below patch, performance is going to be dropped due to
fewer reply queues are getting utilized one this particular patch is
included.
genirq/affinity: irq vector spread  among online CPUs as far as possible

Acked-by: Kashyap Desai <kashyap.desai@broadcom.com>
Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
