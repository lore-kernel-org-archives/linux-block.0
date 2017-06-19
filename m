Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/10 v13] merge request: No wait AIO
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: viro@ZenIV.linux.org.uk, hch@lst.de, jack@suse.cz,
 akpm@linux-foundation.org, linux-block@vger.kernel.org
References: <20170619163348.15542-1-rgoldwyn@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a3c9ac14-d04d-2dc5-c656-879c6262aa96@kernel.dk>
Date: Mon, 19 Jun 2017 17:15:16 -0600
MIME-Version: 1.0
In-Reply-To: <20170619163348.15542-1-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 10:33 AM, Goldwyn Rodrigues wrote:
> Jens,
> 
> As Christoph suggested, I am sending the patches against the block
> tree for merge since the block layer changes had the most conflicts.
> My tree is at https://github.com/goldwynr/linux/tree/nowait-block

I can merge it for 4.13, but I need Al to be happy with it first.

-- 
Jens Axboe
