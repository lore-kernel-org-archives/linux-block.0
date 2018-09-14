Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
References: <20180913121546.5710-1-ming.lei@redhat.com> <20180913121546.5710-12-ming.lei@redhat.com>
 <ae5c53be-b61a-5cba-9e92-538dee0a6536@oracle.com>
In-Reply-To: <ae5c53be-b61a-5cba-9e92-538dee0a6536@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 14 Sep 2018 19:33:20 +0800
Message-ID: <CACVXFVMWxXZqQfhAT7KaWP60NE2ACPPOz-9Tuoku_QYxuJuwRg@mail.gmail.com>
Subject: Re: [PATCH V3 11/17] SCSI: track pending admin commands
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>, Adrian Hunter <adrian.hunter@intel.com>,
	James Bottomley <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Linux SCSI List <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 14, 2018 at 11:40 AM jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
>
> Hi Ming
>
> On 09/13/2018 08:15 PM, Ming Lei wrote:
> >  EXPORT_SYMBOL(__scsi_execute);
> > @@ -3246,6 +3251,7 @@ static int scsi_internal_device_block(struct scsi_device *sdev)
> >               else
> >                       scsi_wait_for_queuecommand(sdev);
> >       }
> > +     wait_event(sdev->admin_wq, !atomic_read(&sdev->nr_admin_pending));
> >       mutex_unlock(&sdev->state_mutex);
> >
> >       return err;
> ...
> > diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> > index 3aee9464a7bf..8bcb7ecc0c06 100644
> > --- a/drivers/scsi/scsi_sysfs.c
> > +++ b/drivers/scsi/scsi_sysfs.c
> > @@ -1393,6 +1393,7 @@ void __scsi_remove_device(struct scsi_device *sdev)
> >
> >       blk_cleanup_queue(sdev->request_queue);
> >       cancel_work_sync(&sdev->requeue_work);
> > +     wait_event(sdev->admin_wq, !atomic_read(&sdev->nr_admin_pending))
>
> This nr_admin_pending could drain the ongoing scsi_request_fn/scsi_queue_rq,
> but I'm afraid it cannot stop new ones coming in, such as the ones that have passed
> the sdev state checking and have not crossed the atomic_inc(&sdev->nr_admin_pending).
>

The counter of .nr_admin_pending is introduced for draining queued
admin requests to this scsi device.

Actually new requests have been prevented from entering scsi_queue_rq(),
please see the two callers of wait_event(sdev->admin_wq,
!atomic_read(&sdev->nr_admin_pending)).

Thanks,
Ming Lei
