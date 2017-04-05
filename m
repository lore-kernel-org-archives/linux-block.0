Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH 25/25] block: remove the discard_zeroes_data flag
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
	<20170331163313.31821-26-hch@lst.de>
Date: Wed, 05 Apr 2017 07:56:49 -0400
In-Reply-To: <20170331163313.31821-26-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:33:13 +0200")
Message-ID: <yq1bmsbrrsu.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> Now that we use the proper REQ_OP_WRITE_ZEROES operation everywhere we
> can kill this hack.

Oh yeah!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
