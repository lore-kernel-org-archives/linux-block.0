Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] virtio_blk: Fix an SG_IO regression
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Dann Frazier <dann.frazier@canonical.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org
References: <20171024060436.24954-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <322bcd13-699b-5616-124c-4d337d17ec3c@kernel.dk>
Date: Tue, 24 Oct 2017 07:48:33 -0600
MIME-Version: 1.0
In-Reply-To: <20171024060436.24954-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/24/2017 12:04 AM, Bart Van Assche wrote:
> Avoid that submitting an SG_IO ioctl triggers a kernel oops that
> is preceded by:
> 
> usercopy: kernel memory overwrite attempt detected to (null) (<null>) (6 bytes)
> kernel BUG at mm/usercopy.c:72!
> 
> Additionally, make it easier to diagnose crashes like the one
> fixed by this patch.

This really should have been two patches... Anyway, applied for 4.14.

-- 
Jens Axboe
