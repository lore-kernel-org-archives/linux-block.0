Return-Path: <efault@gmx.de>
Message-ID: <1525660992.5105.1.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
  LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com,  oleksandr@natalenko.name
Date: Mon, 07 May 2018 04:43:12 +0200
In-Reply-To: <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
	 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
	 <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
	 <1525532191.5406.15.camel@gmx.de>
	 <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sun, 2018-05-06 at 09:42 +0200, Paolo Valente wrote:
> 
> I've attached a compressed patch (to avoid possible corruption from my
> mailer).  I'm little confident, but no pain, no gain, right?
> 
> If possible, apply this patch on top of the fix I proposed in this
> thread, just to eliminate possible further noise. Finally, the
> patch content follows.
> 
> Hoping for a stroke of luck,

FWIW, box didn't survive the first full build of the morning.

> Paolo
> 
> diff --git a/block/bfq-mq-iosched.c b/block/bfq-mq-iosched.c
> index 118f319af7c0..6662efe29b69 100644
> --- a/block/bfq-mq-iosched.c
> +++ b/block/bfq-mq-iosched.c

That doesn't exist in master, so I applied it like so.

---
 block/bfq-iosched.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -554,8 +554,12 @@ static void bfq_limit_depth(unsigned int
        if (unlikely(bfqd->sb_shift != bt->sb.shift))
                bfq_update_depths(bfqd, bt);
 
+#if 0
        data->shallow_depth =
                bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
+#else
+       data->shallow_depth = 1;
+#endif
 
        bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
                        __func__, bfqd->wr_busy_queues, op_is_sync(op),
