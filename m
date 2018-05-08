Return-Path: <efault@gmx.de>
Message-ID: <1525755090.24338.1.camel@gmx.de>
Subject: Re: bug in tag handling in blk-mq?
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block
 <linux-block@vger.kernel.org>,  Ulf Hansson <ulf.hansson@linaro.org>, LKML
 <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Tue, 08 May 2018 06:51:30 +0200
In-Reply-To: <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
	 <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
	 <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-05-07 at 20:02 +0200, Paolo Valente wrote:
>=20
>=20
> > Is there a reproducer?

Just building fat config kernels works for me.  It was highly non-
deterministic, but reproduced quickly twice in a row with Paolos hack.
=A0=A0
> Ok Mike, I guess it's your turn now, for at least a stack trace.

Sure.  I'm deadlined ATM, but will get to it.

	-Mike
