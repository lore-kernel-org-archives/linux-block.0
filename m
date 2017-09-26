Return-Path: <ming.lei@redhat.com>
Date: Tue, 26 Sep 2017 16:34:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v4 2/7] block: Make q_usage_counter also track legacy
 requests
Message-ID: <20170926083424.GC518@ming.t460p>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
 <20170925202924.16603-3-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925202924.16603-3-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 01:29:19PM -0700, Bart Van Assche wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> This patch makes it possible to pause request allocation for
> the legacy block layer by calling blk_mq_freeze_queue() and
> blk_mq_unfreeze_queue().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [ bvanassche: Combined two patches into one, edited a comment and made sure
>   REQ_NOWAIT is handled properly in blk_old_get_request() ]
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---

Thanks for considering block legacy path in this version!

-- 
Ming
