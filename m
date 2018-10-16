Return-Path: <richard.weinberger@gmail.com>
MIME-Version: 1.0
References: <20181015065637.1860-1-hch@lst.de>
In-Reply-To: <20181015065637.1860-1-hch@lst.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 17 Oct 2018 00:43:14 +0200
Message-ID: <CAFLxGvwx4TPTHRY91LMBdd7h4pgCjw2zY7Q67r3CRHTqfzSB1w@mail.gmail.com>
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-um@lists.infradead.org,
	"linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 15, 2018 at 8:56 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no good reason to create a scatterlist in the ubd driver,
> it can just iterate the request directly.

BTW: Does it make sense to drop blk_rq_map_sq from()
drivers/mtd/ubi/block.c too?
If so we have to allocate a temporary structure for the worker thread
for each segment, just like
UBD does already. I'm not sure if that is cheaper than blk_rq_map_sq().

-- 
Thanks,
//richard
