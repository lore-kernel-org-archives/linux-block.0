Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove blk_mq_alloc_single_hw_queue() prototype
To: Linus Walleij <linus.walleij@linaro.org>, linux-block@vger.kernel.org
References: <1473856395-22262-1-git-send-email-linus.walleij@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <07f6c7be-69e6-29c2-0a6a-9ec38282e614@kernel.dk>
Date: Wed, 14 Sep 2016 08:45:14 -0600
MIME-Version: 1.0
In-Reply-To: <1473856395-22262-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/14/2016 06:33 AM, Linus Walleij wrote:
> The blk_mq_alloc_single_hw_queue() is a prototype artifact that
> should have been removed with
> commit cdef54dd85ad66e77262ea57796a3e81683dd5d6
> "blk-mq: remove alloc_hctx and free_hctx methods" where the last
> users of it were deleted.

Added for 4.9, thanks.

-- 
Jens Axboe
