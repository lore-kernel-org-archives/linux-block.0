Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A81C433EF
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 16:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351776AbhKZQll (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 11:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbhKZQjk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 11:39:40 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2301DC0617A5
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 08:21:12 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e8so9536777ilu.9
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 08:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8VUNi0tD7aQvypwML4HzjsEbW1rI3hjQtUP8+ss6If0=;
        b=tiFtDeV4VI7HTx7QGq828pPLHGOSSOOZfsnKzpIZSxl0Z8dMQO3JCNWZt3mj20VGPV
         39x8/Mi7xvvYT3B9hKry2pYfPYQjJWCvQdP3cGqTw6hXD/FvUoRO+9G5eHUg3fzik974
         x8CXwGcoblMwDKQZsYIygelsQCzPjCdrebuI8S3Cn9GnEbprVOjyyKldhTWFu0WCXV2Z
         rZMA4OB2zY5dcSQj2x62IEE6v89ZiZe05t0ePjvRsqK6PwGXtCFekjK8OcNmuxeS3eoo
         nUnlIhhU5HD1XtTZhqxCJAaqpFknjw8uj9RXSrgKBzyCAEibiJU7RN5ylTVOFjlSiUtA
         aYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8VUNi0tD7aQvypwML4HzjsEbW1rI3hjQtUP8+ss6If0=;
        b=HtavN8WK94bqEIkXMWnOYfxOcSrenHiMEWY49qvVLFEdQHEKDMc88tYVMqZqDc6rff
         8OgKdsCbKPvR2QormYtK+uQJTYMGQnbolE/4JG67uCLEXIi4Hp5VSUd8uk4BSNajRGrc
         zePOp4Y2N/F6umTlJbV7qjOpHhsqWCFPh+Fnx+I82Lz736Qk7/o3KUlqoDAsq+9cxQVb
         HO1cz4B89GDK2U6YGNEDvkvF8Fr+WWG4ccQmYQR8dOAMUbwANs1PtLxEZkZvq0h1es8l
         45kXd0zcSQLX+m1NpYlPpxEGAts2VyeREw9Wm2SR/qzY9Of4txQvs9cVI4+TYlGeUgJn
         176Q==
X-Gm-Message-State: AOAM531Neo0mm8LduCCWj90modh1iU1DMDssGju8Qdw/KO8VHU8FzxLJ
        St+i4REgQfuWyMvZDB8lz7+Yaw==
X-Google-Smtp-Source: ABdhPJybNYibW8zTuWoXZTMyZ1XkGSGSJv0u6HcEEA+PMrayvKIUYJiOizJH0VBCU83Si2l/osxpyA==
X-Received: by 2002:a05:6e02:219a:: with SMTP id j26mr30543481ila.323.1637943671345;
        Fri, 26 Nov 2021 08:21:11 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j15sm3528017ilu.64.2021.11.26.08.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 08:21:10 -0800 (PST)
Subject: Re: I/O hang with v5.16-rc2
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20211126095352.bkbrvtgfcmfj3wkj@shindev>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <124f86f8-91db-3a02-702d-5c26b22de107@kernel.dk>
Date:   Fri, 26 Nov 2021 09:21:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211126095352.bkbrvtgfcmfj3wkj@shindev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/21 2:53 AM, Shinichiro Kawasaki wrote:
> I ran my test set on v5.16-rc2 and observed a process hang. The test work load
> repeats file creation on xfs on dm-zoned. This dm-zoned device is on top of 3
> dm-linear devices. One of them is dm-linear device on non-zoned NVMe device as
> the cache of the dm-zoned device. The other two are dm-linear devices on zoned
> SMR HDDs. So far, the hang is recreated 100% with my test system.
> 
> The kernel message [2] reported hanging tasks. In the call stack, I observe
> wbt_wait(). Also I observed "inflight 1" value in the "rqos/wbt/inflight"
> attribute of debug sysfs.
> 
> # grep -R . /sys/kernel/debug/block/nvme0n1 | grep inflight
> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:0: inflight 1
> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:1: inflight 0
> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:2: inflight 0
> 
> These symptoms look related to another issue reported to linux-block [1]. As
> discussed in that thread, I set 0 to /sys/block/nvme0n1/queue/wbt_lat_usec.
> With this setting, I observed the hang disappeared. Then this hang I observe
> also related to writeback throttling for the NVMe device.
> 
> I bisected and found the commit 4f5022453acd ("nvme: wire up completion batching
> for the IRQ path") is the trigger commit. I reverted this commit from v5.16-rc2,
> and observed the hang disappeared.
> 
> Wish this report helps.
> 
> 
> [1] https://lore.kernel.org/linux-block/b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com

Yes looks the same as that one, and that commit was indeed my suspicion
on what could potentially cause the accounting discrepancy. I'll take a
look at this.

-- 
Jens Axboe

