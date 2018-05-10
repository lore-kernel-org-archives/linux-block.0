Return-Path: <efault@gmx.de>
Message-ID: <1525927108.7533.1.camel@gmx.de>
Subject: Re: bug in tag handling in blk-mq?
From: Mike Galbraith <efault@gmx.de>
To: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block
 <linux-block@vger.kernel.org>,  Ulf Hansson <ulf.hansson@linaro.org>, LKML
 <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Thu, 10 May 2018 06:38:28 +0200
In-Reply-To: <2b65d736-aef8-5da1-96ad-c86a931d59eb@kernel.dk>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
	 <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
	 <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
	 <1525755090.24338.1.camel@gmx.de> <1525768632.5208.4.camel@gmx.de>
	 <ffd0c030-43f8-0dbe-42b3-03bb9c410bea@kernel.dk>
	 <1525797766.5204.2.camel@gmx.de>
	 <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
	 <f04636df-3f97-6c16-f37b-d407e062b9e5@kernel.dk>
	 <57952405-bdeb-f4e4-1aef-a7c0a8a68674@kernel.dk>
	 <1525839089.15732.1.camel@gmx.de>
	 <ce5ee556-9552-6ffd-7578-7b3b983c07bf@kernel.dk>
	 <1525885030.15732.6.camel@gmx.de>
	 <1e51eb57-6d9b-a53c-9cd6-2adfc86b21b5@kernel.dk>
	 <1525890708.11382.1.camel@gmx.de>
	 <2b65d736-aef8-5da1-96ad-c86a931d59eb@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-05-09 at 13:50 -0600, Jens Axboe wrote:
> On 5/9/18 12:31 PM, Mike Galbraith wrote:
> > On Wed, 2018-05-09 at 11:01 -0600, Jens Axboe wrote:
> >> On 5/9/18 10:57 AM, Mike Galbraith wrote:
> >>
> >>>>> Confirmed.  Impressive high speed bug stomping.
> >>>>
> >>>> Well, that's good news. Can I get you to try this patch?
> >>>
> >>> Sure thing.  The original hang (minus provocation patch) being
> >>> annoyingly non-deterministic, this will (hopefully) take a while.
> >>
> >> You can verify with the provocation patch as well first, if you wish.
> > 
> > Done, box still seems fine.
> 
> Omar had some (valid) complaints, can you try this one as well? You
> can also find it as a series here:
> 
> http://git.kernel.dk/cgit/linux-block/log/?h=bfq-cleanups
> 
> I'll repost the series shortly, need to check if it actually builds and
> boots.

I applied the series (+ provocation), all is well.

	-Mike
