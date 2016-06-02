Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: really fix plug list flushing for nomerge queues
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>
References: <cb7c4181478c6483fa3d5fe499f53cb9dc937f44.1464844522.git.osandov@fb.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com, Omar Sandoval <osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57507146.5080809@kernel.dk>
Date: Thu, 2 Jun 2016 11:47:50 -0600
MIME-Version: 1.0
In-Reply-To: <cb7c4181478c6483fa3d5fe499f53cb9dc937f44.1464844522.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/01/2016 11:18 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> Commit 0809e3ac6231 ("block: fix plug list flushing for nomerge queues")
> updated blk_mq_make_request() to set request_count even when
> blk_queue_nomerges() returns true. However, blk_mq_make_request() only
> does limited plugging and doesn't use request_count;
> blk_sq_make_request() is the one that should have been fixed. Do that
> and get rid of the unnecessary work in the mq version.

Thanks Omar, applied for this series.

-- 
Jens Axboe
