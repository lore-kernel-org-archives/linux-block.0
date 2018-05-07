Return-Path: <efault@gmx.de>
Message-ID: <1525663384.5064.1.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
  LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com,  oleksandr@natalenko.name
Date: Mon, 07 May 2018 05:23:04 +0200
In-Reply-To: <1525660992.5105.1.camel@gmx.de>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
	 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
	 <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
	 <1525532191.5406.15.camel@gmx.de>
	 <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
	 <1525660992.5105.1.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-05-07 at 04:43 +0200, Mike Galbraith wrote:
> On Sun, 2018-05-06 at 09:42 +0200, Paolo Valente wrote:
> > 
> > I've attached a compressed patch (to avoid possible corruption from my
> > mailer).  I'm little confident, but no pain, no gain, right?
> > 
> > If possible, apply this patch on top of the fix I proposed in this
> > thread, just to eliminate possible further noise. Finally, the
> > patch content follows.
> > 
> > Hoping for a stroke of luck,
> 
> FWIW, box didn't survive the first full build of the morning.

Nor the second.

	-Mike
