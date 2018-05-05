Return-Path: <efault@gmx.de>
Message-ID: <1525532191.5406.15.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
  LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com,  oleksandr@natalenko.name
Date: Sat, 05 May 2018 16:56:31 +0200
In-Reply-To: <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
	 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
	 <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sat, 2018-05-05 at 12:39 +0200, Paolo Valente wrote:
> 
> BTW, if you didn't run out of patience with this permanent issue yet,
> I was thinking of two o three changes to retry to trigger your failure
> reliably.

Sure, fire away, I'll happily give the annoying little bugger
opportunities to show its tender belly.

	-Mike
