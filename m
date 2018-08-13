Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v6 08/12] block, scsi: Introduce blk_pm_runtime_exit()
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.com" <hare@suse.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
 <20180809194149.15285-9-bart.vanassche@wdc.com>
 <be4d4011-efba-c866-e9a8-c14743eb0a1a@oracle.com>
 <e993bdc480ccffc4922463fef7102b0cb2e542fd.camel@wdc.com>
 <01569014d645b6561a7c1da0f20d08b41a8a213a.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <04e102b0-909f-7a25-16ca-ab153188f8f8@oracle.com>
Date: Mon, 13 Aug 2018 17:24:40 +0800
MIME-Version: 1.0
In-Reply-To: <01569014d645b6561a7c1da0f20d08b41a8a213a.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 08/11/2018 12:17 AM, Bart Van Assche wrote:
> void blk_pm_runtime_exit(struct request_queue *q)
> {
> 	if (!q->dev)
> 		return;
> 
> 	pm_runtime_get_sync(q->dev);
> 	blk_freeze_queue(q);
> 	q->dev = NULL;
> 	blk_unfreeze_queue(q);
> }

I'm afraid this will not work.

In following patch:

@@ -972,6 +972,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		if (success)
 			return 0;
 
+		blk_pm_request_resume(q);
+
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EBUSY;

We could still invoke blk_pm_request_resume even if the queue is frozen.

And we have blk_pm_request_resume later as following:

+static inline void blk_pm_request_resume(struct request_queue *q)
+{
+	if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
+		       q->rpm_status == RPM_SUSPENDING))
+		pm_request_resume(q->dev);
+}

Thanks
Jianchao
