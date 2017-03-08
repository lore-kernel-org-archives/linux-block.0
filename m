Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] axonram: Fix gendisk handling
To: Jan Kara <jack@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>
References: <20170308135605.4250-1-jack@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3e7da115-32c8-7b80-3530-b4cf74edfa0d@kernel.dk>
Date: Wed, 8 Mar 2017 10:55:56 -0700
MIME-Version: 1.0
In-Reply-To: <20170308135605.4250-1-jack@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/08/2017 06:56 AM, Jan Kara wrote:
> It is invalid to call del_gendisk() when disk->queue is NULL. Fix error
> handling in axon_ram_probe() to avoid doing that.
> 
> Also del_gendisk() does not drop a reference to gendisk allocated by
> alloc_disk(). That has to be done by put_disk(). Add that call where
> needed.

Applied, thanks.

-- 
Jens Axboe
