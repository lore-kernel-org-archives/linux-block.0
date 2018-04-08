Return-Path: <ming.lei@redhat.com>
Date: Sun, 8 Apr 2018 17:25:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [block regression] kernel oops triggered by removing scsi device
 dring IO
Message-ID: <20180408092541.GB24737@ming.t460p>
References: <20180408042112.GB19128@ming.t460p>
 <0c744185-2374-1485-81da-068e4ed0d82f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0c744185-2374-1485-81da-068e4ed0d82f@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 08, 2018 at 04:11:51PM +0800, Joseph Qi wrote:
> This is because scsi_remove_device() will call blk_cleanup_queue(), and
> then all blkgs have been destroyed and root_blkg is NULL.
> Thus tg is NULL and trigger NULL pointer dereference when get td from
> tg (tg->td).
> It seems that we cannot simply move blkcg_exit_queue() up to
> blk_cleanup_queue().

Maybe one per-queue blkcg should be introduced, which seems reasonable
too.

Thanks,
Ming
