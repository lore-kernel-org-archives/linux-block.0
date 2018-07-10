Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: iolatency: avoid 64-bit division
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <jbacik@fb.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180710152146.2371336-1-arnd@arndb.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d9014b7b-2eca-97ba-7e04-4f7f99e88c9b@kernel.dk>
Date: Tue, 10 Jul 2018 12:28:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180710152146.2371336-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/10/18 9:21 AM, Arnd Bergmann wrote:
> On 32-bit architectures, dividing a 64-bit number needs to use the
> do_div() function or something like it to avoid a link failure:
> 
> block/blk-iolatency.o: In function `iolatency_prfill_limit':
> blk-iolatency.c:(.text+0x8cc): undefined reference to `__aeabi_uldivmod'
> 
> Using div_u64() gives us the best output and avoids the need for an
> explicit cast.

Applied, thanks Arnd.

-- 
Jens Axboe
