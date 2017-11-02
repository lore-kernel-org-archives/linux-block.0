Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] ide: Make ide_cdrom_prep_fs() initialize the sense buffer
 pointer
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hongxu Jia <hongxu.jia@windriver.com>
References: <20171101223149.27593-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <64e7ec9a-eb5b-fbb9-2c8f-90b59cfba3cf@kernel.dk>
Date: Thu, 2 Nov 2017 08:28:12 -0600
MIME-Version: 1.0
In-Reply-To: <20171101223149.27593-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/01/2017 04:31 PM, Bart Van Assche wrote:
> The changes introduced through commit 82ed4db499b8 assume that the
> sense buffer pointer in struct scsi_request is initialized for all
> requests - passthrough and filesystem requests. Hence make sure
> that that pointer is initialized for filesystem requests. Remove
> the memset() call that clears .cmd because the scsi_req_init()
> call in ide_initialize_rq() already initializes the .cmd.

I'll queue this up for 4.15, post the initial merge.

-- 
Jens Axboe
