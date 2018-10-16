Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH -next] null_blk: remove set but not used variable 'q'
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1539654326-165410-1-git-send-email-yuehaibing@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ad638446-2ce6-34f4-ed7a-a3cafaabc2b4@kernel.dk>
Date: Mon, 15 Oct 2018 20:03:29 -0600
MIME-Version: 1.0
In-Reply-To: <1539654326-165410-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/15/18 7:45 PM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/block/null_blk_main.c: In function 'end_cmd':
> drivers/block/null_blk_main.c:609:24: warning:
>  variable 'q' set but not used [-Wunused-but-set-variable]
> 
> It not used any more after commit
> e50b1e327aeb ("null_blk: remove legacy IO path")

Thanks, applied.

-- 
Jens Axboe
