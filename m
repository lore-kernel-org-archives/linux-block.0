Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] drbd: mark expected switch fall-throughs
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180702174902.GA18713@embeddedor.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d776672f-3173-037e-81fc-5c2619177682@kernel.dk>
Date: Mon, 2 Jul 2018 15:11:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180702174902.GA18713@embeddedor.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/2/18 11:49 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 2 was used in this case: -Wimplicit-fallthrough=2

Applied, thanks.

-- 
Jens Axboe
