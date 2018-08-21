Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block/DAC960.c: make some arrays static const, shrinks
 object size
To: Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180821091248.8669-1-colin.king@canonical.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cbe876ce-8f1f-1dc3-86fb-b26278277312@kernel.dk>
Date: Tue, 21 Aug 2018 11:00:49 -0600
MIME-Version: 1.0
In-Reply-To: <20180821091248.8669-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/21/18 3:12 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the arrays ReadCacheStatus, WriteCacheStatus and
> SenseErrors on the stack but instead make them static const. Makes
> the object code smaller by 47 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>  160974	  34628	    832	 196434	  2ff52	drivers/block/DAC960.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>  160671	  34884	    832	 196387	  2ff23	drivers/block/DAC960.o
> 
> (gcc version 8.2.0 x86_64)

Applied, thanks.

-- 
Jens Axboe
