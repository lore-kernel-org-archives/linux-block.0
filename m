Return-Path: <axboe@kernel.dk>
Subject: Re: remove most req->special users v2
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20181110083049.17475-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2c4d10e5-b83f-7c9d-f295-dbcf7c3d4217@kernel.dk>
Date: Sat, 10 Nov 2018 08:04:29 -0700
MIME-Version: 1.0
In-Reply-To: <20181110083049.17475-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/10/18 1:30 AM, Christoph Hellwig wrote:
> Try to get rid of the req->special users so that we can remove this
> field.  With this series we basically only have the osd / scsi BIDI
> code left, which should go away in another series.
> 
> Note that the first one is a bug fix for the blk-mq conversion
> series, I don't think the current fnic code can work, but this
> version is only compile tested as well.

Applied, thanks.

-- 
Jens Axboe
