Return-Path: <linux-scsi-owner@vger.kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-scsi@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] scsi: fix scsi_host_queue_ready
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180630012724.24178-1-ming.lei@redhat.com>
Date: Mon, 02 Jul 2018 16:24:26 -0400
In-Reply-To: <20180630012724.24178-1-ming.lei@redhat.com> (Ming Lei's message
        of "Sat, 30 Jun 2018 09:27:24 +0800")
Message-ID: <yq1601xz8qt.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


Ming,

> 328728630d9f2bf1 ("scsi: avoid to hold host-wide counter of host_busy
> for scsi_mq") adds one extra check on scsi_host_busy(shost) in
> scsi_host_queue_ready(), which is wrong and not necessary, can causes
> booting stall on LSI53c895A.

Applied to 4.19/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
