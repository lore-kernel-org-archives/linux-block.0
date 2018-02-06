Return-Path: <efault@gmx.de>
Message-ID: <1517903761.9843.12.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Oleksandr Natalenko <oleksandr@natalenko.name>, Paolo Valente
	 <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, broonie@kernel.org,
 linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
 alban.browaeys@gmail.com,  ming.lei@redhat.com, ivan@ludios.org,
 169364@studenti.unimore.it, Serena Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 08:56:01 +0100
In-Reply-To: <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
	 <20180205190510.5499-2-paolo.valente@linaro.org>
	 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-02-06 at 08:44 +0100, Oleksandr Natalenko wrote:
> Hi, Paolo.
> 
> I can confirm that this patch fixes cfdisk hang for me. I've also tried 
> to trigger the issue Mike has encountered, but with no luck (maybe, I 
> wasn't insistent enough, just was doing dd on usb-storage device in the 
> VM).

I was doing kbuilds, and it blew up on me twice.  Switching back to cfq
seemed to confirm it was indeed the patch causing trouble, but that's
by no means a certainty.

	-Mike
