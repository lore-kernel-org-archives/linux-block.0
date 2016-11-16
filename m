Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-bwt: fix old-style function declaration
To: Arnd Bergmann <arnd@arndb.de>
References: <20161116153007.3543720-1-arnd@arndb.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dfe64076-700c-a8a4-0507-5dfd3e695951@kernel.dk>
Date: Wed, 16 Nov 2016 08:33:05 -0700
MIME-Version: 1.0
In-Reply-To: <20161116153007.3543720-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/16/2016 08:29 AM, Arnd Bergmann wrote:
> The newly added driver causes a harmless warning in some configurations:
>
> block/blk-wbt.c:250:1: error: ‘inline’ is not at beginning of declaration [-Werror=old-style-declaration]
>  static bool inline stat_sample_valid(struct blk_rq_stat *stat)
>
> This makes it use the expected format for the declaration.

Thanks Arnd, applied with the subject typo fixed up.

-- 
Jens Axboe
