Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D6DC433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 11:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F217C208DB
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 11:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0ptv0bga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbgE0LUG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 07:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388194AbgE0LUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 07:20:05 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11442C03E979
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 04:20:05 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so10014570plo.7
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 04:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9fTpy5j80/hMqlw+UrtihYdz2nGosx0tBx+jDWOLC/A=;
        b=0ptv0bgacMd3Dptq+L0VYV1JnfBZNdWRfDs5pYCYar/GOfqcf+EP2klSEvtGax6qOc
         wT59vdULc+WMjIL1paOIAYcv4KXSk+7y1JnO+GPit+XnrJrgd3Fozyv3SjAVPS8JlJy4
         AdHBAYKx3g/oT1yQT7eSrQLYxwXe45EX6sFsQtHmQ8BiBYwKA3fTDsO1DXAbej4BD2C3
         VQYLtuoHsSh/iQFffOsy6IBOnAYET9iC/w0NXqfrET6At44yJjZlD9gOi3447YzTntoH
         2114U+BMaMz5/jirRPxakvc3oDSZ8eELWbAxfFNiWg+20jlLyoR/8Xf8QcxB9TtNtFyK
         e+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9fTpy5j80/hMqlw+UrtihYdz2nGosx0tBx+jDWOLC/A=;
        b=K+SdvG/wJ18Gy/0tMg/a+vbWsuI3U+ba5ccvNUyC9V2sMcXa7J4T2nLmYk6BxSfnZ/
         swhVHqyr+Xz6DefT7qA9oeJPLQuFACecdEd1Bw6adyfnCud88X9Mz3mmmnITTxAPi2KW
         RmxLjH9+/GvnX9/CN/qiJSzxOo1PCbCGrvGxpWe8hLxD5Vm+a7LXgh6HnLSiqr7HCN8V
         EwoI5qZ0Ra68jFwLoIMraUwNzHrlr3pf5wQUvyD8JhXYxiIGUG7XXktp/Rl6r3stw6nJ
         fVVDf1cX3bgU9nxtXTUCWif3HA8zY2q+TlyfBiHmKmOpQEj1Psb6dSTyMFliwKiKuYOr
         Dy7A==
X-Gm-Message-State: AOAM532uQ5FTTL7VOVkp5ATaibGT3lVDH80BCF2cmYnbmF7YHU4IFzE5
        1bolawTsSjqzS69CuENnDn29f7RBYqVKDg==
X-Google-Smtp-Source: ABdhPJyHm4EG8buSkq97vIKLdVJGgLvGNNy582M+oHWY6jpy0nEWRHgiRjJOxcdP2lE9q0GvJlEwcw==
X-Received: by 2002:a17:90b:4c4b:: with SMTP id np11mr4557076pjb.58.1590578404266;
        Wed, 27 May 2020 04:20:04 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:2cc3:8599:f649:862c? ([2605:e000:100e:8c61:2cc3:8599:f649:862c])
        by smtp.gmail.com with ESMTPSA id c7sm2371445pjr.32.2020.05.27.04.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 04:20:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] bcache patches for Linux-5.8
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20200527040155.43690-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75af2ed6-9dec-a99c-76e1-4708aec30b76@kernel.dk>
Date:   Wed, 27 May 2020 05:20:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527040155.43690-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/20 10:01 PM, Coly Li wrote:
> Hi Jens,
> 
> This is the bcache patches for Linux v5.8.
> 
> Patches from Colin Ian King and Joe Perches are sent again for v5.8
> merge windows. The first patch from me is to fix a refcount underflow
> issue when stopping a pending backing device without created bcache
> device. The last two patches from me is for an experiment sysfs
> interface to register bcache devices in asynchronous way, to avoid
> the udevd timeout issue which I tried before.
> 
> Please take them for v5.8, and thank you in advance.

Applied for 5.8, thanks.

-- 
Jens Axboe

