Return-Path: <axboe@kernel.dk>
Date: Fri, 18 Aug 2017 08:35:46 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 06/12] blk-mq-debugfs: Generate name-to-text translation
 tables
Message-ID: <20170818143545.GB20707@kernel.dk>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-7-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817232311.25948-7-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 17 2017, Bart Van Assche wrote:
> It is easy to add a flag to one of the block layer headers and to
> forget to update blk-mq-debugfs.c. E.g. QUEUE_FLAG_SCSI_PASSTHROUGH,
> QUEUE_FLAG_QUIESCED and REQ_NOWAIT are missing from blk-mq-debugfs.c.
> Hence generate the symbol-to-text translation tables.

This is just too ugly to live...

-- 
Jens Axboe
