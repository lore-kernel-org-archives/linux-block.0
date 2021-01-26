Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C92C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 18:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D51B22B37
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 18:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbhAZROu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:14:50 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:34655 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389855AbhAZIWM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 03:22:12 -0500
Received: by mail-lf1-f44.google.com with SMTP id a12so13485438lfb.1;
        Tue, 26 Jan 2021 00:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N6uAHsEyZ6WgEQ8At+K9g1mYi2N+EF3aByRgWxP6Lbg=;
        b=A0+jKnFvarbmgOBO5motmMTxjO6LDBfxsb0zmXt3PtirVWmOpe6xC7qoUAEn4wuPSj
         NZcosRnQOn+Wx51Mt7NJnbn17ndcDXq4TlSxKfiZV6iYkSm1t32acGpWH1X0G+kbev+k
         wNBJD1QjJDAViMr5ltXJ2p6KtOlyZJbSAJqW9CN3+iNngzQKHO8CGbc3FPaQWu06nBs7
         aT5ip24Z/XYa9lPCRYIhfOhYUlWDxXDBqMJElhslx0ayN8wMtGu8e4VEVc4PgXYB1nNT
         aJHJw53c7sl3ItxASdxRzQNJgM4bHO02xkYRJCk57iO8kr1fytW0lbKeqBtLCzNM7n8q
         pC7Q==
X-Gm-Message-State: AOAM530ZL7+cYyuRbjqbwVnOsrNJl70qNRmK+qq0EUcI9qUUZng9RP4a
        6OUl8DgyY+7KUMreWbIWbGwsGT9zuxM=
X-Google-Smtp-Source: ABdhPJy37CITPmRFi1sebHwyDteqDL1NOVrBthrPaHyo5WeqSvHv29bD+z3BZ0opv3lYdLx4iyXbOg==
X-Received: by 2002:a05:6512:1105:: with SMTP id l5mr2247524lfg.179.1611649290210;
        Tue, 26 Jan 2021 00:21:30 -0800 (PST)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id p3sm2422193lfu.271.2021.01.26.00.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 00:21:29 -0800 (PST)
Subject: Re: [PATCH] floppy: reintroduce O_NDELAY fix
To:     Jiri Kosina <jikos@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Wim Osterholt <wim@djo.tudelft.nl>,
        Kurt Garloff <kurt@garloff.de>
References: <20160610230255.GA27770@djo.tudelft.nl>
 <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm>
 <20160614184308.GA6188@djo.tudelft.nl>
 <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm>
 <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm>
 <20160615224722.GA9545@djo.tudelft.nl>
 <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm>
 <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm>
 <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
 <nycvar.YFH.7.76.2101191649190.5622@cbobk.fhfr.pm>
 <5cb57175-7f0b-5536-925d-337241bcda93@linux.com>
 <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2101211543230.5622@cbobk.fhfr.pm>
 <e503292b-5f51-eac5-771f-e35991d1084c@linux.com>
 <nycvar.YFH.7.76.2101211603590.5622@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2101221209060.5622@cbobk.fhfr.pm>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <5ef748c9-9ab9-9a7e-6ae9-6e4a292b6842@linux.com>
Date:   Tue, 26 Jan 2021 11:21:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2101221209060.5622@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/22/21 2:13 PM, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> This issue was originally fixed in 09954bad4 ("floppy: refactor open() 
> flags handling").
> 
> The fix as a side-effect, however, introduce issue for open(O_ACCMODE) 
> that is being used for ioctl-only open. I wrote a fix for that, but 
> instead of it being merged, full revert of 09954bad4 was performed, 
> re-introducing the O_NDELAY / O_NONBLOCK issue, and it strikes again.
> 
> This is a forward-port of the original fix to current codebase; the 
> original submission had the changelog below:
> 
> ====
> Commit 09954bad4 ("floppy: refactor open() flags handling"), as a
> side-effect, causes open(/dev/fdX, O_ACCMODE) to fail. It turns out that
> this is being used setfdprm userspace for ioctl-only open().
> 
> Reintroduce back the original behavior wrt !(FMODE_READ|FMODE_WRITE) 
> modes, while still keeping the original O_NDELAY bug fixed.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Wim Osterholt <wim@djo.tudelft.nl>
> Tested-by: Wim Osterholt <wim@djo.tudelft.nl>
> Reported-and-tested-by: Kurt Garloff <kurt@garloff.de>
> Fixes: 09954bad4 ("floppy: refactor open() flags handling")
> Fixes: f2791e7ead ("Revert "floppy: refactor open() flags handling"")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Applied. I'll send it to Jens soon with a couple of cleanup patches.

https://github.com/evdenis/linux-floppy/commit/e32f6163c47efbdbad06258560aa00d1c7e5b699

Thanks,
Denis

> ---
>  drivers/block/floppy.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index dfe1dfc901cc..0b71292d9d5a 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4121,23 +4121,23 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
>  	if (fdc_state[FDC(drive)].rawcmd == 1)
>  		fdc_state[FDC(drive)].rawcmd = 2;
>  
> -	if (!(mode & FMODE_NDELAY)) {
> -		if (mode & (FMODE_READ|FMODE_WRITE)) {
> -			drive_state[drive].last_checked = 0;
> -			clear_bit(FD_OPEN_SHOULD_FAIL_BIT,
> -				  &drive_state[drive].flags);
> -			if (bdev_check_media_change(bdev))
> -				floppy_revalidate(bdev->bd_disk);
> -			if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags))
> -				goto out;
> -			if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags))
> -				goto out;
> -		}
> -		res = -EROFS;
> -		if ((mode & FMODE_WRITE) &&
> -		    !test_bit(FD_DISK_WRITABLE_BIT, &drive_state[drive].flags))
> +	if (mode & (FMODE_READ|FMODE_WRITE)) {
> +		drive_state[drive].last_checked = 0;
> +		clear_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags);
> +		if (bdev_check_media_change(bdev))
> +			floppy_revalidate(bdev->bd_disk);
> +		if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags))
> +			goto out;
> +		if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags))
>  			goto out;
>  	}
> +
> +	res = -EROFS;
> +
> +	if ((mode & FMODE_WRITE) &&
> +			!test_bit(FD_DISK_WRITABLE_BIT, &drive_state[drive].flags))
> +		goto out;
> +
>  	mutex_unlock(&open_lock);
>  	mutex_unlock(&floppy_mutex);
>  	return 0;
> 
