Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB28FC282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F3321773
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 15:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="L4JJxMaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfBJPYj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:24:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36581 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfBJPYj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 10:24:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so4070678plo.3
        for <linux-block@vger.kernel.org>; Sun, 10 Feb 2019 07:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YkBV2Luy6JDa+eoYSZZrkwq1U1aY1C2Hv2PLNg6uGwU=;
        b=L4JJxMaFo9uVK+ZxzcxAqG6d1cFl1z6A0CILcufJbOydfQgy5IB1BLhIbLFxN7FPps
         b1OVtbns9HfRGw3jVmMRvSULWPUOyGyN+kM9HmB9VK+amNAKoUffmHen8+qZM3pno4mz
         19Kj1BMV7Kwr9/8FLvXc1MXZ4CNQRq/sk84qP79X3pXiBYvGKdNAMdbQUybTNuUmFd6e
         lQR8pHd9ezJgOMOH8/wo0CrG4jWjX720N3fFbML4H+x7fxkFk20A9ZngiQhIZHwY/pC9
         5/6OnHTUNW9aC4uvcUpvXl9tZnoAWXLLc4PIgSGE8j1O+jRSho1zVl9DaOXgRaA5sVsW
         QcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YkBV2Luy6JDa+eoYSZZrkwq1U1aY1C2Hv2PLNg6uGwU=;
        b=VQRVZsWANy+DTQIWSI1Yt0VWvrWf9VJewdRlIjcdNl/iHXl3icBm7HjWo04bDHU6mY
         M5W622BupLqPylvc0ObbXh/5bqNCUD5w4oZsCiuhSFQFI2ty6TiWqMEnSEtqBLNq/53A
         gksps4EttLlt9B4c1ulKYGquOmUHVANNEchufOF7/2CB49R9ByxzMgiDbs9iqSRbe4j0
         27yIutZWP1fsSBL+a9yfa4W+s7DRRh3ar8rI9fxcAm4e4ypSZPjMErEiVsu6S00UkRkz
         TIH5lTGMx4VEIGYIfMXgHBd+DPnh0HulnUX8/tY647OJ2vojBObJpJ4T8F7U4eQqhXfR
         anZw==
X-Gm-Message-State: AHQUAuYqvFkkpdEw9P6wcKSMrWdd0YhchucxxO5E0mIM/3BW0e5ACSVj
        eKaphLaRSJDHbOJVIkV8PUeJlsfwO4aSbw==
X-Google-Smtp-Source: AHgI3IbPIp68qq0VR4xrdSYgqWF2qXE4rnN59/mQkdJOYePV4gUQw4xj3Uci5fTQk4lAs/Xn7EMV7w==
X-Received: by 2002:a17:902:ab92:: with SMTP id f18mr32281119plr.221.1549812278401;
        Sun, 10 Feb 2019 07:24:38 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 125sm11804567pfx.159.2019.02.10.07.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 07:24:37 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: Fix doc related to blkcg_exit_queue
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
References: <20190125020142.921371-1-marcos.souza.org@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ba6bb55-13bb-819e-f606-d599f8e6cc7e@kernel.dk>
Date:   Sun, 10 Feb 2019 08:24:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125020142.921371-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/19 7:01 PM, Marcos Paulo de Souza wrote:
> Since 4cf6324b17e9, a portion of function blk_cleanup_queue was moved to
> a newly created function called blk_exit_queue, including the call of
> blkcg_exit_queue. So, adjust the documenation according.

Applied, thanks.

-- 
Jens Axboe

