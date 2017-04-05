Return-Path: <hch@lst.de>
Date: Wed, 5 Apr 2017 14:08:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
	dm-devel@redhat.com, linux-raid@vger.kernel.org
Subject: Re: always use REQ_OP_WRITE_ZEROES for zeroing offload
Message-ID: <20170405120826.GA2275@lst.de>
References: <20170331163313.31821-1-hch@lst.de> <yq1vaqjt74b.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1vaqjt74b.fsf@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 05, 2017 at 07:40:36AM -0400, Martin K. Petersen wrote:
> > This series makes REQ_OP_WRITE_ZEROES the only zeroing offload
> > supported by the block layer, and switches existing implementations
> > of REQ_OP_DISCARD that correctly set discard_zeroes_data to it,
> > removes incorrect discard_zeroes_data, and also switches WRITE SAME
> > based zeroing in SCSI to this new method.
> 
> Very, very nice. I think this is the correct approach.
> 
> I'm going to send two follow-up patches that allow us to use UNMAP for
> discards and WRITE SAME w/ UNMAP for zeroout. That appears to be the
> preferred configuration for most storage devices.

Thanks, I'll resend it with your nitpicks fixed, your follow on
patches tacked on and the various reviewed-by tags in a bit.
