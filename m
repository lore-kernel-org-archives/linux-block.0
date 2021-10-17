Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72ADC433FE
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FAF60E9B
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbhJQBy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhJQBy1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:54:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2916C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:52:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g5so8892187plg.1
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=kFsx5p0S2J6if3CoPL0tGJwTCamVX4gEpCHzQKPONpU=;
        b=aGdWTYH1HHWHgyCnQ1WXgvjtm7nhOhTa1Jhr5+MmVHWVTeFRjtGBTGOOiM0EW1tgxj
         q31O+nliO7gQp1lTg1E/qlkpCgVVX/c7okRnCbpWvNggpLY74+rg1cE/eBfuCYVvkICV
         mAyfj59Cbrkfbw0v/M0jmaEgkXWGn1fW7c1Sd9IcalfgjKQH3WufFsx/Gi8fb/2TMoa5
         +7dToF6nrp+W/QMRCNnPGIsl8Qhpiv53mqnsYUAn8tYqGPPvLAp/FGRVQM01JNnAQbN9
         PQBOluB3//fz8RP3z/e1dZeATW6izqr8LIqBcpcjqabBsnCEgc7CMvJuZjHx8b8Zr9NF
         G7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=kFsx5p0S2J6if3CoPL0tGJwTCamVX4gEpCHzQKPONpU=;
        b=kzDu7SPkRB0qmXTcGDYn+dU84ePemjU3f8ECWdcRbLRb7urbGexkJj97WUv9x3cVxE
         +yiVJ6PrRfQVM7JQAV5u1nJoTAD+Zn6hCdj1hiuflkVmpzNRPGdC2vhV9C5TD1hBm/zf
         l1ycFco9rREkJmlAucAxv/TRzWPqWfl/86d/oSOevHdLuqHd2ATLSMTDAyoZoxsHYGMe
         T9P4L9vK1fzgYtzlK+f9/UkRa793pp8fhtB99YxnUr95n0srhSXp1t5rbVEVCvgiXXQD
         ySpHT7xRjP8hX3q7Aa9DjpcB/R/Dj6AauF908TEeHbAkVcJk5o8n/dGhkduu082nnpQk
         57Pg==
X-Gm-Message-State: AOAM530vIJJzwOg9rvCN5dFg8Bj+Zvq4z7qJWAUKXnMIDxqjFi/GvvrR
        3Xzy2KCr7OiExTXPoIxd5aU=
X-Google-Smtp-Source: ABdhPJzopR8j7+MF9HH7rTHEJbMBofHK4l234546f8+XLA7llRSFgERPhMqa4nNjtqlX++79J7bXTA==
X-Received: by 2002:a17:90a:2902:: with SMTP id g2mr23750027pjd.161.1634435536336;
        Sat, 16 Oct 2021 18:52:16 -0700 (PDT)
Received: from [10.1.1.26] (222-155-4-20-adsl.sparkbb.co.nz. [222.155.4.20])
        by smtp.gmail.com with ESMTPSA id o72sm8703401pjo.50.2021.10.16.18.52.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Oct 2021 18:52:15 -0700 (PDT)
Subject: Re: [PATCH] ataflop: unlock ataflop_probe_lock at atari_floppy_init()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <1d9351dc-baeb-1a54-625c-04ce01b009b0@i-love.sakura.ne.jp>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6d26961c-3b51-d6e1-fb95-b72e720ed5d0@gmail.com>
Date:   Sun, 17 Oct 2021 14:52:05 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1d9351dc-baeb-1a54-625c-04ce01b009b0@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tetsuo,

thank you for fixing this bug!

On 17/10/21 02:25, Tetsuo Handa wrote:
> Commit bf9c0538e485b591 ("ataflop: use a separate gendisk for each media
> format") introduced ataflop_probe_lock mutex, but forgot to unlock the
> mutex when atari_floppy_init() (i.e. module loading) succeeded. If
> ataflop_probe() is called, it will deadlock on ataflop_probe_lock mutex.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: bf9c0538e485b591 ("ataflop: use a separate gendisk for each media format")
> ---
> To m68k users
>
>   This patch suggests that nobody is testing this module using a real hardware.

Not as a module, no. I use the Atari floppy driver built-in. Latest 
kernel version I ran was 5.13.

Relevant kernel log excerpt:

calling  atari_floppy_init+0x0/0x4d4 @ 1
Atari floppy driver: max. HD, track buffering
Probing floppy drive(s):
fd0
initcall atari_floppy_init+0x0/0x4d4 returned 0 after 675082 usecs

Haven't tried to read from the drive in a while though... waiting for 
floppy I/O isn't my favourite spectator sport.

I take it a read attempt should fail, without your patch?

>   Can somebody test this module?

Yes.

>   Is current m68k hardware still supporting Atari floppy?

Yes.

Cheers,

	Michael Schmitz


>   If Atari floppy is no longer supported, do we still need this module?
>
> To Christoph Hellwig and Luis Chamberlain
>
>   If we move __register_blkdev() in atari_floppy_init() to the end of
>   atari_floppy_init() and move unregister_blkdev() in atari_floppy_exit() to
>   the beginning of atari_floppy_exit(), we can remove unregister_blkdev() from
>   atari_floppy_init(), and I think we can also remove ataflop_probe_lock mutex
>   because probe function and __exit function are serialized by major_names_lock
>   mutex.
>
>  drivers/block/ataflop.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> index a093644ac39f..39b42cb8d173 100644
> --- a/drivers/block/ataflop.c
> +++ b/drivers/block/ataflop.c
> @@ -2072,7 +2072,8 @@ static int __init atari_floppy_init (void)
>  	       UseTrackbuffer ? "" : "no ");
>  	config_types();
>
> -	return 0;
> +	ret = 0;
> +	goto out_unlock;
>
>  err:
>  	while (--i >= 0) {
>
