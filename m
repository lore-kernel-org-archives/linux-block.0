Return-Path: <hch@lst.de>
Date: Wed, 24 Oct 2018 13:22:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, tom.leiming@gmail.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] block: fix the DISCARD request merge
Message-ID: <20181024112253.GA18207@lst.de>
References: <1540350450-15208-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1540350450-15208-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

> -	/*
> -	 * not contiguous
> -	 */
> -	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
> -		return NULL;
> -

As suggested previously I think we want something like blk_try_merge
and its return values here.  Maybe a blk_try_req_merge that takes
requests instead of bios.
