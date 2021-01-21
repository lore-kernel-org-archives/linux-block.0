Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC20C433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 14:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9937A238E3
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 14:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbhAUOr3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 09:47:29 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:35325 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732093AbhAUOqR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 09:46:17 -0500
Received: by mail-lj1-f177.google.com with SMTP id p13so2784945ljg.2;
        Thu, 21 Jan 2021 06:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:references:from:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=405oyctWCF4c6HZyWVXh37+hz6ooySr8zjsgVJNe27I=;
        b=MbcXA4JOY7+mctDWKy0oxqnrunp19dret4nkIZQOx4P7hj0RIBeS20CyarWVL6MVLH
         5Bln9dxZpDmD6vMSX6QoesQnULK4k5UxDcHeIyJdSe6hq1RKqBmjF8RZ72j4kVfMEZ6/
         EIZ74Ed/bmpQ5HUr5TIehw6V6HQ1isIlAW2BaPctvm/vzfQLjYxAfk6ZpfatrE5G0efj
         1Qu/57xFwB/xlx8qc3mL9ZnH9OPGtU9P6aXuOuhQ7ScD+3xG0UTUIQadzvx697Cmgc42
         21SlemIVUZNikPVoMvjlvRTAg/F3l01QEYPLha5S1doMbS1HSSQ5LmuJzxyTfbcQNbqY
         0K1A==
X-Gm-Message-State: AOAM533EGtLnY5fReEwGbany/VzjygxpcRiJQLvnl/kZJojzFJX9eNlg
        NZ+NxjwNlxYH0A2XP2LCN3k7y1QrrPI=
X-Google-Smtp-Source: ABdhPJwlE/upxBt3OxW6i90tURdrT8MWAcmKys2pJo69FN0nAynnTtMAAXEvdNA1XgvviKuBiP+tOg==
X-Received: by 2002:a05:651c:1254:: with SMTP id h20mr7069162ljh.211.1611240334966;
        Thu, 21 Jan 2021 06:45:34 -0800 (PST)
Received: from [10.68.32.148] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id 132sm546867lff.197.2021.01.21.06.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 06:45:34 -0800 (PST)
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
From:   Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH RESEND] floppy: fix open(O_ACCMODE) for ioctl-only open
Message-ID: <08c74fa2-ecbf-3c1d-be09-2447bb009bcb@linux.com>
Date:   Thu, 21 Jan 2021 17:45:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/21 1:25 PM, Jiri Kosina wrote:
> On Thu, 21 Jan 2021, Denis Efremov wrote:
> 
>> I think it's hard to recall the exact reasons after so many years. 
> 
> Yeah, I guess so :)
> 
>> I'll send a patch today based on this one.
> 
> I am currently waiting for confirmation by the original reporter that the 
> patch below fixes the issue.
> 
> 
> 
> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] floppy: reintroduce O_NDELAY fix
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
> Reported-by: Wim Osterholt <wim@djo.tudelft.nl>
> Tested-by: Wim Osterholt <wim@djo.tudelft.nl>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> =====
> 
> Fixes: 09954bad4 ("floppy: refactor open() flags handling")
> Fixes: f2791e7ead ("Revert "floppy: refactor open() flags handling"")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/block/floppy.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index dfe1dfc901cc..bda9417aa0a8 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4121,23 +4121,22 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
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


As the bot points out this was refactored a bit in:
8d9d34e25a37 ("floppy: cleanup: expand macro UDRS")
4a6f3d480edc ("floppy: use bdev_check_media_change")

Should be something like:
+               drive_state[drive].last_checked = 0;
+               clear_bit(FD_OPEN_SHOULD_FAIL_BIT,
+                         &drive_state[drive].flags);
+               if (bdev_check_media_change(bdev))
+                       floppy_revalidate(bdev->bd_disk);

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
