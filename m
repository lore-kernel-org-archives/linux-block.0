Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] paride: remove redundant variable n
To: Colin King <colin.king@canonical.com>, Tim Waugh <tim@cyberelk.net>,
 linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702081419.12207-1-colin.king@canonical.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <213e1e8a-d962-c4bf-cfbe-69ebb5628747@kernel.dk>
Date: Mon, 2 Jul 2018 08:28:50 -0600
MIME-Version: 1.0
In-Reply-To: <20180702081419.12207-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/2/18 2:14 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable n is being assigned but is never used hence it is redundant
> and can be removed. Also put spacing between variables in declaration
> to clean up checkpatch warnings.
> 
> Cleans up clang warning:
> warning: variable 'n' set but not used [-Wunused-but-set-variable]

Applied for 4.19, thanks.

-- 
Jens Axboe
