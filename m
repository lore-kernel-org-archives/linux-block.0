Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH -next] blk-iolatency: remove set but not used variables
 'changed' and 'blkiolat'
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1536888911-54172-1-git-send-email-yuehaibing@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5b7bf9ea-335d-ba84-c469-cbe921ef8bc0@kernel.dk>
Date: Thu, 13 Sep 2018 19:59:48 -0600
MIME-Version: 1.0
In-Reply-To: <1536888911-54172-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/13/18 7:35 PM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> block/blk-iolatency.c: In function 'scale_change':
> block/blk-iolatency.c:301:7: warning:
>  variable 'changed' set but not used [-Wunused-but-set-variable]
> 
> block/blk-iolatency.c: In function 'iolatency_set_limit':
> block/blk-iolatency.c:765:24: warning:
>  variable 'blkiolat' set but not used [-Wunused-but-set-variable]

Applied, thanks.

-- 
Jens Axboe
