Return-Path: <efault@gmx.de>
Message-ID: <1525463210.622.1.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
	bfq-iosched@googlegroups.com, oleksandr@natalenko.name
Date: Fri, 04 May 2018 21:46:50 +0200
In-Reply-To: <20180504171701.6876-1-paolo.valente@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Tentatively, I suspect you've just fixed the nasty stalls I reported a
while back.  Not a hint of stall as yet (should have shown itself by
now), spinning rust buckets are being all they can be, box feels good.

Later mq-deadline (I hope to eventually forget the module dependency
eternities we've spent together;), welcome back bfq (maybe.. I hope).

	-Mike
