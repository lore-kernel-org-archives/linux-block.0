Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2E8C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 19:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6539F2082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 19:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="jYUNXSIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6539F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeLAHGd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:06:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39562 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbeLAHGc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 02:06:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so3309307pfc.6
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lDemUPEMWm+oRHcUjNq0mhWEwrrriN+plSLSXai9Pwg=;
        b=jYUNXSIVnlKz7M8TAXjqIDWejbvySOYSRFbOWE0XjR57tAwFDRMM5YRj5ZhajyF/Yo
         oujR/g4XKNNpESh7iagA49ZrwGLB3rbBa5H1od/26BZ528tlfR0XjQSLGvHsGCpQBpgh
         SBytB4LV+DojW2BhP7pFG30o1EOQ4BbLbXNwGe10wOa+1R2DC4w0QTrPefdVP6aDZsRp
         t7aSph2A0n1hxtYygmmI7VXPudtLsX1I/ovgpICLfo4Oz+YgAis/cuwTzTkSpQFtZovV
         qGUulOaT7r3Zmx9WNVrmOCM9cP9IN7KxlRZeXF7E7eR9vXHw5ycIPLgdYJHyeWIrpkDV
         eodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lDemUPEMWm+oRHcUjNq0mhWEwrrriN+plSLSXai9Pwg=;
        b=UmZO4AWA/gMTeL+p8LzOUY3TjkeWpwTvk6EHS4AvtHSe74LOopaq+YPGzq47GVb3sK
         E1hpTHWDWpHp5NrT+NNEngUT2LyIDtIXmJ6jj47EtNKCktTnwWPVj90gnhXXPfpFtZni
         vc+58wUIc0wysCqSu+raoIAMStg62ueMdbkCxPywciAy85e9zOXZ5L6vT31OKhes4bjC
         iixdufjXp2V1erVR/Wmi1DaNVjrKr3w+5Z3oVcbgd6g2yF9BJiqGThOKv6cdt23Ie922
         jiVJoCftbwidn2QallVezufsO/xLXcG9SXo/eFlqCPu0b22H17cn//yWfxskwLko9EWm
         Ax9g==
X-Gm-Message-State: AA+aEWbGWCtCbdc0fc9/zue9c2fFRZ0iFpra1LhK6kCLuXR+HlssJtDq
        d8DF9d98rdQNPQrpBbmeS6MISQ==
X-Google-Smtp-Source: AFSGD/UmDD2/WxEITstarAA613azDA8uRm8LDmfJmn9NHKjHYVUJmPY3QgQOIyCL3bDAB74jZjiP2g==
X-Received: by 2002:a62:5182:: with SMTP id f124mr6947172pfb.238.1543607769002;
        Fri, 30 Nov 2018 11:56:09 -0800 (PST)
Received: from vader ([2620:10d:c090:200::4:705d])
        by smtp.gmail.com with ESMTPSA id i73sm12321942pfi.66.2018.11.30.11.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 11:56:08 -0800 (PST)
Date:   Fri, 30 Nov 2018 11:56:07 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Huijin Park <huijin.park@samsung.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Michael Callahan <michaelcallahan@fb.com>,
        Omar Sandoval <osandov@fb.com>, js07.lee@samsung.com,
        Huijin Park <bbanghj.park@gmail.com>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH,1/2] genhd: avoid overflow of sectors in disk_stats
Message-ID: <20181130195607.GA27411@vader>
References: <CGME20181130093318eucas1p24feb8e649c8f244ce149a7f87e43c828@eucas1p2.samsung.com>
 <1543570361-3168-1-git-send-email-huijin.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543570361-3168-1-git-send-email-huijin.park@samsung.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 04:32:40AM -0500, Huijin Park wrote:
> From: "huijin.park" <huijin.park@samsung.com>
> 
> This patch changes the 'sectors' type to an u64.
> In 32 bit system, the 'sectors' can accumulate up to about 2TiB.
> If a 32 bit system makes i/o over 2TiB while running,
> the 'sectors' will overflow.
> As a result, the part_stat_read(sectors), the diskstats in proc and
> the (lifetime|session)_write_kbytes in sysfs return invalid statistic.

What about parsers which expect it to be an unsigned long? E.g., iostat:
https://github.com/sysstat/sysstat/blob/v12.1.1/rd_stats.c#L736

At least with glibc, scanf seems to truncate sanely, but this appears to
be undefined.

> Signed-off-by: huijin.park <huijin.park@samsung.com>
> ---
>  block/genhd.c         |    6 +++---
>  include/linux/genhd.h |    2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 0145bcb..7518dcd 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1343,10 +1343,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>  		part_stat_unlock();
>  		part_in_flight(gp->queue, hd, inflight);
>  		seq_printf(seqf, "%4d %7d %s "
> -			   "%lu %lu %lu %u "
> -			   "%lu %lu %lu %u "
> +			   "%lu %lu %llu %u "
> +			   "%lu %lu %llu %u "
>  			   "%u %u %u "
> -			   "%lu %lu %lu %u\n",
> +			   "%lu %lu %llu %u\n",
>  			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
>  			   disk_name(gp, hd->partno, buf),
>  			   part_stat_read(hd, ios[STAT_READ]),
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 0c5ee17..5bf86f9 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -84,7 +84,7 @@ struct partition {
>  
>  struct disk_stats {
>  	u64 nsecs[NR_STAT_GROUPS];
> -	unsigned long sectors[NR_STAT_GROUPS];
> +	u64 sectors[NR_STAT_GROUPS];
>  	unsigned long ios[NR_STAT_GROUPS];
>  	unsigned long merges[NR_STAT_GROUPS];
>  	unsigned long io_ticks;
> -- 
> 1.7.9.5
> 
