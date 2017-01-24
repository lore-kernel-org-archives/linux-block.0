Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix use after free in __blkdev_direct_IO
To: Christoph Hellwig <hch@lst.de>
References: <1485265819-2403-1-git-send-email-hch@lst.de>
Cc: m@bjorling.me, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <03114a65-d54f-f3c5-5fc8-cf761e9b0ddc@kernel.dk>
Date: Tue, 24 Jan 2017 07:56:07 -0700
MIME-Version: 1.0
In-Reply-To: <1485265819-2403-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/24/2017 06:50 AM, Christoph Hellwig wrote:
> We can't dereference the dio structure after submitting the last bio for
> this request, as I/O completion might have happened before the code is
> run. Introduce a local is_sync variable instead.

Applied.

-- 
Jens Axboe
