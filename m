Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/10 v14] merge request: No wait AIO
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: viro@ZenIV.linux.org.uk, hch@lst.de, jack@suse.cz,
 akpm@linux-foundation.org, linux-block@vger.kernel.org
References: <20170620120549.23147-1-rgoldwyn@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <340357d1-9c11-7dc0-b223-d5b505f8e04c@kernel.dk>
Date: Tue, 20 Jun 2017 07:12:33 -0600
MIME-Version: 1.0
In-Reply-To: <20170620120549.23147-1-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 06:05 AM, Goldwyn Rodrigues wrote:
> Jens,
> 
> As discussed, here are the patches against the block
> tree for merge since the block layer changes had the most conflicts.
> My tree is at https://github.com/goldwynr/linux/tree/nowait-block
> 
>  Changes since v13:
>  + nowait support for dax files in ext4 and xfs

Added for 4.13, thanks.

-- 
Jens Axboe
