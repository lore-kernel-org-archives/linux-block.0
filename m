Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] loop: return proper error from loop_queue_rq()
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
References: <fad6bce50526f8554f47d83d61ae334073075a6d.1479164136.git.osandov@fb.com>
Cc: kernel-team@fb.com, Ming Lei <tom.leiming@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <27bcb43c-5361-9303-36a7-93c28fb2ae28@kernel.dk>
Date: Mon, 14 Nov 2016 15:58:24 -0700
MIME-Version: 1.0
In-Reply-To: <fad6bce50526f8554f47d83d61ae334073075a6d.1479164136.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/14/2016 03:56 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> ->queue_rq() should return one of the BLK_MQ_RQ_QUEUE_* constants, not
> an errno.

Thanks Omar, applied.

-- 
Jens Axboe
