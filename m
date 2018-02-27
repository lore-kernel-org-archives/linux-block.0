Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: fix return value in error handling path
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Josef Bacik <jbacik@fb.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <20180212171450.GA31668@embeddedgus>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e9fb8864-a36a-7ed0-ed86-0a1ae8ae92bd@kernel.dk>
Date: Tue, 27 Feb 2018 15:51:59 -0700
MIME-Version: 1.0
In-Reply-To: <20180212171450.GA31668@embeddedgus>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/12/18 10:14 AM, Gustavo A. R. Silva wrote:
> It seems that the proper value to return in this particular case is the
> one contained into variable new_index instead of ret.

Thanks, applied.

-- 
Jens Axboe
