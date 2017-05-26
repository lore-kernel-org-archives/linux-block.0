Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] blk-mq: Only register debugfs attributes for blk-mq
 queues
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
 <20170525233810.23211-2-bart.vanassche@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bf01823a-d50d-6168-894d-17970c5b7a63@kernel.dk>
Date: Fri, 26 May 2017 07:27:13 -0600
MIME-Version: 1.0
In-Reply-To: <20170525233810.23211-2-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/25/2017 05:38 PM, Bart Van Assche wrote:
> The code in blk-mq-debugfs.c assumes that it is working on a blk-mq
> queue and is not intended to work on a blk-sq queue. Hence only
> register blk-mq debugfs attributes for blk-mq queues.

Thanks Bart, I have queued this up for this series.

-- 
Jens Axboe
