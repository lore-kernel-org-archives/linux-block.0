Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: pass full fmode_t to blk_verify_command
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20171105073631.9132-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fafd0e6c-a2c5-d3b6-28d8-19f2cc95d222@kernel.dk>
Date: Wed, 8 Nov 2017 11:18:32 -0700
MIME-Version: 1.0
In-Reply-To: <20171105073631.9132-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/05/2017 01:36 AM, Christoph Hellwig wrote:
> Use the obvious calling convention.

Applied, thanks.

-- 
Jens Axboe
