Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH 11/25] block: add a REQ_UNMAP flag for REQ_OP_WRITE_ZEROES
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
	<20170331163313.31821-12-hch@lst.de>
Date: Wed, 05 Apr 2017 07:46:55 -0400
In-Reply-To: <20170331163313.31821-12-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:32:59 +0200")
Message-ID: <yq11st7t6ts.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> If this flag is set logical provisioning capable device should
> release space for the zeroed blocks if possible, if it is not set
> devices should keep the blocks anchored.
>
> Also remove an out of sync kerneldoc comment for a static function
> that would have become even more out of data with this change.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
