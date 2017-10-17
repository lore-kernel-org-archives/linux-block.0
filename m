Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] kyber: fix hang on domain token wait queue
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Bin Zha <zhabin.zb@alibaba-inc.com>
References: <0c81254e266944c463e7dc12da15cc99edc466b8.1507743307.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d01f14ee-ea8a-28b2-5b75-dddebb5a5a51@kernel.dk>
Date: Tue, 17 Oct 2017 16:18:44 -0600
MIME-Version: 1.0
In-Reply-To: <0c81254e266944c463e7dc12da15cc99edc466b8.1507743307.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/11/2017 11:39 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> When we're getting a domain token, if we fail to get a token on our
> first attempt, we put the current hardware queue on a wait queue and
> then try again just in case a token was freed after our initial attempt
> but before we got on the wait queue. If this second attempt succeeds, we
> currently leave the hardware queue on the wait queue. Usually this is
> okay; we'll just run the hardware queue one extra time when another
> token is freed. However, if the hardware queue doesn't have any other
> requests waiting, then when it it gets the extra wakeup, it won't have
> anything to free and therefore won't wake up any other hardware queues.
> If tokens are limited, then we won't make forward progress and the
> device will hang.

Applied for 4.15, thanks Omar.

-- 
Jens Axboe
