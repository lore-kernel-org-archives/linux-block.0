Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] aoe: mark expected switch fall-through
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "Ed L. Cashin" <ed.cashin@acm.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180801223020.GA11729@embeddedor.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <676f82a9-82d6-d219-f9d1-6e8847a7db73@kernel.dk>
Date: Thu, 2 Aug 2018 09:59:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180801223020.GA11729@embeddedor.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/1/18 4:30 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Applied for 4.19, thanks.

-- 
Jens Axboe
