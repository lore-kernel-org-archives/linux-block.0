Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH 12/25] block: add a new BLKDEV_ZERO_NOFALLBACK flag
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
	<20170331163313.31821-13-hch@lst.de>
Date: Wed, 05 Apr 2017 07:47:39 -0400
In-Reply-To: <20170331163313.31821-13-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:33:00 +0200")
Message-ID: <yq1wpazrs84.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> This avoids fallbacks to explicit zeroing in (__)blkdev_issue_zeroout
> if the caller doesn't want them.
>
> Also clean up the convoluted check for the return condition that this
> new flag is added to.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
