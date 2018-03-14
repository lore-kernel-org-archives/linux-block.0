Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34674 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbeCNI6S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Mar 2018 04:58:18 -0400
Date: Wed, 14 Mar 2018 09:58:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V5 4/5] scsi: virtio_scsi: fix IO hang caused by irq
        vector automatic affinity
Message-ID: <20180314085816.GC28983@lst.de>
References: <20180313094243.8710-1-ming.lei@redhat.com> <20180313094243.8710-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313094243.8710-5-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
