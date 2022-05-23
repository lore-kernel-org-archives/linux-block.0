Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F14CC43217
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 12:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiEWMgd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 08:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiEWMeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 08:34:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C984442A3B
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 05:34:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q18so12953561pln.12
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GCE2nGwlSzDm4FRAKR9XWUKV2cYGLHBtnDJjqTUCz3g=;
        b=AUD1k/5Il6KA9nnZTRKy51zxMg8hpIWppmF4I8Uq7kwfO4N0BNxkUkR8vSrWNW+0QT
         JDNSeq3l/+4fQqS/qGn9CwHw7c1mcAx1l5O+MQeH0utxCCJVT6snY8oB2qwhwHTfDW3i
         V1okNcXPCrDilUi5gWzX1lfwwy6xvmR9hKNw0aB66aPg+DCrTEAA1O0X2xPK4uVxXoUZ
         pBEHpZbcgUavV5sNyrmE1478ivZoCgLLT+h7+1EmIi2HSH9VbyeSuM1IrWjnFM8BL9z3
         isx02vSybd+XlNVJp4Nt3WtRmkh7FXPA8V+he7D6O2lbNQV/uEyl3H+WNFZbbRBwxRHU
         Z3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GCE2nGwlSzDm4FRAKR9XWUKV2cYGLHBtnDJjqTUCz3g=;
        b=6aUMrvVZipbHjd5n0/1/ZUHVnGjXM1gh3cEPu6h9Dm7PMQlaU28Smq2HS9UCpaWZ2y
         tsAcUJt5J3pOGCCNZvjKzyWWX3n4Lycfxr34OQnUbqDOv7AkE9Rk/ia/iKho5T4OV8X3
         jA3xu+xb1JTy93y++NEcR1o5jCsnjF2DemZSu5qqpKB7deLo9qIqsxNrKuCmS5OPkyrw
         dbf8e+FyPgZHQCQM9cAsNvvQqpMWoPGWLKcl4FfBpUMolc44Bxp6WVkKMUhd/UjhYTSb
         POeWzMbaRXpMY8jVxe8yGpPFfHSjiVkf8yT7n4NIMErJZUngY4CphRO+AiR/Ow0CxaVV
         uVYA==
X-Gm-Message-State: AOAM532h4420t3GFVY1USkVTVValWLhs515iUejQWjgYSrXbHuvSSfk0
        EtjlgIuVpPciLD+NED4B4MNz1A==
X-Google-Smtp-Source: ABdhPJzgoOyGNawu3EG5PhFUkCLxs26tbNXp/x3LWQH9HJyu0iQ7D/qLRRHPfLvKpd0iKudcqH3otw==
X-Received: by 2002:a17:90b:3b81:b0:1e0:3ebf:c6ae with SMTP id pc1-20020a17090b3b8100b001e03ebfc6aemr7486040pjb.186.1653309250207;
        Mon, 23 May 2022 05:34:10 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ms16-20020a17090b235000b001d5943e826asm7336604pjb.20.2022.05.23.05.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 05:34:09 -0700 (PDT)
Message-ID: <e6f9a552-bf9a-ae80-d8be-55f23d6050eb@kernel.dk>
Date:   Mon, 23 May 2022 06:34:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/4] bcache patches for Linux v5.19 (1st wave)
Content-Language: en-US
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20220522170736.6582-1-colyli@suse.de>
 <ece7e00e-5d03-41c0-4013-75809958e9d7@kernel.dk>
 <9c3fddec-1741-872f-1cdb-b44316e2ff64@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9c3fddec-1741-872f-1cdb-b44316e2ff64@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/22 12:26 AM, Coly Li wrote:
> On 5/23/22 1:43 AM, Jens Axboe wrote:
>> On 5/22/22 11:07 AM, Coly Li wrote:
>>> Hi Jens,
>>>
>>> The bcache has 4 patches for Linux v5.19 merge window, all from me.
>>> - The first 2 patches are code clean up and potential bug fixes for
>>> multi- threaded btree nodes check (for cache device) and dirty sectors
>>> counting (for backing device), although no report from mailing list for
>>> them, it is good to have the fixes.
>>> - The 3rd patch removes incremental dirty sectors counting because it
>>> is conflicted with multithreaded dirty sectors counting and the latter
>>> one is 10x times faster.
>>> - The last patch fixes a journal no-space deadlock during cache device
>>> registration, it always reserves one journal bucket and only uses it
>>> in registration time, so the no-spance condition won't happen anymore.
>>>
>>> There are still 2 fixes are still under the long time I/O pressure
>>> testing, once they are accomplished, I will submit to you in later
>>> RC cycles.
>>>
>>> Please take them, and thanks in advance.
>> It's late for sending in that stuff, now I have to do a round 2 or
>> your patches would get zero time in linux-next. Please send patches
>> a week in advance at least, not on the day of release...
>>
> Hi Jens,
> 
> This time the situation was awkward, indeed I didn't expect I can
> submit the fix in this merge window, but just around 1 week before I
> found the difficult was from influence by other depending issues.
> After fixed all of them and do I/O pressure testing for 24x2 hours, it
> comes to such close day to the merge window.
> 
> My confusion was, it was very close to the merge window so maybe I
> should submit them in next merge window (5.20), but this series were
> bug fixes which should go into mainline earlier. It seems neither
> option was proper, so I chose the first one...
> 
> Could you give me a hint, what is the proper way that I should do for
> such situation? Then I will try to follow that and avoid adding more
> workload to you.

It would help if the submission came with an explanation of why they are
being submitted so late, as I really do expect it to happen around -rc7
time. Sometimes it's just because people are a bit lazy getting changes
submitted, and then do it at that last minute. That makes me a bit
annoyed. And other times there are totally legitimate reasons for why
they are being submitted late, like your explanation above.

It really depends on the scope of the changes, too. Simple fixes are
obviously fair game at any time.

-- 
Jens Axboe

