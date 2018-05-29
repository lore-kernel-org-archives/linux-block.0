Return-Path: <axboe@kernel.dk>
Subject: Re: check_disk_size_change tidyups
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20180529144259.29819-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ff092b10-5ff2-f626-249e-ea2a2fefaa4a@kernel.dk>
Date: Tue, 29 May 2018 08:51:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180529144259.29819-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/29/18 8:42 AM, Christoph Hellwig wrote:
> Remove the unused export, and suppress the size change message when the
> device went away.

Applied, thanks.

-- 
Jens Axboe
