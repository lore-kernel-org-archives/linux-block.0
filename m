Return-Path: <efault@gmx.de>
Message-ID: <1525508378.5406.6.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
	bfq-iosched@googlegroups.com, oleksandr@natalenko.name
Date: Sat, 05 May 2018 10:19:38 +0200
In-Reply-To: <1525463210.622.1.camel@gmx.de>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
	 <1525463210.622.1.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-05-04 at 21:46 +0200, Mike Galbraith wrote:
> Tentatively, I suspect you've just fixed the nasty stalls I reported a
> while back.

Oh well, so much for optimism.  It took a lot, but just hung.
