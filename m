Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Add fallthrough markers to switch statements
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20170621164011.4409-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5d4fb46b-1864-3b29-85a4-7e90c0006a1f@kernel.dk>
Date: Wed, 21 Jun 2017 11:45:54 -0600
MIME-Version: 1.0
In-Reply-To: <20170621164011.4409-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/21/2017 10:40 AM, Bart Van Assche wrote:
> This patch suppresses gcc 7 warnings about falling through in switch
> statements when building with W=1. From the gcc documentation: The
> -Wimplicit-fallthrough=3 warning is enabled by -Wextra. See also
> https://gcc.gnu.org/onlinedocs/gcc-7.1.0/gcc/Warning-Options.html.

Sort of split on patches like this, but let's just queue it up.

-- 
Jens Axboe
