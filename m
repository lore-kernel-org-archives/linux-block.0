Return-Path: <efault@gmx.de>
Message-ID: <1525687297.26987.1.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
  LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com,  oleksandr@natalenko.name
Date: Mon, 07 May 2018 12:01:37 +0200
In-Reply-To: <1723D46D-579A-4C5A-BCC1-6ABAA6E7C3FB@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
	 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
	 <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
	 <1525532191.5406.15.camel@gmx.de>
	 <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
	 <1525672597.5064.3.camel@gmx.de>
	 <1723D46D-579A-4C5A-BCC1-6ABAA6E7C3FB@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-05-07 at 11:27 +0200, Paolo Valente wrote:
> 
> 
> Where is the bug?

Hm, seems potent pain-killers and C don't mix all that well.
