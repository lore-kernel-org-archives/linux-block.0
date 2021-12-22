Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B1DC433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Dec 2021 15:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbhLVP4y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Dec 2021 10:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhLVP4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Dec 2021 10:56:53 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61615C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Dec 2021 07:56:53 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id v10so2141770ilj.3
        for <linux-block@vger.kernel.org>; Wed, 22 Dec 2021 07:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AGUbv8FQKdejZqiK/AphGsZArcqOnzS9+M0oJenzGdE=;
        b=HPm5xSQmnUPzu4QXQssDXgC0m16sxG4xHWJhxR0nmtU2nRwMsy073pbH/F81hiB4Iy
         x/dSG+sc7rJNdBPrn4ORI5L5zUkkjv46UdmeMWNJqHXbb/qQZP4bu3JQUUIeEcLapbZd
         8eifD/oQF3KZiVumew4cLPKwXhPQS6fd4AE9bDtO7WGO7AVLkm0EKJ1dvKHkiQvB620l
         o2sWZ9FUMpG74ienXzEej0P//5tEObtericeqq0m3J6cjLTxWh0nxnpJpNc7i/yovIY0
         hSmeenCDHnnbDJxqnINjl6BGD1CrK3/OsGuMIDYa50FTbk/w8vbAh7iN8cG3d2h3a7mN
         XgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AGUbv8FQKdejZqiK/AphGsZArcqOnzS9+M0oJenzGdE=;
        b=a/Dg+jhN8neaetPes2yRisKdRlXQDnnSB9+N1u6nGeYV3t+NSJhDcppuyq223gwd6C
         LuQkymHVk0fvk4+swoyGMuv2D+62Cd0O+bx6X2ax3q/qtVD964oFlI+21CxBaqdZxWAJ
         as4Sca5W8lcxbLFhFtR/hHOpbw0xw3/ThLaUj8nekKUwk4tuddTGzVCz/YxIzNSJVZ9H
         GKnJprfGqWTn5dfap8S0HnzkrakwrU86ZuFat5g0kfhPnIw+fpfwW92nM4HOYE4VRcoY
         WZgoPagc3jeLhUE+CJsvaV9cttbjJJUQRJWbcEuzbtxwXq6ewkl93MrkctJph7Jh6CT5
         YsrQ==
X-Gm-Message-State: AOAM530Xum9mKEB3Hdj8PMx3k3NEUVTidGDv6SWq6Fg9tj38YfizkIMl
        iW4V/FEAq4YplwIZWfmkQ8VYur2pZrxLXw==
X-Google-Smtp-Source: ABdhPJzQckiUKSuYnTpfMWij+o0lAZ8p6bGjj83S4wEO3Y/aGuUjrffl9cll30uJoifcvnnHY0nw+w==
X-Received: by 2002:a05:6e02:1bc6:: with SMTP id x6mr1630136ilv.31.1640188611969;
        Wed, 22 Dec 2021 07:56:51 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h13sm1386886ilj.59.2021.12.22.07.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 07:56:51 -0800 (PST)
Subject: Re: [PATCH 2/2] loop: use task_work for autoclear operation
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
References: <e9f59c70-5dc9-45ce-be93-9f149028f922@i-love.sakura.ne.jp>
 <9eff2034-2f32-54a3-e476-d0f609ab49c0@i-love.sakura.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da951c17-8a2f-4731-c34d-e08921824414@kernel.dk>
Date:   Wed, 22 Dec 2021 08:56:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9eff2034-2f32-54a3-e476-d0f609ab49c0@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/22/21 8:27 AM, Tetsuo Handa wrote:
> The kernel test robot is reporting that xfstest can fail at
> 
>   umount ext2 on xfs
>   umount xfs
> 
> sequence, for commit 322c4293ecc58110 ("loop: make autoclear operation
> asynchronous") broke what commit ("loop: Make explicit loop device
> destruction lazy") wanted to achieve.
> 
> Although we cannot guarantee that nobody is holding a reference when
> "umount xfs" is called, we should try to close a race window opened
> by asynchronous autoclear operation.
> 
> Try to make the autoclear operation upon close() synchronous, by calling
> __loop_clr_fd() from current thread's task work rather than a WQ thread.

Doesn't this potentially race with fput?

-- 
Jens Axboe

