Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [RFC PATCH V2 16/17] block: simplify runtime PM support
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20180811071220.357-1-ming.lei@redhat.com>
 <20180811071220.357-17-ming.lei@redhat.com>
 <6baaef0e-6845-d3d5-6d78-85ce89bc0a2a@oracle.com>
 <20180815082803.GA26016@ming.t460p>
 <bec354c7-3c62-e55e-453b-a1916001e313@oracle.com>
 <20180815112302.GA27213@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <73713a10-4127-f0c4-5658-983aad55fcc6@oracle.com>
Date: Thu, 16 Aug 2018 16:26:30 +0800
MIME-Version: 1.0
In-Reply-To: <20180815112302.GA27213@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 08/15/2018 07:23 PM, Ming Lei wrote:
> We may do that, but seems not necessary given the .runtime_suspend()
> (scsi_runtime_suspend) is just called when the timer is expired.
> 
> As we know, even there is request entering queue during the suspend
> window, not a big deal, the current approach still works fine.

Yes, indeed. :)

Thanks
Jianchao
