Return-Path: <axboe@kernel.dk>
Date: Sat, 6 Jan 2018 09:26:11 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH V3 0/4] blk-mq: fix race related with device
 deletion/reset/switching sched
Message-ID: <20180106162610.GC6343@kernel.dk>
References: <20180106082740.26442-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180106082740.26442-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Jan 06 2018, Ming Lei wrote:
> Hi,
> 
> The 1st patch fixes one kernel oops triggered by IOs vs. deleting SCSI
> device, and this issue can be triggered easily on scsi_debug.
> 
> The other 3 patch fixes recent Yi Zhang's reports about his NVMe stress
> tests, most of them are related with switching io sched, NVMe reset or
> updating nr_hw_queues.

Applied for 4.16, thanks.

-- 
Jens Axboe
