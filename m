Return-Path: <efault@gmx.de>
Message-ID: <1525842595.15732.3.camel@gmx.de>
Subject: Re: bug in tag handling in blk-mq?
From: Mike Galbraith <efault@gmx.de>
To: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block
 <linux-block@vger.kernel.org>,  Ulf Hansson <ulf.hansson@linaro.org>, LKML
 <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 09 May 2018 07:09:55 +0200
In-Reply-To: <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
	 <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
	 <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
	 <1525755090.24338.1.camel@gmx.de> <1525768632.5208.4.camel@gmx.de>
	 <ffd0c030-43f8-0dbe-42b3-03bb9c410bea@kernel.dk>
	 <1525797766.5204.2.camel@gmx.de>
	 <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-05-08 at 14:37 -0600, Jens Axboe wrote:
> 
> - sdd has nothing pending, yet has 6 active waitqueues.

sdd is where ccache storage lives, which that should have been the only
activity on that drive, as I built source in sdb, and was doing nothing
else that utilizes sdd.

	-Mike
