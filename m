Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Wed, 8 Aug 2018 10:06:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] SCSI: introduce per-host admin queue & enable
 runtime PM
In-Reply-To: <20180807174433.8374-1-ming.lei@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1808081001260.1466-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, 8 Aug 2018, Ming Lei wrote:

> Hi,
> 
> This patchset introduces per-host admin request queue for submitting
> admin request only, and uses this approach to implement both SCSI
> quiesce and runtime PM in one very simply way. Also runtime PM deadlock
> can be avoided in case that request pool is used up.
> 
> The idea is borrowed from NVMe.
> 
> Admin request is submitted via per-host admin queue, and it is still
> associated with the same scsi_device as before, and respects this
> scsi_device's all kinds of limits. Admin queue shares host tags with
> other IO queues.
> 
> One core idea is that for admin request submitted from this admin queue,
> this request won't be called back to block layer via the associated IO
> queue(scsi_device). And this is done in the 3rd patch. So once IO queue
> is frozen, it can be observed as really frozen from block layer view.
> 
> SCSI quiesce is implemented by admin queue in very simple way, see patch
> 12.
> 
> Also runtime PM for legacy path can be simplified too, see patch 13.
> 
> Finally blk-mq simply follows legacy's approach for supporting runtime PM.
> 
> Any comments are welcome!

The admin queue is meant for a few other types of request, not just PM
requests, right?

Which raises a question: How do you prevent those other types of 
request, once they are added to the admin queue, from being sent to the 
device while it is in low-power mode?

Or turn the question around: Suppose you prevent all requests, even 
those on the admin queue, from being sent to the device while it is in 
low-power mode.  Then how do you send the request which tells the 
device to go back to full power?

It seems to me that any queue-based approach needs to be aware of which
requests will actually change the device's power level.

Alan Stern
