Return-Path: <ming.lei@redhat.com>
Date: Sat, 24 Feb 2018 20:44:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 0/6] Fix races between blkcg code and request queue
 initialization and cleanup
Message-ID: <20180224124427.GA26192@ming.t460p>
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180223010808.25765-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 22, 2018 at 05:08:02PM -0800, Bart Van Assche wrote:
> Hello Jens,
> 
> Recently Joseph Qi identified races between the block cgroup code and request
> queue initialization and cleanup. This patch series address these races. Please
> consider these patches for kernel v4.17.
> 
> Thanks,
> 
> Bart.
> 
> Changes between v3 and v4:
> - Added three patches that fix the calling order of del_gendisk() and
>   blk_cleanup_queue() in multiple block drivers.

Suggest to add description about the reason why we have to delete
gendisk before blk_cleanup_queue() in commit log.

For patches 1 ~ 3:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
