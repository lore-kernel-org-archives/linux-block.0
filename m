Return-Path: <ming.lei@redhat.com>
Date: Sat, 23 Jun 2018 05:33:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
	linux-scsi@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: avoid to synchronize rcu inside
 blk_cleanup_queue()
Message-ID: <20180622213333.GB2949@ming.t460p>
References: <20180620025522.8002-1-ming.lei@redhat.com>
 <86ef306e-e16a-dba5-29b8-469d92eec9f4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <86ef306e-e16a-dba5-29b8-469d92eec9f4@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 22, 2018 at 08:47:35AM -0600, Jens Axboe wrote:
> On 6/19/18 8:55 PM, Ming Lei wrote:
> > SCSI probing may synchronously create and destroy a lot of request_queues
> > for non-existent devices. Any synchronize_rcu() in queue creation or
> > destroy path may introduce long latency during booting, see detailed
> > description in comment of blk_register_queue().
> > 
> > This patch removes two synchronize_rcu() inside blk_cleanup_queue()
> > for this case:
> > 
> > 1) commit c2856ae2f315d75(blk-mq: quiesce queue before freeing queue)
> > need synchronize_rcu() for implementing blk_mq_quiesce_queue(), but
> > when queue isn't initialized, it isn't necessary to do that since
> > only pass-through requests are involved, no original issue in
> > scsi_execute() at all.
> > 
> > 2) when only one request queue is attached to tags, no necessary to
> > call synchronize_rcu() too.
> > 
> > Without this patch, it may take more 20+ seconds for virtio-scsi to
> > complete disk probe. With this patch, the time becomes less than 100ms.
> 
> Looks reasonable to me. But this is something that we've been breaking
> multiple times over the years, any chance you could add a blktests
> test for it?

Looks a good idea, I guess it can be triggered on scsi_debug too, will cook
a patch later.

thanks,
Ming
