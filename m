Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31779C433EF
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 22:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96DF610A5
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 22:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbhIRWf1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Sep 2021 18:35:27 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:42846 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbhIRWf1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Sep 2021 18:35:27 -0400
Received: by mail-lf1-f48.google.com with SMTP id bq5so49346277lfb.9
        for <linux-block@vger.kernel.org>; Sat, 18 Sep 2021 15:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qlc7epnvhUiTqb48DwQxCEm9wDivQTS9ssC9/xibXAE=;
        b=iZZMtLqTjarFmhvYpaJgyNLLOFPm99m5i2bLs4wCyaoSGYhntLO+OuaG+8Xp4SrnRv
         8qbdncqTZqcOdmY2h3rowhO4wwrfSGuGPcvUh7/64egvaCIW9BexyEFdDGMBPe0+Ml3K
         CLhYHgytnt/CJWORUViSEBZ1erVk8V2+00iDsmo8kkoIaYkEE2rb3Gf32VAvaaSLxWuw
         29I2PEEoHNj7AdlZZXpY8hc4dOX60LFr1VRzTE5KolceL6vkoj/ZGCgipTtEj6aO5DEc
         J2WF5fg82VrMjDwEBjUJAnCoPjzy9ze2x0OwOz8iHq7wMiIBwU0nA7jH/qV5T1EiTVi5
         AJyQ==
X-Gm-Message-State: AOAM533EaVbA8OZDawJmj7nEBjWfU+gA5Ji2cFPKVWDtyFN3CPgHZrLf
        AidrFFguxZ8m9MhpZATn7EU=
X-Google-Smtp-Source: ABdhPJxoISslCfpzksiryKnpojqYUIlhbRNsoYG/TC4GsEnAbEmF4fW+xk/Pn09HxUGxBx3KDzjwlQ==
X-Received: by 2002:a2e:5709:: with SMTP id l9mr9997520ljb.315.1632004441799;
        Sat, 18 Sep 2021 15:34:01 -0700 (PDT)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id b8sm871990lff.106.2021.09.18.15.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 15:34:01 -0700 (PDT)
Message-ID: <92da8abb-4270-83c3-6059-44627eb6b42c@linux.com>
Date:   Sun, 19 Sep 2021 01:33:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] floppy: Fix hang in watchdog when disk is ejected
Content-Language: en-US
To:     Tasos Sahanidis <tasos@tasossah.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, jkosina@suse.cz
References: <399e486c-6540-db27-76aa-7a271b061f76@tasossah.com>
From:   Denis Efremov <efremov@linux.com>
In-Reply-To: <399e486c-6540-db27-76aa-7a271b061f76@tasossah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 9/3/21 09:47, Tasos Sahanidis wrote:
> When the watchdog detects a disk change, it calls cancel_activity(),
> which in turn tries to cancel the fd_timer delayed work.
> 
> In the above scenario, fd_timer_fn is set to fd_watchdog(), meaning
> it is trying to cancel its own work.
> This results in a hang as cancel_delayed_work_sync() is waiting for the
> watchdog (itself) to return, which never happens.
> 
> This can be reproduced relatively consistently by attempting to read a
> broken floppy, and ejecting it while IO is being attempted and retried.
> 
> To resolve this, this patch calls cancel_delayed_work() instead, which
> cancels the work without waiting for the watchdog to return and finish.
> 
> Before this regression was introduced, the code in this section used
> del_timer(), and not del_timer_sync() to delete the watchdog timer.
> 
> Fixes: 070ad7e793dc ("floppy: convert to delayed work and single-thread wq")
> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
> ---
>  drivers/block/floppy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index fef79ea52..85464d72d 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -1014,7 +1014,7 @@ static DECLARE_DELAYED_WORK(fd_timer, fd_timer_workfn);
>  static void cancel_activity(void)
>  {
>  	do_floppy = NULL;
> -	cancel_delayed_work_sync(&fd_timer);
> +	cancel_delayed_work(&fd_timer);
>  	cancel_work_sync(&floppy_work);
>  }


Sorry for the long response. Applied, thanks!
https://github.com/evdenis/linux-floppy/commit/4258a7afaf3bde4441e844335170ee310ee29392

I will send it to Jens with other fixes.

Regards,
Denis


