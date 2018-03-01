Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] mq-deadline: Make sure to always unlock zones
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <damien.lemoal@wdc.com>, Hannes Reinecke <hare@suse.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20180228173529.24941-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eb438a70-d09b-d311-718c-ef73a037afe6@kernel.dk>
Date: Thu, 1 Mar 2018 08:39:41 -0700
MIME-Version: 1.0
In-Reply-To: <20180228173529.24941-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/28/18 10:35 AM, Bart Van Assche wrote:
> From: Damien Le Moal <damien.lemoal@wdc.com>
> 
> In case of a failed write request (all retries failed) and when using
> libata, the SCSI error handler calls scsi_finish_command(). In the
> case of blk-mq this means that scsi_mq_done() does not get called,
> that blk_mq_complete_request() does not get called and also that the
> mq-deadline .completed_request() method is not called. This results in
> the target zone of the failed write request being left in a locked
> state, preventing that any new write requests are issued to the same
> zone.
> 
> Fix this by replacing the .completed_request() method with the
> .finish_request() method as this method is always called whether or
> not a request completes successfully. Since the .finish_request()
> method is only called by the blk-mq core if a .prepare_request()
> method exists, add a dummy .prepare_request() method.

Thanks, applied for 4.16.

-- 
Jens Axboe
