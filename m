Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A74CC54E4A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 21:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F3620A8B
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 21:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AdL+4uCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgEIVJe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 May 2020 17:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgEIVJd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 May 2020 17:09:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC32C061A0C
        for <linux-block@vger.kernel.org>; Sat,  9 May 2020 14:09:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y25so2789043pfn.5
        for <linux-block@vger.kernel.org>; Sat, 09 May 2020 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fcxrt5TeOTNZIA2qVesVcnGQf2Divl5YftKQUCVafyc=;
        b=AdL+4uCjBtsOtZJN2H2IklJcYEKp/Xrmw0Yh1L+9EvNngpSPI/s9F/kbv33Th278vy
         3me96pNZ8HL8x1+p3SVd2YJsdqE8m5i43K+TY4XvC7hBhYkdLWB+0HXqSRB5FiQz03/F
         FKm3Y4OrOcO3uj6UWUx45tPNlxvx2x3fFLTRT59ZWMl2KIPDz5ZK21p4MtEHyFGGkZYt
         VymOSlzyKtSWrtEHws6o13geuu86++KJmp6cFw2ClMtjKE1UlP0KR3uW7+y2XZQNsjXi
         4ts1q3pTpeeMm31mjQA7ELhC7i+wCFctcxW2EVXFaclg+GQrsCwJsCkFLAItHLSSZt2w
         MlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fcxrt5TeOTNZIA2qVesVcnGQf2Divl5YftKQUCVafyc=;
        b=Qn+1Ds3BjeucjFFoZ3LnAKQZSSO6LbXnBQLB0MlxOUADXWgIn8gWS3wp6BCQpPBjF1
         xO9kUk/leJLY02Ox3uYtmduEL9W6qMZ0Js3GY4BEzZXDLXal8Ee1gHzzLcgK0z02Y7uM
         +k8guICPuG9IBn44g+kLu+mvALLu67N0CtJa3S7Orqq0vXxR38uEudxqO7Y9TPnxB49N
         SZU6w5UApLGhgbjK79N7y8+rAnvoHZARXXqEWZEc/rlzQRm810in3oZExBUlRL6YFYoS
         kiX5TfcQ3ZcCI5sOoGlr6BM2httSqIbMq8hEmYOd1tFzQ4LJ2DVPXrn1k3OfT1Zm7Mwf
         iK6w==
X-Gm-Message-State: AGi0PuYrcXS0MFiUsRdUhxj4LAcItDHLje+bLD7hTrlrAV9+kRceDIE/
        00OLVIeUNQtvix7A1JovK1H+hNJZkqo=
X-Google-Smtp-Source: APiQypJOeiA/2qHIvTyBmt7vQNiJw20PtLhSu7eCu3XZiN4nf+aVP3N2DLevtISj59C8EB6Xodr8EA==
X-Received: by 2002:a63:4d0c:: with SMTP id a12mr3697447pgb.449.1589058571491;
        Sat, 09 May 2020 14:09:31 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d35sm4237506pgd.29.2020.05.09.14.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 14:09:30 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.7-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <cc854168-7859-49f9-63f7-dbaaff8fbb3d@kernel.dk>
 <CAHk-=wiaK+pETqCN6vMvU_wfpe-aUy1NkZADx4cV7tCcmDA=UA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c1230ad8-2bfa-9f2c-0605-e65703a6b462@kernel.dk>
Date:   Sat, 9 May 2020 15:09:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiaK+pETqCN6vMvU_wfpe-aUy1NkZADx4cV7tCcmDA=UA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/9/20 1:40 PM, Linus Torvalds wrote:
> On Fri, May 8, 2020 at 8:17 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> A few fixes that should go into this series:
> 
> Jens, wtf?
> 
> This doesn't even build. Commit 0f6438fca125 ("bdi: use bdi_dev_name()
> to get device name") results in
> 
>   In file included from ./include/linux/kernel.h:15,
>                    from ./include/linux/list.h:9,
>                    from ./include/linux/module.h:12,
>                    from block/bfq-iosched.c:116:
>   block/bfq-iosched.c: In function ‘bfq_set_next_ioprio_data’:
>   block/bfq-iosched.c:4980:5: error: implicit declaration of function
> ‘bdi_dev_name’; did you mean ‘blkg_dev_name’?
> [-Werror=implicit-function-declaration]
>    4980 |     bdi_dev_name(bfqq->bfqd->queue->backing_dev_info),
>         |     ^~~~~~~~~~~~
>   ./include/linux/printk.h:299:33: note: in definition of macro ‘pr_err’
>     299 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>         |                                 ^~~~~~~~~~~
>   In file included from ./include/linux/printk.h:7,
>                    from ./include/linux/kernel.h:15,
>                    from ./include/linux/list.h:9,
>                    from ./include/linux/module.h:12,
>                    from block/bfq-iosched.c:116:
>   ./include/linux/kern_levels.h:5:18: warning: format ‘%s’ expects
> argument of type ‘char *’, but argument 2 has type ‘int’ [-Wformat=]
>       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
>         |                  ^~~~~~
>   ./include/linux/kern_levels.h:11:18: note: in expansion of macro ‘KERN_SOH’
>      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
>         |                  ^~~~~~~~
>   ./include/linux/printk.h:299:9: note: in expansion of macro ‘KERN_ERR’
>     299 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>         |         ^~~~~~~~
>   block/bfq-iosched.c:4979:3: note: in expansion of macro ‘pr_err’
>    4979 |   pr_err("bdi %s: bfq: bad prio class %d\n",
>         |   ^~~~~~
>   cc1: some warnings being treated as errors
>   make[1]: *** [scripts/Makefile.build:267: block/bfq-iosched.o] Error 1
>   make: *** [Makefile:1722: block] Error 2
> 
> and no, it's not a merge error - at least not one by me. I tested the
> tip-of-tree that you sent me, at commit ded3148fc653.
> 
> So that build error exists in your branch.
> 
> Unpulled. Get testing, and don't send me garbage.

Gah, sorry about that, not sure how this went undetected. I'll
redo the pull request.

-- 
Jens Axboe

