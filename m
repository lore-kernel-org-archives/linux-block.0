Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block/floppy: remove redundant variable dflags
To: Colin King <colin.king@canonical.com>, Jiri Kosina <jikos@kernel.org>,
 linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702074234.10435-1-colin.king@canonical.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <def4a200-a68a-3290-73d5-bd1c98626283@kernel.dk>
Date: Mon, 2 Jul 2018 08:27:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180702074234.10435-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/2/18 1:42 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable dflags is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'dflags' set but not used [-Wunused-but-set-variable]

Applied for 4.19, thanks.

-- 
Jens Axboe
