Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2BBC433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206EB60C49
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhJRXJf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 19:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhJRXJf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 19:09:35 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5F1C061745
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 16:07:23 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j8so16543026ila.11
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 16:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cgBnfuvcZu56328itL4at5TeThGSI6ERZbPFvtTMPB0=;
        b=soDFYoIOYlmGB1fXcSHfAqdDOiFWS+3DeI2m5jhCu6TC0AQ8PwF0ttJZTgKjuRxCaY
         E8Lp6pvXC8SFUFicJzIZgO7+mJEfVcob6QuT34jQXGHeItnUfdvWtH5r9g9naNYSAEX1
         XBrtLMMxiaBdFu3vVfou25WzOwZf1p55knBa3gtTr8/xKCrS28IoB4IuqmQ+63ZZKqGE
         xUIAWMO0qi7jI+q7MjR2XrEMpBGjwscKH+XnBuZIioMORx+lep2vKHpToaHwhJt910Lg
         Pw3LXTSqCIhAqF/abMxrFsB7DBdriXZr8UDqds2pElWuxCSPxm2qmQxOVZjD2BCrZ6Mz
         KaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgBnfuvcZu56328itL4at5TeThGSI6ERZbPFvtTMPB0=;
        b=j/U1SudP5ImhiYPXFqcIZyP/DlTWqp+1AKzPOO32luSWxpXAWA+C00SvH0lqLLJXl0
         7zntM8fVPVGgMyqthFY7GJCWvIuFrgMxbT9sjpVCav87wsxYR4kfi4S0ZacQjF64mP44
         oA4kY36mlOrgwKWqUkB4UuuiV75bro9JdAR2fCkl6iw76KQW8n95eFdwXqXaMa7Hp4LR
         AUuJlWBUdJyLHeZhtVzTpOXfvrP4OYdcB/xPNPI9o5kE86kf17Sne0bCGsVn2bMhu3gV
         65clxc4K4D5mIEpMi43CwBdKtwJiY4f36ouvc8rZcK21eWwsp0f0L+sn1V9umofP1zlF
         lTNQ==
X-Gm-Message-State: AOAM532y0XVLsb/apORNP2CWSnpz0rorml71tYADQBbso8HEvpFBpSWD
        pCNZ90pVWmenqp5zhhwknqsAcQ==
X-Google-Smtp-Source: ABdhPJxS+/Y50/QdD0KF2Et0sT9G8VxE2gDlkU6k1WEAqIC07fzYRgdMythLZ/BoE0w0BUI0O9Oxrw==
X-Received: by 2002:a05:6e02:1a2e:: with SMTP id g14mr12399334ile.294.1634598443041;
        Mon, 18 Oct 2021 16:07:23 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b13sm7267493ioq.26.2021.10.18.16.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 16:07:22 -0700 (PDT)
Subject: Re: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq
 refactoring
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20211018222157.12238-1-schmitzmic@gmail.com>
 <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk>
 <97323ce2-4f5c-3af2-83ac-686edf672aea@linux-m68k.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7f64bd89-e0a5-8bc9-e504-add00dc63cf6@kernel.dk>
Date:   Mon, 18 Oct 2021 17:07:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <97323ce2-4f5c-3af2-83ac-686edf672aea@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 4:51 PM, Finn Thain wrote:
> 
> On Mon, 18 Oct 2021, Jens Axboe wrote:
> 
>> Was going to ask if this driver was used by anyone, since it's taken 3
>> years for the breakage to be spotted... 
> 
> A lack of bug reports never implied a lack of users (or potential users). 
> That falacy is really getting tiresome.

If it's utterly broken, I'd say yes, it very much does imply that really
nobody is using it. 

> It is much more difficult to report regressions than it is to use a 
> workaround (i.e. boot a known good kernel). And I have plenty of sympathy 
> for end-users who may assume that the people and corporations who create 
> the breakage will take responsibility for fixing it.

We're talking about a floppy driver here, and one for ATARI no less.
It's not much of a leap of faith to assume that

a) those users are more savvy than the average computer user, as they
   have to compile their own kernels anyway.

b) that there are essentially zero of them left. The number is clearly
   different from zero, but I doubt by much.

Hence it would stand to reason that if someone was indeed in the group
of ATARI floppy users that they would know how to report a bug. Not to
mention that it was pretty broken to begin with, so can't have been used
much before either.

The reason I ask is always to have an eye out for what drivers can be
eventually removed. The older drivers, and particurly the floppy ones,
are quite horrible and would need a lot of work to bring up to modern
standards in terms of how they are written. And if nobody is really
using them, then we'd all be better off cutting some of that dead
baggage.

> Do maintainers really expect innocent end users to report and bisect 
> regressions, and also test a series of potential fixes until one of them 
> is finally found to both work and pass code review?

If someone reports a bug to me, the most basic is usually "It worked in
this version, it's broken in this one". Then you take it from there,
depending on the abilities of the user. I'd only ask someone to bisect
an issue if it's really puzzling and the user is capable and willing.
But it doesn't take much to send a simple email saying that something
used to work and now it's broken.

-- 
Jens Axboe

