Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH 03/25] block: implement splitting of REQ_OP_WRITE_ZEROES bios
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
	<20170331163313.31821-4-hch@lst.de>
Date: Wed, 05 Apr 2017 07:43:40 -0400
In-Reply-To: <20170331163313.31821-4-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:32:51 +0200")
Message-ID: <yq1inmjt6z7.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> Copy and past the REQ_OP_WRITE_SAME code to prepare to implementations
> that limit the write zeroes size.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
