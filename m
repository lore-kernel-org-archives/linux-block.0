Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A81EC433F5
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 06:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D0961054
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 06:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhIDGCB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Sep 2021 02:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232570AbhIDGCA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 4 Sep 2021 02:02:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE5DE601FA;
        Sat,  4 Sep 2021 06:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630735259;
        bh=i+kOoFcu+/LB0ja8eJtWIaAB28BCa6gfZyJVWD8CScM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kza1sNJXWEmxhxQc4pJ68ynjhtNSM9UsULjW5EpYp8o6mIAfclTmkbmoE77g4hF3i
         n2Y96aHugpKYksQLhZOrHZZRtUzGKCSAT3bHu+rP7yCsZI2AtKyZVrtqqEml5gyIdU
         v46lHTUWhBw/t2XBEhEMyY824vBUjNH9bjQgucTM=
Date:   Sat, 4 Sep 2021 08:00:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     axboe@kernel.dk, pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-block@vger.kernel.org, linux@vger.kernel.org,
        kabel@kernel.org
Subject: Re: [PATCH 08/18] ledtrig-blkdev: Add miscellaneous helper functions
Message-ID: <YTMLmHBHas3ViJdM@kroah.com>
References: <20210903204548.2745354-1-arequipeno@gmail.com>
 <20210903204548.2745354-9-arequipeno@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903204548.2745354-9-arequipeno@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 03, 2021 at 03:45:38PM -0500, Ian Pilcher wrote:
> Add blkdev_skip_space() and blkdev_find_space() for parsing writes to
> sysfs attributes
> 
> Add blkdev_read_mode() and blkdev_write_mode() LED comparison helpers
> 
> Signed-off-by: Ian Pilcher <arequipeno@gmail.com>
> ---
>  drivers/leds/trigger/ledtrig-blkdev.c | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/leds/trigger/ledtrig-blkdev.c b/drivers/leds/trigger/ledtrig-blkdev.c
> index db8326874400..1f319529c3be 100644
> --- a/drivers/leds/trigger/ledtrig-blkdev.c
> +++ b/drivers/leds/trigger/ledtrig-blkdev.c
> @@ -6,6 +6,7 @@
>   *	Copyright 2021 Ian Pilcher <arequipeno@gmail.com>
>   */
>  
> +#include <linux/ctype.h>
>  #include <linux/module.h>
>  
>  #include "ledtrig-blkdev.h"
> @@ -66,3 +67,46 @@ static unsigned int ledtrig_blkdev_count;
>  
>  /* How often to check for drive activity - in jiffies */
>  static unsigned int ledtrig_blkdev_interval;
> +
> +
> +/*
> + *
> + *	Miscellaneous helper functions
> + *
> + */
> +
> +/*
> + * Returns a pointer to the first non-whitespace character in s
> + * (or a pointer to the terminating null).
> + */
> +static const char *blkdev_skip_space(const char *s)
> +{
> +	while (*s != 0 && isspace(*s))
> +		++s;
> +
> +	return s;
> +}
> +
> +/*
> + * Returns a pointer to the first whitespace character in s (or a pointer to the
> + * terminating null), which is effectively a pointer to the position *after* the
> + * last character in the non-whitespace token at the beginning of s.  (s is
> + * expected to be the result of a previous call to blkdev_skip_space()).
> + */
> +static const char *blkdev_find_space(const char *s)
> +{
> +	while (*s != 0 && !isspace(*s))
> +		++s;
> +
> +	return s;
> +}

Why are block devices odd and need to have spaces found in their names?

And are you sure we do not already have string functions that do this?

thanks,

greg k-h
