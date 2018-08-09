Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: paride: pd: mark expected switch fall-throughs
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Tim Waugh <tim@cyberelk.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180809155446.GA19883@embeddedor.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <159dd22f-d923-3c1c-e7e3-405c67094882@kernel.dk>
Date: Thu, 9 Aug 2018 10:18:01 -0600
MIME-Version: 1.0
In-Reply-To: <20180809155446.GA19883@embeddedor.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/9/18 9:54 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Applied, thanks.

-- 
Jens Axboe
