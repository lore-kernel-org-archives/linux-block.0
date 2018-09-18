Return-Path: <ming.lei@redhat.com>
Date: Tue, 18 Sep 2018 15:39:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Bottomley <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Linux SCSI List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH V3 11/17] SCSI: track pending admin commands
Message-ID: <20180918073957.GB4805@ming.t460p>
References: <20180913121546.5710-1-ming.lei@redhat.com>
 <20180913121546.5710-12-ming.lei@redhat.com>
 <ae5c53be-b61a-5cba-9e92-538dee0a6536@oracle.com>
 <CACVXFVMWxXZqQfhAT7KaWP60NE2ACPPOz-9Tuoku_QYxuJuwRg@mail.gmail.com>
 <5c13533d-b1ea-616e-07d0-99d59cf65f8a@oracle.com>
 <20180917113506.GA28349@ming.t460p>
 <1f91bfaf-7b9e-881d-7455-6f04bbb37823@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1f91bfaf-7b9e-881d-7455-6f04bbb37823@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 18, 2018 at 09:22:32AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 09/17/2018 07:35 PM, Ming Lei wrote:
> > On Mon, Sep 17, 2018 at 10:46:34AM +0800, jianchao.wang wrote:
> >> Hi Ming
> >>
> >> On 09/14/2018 07:33 PM, Ming Lei wrote:
> >>> On Fri, Sep 14, 2018 at 11:40 AM jianchao.wang
> >>> <jianchao.w.wang@oracle.com> wrote:
> >>>>
> >>>> Hi Ming
> >>>>
> >>>> On 09/13/2018 08:15 PM, Ming Lei wrote:
> >>>>>  EXPORT_SYMBOL(__scsi_execute);
> >>>>> @@ -3246,6 +3251,7 @@ static int scsi_internal_device_block(struct scsi_device *sdev)
> >>>>>               else
> >>>>>                       scsi_wait_for_queuecommand(sdev);
> >>>>>       }
> >>>>> +     wait_event(sdev->admin_wq, !atomic_read(&sdev->nr_admin_pending));
> >>>>>       mutex_unlock(&sdev->state_mutex);
> >>>>>
> >>>>>       return err;
> >>>> ...
> >>>>> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> >>>>> index 3aee9464a7bf..8bcb7ecc0c06 100644
> >>>>> --- a/drivers/scsi/scsi_sysfs.c
> >>>>> +++ b/drivers/scsi/scsi_sysfs.c
> >>>>> @@ -1393,6 +1393,7 @@ void __scsi_remove_device(struct scsi_device *sdev)
> >>>>>
> >>>>>       blk_cleanup_queue(sdev->request_queue);
> >>>>>       cancel_work_sync(&sdev->requeue_work);
> >>>>> +     wait_event(sdev->admin_wq, !atomic_read(&sdev->nr_admin_pending))
> >>>>
> >>>> This nr_admin_pending could drain the ongoing scsi_request_fn/scsi_queue_rq,
> >>>> but I'm afraid it cannot stop new ones coming in, such as the ones that have passed
> >>>> the sdev state checking and have not crossed the atomic_inc(&sdev->nr_admin_pending).
> >>>>
> >>>
> >>> The counter of .nr_admin_pending is introduced for draining queued
> >>> admin requests to this scsi device.
> >>>
> >>> Actually new requests have been prevented from entering scsi_queue_rq(),
> >>> please see the two callers of wait_event(sdev->admin_wq,
> >>> !atomic_read(&sdev->nr_admin_pending)).
> >>>
> >> For example
> >>
> >> _scsi_execute
> >> ...
> >>                                           scsi_internal_device_block
> >>                                             scsi_internal_device_block_nowait
> >>                                             blk_mq_quiesce_queue
> >>                                             wait_event(sdev->admin_wq, !atomic_read(&sdev->nr_admin_pending))
> >>   &sdev->nr_admin_pending;
> >>
> >>   blk_execute_rq（...）
> >>
> >>   atomic_dec(&sdev->nr_admin_pending);
> >>   wake_up_all(&sdev->admin_wq);
> >>
> >> Or do you mean the scsi_queue_rq -> scsi_prep_state_check could gate out of ?
> > 
> > I got it, then this issue can be fixed simply by moving atomic_inc/dec(&sdev->nr_admin_pending)
> > and related wake_up_all(&sdev->admin_wq) into scsi_admin_queue_rq().
> > 
> 
> I don't think so. It is a similar scenario.
> 
> I guess a state checking is needed after atomic_inc(&sdev->nr_admin_pending), like:
> 
>  _scsi_execute
>  ...
>                                            scsi_internal_device_block
>                                              scsi_internal_device_block_nowait
>                                              blk_mq_quiesce_queue
>                                              wait_event(sdev->admin_wq, !atomic_read(&sdev->nr_admin_pending))
>    atomic_inc(&sdev->nr_admin_pending);
>    if state checking fails
>      goto done

The check will be done in scsi_admin_queue_rq().

> 
>    blk_execute_rq（...）
> 
>    atomic_dec(&sdev->nr_admin_pending);
>    wake_up_all(&sdev->admin_wq);

I guess you may misunderstand the purpose of .nr_admin_pending, which is
for draining requests to .queue_rq(). So it is enough to just move the
inc/dec of .nr_admin_pending into scsi_admin_queue_rq(), right?

Thanks,
Ming
