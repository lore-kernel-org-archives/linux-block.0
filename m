Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] sbitmap: avoid maybe-uninitialized warning
To: Arnd Bergmann <arnd@arndb.de>
References: <20160919123359.1225305-1-arnd@arndb.de>
Cc: Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6efcc3e0-b85f-9612-2562-d37922a1dc92@kernel.dk>
Date: Mon, 19 Sep 2016 08:43:12 -0600
MIME-Version: 1.0
In-Reply-To: <20160919123359.1225305-1-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/19/2016 06:33 AM, Arnd Bergmann wrote:
> The sbitmap code that has just been turned into a library module
> returns uninitialized data for sbitmap_weight(), as pointed out by
> gcc when building with -Wmaybe-uninitialized:
>
> lib/sbitmap.c: In function 'sbitmap_weight':
> lib/sbitmap.c:179:9: error: 'weight' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> Note that the value is never initialized, we just add data on
> top, so it is wrong regardless of sb->map_nr.
>
> This adds the missing initialization.

Thanks Arnd, Colin sent the same patch and I applied it. Note that:

> Fixes: 88459642cba4 ("blk-mq: abstract tag allocation out into sbitmap library")

that isn't truly correct, that patch is just what moved the code. The 
bug predates that commit.

-- 
Jens Axboe
