Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH -next] block: remove set but not used variable 'et'
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1541817674-19370-1-git-send-email-yuehaibing@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <daa59ba1-5786-d181-bd4f-17aefd639ed9@kernel.dk>
Date: Fri, 9 Nov 2018 20:08:24 -0700
MIME-Version: 1.0
In-Reply-To: <1541817674-19370-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 7:41 PM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> block/blk-ioc.c: In function 'put_io_context_active':
> block/blk-ioc.c:174:24: warning:
>  variable 'et' set but not used [-Wunused-but-set-variable]
> 
> It not used any more after commit
> a1ce35fa4985 ("block: remove dead elevator code")

Thanks, applied.

-- 
Jens Axboe
