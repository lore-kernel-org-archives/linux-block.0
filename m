Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remov blk_queue_invalidate_tags
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20180615115507.26745-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2e8de4d7-3aeb-fb6c-6b3e-4329d2f1b026@kernel.dk>
Date: Fri, 15 Jun 2018 08:13:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180615115507.26745-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/15/18 5:55 AM, Christoph Hellwig wrote:
> This function is entirely unused, so remove it and the tag_queue_busy
> member of struct request_queue.

Applied, thanks.

-- 
Jens Axboe
