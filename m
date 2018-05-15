Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] jsflash: fix compilation
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, sparclinux@vger.kernel.org
References: <20180515183258.4440-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0d9ca090-5277-6c1c-9bff-477054f97746@kernel.dk>
Date: Tue, 15 May 2018 12:51:20 -0600
MIME-Version: 1.0
In-Reply-To: <20180515183258.4440-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/15/18 12:32 PM, Christoph Hellwig wrote:
> No bio in this whole function, use req->bio instead.

Applied.

> Looks like no one except for Guenters build bot cared.  I wonder if we
> should just get rid of the driver given that it doesn't look in a good
> shape at all based on his build logs even with the fix..

Needs input from the folks that actually might use it. The driver looks
abandoned, it's only getting updates through API changes etc.

-- 
Jens Axboe
