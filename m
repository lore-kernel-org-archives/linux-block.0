Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v2 4/5] block, scsi: Rework runtime power management
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
 <20180725222607.8854-5-bart.vanassche@wdc.com>
 <0fe202dd-32a6-4bd1-43dd-440511ad52e4@oracle.com>
 <b73752a1ea9356cce26e36bd8538391c5985f81a.camel@wdc.com>
 <aa8cbdb5-826d-1481-e60b-1c27b1c02682@oracle.com>
 <c1264b65598598dacafc51df34dcd09201c2c095.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c1e71057-0245-f1bd-5adb-c9f706230da6@oracle.com>
Date: Mon, 30 Jul 2018 09:56:56 +0800
MIME-Version: 1.0
In-Reply-To: <c1264b65598598dacafc51df34dcd09201c2c095.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>


Hi Bart

On 07/27/2018 11:09 PM, Bart Van Assche wrote:
> On Fri, 2018-07-27 at 09:57 +0800, jianchao.wang wrote:
>> If q_usage_counter is not zero here, we will leave the request_queue in preempt only mode.
> 
> That's on purpose. If q_usage_counter is not zero then blk_pre_runtime_suspend()
> will return -EBUSY. That error code will be passed to blk_post_runtime_suspend()
> and that will cause that function to clear QUEUE_FLAG_PREEMPT_ONLY.
> 

static int sdev_runtime_suspend(struct device *dev)
{
	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
	struct scsi_device *sdev = to_scsi_device(dev);
	int err = 0;

	err = blk_pre_runtime_suspend(sdev->request_queue);
	if (err)
		return err;
	if (pm && pm->runtime_suspend)
		err = pm->runtime_suspend(dev);
	blk_post_runtime_suspend(sdev->request_queue, err);

	return err;
}

If blk_pre_runtime_suspend returns -EBUSY, blk_post_runtime_suspend will not be invoked.

>> The request_queue should be set to preempt only mode only when we confirm we could set
>> rpm_status to RPM_SUSPENDING or RPM_RESUMING.
> 
> Why do you think this?

https://marc.info/?l=linux-scsi&m=133727953625963&w=2
"
If q->rpm_status is RPM_SUSPENDED, they shouldn't do anything -- act as though the queue is
empty.  If q->rpm_status is RPM_SUSPENDING or RPM_RESUMING, they should hand over the request
only if it has the REQ_PM flag set.
"
In additon, if we set the preempt only here unconditionally, the normal IO will be blocked
during the blk_pre_runtime_suspend. In your patch, q_usage_counter will be switched to atomic mode,
this could cost some time. Is it really OK ?

Thanks
Jianchao
> 
> Bart.
> 
> 
