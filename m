Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 6 Nov 2017 07:00:02 -0800
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>,
	linux-block <linux-block@vger.kernel.org>,
	Luca Miccio <lucmiccio@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: high overhead of functions blkg_*stats_* in bfq
Message-ID: <20171106150002.GY3252168@devbig577.frc2.facebook.com>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org>
 <20171018131918.GB1302522@devbig577.frc2.facebook.com>
 <76CAD24C-BE7A-4AE0-A207-0FDD0E6506DD@linaro.org>
 <83aaaeb1-2e04-33ed-193a-7d36024fc9dd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <83aaaeb1-2e04-33ed-193a-7d36024fc9dd@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Sun, Nov 05, 2017 at 07:21:01PM -0700, Jens Axboe wrote:
> It's pointless to give up on this so soon, when no effort has apparently
> been dedicated to figuring out what the actual issue is yet. So no, no
> patch that will just disable the stats is going to be accepted.
> 
> That said, I have no idea who uses these stats. Surely someone can
> answer that question. Tejun?

Except for the basic bytes / ios counts, it's all debug fluff, which
should have been hidden behind a debug boot param or go under debugfs.
I'm not sure we can get rid of them at this point for cfq but I don't
see why we'd have them for bfq.

Thanks.

-- 
tejun
