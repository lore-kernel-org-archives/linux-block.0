Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] loop: remove redundant pointer inode
To: Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702074706.10586-1-colin.king@canonical.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1ab10ca5-4d2e-d95c-d1aa-3b510b874d2e@kernel.dk>
Date: Mon, 2 Jul 2018 08:27:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180702074706.10586-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/2/18 1:47 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer inode is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'inode' set but not used [-Wunused-but-set-variable]

Applied for 4.19, thanks.

-- 
Jens Axboe
