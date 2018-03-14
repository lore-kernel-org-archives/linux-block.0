Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Wed, 14 Mar 2018 09:57:44 +0100
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
        Hannes Reinecke <hare@suse.de>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: Re: [PATCH V5 1/5] scsi: hpsa: fix selection of reply queue
Message-ID: <20180314085744.GA28983@lst.de>
References: <20180313094243.8710-1-ming.lei@redhat.com> <20180313094243.8710-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313094243.8710-2-ming.lei@redhat.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

I still don't like the code duplication, but I guess I can fix this
up in one of the next merge windows myself..

Reviewed-by: Christoph Hellwig <hch@lst.de>
