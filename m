Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Jan 2018 07:01:07 -0800
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, lennart@poettering.net,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	ANGELO RUOCCO <220530@studenti.unimore.it>
Subject: Re: unify the interface of the proportional-share policy in blkio/io
Message-ID: <20180110150107.GE3668920@devbig577.frc2.facebook.com>
References: <56EFD7A1-A894-410D-A923-E33911ED4647@linaro.org>
 <20180109195205.GP3668920@devbig577.frc2.facebook.com>
 <28156887-c8eb-f142-f6c4-db726680305b@kernel.dk>
 <2BEF2051-3C39-4CE1-A460-BBAE586A528F@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2BEF2051-3C39-4CE1-A460-BBAE586A528F@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue, Jan 09, 2018 at 11:28:55PM +0100, Paolo Valente wrote:
> Yep.  So, do you guys think that our proposal may be ok?  We are
> waiting just for the green light to start implementing it.

Yeah, sounds reasonable to me.  Non-debug stats are already in blkcg
core anyway and I wouldn't worry too much about debug stats.  They can
have different names (they'll mean different things anyway) and better
be hidden behind debug option anyway.

Thanks.

-- 
tejun
