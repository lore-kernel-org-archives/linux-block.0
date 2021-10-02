Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C73C433F5
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 13:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE9C61AF7
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 13:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhJBNbe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Oct 2021 09:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhJBNbd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Oct 2021 09:31:33 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219D5C0613EC
        for <linux-block@vger.kernel.org>; Sat,  2 Oct 2021 06:29:48 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h129so14930903iof.1
        for <linux-block@vger.kernel.org>; Sat, 02 Oct 2021 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dENNweAxQWOuKHBUsJgBLnxMXPi9Q5rhL1QhSKK0T1g=;
        b=PuYtCcNNxGBTT04lZ6LV0k2cibJvEShQCrJgf/bPnGnd74ugg3v9m/PMIjhVvXNX0E
         hCNqdz3sogdj2vHTHjqP1IflDMaLZjrT2vZNQelszRdjFYoiqAOL42MDHzT9pPjX0Q15
         ZS4bn+tbtjqrki0zw9AKkjs0RYsZCuWk5xWjtbkmfB+x8tss9XmBusMdDNpttIxyrZT4
         4Xk7t8qaryjk1BdiQ3V3rR31voRsOToLwbnGheq8Bgi7DTQQdJkhu8sFVPb8DKDFyiqq
         gw1/9xeJWtmfQYpDpn2escbIBz4VAR44zYkmDdT79sWZC3AYgt19h3swfg/Kj6zTEHFt
         nZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dENNweAxQWOuKHBUsJgBLnxMXPi9Q5rhL1QhSKK0T1g=;
        b=PDZdIyE7O/yGaPqdZDra+EYNllqWPtvycaqju3Am/RjzAvWDWthIF/Lo9DTJVl2St1
         4wYsfh75VZ6uzGxAymlzZDLfTmZx9fnr0nDimQORY9wP4w8K2xTvxVKxPHOQYDHz0d0H
         xV+/3Um9mupBPey28l/jlnPS2hcp2e/kTsKhz5ME8lkZrMZrCyoSmL9V2WBGln9ZxNZv
         d62dn+N8rdVMduq0gHCYVvjvhdzdDqD9VYj5APavSGW/aWYmNwCP4TJNAoxXho/hVeeB
         vZ/B14AAp3mfk0dkaY27pWYLJo+4JVDoNJUqUxS/ND70areVU2h5v3dnnF4+fsYxfZhT
         myug==
X-Gm-Message-State: AOAM532m8v+cNPNTsTshYgziLb39rscYepPVnKm/DAy3RWU3qrvrRX+k
        qXXK1UEzq6Uw8bYed2OowaGragoy1Y6wpw==
X-Google-Smtp-Source: ABdhPJxQSvvZu8KSbRO8mcHcWffe7EdHUPOMINVxPGEKRLOO9SUNeoMN69ksQ8Tf/8lclUrW73yRDA==
X-Received: by 2002:a05:6602:2151:: with SMTP id y17mr2424886ioy.197.1633181387585;
        Sat, 02 Oct 2021 06:29:47 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h3sm2613208ili.87.2021.10.02.06.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 06:29:47 -0700 (PDT)
Subject: Re: [PATCH v2 (RESEND)] block: genhd: fix double kfree() in
 __alloc_disk_node()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <e6dd13c5-8db0-4392-6e78-a42ee5d2a1c4@i-love.sakura.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3b639c9c-539d-f09c-fb52-f838f2a37ad3@kernel.dk>
Date:   Sat, 2 Oct 2021 07:29:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e6dd13c5-8db0-4392-6e78-a42ee5d2a1c4@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/2/21 3:23 AM, Tetsuo Handa wrote:
> syzbot is reporting use-after-free read at bdev_free_inode() [1], for
> kfree() from __alloc_disk_node() is called before bdev_free_inode()
> (which is called after RCU grace period) reads bdev->bd_disk and calls
> kfree(bdev->bd_disk).
> 
> Fix use-after-free read followed by double kfree() problem
> by making sure that bdev->bd_disk is NULL when calling iput().

Applied for 5.15, thanks.

-- 
Jens Axboe

