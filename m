Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] skd: use ktime_get_real_seconds()
To: Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171102114209.1686507-1-arnd@arndb.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2008f991-f586-3552-5284-269ebc235e89@kernel.dk>
Date: Thu, 2 Nov 2017 08:27:31 -0600
MIME-Version: 1.0
In-Reply-To: <20171102114209.1686507-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/02/2017 05:42 AM, Arnd Bergmann wrote:
> Like many storage drivers, skd uses an unsigned 32-bit number for
> interchanging the current time with the firmware. This will overflow in
> y2106 and is otherwise safe.
> 
> However, the get_seconds() function is generally considered deprecated
> since the behavior is different between 32-bit and 64-bit architectures,
> and using it may indicate a bigger problem.
> 
> To annotate that we've thought about this, let's add a comment here
> and migrate to the ktime_get_real_seconds() function that consistently
> returns a 64-bit number.

Thanks Arnd, applied.

-- 
Jens Axboe
