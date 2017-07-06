Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] cciss: initialize struct scsi_req
To: Christoph Hellwig <hch@lst.de>
Cc: Meelis Roos <mroos@linux.ee>, Bart Van Assche
 <bart.vanassche@sandisk.com>, linux-block@vger.kernel.org
References: <20170706173220.22129-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <479ad66b-f715-5554-b08b-df25e29793e1@kernel.dk>
Date: Thu, 6 Jul 2017 12:24:04 -0600
MIME-Version: 1.0
In-Reply-To: <20170706173220.22129-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/06/2017 11:32 AM, Christoph Hellwig wrote:
> The changes in "block: Make most scsi_req_init() calls implicit" mean
> that every driver that supports the generic scsi ioctls needs to
> call scsi_req_init on newly allocated requests, but that commit didn't
> add the call to the ccіss driver.  Fix that to avoid crashes when
> udev issues SG_IO commands.

Applied, thanks.

-- 
Jens Axboe
