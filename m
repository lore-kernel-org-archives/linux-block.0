Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:42098 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeAITwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jan 2018 14:52:09 -0500
Date: Tue, 9 Jan 2018 11:52:05 -0800
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: lennart@poettering.net, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        ANGELO RUOCCO <220530@studenti.unimore.it>
Subject: Re: unify the interface of the proportional-share policy in blkio/io
Message-ID: <20180109195205.GP3668920@devbig577.frc2.facebook.com>
References: <56EFD7A1-A894-410D-A923-E33911ED4647@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56EFD7A1-A894-410D-A923-E33911ED4647@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Paolo.

On Thu, Jan 04, 2018 at 08:00:02PM +0100, Paolo Valente wrote:
> The solution for the second type of parameters may prove useful to
> unify also the computation of statistics for the throttling policy.
> 
> Does this proposal sound reasonable?

So, the above should work too but I wonder whether we could do this
simpler.  Frankly, I wouldn't mind if cfq and bfq can't be mixed on a
system - e.g. they can be built together but you can't enable bfq on
some devides and cfq on others.  If we do that, all we need to do is
just removing / adding cftypes when either gets activated which cgroup
already does.

Thanks.

-- 
tejun
