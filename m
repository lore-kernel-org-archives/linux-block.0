Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove unnecessary condition check
To: Chengguang Xu <cgxu519@gmx.com>
Cc: linux-block@vger.kernel.org
References: <20180827233111.9324-1-cgxu519@gmx.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e81fab90-ced8-b2ec-5491-12ca7c877bb0@kernel.dk>
Date: Mon, 27 Aug 2018 19:16:19 -0600
MIME-Version: 1.0
In-Reply-To: <20180827233111.9324-1-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/27/18 5:31 PM, Chengguang Xu wrote:
> kmem_cache_destroy() can handle NULL pointer correctly, so there is
> no need to check e->icq_cache before calling kmem_cache_destroy().

Applied, thanks.

-- 
Jens Axboe
