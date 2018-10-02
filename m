Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] pktcdvd: fix fall-through annotation
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20181002102440.GA2888@embeddedor.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cd860546-1160-f388-670c-aee2415eafc9@kernel.dk>
Date: Tue, 2 Oct 2018 08:37:09 -0600
MIME-Version: 1.0
In-Reply-To: <20181002102440.GA2888@embeddedor.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/2/18 4:24 AM, Gustavo A. R. Silva wrote:
> Replace "fallthru" with a proper "fall through" annotation.
> 
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough

Applied, thanks.

-- 
Jens Axboe
