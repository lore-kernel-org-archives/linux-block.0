Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	bfq-iosched@googlegroups.com,
	oleksandr@natalenko.name,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/1] bloc, bfq: fix of a bug introduced by my last patch
Date: Wed, 10 Jan 2018 15:58:55 +0100
Message-Id: <20180110145856.4040-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,
unfortunately, the patch of mine that you applied yesterday ("block,
bfq: release oom-queue ref to root group on exit"), does not compile
if CONFIG_BFQ_GROUP_IOSCHED is not defined. I forgot to test that patch
with that option disabled. Honestly, I'm more and more uncertain
about how useful (disabling) that option is ...

In any case, one question about the present patch: I didn't add any
hash for the commit that this patch fixes, because, if I'm not
mistaken, the hash that that commit will have in mainline is not yet
defined. I hope this is the right way to go.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: compile group put for oom queue only if BFQ_GROUP_IOSCHED
    is set

 block/bfq-iosched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--
2.15.1
