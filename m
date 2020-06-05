Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB750C433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 03:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C2D20772
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 03:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fI1F/2Sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgFEDOO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDON (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 23:14:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ACFC08C5C0
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 20:14:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y17so3050671plb.8
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 20:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6KKE6NK5t9Roonzbio2T7KL2VGRRj3+kmOOOa7VG8/s=;
        b=fI1F/2Sa266KWRP/4o4oPDAY7hothAQoi9UFJqV6trb/SYEHzkFAolymEWGiiiZBG8
         h8O2+6IQ2W7tzG5TmaZMAxinUdqYVgimPqyTK0KxM3A1Xps67siipQVTQbMHkSkUnfPg
         IIjzkYRRKdgYICncw5jTv/hgTFjB9NVm5/WZeMKGSpK6TO3eYKqEvwayr4maTmw1anit
         SuGCUe6r9YOFOs9yNnbD/VI5HEeYl6mV7YlilU2FiPIwDX0MLGxSL+iyFxl6rxfHrCp9
         xYqT/wEObSkN5A5+5VSU/SwunR6E0dRe+/B2+G3h/HSmmVKmXDLIdTl68YrjPAJIdYwy
         ceNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6KKE6NK5t9Roonzbio2T7KL2VGRRj3+kmOOOa7VG8/s=;
        b=HV8d/xJJ4zZnX3suy4vEJsLefwjSLfp3XMimGjycjFKnvPHftwDISwHHKqT0YzviK+
         rjF5R1frkQISrr2A1NKwctixa2qUtevy+4oUfl7NDa0mbWRIftADieCT4ie6XAOrGIfv
         0uwR6T0LckFV+dGuVhdiOWOKayqAYf+yZ1ntprnxRAvaYqktYtXNborEYttXUrFAuG0Q
         4YNCs28vqrNSZhfhW8arE7M+JeaUg/hNxgrpWHQLg0jMeCZM72F4rojh7YSfvkb7msSV
         07xumb2xdxWoGuI2IaqlnDv+Riu7ejTwTB7lK3acUmMCexIz/JjRSCZRb9X+RWtpZ/Hg
         asHg==
X-Gm-Message-State: AOAM533s9UvTMatCh2cxiZtJIBLjVIjzib3d8AMu0SPMyHce02Xik7HY
        HcYKKrROQDRpOearbtn+VArBzQ==
X-Google-Smtp-Source: ABdhPJwVc7r07LTRQdHM5JOUgiO7JxGpa/iZLCMO//6XZc4ZtRE//eys78KGf1TSoqDNWxdX4SB7KQ==
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr7842163plp.6.1591326851673;
        Thu, 04 Jun 2020 20:14:11 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 124sm5682949pfb.15.2020.06.04.20.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 20:14:10 -0700 (PDT)
Subject: Re: [PATCH] loop: Fix wrong masking of status flags
To:     Martijn Coenen <maco@android.com>, hch@lst.de,
        naresh.kamboju@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200604202520.66459-1-maco@android.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c5190958-b32a-6b22-c180-dc4bda785689@kernel.dk>
Date:   Thu, 4 Jun 2020 21:14:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604202520.66459-1-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/4/20 2:25 PM, Martijn Coenen wrote:
> In faf1d25440d6, loop_set_status() now assigns lo_status directly from
> the passed in lo_flags, but then fixes it up by masking out flags that
> can't be set by LOOP_SET_STATUS; unfortunately the mask was negated.
> 
> Re-ran all ltp ioctl_loop tests, and they all passed.
> 
> Pass run of the previously failing one:
> 
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> tst_device.c:88: INFO: Found free device 0 '/dev/loop0'
> ioctl_loop01.c:49: PASS: /sys/block/loop0/loop/partscan = 0
> ioctl_loop01.c:50: PASS: /sys/block/loop0/loop/autoclear = 0
> ioctl_loop01.c:51: PASS: /sys/block/loop0/loop/backing_file =
> '/tmp/ZRJ6H4/test.img'
> ioctl_loop01.c:65: PASS: get expected lo_flag 12
> ioctl_loop01.c:67: PASS: /sys/block/loop0/loop/partscan = 1
> ioctl_loop01.c:68: PASS: /sys/block/loop0/loop/autoclear = 1
> ioctl_loop01.c:77: PASS: access /dev/loop0p1 succeeds
> ioctl_loop01.c:83: PASS: access /sys/block/loop0/loop0p1 succeeds
> 
> Summary:
> passed   8
> failed   0
> skipped  0
> warnings 0

Applied, thanks.

-- 
Jens Axboe

