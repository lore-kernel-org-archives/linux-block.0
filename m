Return-Path: <ming.lei@redhat.com>
Date: Wed, 8 Aug 2018 16:21:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v5 1/9] block: Change the preempt-only flag into a counter
Message-ID: <20180808082136.GA13518@ming.t460p>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
 <20180807225133.27221-2-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180807225133.27221-2-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 07, 2018 at 03:51:25PM -0700, Bart Van Assche wrote:
> The RQF_PREEMPT flag is used for three purposes:
> - In the SCSI core, for making sure that power management requests
>   are executed if a device is in the "quiesced" state.
> - For domain validation by SCSI drivers that use the parallel port.
> - In the IDE driver, for IDE preempt requests.

I think the above description may not be accurate, BLK_MQ_REQ_PREEMPT is
always set inside scsi_execute(), that means any scsi_execute() callers
can use the flag of RQF_PREEMPT, of course, not limited to the above
three cases.


Thanks,
Ming
