Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] partitions/ldm: remove redundant pointer dgrp
To: Colin King <colin.king@canonical.com>, Richard Russon <ldm@flatcap.org>,
 linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702071359.6534-1-colin.king@canonical.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d3ea960d-90eb-1bda-2d24-7730a94d3285@kernel.dk>
Date: Mon, 2 Jul 2018 08:26:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180702071359.6534-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/2/18 1:13 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer dgrp is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'dgrp' set but not used [-Wunused-but-set-variable]

Applied for 4.19, thanks.

-- 
Jens Axboe
