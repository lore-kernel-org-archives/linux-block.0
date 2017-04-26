Return-Path: <davem@davemloft.net>
Date: Wed, 26 Apr 2017 10:39:00 -0400 (EDT)
Message-Id: <20170426.103900.178089085115304059.davem@davemloft.net>
To: hch@lst.de
Cc: axboe@kernel.dk, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] ide-pm: always pass 0 error to
 __blk_end_request_all
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170426073422.14511-3-hch@lst.de>
References: <20170426073422.14511-1-hch@lst.de>
	<20170426073422.14511-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>
Date: Wed, 26 Apr 2017 09:34:21 +0200

> ide_pm_execute_rq exectures a PM request synchronously, and in the failure
> case where it calls __blk_end_request_all it never checks the error field
> passed to the end_io callback, so don't bother setting it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
