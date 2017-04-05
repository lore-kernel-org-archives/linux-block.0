Return-Path: <hch@lst.de>
Date: Wed, 5 Apr 2017 16:51:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com, dm-devel@redhat.com,
	linux-raid@vger.kernel.org
Subject: Re: always use REQ_OP_WRITE_ZEROES for zeroing offload V2
Message-ID: <20170405145142.GA5553@lst.de>
References: <20170405142205.6477-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170405142205.6477-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Looks like the mail server crapped out under the load..

I'll resend tomorrow morning, in the meantime the git url below
works.

On Wed, Apr 05, 2017 at 04:21:38PM +0200, Christoph Hellwig wrote:
> This series makes REQ_OP_WRITE_ZEROES the only zeroing offload
> supported by the block layer, and switches existing implementations
> of REQ_OP_DISCARD that correctly set discard_zeroes_data to it,
> removes incorrect discard_zeroes_data, and also switches WRITE SAME
> based zeroing in SCSI to this new method.
> 
> The series is against the block for-next tree.
> 
> A git tree is also avaiable at:
> 
>     git://git.infradead.org/users/hch/block.git discard-rework.2
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/discard-rework.2
> 
> Changes since V2:
>  - various spelling fixes
>  - various reviews captured
>  - two new patches from Martin at the end
---end quoted text---
