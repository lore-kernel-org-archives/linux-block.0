Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-debugfs: Also show requests that have not yet been
 started
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20180112215207.17852-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <78a60ddb-7e5f-3dac-2024-390e17da02f8@kernel.dk>
Date: Fri, 12 Jan 2018 14:55:57 -0700
MIME-Version: 1.0
In-Reply-To: <20180112215207.17852-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/12/18 2:52 PM, Bart Van Assche wrote:
> When debugging e.g. the SCSI timeout handler it is important that
> requests that have not yet been started or that already have
> completed are also reported through debugfs.
> 
> This patch depends on a patch that went upstream recently, namely
> commit 14e3062fb185 ("scsi: core: Fix a scsi_show_rq() NULL pointer
> dereference").

Why don't we just kill the check, and dump any request that has a
matching hctx? We already know the bit was set, so just print
all of them.

-- 
Jens Axboe
