Return-Path: <lars.ellenberg@linbit.com>
Return-Path: <lars.ellenberg@linbit.com>
Date: Thu, 30 Mar 2017 12:06:41 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com, dm-devel@redhat.com,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 22/23] drbd: implement REQ_OP_WRITE_ZEROES
Message-ID: <20170330100641.GI5939@soda.linbit>
References: <20170323143341.31549-1-hch@lst.de>
 <20170323143341.31549-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170323143341.31549-23-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 23, 2017 at 10:33:40AM -0400, Christoph Hellwig wrote:
> It seems like DRBD assumes its on the wire TRIM request always zeroes data.
> Use that fact to implement REQ_OP_WRITE_ZEROES.
> 
> XXX: will need a careful audit from the drbd team!

Thanks, this one looks ok to me.

The real question for me is, will the previous one (21/23)
return != 0 (some EOPNOTSUPP or else) to DRBD in more situations than
what we have now?  Will it make an fstrim cause thinly provisioned
devices to suddenly be fully allocated?
Or does it unmap "the same" as what we have now?
Especially on top of dm-thin, but also on top of any other device.
That's something that is not really "obvious" to me yet.

Cheers,
    Lars
