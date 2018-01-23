Return-Path: <msnitzer@redhat.com>
Date: Tue, 23 Jan 2018 11:20:20 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] blk-mq: introduce BLK_STS_DEV_RESOURCE
Message-ID: <20180123162020.GA25863@redhat.com>
References: <20180123161613.14214-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123161613.14214-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 23 2018 at 11:16am -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> This status is returned from driver to block layer if device related
> resource is run out of, but driver can guarantee that IO dispatch will
> be triggered in future when the resource is available.
> 
> This patch converts some drivers to use this return value. Meantime
> if driver returns BLK_STS_RESOURCE and S_SCHED_RESTART is marked, run
> queue after 10ms for avoiding IO hang.
> 
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Mike Snitzer <snitzer@redhat.com>

Thanks Ming
