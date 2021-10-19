Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF9CC433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF996101A
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhJSVcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVcf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:32:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AAFC06161C;
        Tue, 19 Oct 2021 14:30:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n11so14643213plf.4;
        Tue, 19 Oct 2021 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/A0vjBtdWcQiSlwZh59qIbopjqHxgB5b4LP7gfZx3Oo=;
        b=oILrH2qysB+qDzhwkdG8LC2R/dLRHXDpRW+GHAfo68BlOShl4R3Y5OakI73uO6ClMm
         IXx3pihhbxSMgFAW1tl6wekLLi3NXPlc5a6a/prVsqDGe54UI3SVnE+SRqT0iB0nWU9D
         V2C1XdG+22z7ELfnDRTljKrkcExNSoJsEzRt/LMg+soZzJ9l9EGi12k+s1f1l9XUAAfg
         Ytc8Rqd8LB3/fs2uyDJmVuG8Tm/Kfa0lnnlubQkboz6imhqJjobVLMQvBQP2mqnjiYgC
         NEKMLpN9CkHEjMXTQBBihpr6QQJkXeSgRrQv7cPSDYKZjytUCYc97fehiiY3hKwDQ1wr
         61bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/A0vjBtdWcQiSlwZh59qIbopjqHxgB5b4LP7gfZx3Oo=;
        b=apVWCQhpuFPHK6QrcpigwPcGjMbgsEMZhs9jk4bvZqxi4YCDlaEVA9OKHx3+jLUZ5w
         eMGlFnih0FYMH8ywh+JKUQcePmv5XBvtM47bKDxTAuIWmrIgRbzInbZ4KbWeG98TUbbZ
         Nf79PVtmDYF4B/3bFv8tzhLR+6t70kY++vJVbth09rIfF2pTP/pLhEEjKf5YtqTCD9TU
         dH4SFwIllhsLCBEuGP8mbYSPTWUqlxNyVlx+9o+7lDAjDySJs3KGjFuDIXUMA7oZdbIX
         ob6ryZWOJcw7LMM75M/JWoM0fG+NPSXyiV1pClWNQixBVOj9D9CHdgeCqwEpQ7Rn83/R
         BjRw==
X-Gm-Message-State: AOAM533+wXnu2+3E48VjAPtksxeL6NCfS8nesImX/pLvT11vJWOgsb7F
        KolzE3WvlRc0tpYhlCZi/ycBUwwLGrc=
X-Google-Smtp-Source: ABdhPJzHARR0Ko1Jx1iA5U9QYvyBKHW+A2haok8dfwMYjyR0ffa+wpvQVT5VJi9wDnU3uBDUfjY1Yg==
X-Received: by 2002:a17:902:9b8a:b0:13f:c286:a060 with SMTP id y10-20020a1709029b8a00b0013fc286a060mr12356715plp.66.1634679021318;
        Tue, 19 Oct 2021 14:30:21 -0700 (PDT)
Received: from [10.1.1.26] (222-155-4-20-adsl.sparkbb.co.nz. [222.155.4.20])
        by smtp.gmail.com with ESMTPSA id a12sm3554685pjq.16.2021.10.19.14.30.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 14:30:20 -0700 (PDT)
From:   Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v2] block - ataflop.c: fix breakage introduced at blk-mq
 refactoring
To:     Jens Axboe <axboe@kernel.dk>, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org
References: <20211019061321.26425-1-schmitzmic@gmail.com>
 <163464555754.595860.5260761740824485566.b4-ty@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Message-ID: <658a78d1-942c-3099-eaac-91afbbddc31c@gmail.com>
Date:   Wed, 20 Oct 2021 10:30:09 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <163464555754.595860.5260761740824485566.b4-ty@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Jens,

I'll pore over the code some more to see if there are any other problems...

Cheers,

	Michael

On 20/10/21 01:12, Jens Axboe wrote:
> On Tue, 19 Oct 2021 19:13:21 +1300, Michael Schmitz wrote:
>> Refactoring of the Atari floppy driver when converting to blk-mq
>> has broken the state machine in not-so-subtle ways:
>>
>> finish_fdc() must be called when operations on the floppy device
>> have completed. This is crucial in order to relase the ST-DMA
>> lock, which protects against concurrent access to the ST-DMA
>> controller by other drivers (some DMA related, most just related
>> to device register access - broken beyond compare, I know).
>>
>> [...]
>
> Applied, thanks!
>
> [1/1] block - ataflop.c: fix breakage introduced at blk-mq refactoring
>       commit: 86d46fdaa12ae5befc16b8d73fc85a3ca0399ea6
>
> Best regards,
>
