Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94EBC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 02:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F9F6121F
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 02:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhIOCHB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 22:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhIOCHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 22:07:01 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D53BC061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 19:05:43 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z1so1434486ioh.7
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 19:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YgNlcOyQRX1AeL4r8+ZI8QsWp4WbmZJYMYN/OP2NpeE=;
        b=L+J4SJ2AHwetYS3hZyfF08GJUkdxGCxV8XQPkr+yw6yqBbMaw6XKo2OJTKygXO5lcE
         N6dUppk1JDXeZRBV6MksamR1WbKSwyiNlMbWXS834NsxVWDbH5g46xkgQxF+BolGujyU
         rdegvmGgemF9/h2RpuqyHgXu57+T5JEyU3roK/6bq4chg9krLggT4b3giRucpTk6gtva
         c6IU9ArGsp7TIc/JiGmk1lYzsQSHqoLlTyXUQPWUeYXkZHm/uHdMJHZTsNiwXZCCANq/
         OfkUgTn8IpLkeLEdPoZwLL/YSxwztbCxAJifRG02dWKgsJ6ep0YKndP1vSMgnLpuq29Y
         +CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YgNlcOyQRX1AeL4r8+ZI8QsWp4WbmZJYMYN/OP2NpeE=;
        b=YriC9r0EsN0KSvBgtCZNHH/W519yJOHi53Z/8TrBHKrCw24FZlr7z6kfc6SFwFewX/
         243hLBzcZiJ1SxG+nTwQfBnDaXakImcyXnaYduW5Y8L+Y1sBxM1cN42yh44/islF9U/m
         iqqqDGQzkgLTdgZ8NEwVdOOpddUPlQSETLnSaE1irP7stTChrwksSf31M31w4Oy8Ort/
         pz6mnTZF3SE36/lHApfHg/YUj1WpdVCdwRXNmcRjxGJjeW2X3ekuxD9/aA8nGOdKuxGl
         AaLB2zZrEwZB0OjdQS+oFwujaI530mqKCnj8LX7+1u1f6A2eJc2IVKLT2cOWgj4zfMxp
         upNA==
X-Gm-Message-State: AOAM531b4xhbVH432e5TZqqCBjd15T0q78XA9m8SNBc4nWUvqXLH+bJ0
        p2s/hQtwiNFsJTrBbcVbwtAEp5vhgXLrMw==
X-Google-Smtp-Source: ABdhPJyFaIiL/4SxvzBf43zyYa1n7hTcG+1596RuPnDLwsyzh5vt1nVRTvzmRJdqrBewfpyDl2cnYw==
X-Received: by 2002:a6b:5a1a:: with SMTP id o26mr16353775iob.40.1631671542361;
        Tue, 14 Sep 2021 19:05:42 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k7sm7410016iok.22.2021.09.14.19.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 19:05:42 -0700 (PDT)
Subject: Re: [PATCH v3] drivers/cdrom: improved ioctl for media change
 detection
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-block@vger.kernel.org
References: <20210913230942.1188-1-phil@philpotter.co.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5766487b-a5b4-9590-3f56-2c1d23819ffa@kernel.dk>
Date:   Tue, 14 Sep 2021 20:05:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210913230942.1188-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/13/21 5:09 PM, Phillip Potter wrote:
> From: Lukas Prediger <lumip@lumip.de>
> 
> The current implementation of the CDROM_MEDIA_CHANGED ioctl relies on
> global state, meaning that only one process can detect a disc change
> while the ioctl call will return 0 for other calling processes afterwards
> (see bug 213267).
> 
> This introduces a new cdrom ioctl, CDROM_TIMED_MEDIA_CHANGE, that
> works by maintaining a timestamp of the last detected disc change instead
> of a boolean flag: Processes calling this ioctl command can provide
> a timestamp of the last disc change known to them and receive
> an indication whether the disc was changed since then and the updated
> timestamp.
> 
> I considered fixing the buggy behavior in the original
> CDROM_MEDIA_CHANGED ioctl but that would require maintaining state
> for each calling process in the kernel, which seems like a worse
> solution than introducing this new ioctl.

Applied for 5.16, thanks.

-- 
Jens Axboe

