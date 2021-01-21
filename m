Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E3CC433E6
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 15:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EEC239FD
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 15:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbhAUPUQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:20:16 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:37888 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732472AbhAUPDd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 10:03:33 -0500
Received: by mail-lf1-f51.google.com with SMTP id m22so2932560lfg.5;
        Thu, 21 Jan 2021 07:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:references:from:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KczDQBYnwUc6Db3Y4wdjMxvDRIDolHP882VvzzfUBDk=;
        b=YBaQiDuRER6CzJ2xgeTmxKLaym7I5kTCssN5m8/PntnZ5x8IGHc9u3p5xNXVoGybOF
         DnFFW5h7KHhBQxvSxxcv++4AYhNbguSK+bB+Dof1MghVv1C8S8q/xkHBUDfLGiOH35Cx
         wkMmVrWV8BTARjWhLl016AYGaE5AZ9Ic4eYiFBuVIzZgGYPUbVehP1hl+EmU4SPuOjYG
         GR3J6UauefXS+xFlx4VwfQdaugemxayFFV+fPeLVWqvag0H714anfYvr+A/likQb+4vK
         W6EWMKpK5qODhVfLv/ukenyFKDOJML8hYV2bpepTczkh2cDN9Ji3ELUPdo8PoWXknVN9
         4Z/w==
X-Gm-Message-State: AOAM531vbmR9t7yaU+lJrPKuSJMsH5tOgk7FgIcWRuAmRGSmu2JWE5tJ
        6z9g+ir1oJMQH17o15QIyzM=
X-Google-Smtp-Source: ABdhPJwoKe7rQL58Fz74MlnRk483tfISgGrn5h7fvXquVY0DB7zvefQOv6gc5jRpGxaXOBwrtzulIg==
X-Received: by 2002:a05:6512:1311:: with SMTP id x17mr6830381lfu.307.1611241370510;
        Thu, 21 Jan 2021 07:02:50 -0800 (PST)
Received: from [10.68.32.148] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id l11sm554314lfp.284.2021.01.21.07.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 07:02:49 -0800 (PST)
Reply-To: efremov@linux.com
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Wim Osterholt <wim@djo.tudelft.nl>
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
From:   Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH RESEND] floppy: fix open(O_ACCMODE) for ioctl-only open
Message-ID: <e503292b-5f51-eac5-771f-e35991d1084c@linux.com>
Date:   Thu, 21 Jan 2021 18:02:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2101211543230.5622@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/21/21 5:44 PM, Jiri Kosina wrote:
> On Thu, 21 Jan 2021, Jiri Kosina wrote:
> 
>> I am currently waiting for confirmation by the original reporter that the 
>> patch below fixes the issue.
> 
> ... a now a patch that actually compiles :) (made a mistake when 
> forward-porting from the older kernel on which this has been reported).

Oh, sorry for the last message (forgot to check the inbox before hitting
the send button). I'll test the patch. A couple of nitpicks below.

> 
> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH v2] floppy: reintroduce O_NDELAY fix
> 
> Originally fixed in 09954bad4 ("floppy: refactor open() flags handling")
> then reverted for unknown reason in f2791e7eadf437 instead of taking
> the open(O_ACCMODE) for ioctl-only open fix, which had the changelog below
> 
> ====
> Commit 09954bad4 ("floppy: refactor open() flags handling"), as a
> side-effect, causes open(/dev/fdX, O_ACCMODE) to fail. It turns out that
> this is being used setfdprm userspace for ioctl-only open().
> 
> Reintroduce back the original behavior wrt !(FMODE_READ|FMODE_WRITE)
> modes, while still keeping the original O_NDELAY bug fixed.
> 
> Cc: stable@vger.kernel.org # v4.5+

Are you sure that it's not worth to backport it to LTS v4.4?
Because f2791e7ead is just a revert and 09954bad4 is not
presented in v4.4 I'm not sure what fixes tag is better to
use in this case.

> Reported-by: Wim Osterholt <wim@djo.tudelft.nl>
> Tested-by: Wim Osterholt <wim@djo.tudelft.nl>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> =====
> 
> Fixes: 09954bad4 ("floppy: refactor open() flags handling")
> Fixes: f2791e7ead ("Revert "floppy: refactor open() flags handling"")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> 
> v1 -> v2: fix build issue due to bad forward-port
> 
>  drivers/block/floppy.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index dfe1dfc901cc..f9e839c8c5aa 100644
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
> +		UDRS->last_checked = 0;

UDRS will still break the compilation here.

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
