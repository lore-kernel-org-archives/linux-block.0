Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39351 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935241AbcI0Q4O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2016 12:56:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8RGrT85030362
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2016 12:56:14 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 25qr13f1xc-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2016 12:56:14 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Tue, 27 Sep 2016 10:56:13 -0600
Subject: Re: [PATCH 9/9] [RFC] nvme: Fix a race condition
From: James Bottomley <jejb@linux.vnet.ibm.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Steve Wise <swise@opengridcomputing.com>,
        "'Jens Axboe'" <axboe@fb.com>
Cc: linux-block@vger.kernel.org,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'Mike Snitzer'" <snitzer@redhat.com>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        "'Keith Busch'" <keith.busch@intel.com>,
        "'Doug Ledford'" <dledford@redhat.com>, linux-scsi@vger.kernel.org,
        "'Christoph Hellwig'" <hch@lst.de>
Date: Tue, 27 Sep 2016 09:56:00 -0700
In-Reply-To: <9d8e0f32-6703-cf23-d424-bcecb65c2a26@sandisk.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
         <9c372b04-a194-58c4-a64f-b155b52a5244@sandisk.com>
         <013c01d218dc$8a5406c0$9efc1440$@opengridcomputing.com>
         <9d8e0f32-6703-cf23-d424-bcecb65c2a26@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1474995360.2716.19.camel@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2016-09-27 at 09:43 -0700, Bart Van Assche wrote:
> On 09/27/2016 09:31 AM, Steve Wise wrote:
> > > @@ -2079,11 +2075,15 @@ EXPORT_SYMBOL_GPL(nvme_kill_queues);
> > >  void nvme_stop_queues(struct nvme_ctrl *ctrl)
> > >  {
> > >  	struct nvme_ns *ns;
> > > +	struct request_queue *q;
> > > 
> > >  	mutex_lock(&ctrl->namespaces_mutex);
> > >  	list_for_each_entry(ns, &ctrl->namespaces, list) {
> > > -		blk_mq_cancel_requeue_work(ns->queue);
> > > -		blk_mq_stop_hw_queues(ns->queue);
> > > +		q = ns->queue;
> > > +		blk_quiesce_queue(q);
> > > +		blk_mq_cancel_requeue_work(q);
> > > +		blk_mq_stop_hw_queues(q);
> > > +		blk_resume_queue(q);
> > >  	}
> > >  	mutex_unlock(&ctrl->namespaces_mutex);
> > 
> > Hey Bart, should nvme_stop_queues() really be resuming the blk
> > queue?
> 
> Hello Steve,
> 
> Would you perhaps prefer that blk_resume_queue(q) is called from 
> nvme_start_queues()? I think that would make the NVMe code harder to 
> review. The above code won't cause any unexpected side effects if an 
> NVMe namespace is removed after nvme_stop_queues() has been called 
> and before nvme_start_queues() is called. Moving the 
> blk_resume_queue(q) call into nvme_start_queues() will only work as 
> expected if no namespaces are added nor removed between the 
> nvme_stop_queues() and nvme_start_queues() calls. I'm not familiar 
> enough with the NVMe code to know whether or not this change is safe
> ...

It's something that looks obviously wrong, so explain why you need to
do it, preferably in a comment above the function.

James


