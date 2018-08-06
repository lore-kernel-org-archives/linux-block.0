Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <b5548ab1d8523be0a13407e2bfca0071bd340c77.camel@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com> <20180804000325.3610-8-bart.vanassche@wdc.com>
 <CACVXFVOSB-r9OYJ+R7a-PfFuie3LCjUxhs2E7igh9vWp2VONkg@mail.gmail.com> <b5548ab1d8523be0a13407e2bfca0071bd340c77.camel@wdc.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 7 Aug 2018 06:30:00 +0800
Message-ID: <CACVXFVPWERaoKRtU=3XpT=jgTu7rFA=oz0FLSYzKcTPCZt1X9g@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] block, scsi: Rework runtime power management
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 6, 2018 at 11:20 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Sat, 2018-08-04 at 18:01 +0800, Ming Lei wrote:
>> On Sat, Aug 4, 2018 at 8:03 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
>> >
>> > diff --git a/block/blk-pm.c b/block/blk-pm.c
>> > index 2a4632d0be4b..0708185ead61 100644
>> > --- a/block/blk-pm.c
>> > +++ b/block/blk-pm.c
>> > @@ -107,17 +107,31 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>> >         if (!q->dev)
>> >                 return ret;
>> >
>> > +       WARN_ON_ONCE(q->rpm_status != RPM_ACTIVE);
>> > +
>> >         blk_pm_runtime_lock(q);
>> > +       /*
>> > +        * Switch to preempt-only mode before calling synchronize_rcu() such
>> > +        * that later blk_queue_enter() calls see the preempt-only state. See
>> > +        * also http://lwn.net/Articles/573497/.
>> > +        */
>> > +       blk_set_pm_only(q);
>> > +       ret = -EBUSY;
>> > +       if (percpu_ref_read(&q->q_usage_counter) == 1) {
>> > +               synchronize_rcu();
>> > +               if (percpu_ref_read(&q->q_usage_counter) == 1)
>> > +                       ret = 0;
>> > +       }
>>
>> The above code looks too tricky, and the following issue might exist in case
>> of potential WRITEs re-order from blk_queue_enter().
>>
>> 1) suppose there are one in-flight request not completed yet
>>
>> 2) observer is the percpu_ref_read() following synchronize_rcu().
>>
>> 3) inside blk_queue_enter(), WRITE in percpu_ref_tryget_live()/percpu_ref_put()
>> can be re-ordered from view of the observer in 2)
>>
>> 4) then percpu_ref_read() may return 1 even though the only in-flight
>> request isn't completed
>>
>> 5) suspend still moves on, and data loss may be triggered
>>
>> Cc Paul, and Alan have been CCed already, so we have several memory
>> model experts here, :-), hope they may help to clarify if this reorder case
>> may exist.
>
> Hello Ming,
>
> There are two cases:
> (a) The percpu_ref_tryget_live() call in (3) is triggered by a runtime power
>     state transition (RPM_*).
> (b) The percpu_ref_tryget_live() call in (3) is not triggered by a runtime
>     power state transition.
>
> In case (b) the driver that submits the request should protect the request
> with scsi_autopm_get_device() / scsi_autopm_put_device() or by any other
> mechanism that prevents runtime power state transitions. Since
> scsi_autopm_get_device() is called before blk_queue_enter(), since
> scsi_autopm_get_device() only returns after it has resumed a device and since
> scsi_autopm_get_device() prevents runtime suspend, the function
> blk_pre_runtime_suspend() won't be called concurrently with blk_queue_enter()
> in case (b).

For normal IO path, blk_queue_enter() is called inside generic_make_request()
which is usually run from fs, do you mean fs code will call
scsi_autopm_get_device()? :-)


Thanks,
Ming Lei
