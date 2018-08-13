Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [RFC PATCH V2 04/17] blk-mq: don't reserve tags for admin queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20180811071220.357-1-ming.lei@redhat.com>
 <20180811071220.357-5-ming.lei@redhat.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <14c6e892-b05f-7422-0fd3-da45a645d3ba@oracle.com>
Date: Mon, 13 Aug 2018 18:02:18 +0800
MIME-Version: 1.0
In-Reply-To: <20180811071220.357-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 08/11/2018 03:12 PM, Ming Lei wrote:
> Not necessary to reserve tags for admin queue since there isn't
> many inflight commands in admin queue usually.
> 
> This change won't starve admin queue too because each blocked queue
> has equal priority to get one new tag when one driver tag is released,
> no matter it is freed from any queue.
> 

We don't count the adminq into tags->active_queues, there maybe following side-effect following:
 - if send a admin request for the LUN_a, it may cause LUN_b cannot get request even though its
   budget is allowed. And when the admin request for LUN_a is completed, LUN_b may not be in the
   first batch to be waked up.

 - all the LUNs still have to share a limited budget of tags

Certainly, I'm not sure whether the performance will be affected, all of above comments are
just concern in theory. ;)

Thanks
Jianchao
