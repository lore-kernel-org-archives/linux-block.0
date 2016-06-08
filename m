Return-Path: <hch@lst.de>
Date: Wed, 8 Jun 2016 13:54:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, keith.busch@intel.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ming Lin <ming.l@ssi.samsung.com>
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_alloc_request_hctx
Message-ID: <20160608115434.GA30912@lst.de>
References: <1465248119-17875-1-git-send-email-hch@lst.de> <1465248119-17875-2-git-send-email-hch@lst.de> <5757A3D2.1030003@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5757A3D2.1030003@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 07, 2016 at 10:49:22PM -0600, Jens Axboe wrote:
> Why are we duplicating this code here? If NOWAIT isn't set, then we'll
> always return a request. bt_get() will run the queue for us, if it needs
> to. blk_mq_alloc_request() does this too, and I'm guessing that code was
> just copied. I'll fix that up. Looks like this should just be:

The generic code is a bit of a mess as it does the nowait optimization
in two different cases, I'll send you a separate cleanup patch for that.
