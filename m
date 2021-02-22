Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F21C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 15:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AE164E61
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 15:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhBVPoz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhBVPoy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 10:44:54 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC63C061574
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 07:44:12 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y202so13682807iof.1
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 07:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PyKfclj0R6sp6C4s7NSiwpoSAE3GRZDAn9hDHIqvY2I=;
        b=S4qkfH2ye1ubjC2ag0zuIEeaWa87Hm9RoPCvvLVm+3UrRjrFspHaO6Gpw+gchvA2vv
         JYa9y7uPCLyRSOIi+o0QwCltMD6cp4QL3Ly7MXG61T3TuuVVv0THp9iAOYNYR3OpS6Zt
         BBlgntcOKLqHE85B7gATRkY8ZgsJvXThTww/duKqyEYKlKx6bFd/FqhZhFRzjqN2dzv+
         wKzB+Kdqmvm2tSIB8tRM/Y3UMhpkuf5nkn/8X07C9sKoHuq+uhc8MNNPT5ATRlNk9Oca
         HXoU8AZXxVN5iOW0GEJ1RwVEokVvAMaIVDKgh8ykH7Zcezvu4dBIy0ydJ/wOmISqGpI+
         roMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PyKfclj0R6sp6C4s7NSiwpoSAE3GRZDAn9hDHIqvY2I=;
        b=Csfkydgog0lDBm45BYT+VavwY7kLH1nciP8AotuYi2kCWID9BqSo5bAIPpECM7zqFy
         xoCzEYxquuiTxyPoZccdO8Xa7P9UR6mmQSNNZ2x1EpyKM/vczqeDhDnbrvJcesB5v06s
         5VciKoM8GpZ/VN6sFQLLidpRkDcd+povLd41mZIFIyXTS6FUOCxPqZ9It73amrpGgaDB
         /X7flogwqRxf4vA094Lci5TqZ6mY5YQtgGhGIwgSLmK2HyBNWcwaejEKQMyRVyQ6g39a
         ODSRCh/UirgXP0tOR0LcSCoiCVWXgtpc9bUaMvu5t/+SGxxKARw5HUm3fRSeQcPOjW0G
         /L6Q==
X-Gm-Message-State: AOAM532jO0YxleewpYQ+nMYKchiwjbaaB4jLgfDhgbZ8geUSxqQjRR37
        dX7XkCUb3oquhFY8BVxrbsO95h0cLo9JSiJC
X-Google-Smtp-Source: ABdhPJwM4sELz40aNehyUxOQYlEfWEK0nnzLuLAfybL2btC5eREh8uHK4S4BUcWfhkxhljTNHk1CMQ==
X-Received: by 2002:a05:6602:99:: with SMTP id h25mr6564987iob.168.1614008651644;
        Mon, 22 Feb 2021 07:44:11 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s8sm11229576ilv.76.2021.02.22.07.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 07:44:11 -0800 (PST)
Subject: Re: [PATCH RESEND v4] loop: fix I/O error on fsync() in detached loop
 devices
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        krisman@collabora.com, eric.desrochers@canonical.com
References: <20210222154123.61797-1-mfo@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d338b39-af7f-4c03-ea93-b5cad3a91abb@kernel.dk>
Date:   Mon, 22 Feb 2021 08:44:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222154123.61797-1-mfo@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 8:41 AM, Mauricio Faria de Oliveira wrote:
> There's an I/O error on fsync() in a detached loop device
> if it has been previously attached.
> 
> The issue is write cache is enabled in the attach path in
> loop_configure() but it isn't disabled in the detach path;
> thus it remains enabled in the block device regardless of
> whether it is attached or not.
> 
> Now fsync() can get an I/O request that will just be failed
> later in loop_queue_rq() as device's state is not 'Lo_bound'.
> 
> So, disable write cache in the detach path.
> 
> Do so based on the queue flag, not the loop device flag for
> read-only (used to enable) as the queue flag can be changed
> via sysfs even on read-only loop devices (e.g., losetup -r.)
> 
> Test-case:
> 
>     # DEV=/dev/loop7
> 
>     # IMG=/tmp/image
>     # truncate --size 1M $IMG
> 
>     # losetup $DEV $IMG
>     # losetup -d $DEV
> 
> Before:
> 
>     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
>     fsync(3)                                = -1 EIO (Input/output error)
>     Warning: Error fsyncing/closing /dev/loop7: Input/output error
>     [  982.529929] blk_update_request: I/O error, dev loop7, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> 
> After:
> 
>     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
>     fsync(3)                                = 0

Applied, thanks.

-- 
Jens Axboe

