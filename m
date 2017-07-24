Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH for-4.13] block: disable runtime-pm for blk-mq
To: Christoph Hellwig <hch@lst.de>
Cc: ming.lei@redhat.com, tomi.p.sarvela@intel.com, evangelos@foutrelis.com,
 linux-block@vger.kernel.org
References: <20170721114610.25582-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ffc7b0ae-36e0-90bd-5f50-4e31dc7f64b5@kernel.dk>
Date: Mon, 24 Jul 2017 08:51:05 -0600
MIME-Version: 1.0
In-Reply-To: <20170721114610.25582-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/21/2017 05:46 AM, Christoph Hellwig wrote:
> The blk-mq code lacks support for looking at the rpm_status field, tracking
> active requests and the RQF_PM flag.
> 
> Due to the default switch to blk-mq for scsi people start to run into
> suspend / resume issue due to this fact, so make sure we disable the runtime
> PM functionality until it is properly implemented.

Added, thanks.

-- 
Jens Axboe
