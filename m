Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: fix default values in documentation
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-block@vger.kernel.org, Minwoo Im <dn3108@gmail.com>
References: <1510060981-24352-1-git-send-email-minwoo.im.dev@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <228e3964-2852-cbef-0c81-f27f4a26bf21@kernel.dk>
Date: Tue, 7 Nov 2017 09:23:48 -0700
MIME-Version: 1.0
In-Reply-To: <1510060981-24352-1-git-send-email-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/07/2017 06:23 AM, Minwoo Im wrote:
> null_blk.c has initial value of
> (1) nr_devices as 1.
> (2) completion_nsec as 10,000ns, not 10.000ns.
> documentation should be updated for fixes above.

Thanks, applied.

-- 
Jens Axboe
