Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB79EC433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 18:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EDB264EC3
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 18:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhBVS3Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhBVS20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 13:28:26 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13026C06178B
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 10:27:42 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id f3so14919868oiw.13
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 10:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=B4XPDxDBKidZk352XP+E3BHF4Q7CL1UymLB/s5MVNw4=;
        b=lGONL59PS/s0eWVAkLMd3bAVVrIKIm8FetIU0PAzxEANy8OlMmZJbqOcGmQZ3tvb+h
         Ci5AHcPAUrultWVdWprzMMOLC9El4PGk5Hx75Rm8MqdUHXJs0n2ytU1yBIn0WlLgakel
         KtsMk1o2TB0ByUGiIzPqsr/CfF4qrvvKUf7gn/dBl9jKxYlO9QYTQXnlrlT7XkEI3HHp
         sdJdqAFQLJ3oro9EC67VbFobEGlAiieis1j6Zd3tRX2pFIetV3BBSbWKloPIMmsA90oU
         OhruN/0hmvauxx3qS64wmLgB1ELOeURcZgRuPAJ5vHfsDiALOqgNxwsNiSfBo7plXwcF
         fQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=B4XPDxDBKidZk352XP+E3BHF4Q7CL1UymLB/s5MVNw4=;
        b=Y2YXtMNsIHdpRkeYHRmSK7QA+RRqYm2X166Y96PGd7EXNpH7ipS1CjWxMPEdSw3yG3
         M0B7BtkuSzgVsfEIP5Hro4KfzkG0wQXAj8XUQM9L0MElwZLeybwjzcFkyf/+R/qK7ths
         hU8MKKZGUvf0hKi+7T7tyYHJV2J1c+IpqR3NgufyYyyUaXS6iLVp8PZyCLq1TVU6Mb8N
         1bCtbQ2H/YyPvWIoEU4mw2oKUDNfWIlIB02Blbk7zeRvDOHd0i8ZpkDWwS+J0FrXBGZf
         egqGn+tBW6OVWh+OR4XEoO+c76Fexh2oydmXYIVq5XQc0seKpBfyfIQ+SF/Rpekuqjg9
         fbUw==
X-Gm-Message-State: AOAM532Gkgw8jVk8VW/OglfH6piUMlfxuvtFlyiGc6iJCKeh6hSUYfrh
        I1TZFYWbY3K+QaJ4w7UqTbT68xfpIkkBGS91
X-Google-Smtp-Source: ABdhPJzU07vxx0Z8bSfO72fhC//C9xqaWJk7dhNdItx3nwkveOfpz0Syipv/rPLhPwif/Rp6o8KeGQ==
X-Received: by 2002:aca:f383:: with SMTP id r125mr16835556oih.18.1614018461431;
        Mon, 22 Feb 2021 10:27:41 -0800 (PST)
Received: from ?IPv6:2603:80a0:e01:cc2f:be5f:f4ff:fe7b:62ec? (2603-80a0-0e01-cc2f-be5f-f4ff-fe7b-62ec.res6.spectrum.com. [2603:80a0:e01:cc2f:be5f:f4ff:fe7b:62ec])
        by smtp.gmail.com with ESMTPSA id g10sm164992otj.15.2021.02.22.10.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 10:27:41 -0800 (PST)
Subject: Re: [Regression] [Bisected] Errors when ejecting USB storage drives
 since v5.10
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
References: <CAARYdbiUBxFTY25VusuxgxqVzNRnoB61fFQeXcmsKyDP_d_ipQ@mail.gmail.com>
 <20210216123755.GA4608@lst.de>
 <CAARYdbiDzi_WcNGe4GkWjtTXeNOV7pZCLiJFk4r+Np_Je+2aZw@mail.gmail.com>
 <20210222114455.GA1749@lst.de>
From:   Tom Seewald <tseewald@gmail.com>
Message-ID: <940375ab-2a92-6e09-9746-e87e8ea8c7fc@gmail.com>
Date:   Mon, 22 Feb 2021 12:27:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222114455.GA1749@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 5:44 AM, Christoph Hellwig wrote:

> Ok, let's try something else entirely, which restores the full revalidation
> that BLKRRPART previously caused by accident:
>
> diff --git a/block/ioctl.c b/block/ioctl.c
> index d61d652078f41c..06b2ecdce593c6 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -81,20 +81,25 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
>  }
>  #endif
>  
> -static int blkdev_reread_part(struct block_device *bdev)
> +static int blkdev_reread_part(struct block_device *bdev, fmode_t mode)
>  {
> -	int ret;
> +	struct block_device *tmp;
>  
>  	if (!disk_part_scan_enabled(bdev->bd_disk) || bdev_is_partition(bdev))
>  		return -EINVAL;
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EACCES;
>  
> -	mutex_lock(&bdev->bd_mutex);
> -	ret = bdev_disk_changed(bdev, false);
> -	mutex_unlock(&bdev->bd_mutex);
> -
> -	return ret;
> +	/*
> +	 * Reopen the device to revalidate the driver state and force a
> +	 * partition rescan.
> +	 */
> +	set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
> +	tmp = blkdev_get_by_dev(bdev->bd_dev, mode, NULL);
> +	if (IS_ERR(tmp))
> +		return PTR_ERR(tmp);
> +	blkdev_put(tmp, mode);
> +	return 0;
>  }
>  
>  static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
> @@ -498,7 +503,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>  		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
>  		return 0;
>  	case BLKRRPART:
> -		return blkdev_reread_part(bdev);
> +		return blkdev_reread_part(bdev, mode & ~FMODE_EXCL);
>  	case BLKTRACESTART:
>  	case BLKTRACESTOP:
>  	case BLKTRACETEARDOWN:
I can confirm the above patch results in my USB drives being unmounted cleanly
and there are no errors in dmesg afterwards. One minor nit I have noticed is
that after ejecting the device, the kernel still reports:

"sde: detected capacity change from 0 to 62333952"

This appears to be reversed from what was previously reported by the kernel in
v5.9 and earlier. I would expect that after ejection it would report:

"sde: detected capacity change from 62333952 to 0"

This appears to be purely cosmetic and it is not something your above patch
introduced so you can add Tested-by: Tom Seewald <tseewald@gmail.com> if you
wish. Thank you again for your help.
