Return-Path: <SRS0=nGPF=IF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1346FC433DB
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 19:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF28A6146B
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 19:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhCGT0t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Mar 2021 14:26:49 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:34584 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhCGT0r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Mar 2021 14:26:47 -0500
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id A59039C5FAB;
        Sun,  7 Mar 2021 20:26:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1615145194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4VOisBNeF6XO2A8QpxSl0raUzxAMOpweTEaXJDZCV9I=;
        b=Uw3vBjrTCRPOVOua616LVKWmGL8G73WqfjIDTh7Oddj0E7+yNBtfkI+PhX4UbVuNIH+pyC
        oRurGudY59wjJf95t0FKTi1iyq+cV5GsvXT3mna8p4KsSuFL5FHgxYniq+l74JBxCeUig+
        YiaCe40psu+o9soOWmHvNkj/km6v16A=
Date:   Sun, 7 Mar 2021 20:26:34 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        BLOCK ML <linux-block@vger.kernel.org>
Subject: Re: [RFC] iosched: add cfq -> bfq alias
Message-ID: <20210307192634.xdq52ntb2sxc34mh@spock.localdomain>
References: <7962131d-12c5-0862-483f-e8873cac8ba0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7962131d-12c5-0862-483f-e8873cac8ba0@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi.

On Sat, Mar 06, 2021 at 11:46:31PM +0100, Xose Vazquez Perez wrote:
> 
> Avoid break old scrips and udev rules.
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 95586137194e..8c6c82860a45 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6914,6 +6914,7 @@ static struct elevator_type iosched_bfq_mq = {
>  	.icq_align =		__alignof__(struct bfq_io_cq),
>  	.elevator_attrs =	bfq_attrs,
>  	.elevator_name =	"bfq",
> +	.elevator_alias =	"cfq",
>  	.elevator_owner =	THIS_MODULE,
>  };
>  MODULE_ALIAS("bfq-iosched");

Hmmm NACK.

CFQ and BFQ are completely different beasts.

If you are going to tune BFQ to match old CFQ behaviour (somehow; I
don't know why one would do this, how one would do this and whether it
is possible at all), you for sure have enough time to fix your old udev
rules and scripts.

If you are just tolerating default BFQ behaviour, you should explicitly
acknowledge it by amending your rules and scripts. For personal systems
this is not a big deal. For enterprise systems you better do it NOW so
that another person that comes to work on those systems in 10 years
after you resign knows what and why was done.

If you are just lazy (no offence! I don't know your real intention
here), I'm not sure we are going to hide such an indifference behind
another aliasing kludge.

Thanks.

-- 
  Oleksandr Natalenko (post-factum)
