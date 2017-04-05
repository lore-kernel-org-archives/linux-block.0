Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com, linux-raid@vger.kernel.org
Subject: Re: always use REQ_OP_WRITE_ZEROES for zeroing offload
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
Date: Wed, 05 Apr 2017 07:40:36 -0400
In-Reply-To: <20170331163313.31821-1-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:32:48 +0200")
Message-ID: <yq1vaqjt74b.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

Christoph,

> This series makes REQ_OP_WRITE_ZEROES the only zeroing offload
> supported by the block layer, and switches existing implementations
> of REQ_OP_DISCARD that correctly set discard_zeroes_data to it,
> removes incorrect discard_zeroes_data, and also switches WRITE SAME
> based zeroing in SCSI to this new method.

Very, very nice. I think this is the correct approach.

I'm going to send two follow-up patches that allow us to use UNMAP for
discards and WRITE SAME w/ UNMAP for zeroout. That appears to be the
preferred configuration for most storage devices.

-- 
Martin K. Petersen	Oracle Linux Engineering
