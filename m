Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4] dm: don't allow ioctls to targets that don't map to
 whole devices
To: Christoph Hellwig <hch@lst.de>, snitzer@redhat.com
References: <20170204094503.19322-1-hch@lst.de>
Cc: agk@redhat.com, pbonzini@redhat.com, dm-devel@redhat.com,
 linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <420daead-8b81-c9ad-87cf-7d2e9ab2fc11@kernel.dk>
Date: Sat, 4 Feb 2017 10:20:10 -0700
MIME-Version: 1.0
In-Reply-To: <20170204094503.19322-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/04/2017 02:45 AM, Christoph Hellwig wrote:
> .. at least for unprivileged users.  Before we called into the SCSI
> ioctl code to allow excemptions for a few SCSI passthrough ioctls,
> but this is pretty unsafe and except for this call dm knows nothing
> about SCSI ioctls.
> 
> As the SCSI ioctl code is now optional, we really don't want to
> drag it in for DM, and the exception is not very useful anyway.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mike Snitzer <snitzer@redhat.com>

Added, with the acks/reviews from Johannes and Pablo added.

-- 
Jens Axboe
