Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH 22/25] block: stop using discards for zeroing
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
	<20170331163313.31821-23-hch@lst.de>
Date: Wed, 05 Apr 2017 07:55:39 -0400
In-Reply-To: <20170331163313.31821-23-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:33:10 +0200")
Message-ID: <yq1fuhnrrus.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> Now that we have REQ_OP_WRITE_ZEROES implemented for all devices that
> support efficient zeroing of devices we can remove the call to

s/of devices/

> blkdev_issue_discard.  This means we only have two ways of zeroing
> left and can simply the code.

simplify

> + *  Note that this function may fail with -EOPNOTSUPP if the driver supports
> + *  efficient zeroing operation, but the device capabilities can only be
> + *  discovered by trial and error.  In this case the caller should call the
> + *  function again, and it will use the fallback path.

Maybe:

"Note that this function may fail with -EOPNOTSUPP if the driver signals
zeroing offload support but the device fails to process the command (for
some devices there is no non-destructive way to verify whether this
operation is actually supported). If -EOPNOTSUPP is returned, the caller
should retry the blkdev_issue_zeroout() and the fallback path will be
used."

Otherwise OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
