Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Tue, 10 Jul 2018 14:16:07 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: iolatency: avoid 64-bit division
Message-ID: <20180710181605.yczet6lc2b57zj2a@destiny>
References: <20180710152146.2371336-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180710152146.2371336-1-arnd@arndb.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 10, 2018 at 05:21:34PM +0200, Arnd Bergmann wrote:
> On 32-bit architectures, dividing a 64-bit number needs to use the
> do_div() function or something like it to avoid a link failure:
> 
> block/blk-iolatency.o: In function `iolatency_prfill_limit':
> blk-iolatency.c:(.text+0x8cc): undefined reference to `__aeabi_uldivmod'
> 
> Using div_u64() gives us the best output and avoids the need for an
> explicit cast.
> 
> Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Oops sorry Arnd,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
