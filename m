Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq-debugfs: Add names for recently added flags
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
References: <20170818225254.30706-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a779f150-ccb9-48dd-2266-486b4166cc4b@kernel.dk>
Date: Fri, 25 Aug 2017 08:07:53 -0600
MIME-Version: 1.0
In-Reply-To: <20170818225254.30706-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 04:52 PM, Bart Van Assche wrote:
> The symbolic constants QUEUE_FLAG_SCSI_PASSTHROUGH, QUEUE_FLAG_QUIESCED
> and REQ_NOWAIT are missing from blk-mq-debugfs.c. Add these to
> blk-mq-debugfs.c such that these appear as names in debugfs instead of
> as numbers.

Added for 4.13, thanks.

-- 
Jens Axboe
