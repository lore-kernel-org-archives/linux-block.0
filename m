Return-Path: <hch@lst.de>
Date: Fri, 14 Sep 2018 15:01:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v4 04/10] block: Move power management code into a new
 source file
Message-ID: <20180914130100.GC26651@lst.de>
References: <20180804000325.3610-1-bart.vanassche@wdc.com> <20180804000325.3610-5-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180804000325.3610-5-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

>  11 files changed, 266 insertions(+), 239 deletions(-)
>  create mode 100644 block/blk-pm.c
>  create mode 100644 block/blk-pm.h
>  create mode 100644 include/linux/blk-pm.h
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 1f2469a0123c..e213d90a5e64 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -228,4 +228,9 @@ config BLK_MQ_RDMA
>  	depends on BLOCK && INFINIBAND
>  	default y
>  
> +config BLK_PM
> +	bool
> +	depends on BLOCK && PM
> +	default y

This could be shortened to

config BLK_PM
	def_bool BLOCK && PM

Also a lot of this code is only used by scsi.  I really wonder if
we should move it into scsi instead, and if not at least make it
a selectable option that only scsi selects.
