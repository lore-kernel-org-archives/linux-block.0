Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH 13/25] block_dev: use blkdev_issue_zerout for hole punches
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
	<20170331163313.31821-14-hch@lst.de>
Date: Wed, 05 Apr 2017 07:48:24 -0400
In-Reply-To: <20170331163313.31821-14-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:33:01 +0200")
Message-ID: <yq1shlnrs6v.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> This gets us support for non-discard efficient write of zeroes
> (e.g. NVMe) and prepare for removing the discard_zeroes_data flag.
                         s

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
