Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0EFC2D0F7
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 17:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA9A206B9
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 17:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zA+fDW7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgELRgl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELRgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 13:36:40 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5400AC061A0C
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 10:36:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so6679350pfv.8
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gVLWN+8R61IdmiSJmCy4d5j/vIO/FBU8hJurAn8zeEk=;
        b=zA+fDW7rsf78djWHisc/zKxTdzFpDcXavv1rH07ojEDeewEhVnsEyFiTm1P5RQl2T7
         HdNG/EyhEBx5LlfjqJVSbqTKhnug9o6pfsSUJ4YB/V0dQ5QZWwtxBQfIi0hfHpaHE2bf
         XJQtdLM9EaHOT+HEBDnW0qkgDmgtzmSxcE+ZmVLjdD0Cnb38c9ebVzcs3zl69c4W1uQU
         Olqhz/0vH4QLgvVPsmO6o61yffHjIwg3O2T8vickdZgFjEKRBJSpSMRTjXDbCJmFes1d
         iHbLa+wZMCXYThMyH4Txkg13a7EBsKa3RetlMf9ysJrglDypCNm9a+9w/evLE6d8nK1A
         PUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gVLWN+8R61IdmiSJmCy4d5j/vIO/FBU8hJurAn8zeEk=;
        b=gRMTLocm+nh22BOtLfzZ4kGUGk67jeXPSWdvGs0uuVXyGCibfIgdu6Sa2EpDceIj/f
         e6FTvmXoGdEQklLQpla6r6aC2AUho7DJ0mf3huekFQrYKdkmAnrvXBfd9wZMtK4aF1/Q
         JFlnwm0Fg+UMKyYqOv1gx3rkEBc3OgT66E0y7bs/OaO/Nvhtn4VNbUhtspcFYQsemc9w
         SGQchhTv2IhqiUPEfC8ACvcEeeT4By9tJKpeY/yCXR38z+aFpV0Qb9e34+Po+BsTli2L
         0bnZv9pnzEQop5uxj2qSe6vGmdfEJRUScnIihdX/ah9n0MYhLx9IVcGJWLrJLD53zp62
         6lUQ==
X-Gm-Message-State: AGi0PuZsFpNRNxoBxpGDNM7Tg1ACpmdNMP51sX2h9DfdGYfPlWIlzxfA
        N4AECplTo3jj6ql+ZtFH/YsVzg==
X-Google-Smtp-Source: APiQypI3Kk35T4p8NhBJk8jfgGwfSQW7xkJf5PLtNEPvhBz2PN2/gQkK1ohTJ1uYwBqOBFtUokhb8g==
X-Received: by 2002:a63:d850:: with SMTP id k16mr20711664pgj.190.1589304999651;
        Tue, 12 May 2020 10:36:39 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:3541:a94b:8f16:bfe6? ([2605:e000:100e:8c61:3541:a94b:8f16:bfe6])
        by smtp.gmail.com with ESMTPSA id t5sm10517208pgp.80.2020.05.12.10.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 10:36:39 -0700 (PDT)
Subject: Re: [GIT PULL RESEND] Floppy cleanups for next
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8d8cb63b-e1ff-ddef-a6e9-8f7adb21be60@linux.com>
 <565fc2e1-a790-241f-7a98-52a4c5ff8158@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c6d08f09-7415-c92e-0f94-1eb521f2ecb0@kernel.dk>
Date:   Tue, 12 May 2020 11:36:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <565fc2e1-a790-241f-7a98-52a4c5ff8158@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/20 11:33 AM, Denis Efremov wrote:
> Rebased on for-5.8/drivers branch.
> 
> The following changes since commit 92decf118f1da4c866515f80387f9cf4d48611d6:
> 
>   nvme: define constants for identification values (2020-05-09 16:18:36 -0600)
> 
> are available in the Git repository at:
> 
>   https://github.com/evdenis/linux-floppy tags/floppy-for-5.8
> 
> for you to fetch changes up to 0836275df4db20daf040fff5d9a1da89c4c08a85:
> 
>   floppy: suppress UBSAN warning in setup_rw_floppy() (2020-05-12 19:34:57 +0300)
> 
> ----------------------------------------------------------------
> Floppy patches for 5.8
> 
> Cleanups:
>   - symbolic register names for x86,sparc64,sparc32,powerpc,parisc,m68k
>   - split of local/global variables for drive,fdc
>   - UBSAN warning suppress in setup_rw_floppy()
> 
> Changes were compile tested on arm, sparc64, powerpc, m68k. Many patches
> introduce no binary changes by using defines instead of magic numbers.
> The patches were also tested with syzkaller and simple write/read/format
> tests on real hardware.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Thanks, pulled.

-- 
Jens Axboe

