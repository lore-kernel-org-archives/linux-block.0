Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC V2 0/3] blk-mq: support runtime PM
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
References: <20180713080602.31602-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c4147a47-876f-0ced-6c9d-1c3792d09858@kernel.dk>
Date: Fri, 13 Jul 2018 08:21:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180713080602.31602-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/13/18 2:05 AM, Ming Lei wrote:
> Hi Guys,
> 
> Runtime PM is usually enabled for SCSI devices, and we are switching to
> SCSI_MQ recently, but runtime PM isn't supported yet by blk-mq, and
> people may complain that.
> 
> This patch tries to support runtime PM for blk-mq. And one chanllenge is
> that it can be quite expensive to account the active in-flight IOs for
> figuring out when to mark the last busy. This patch simply marks busy
> after each non-PM IO is done, and this way is workable because:
> 
> 1) pm_runtime_mark_last_busy() is very cheap
> 
> 2) in-flight non-PM IO is checked in blk_pre_runtime_suspend(), so
> if there is any IO queued, the device will be prevented from being
> suspened.
> 
> 3) Generally speaking, autosuspend_delay_ms is often big, and should
> be in unit of second, so it shouldn't be a big deal to check if queue
> is idle in blk_pre_runtime_suspend().
> 
> 
> V2:
> 	- re-organize code as suggested by Christoph
> 	- use seqlock to sync runtime PM and IO path

See other mail on why this is not going to be acceptable.

-- 
Jens Axboe
