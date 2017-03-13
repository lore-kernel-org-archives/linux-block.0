Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/4] blk-mq: improve blk_mq_try_issue_directly
Date: Mon, 13 Mar 2017 21:02:47 +0000
Message-ID: <1489438953.2658.25.camel@sandisk.com>
References: <20170313154833.14165-1-hch@lst.de>
	 <20170313154833.14165-4-hch@lst.de>
In-Reply-To: <20170313154833.14165-4-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-03-13 at 09:48 -0600, Christoph Hellwig wrote:
> Rename blk_mq_try_issue_directly to __blk_mq_try_issue_directly and add a
> new wrapper that takes care of RCU / SRCU locking to avoid having
> boileplate code in the caller which would get duplicated with new callers=
.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
