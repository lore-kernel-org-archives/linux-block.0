Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix timeout changes for legacy request drivers
To: Christoph Hellwig <hch@lst.de>
Cc: jianchao.w.wang@oracle.com, linux-block@vger.kernel.org
References: <20180619164014.13621-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2534f376-cfa9-71ea-6f7b-92105ced9178@kernel.dk>
Date: Tue, 19 Jun 2018 11:07:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180619164014.13621-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/19/18 10:40 AM, Christoph Hellwig wrote:
> blk_mq_complete_request can only be called for blk-mq drivers, but when
> removing the BLK_EH_HANDLED return value, two legacy request timeout
> methods incorrectly got switched to call blk_mq_complete_request.
> Call __blk_complete_request instead to reinstance the previous behavior.
> For that __blk_complete_request needs to be exported.

Yikes. Looks like blktests only smoke tests blk-mq timeout handling,
we should add a test to do the same for !mq.

-- 
Jens Axboe
