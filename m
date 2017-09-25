Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: cryptoloop - Fix build warning
To: Corentin Labbe <clabbe.montjoie@gmail.com>, herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20170925171007.4660-1-clabbe.montjoie@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d9bed3f0-637d-8003-de09-c382f00f9e1e@kernel.dk>
Date: Mon, 25 Sep 2017 13:24:22 -0600
MIME-Version: 1.0
In-Reply-To: <20170925171007.4660-1-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/25/2017 11:10 AM, Corentin Labbe wrote:
> This patch fix the following build warning:
> drivers/block/cryptoloop.c:46:8: warning: variable 'cipher' set but not used [-Wunused-but-set-variable]

Thanks, added for 4.15.

-- 
Jens Axboe
