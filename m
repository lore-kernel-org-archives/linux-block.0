Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block/loop: mark expected switch fall-through
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702175206.GA18848@embeddedor.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fd31987d-e2d9-6a34-a88f-baf1e6876c47@kernel.dk>
Date: Mon, 2 Jul 2018 15:11:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180702175206.GA18848@embeddedor.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/2/18 11:52 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Applied, thanks.

-- 
Jens Axboe
