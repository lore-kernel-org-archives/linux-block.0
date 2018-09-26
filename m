Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v10 2/8] block, scsi: Change the preempt-only flag into a counter
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180921203122.49743-1-bvanassche@acm.org>
	<20180921203122.49743-3-bvanassche@acm.org>
Date: Tue, 25 Sep 2018 21:33:45 -0400
In-Reply-To: <20180921203122.49743-3-bvanassche@acm.org> (Bart Van Assche's
	message of "Fri, 21 Sep 2018 13:31:16 -0700")
Message-ID: <yq14ledghza.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> The RQF_PREEMPT flag is used for three purposes:
> - In the SCSI core, for making sure that power management requests
>   are executed even if a device is in the "quiesced" state.
> - For domain validation by SCSI drivers that use the parallel port.
> - In the IDE driver, for IDE preempt requests.

> Rename "preempt-only" into "pm-only" because the primary purpose of
> this mode is power management. Since the power management core may but
> does not have to resume a runtime suspended device before performing
> system-wide suspend and since a later patch will set "pm-only" mode as
> long as a block device is runtime suspended, make it possible to set
> "pm-only" mode from more than one context. Since with this change
> scsi_device_quiesce() is no longer idempotent, make that function
> return early if it is called for a quiesced queue.

The SCSI pieces look OK to me...

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
