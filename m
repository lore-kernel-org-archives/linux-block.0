Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3 11/17] SCSI: track pending admin commands
To: Ming Lei <ming.lei@redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>
References: <20180913121546.5710-12-ming.lei@redhat.com>
 <ae5c53be-b61a-5cba-9e92-538dee0a6536@oracle.com>
 <CACVXFVMWxXZqQfhAT7KaWP60NE2ACPPOz-9Tuoku_QYxuJuwRg@mail.gmail.com>
 <5c13533d-b1ea-616e-07d0-99d59cf65f8a@oracle.com>
 <20180917113506.GA28349@ming.t460p>
 <1f91bfaf-7b9e-881d-7455-6f04bbb37823@oracle.com>
 <20180918073957.GB4805@ming.t460p>
 <e448f24c-d5d0-17fa-b802-76f407169ff2@oracle.com>
 <20180918075544.GD4805@ming.t460p>
 <8d9049f4-a133-d725-d144-769b2d285660@oracle.com>
 <20180918121515.GA14172@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <47528f73-334a-16ef-5ec2-b3872b4eeeb7@oracle.com>
Date: Wed, 19 Sep 2018 11:52:21 +0800
MIME-Version: 1.0
In-Reply-To: <20180918121515.GA14172@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 09/18/2018 08:15 PM, Ming Lei wrote:
> The adminq request can be quisced in the scsi_device level, just as normal IO
> request, because the scsi_device instance is same with normal IO.

Yes, the scsi_queue_rq->scsi_prep_state_check could gate things out of.

> 
> But in blk-mq level, this admin queue won't be quiesced or frozen at all.

But the scsi_queue_rq/scsi_request_fn will be invoked, right ?

This is different from the original implementation.

Thanks
Jianchao
