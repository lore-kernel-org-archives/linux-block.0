Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5F7C0015E
	for <linux-block@archiver.kernel.org>; Mon,  3 Jul 2023 21:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjGCVYk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jul 2023 17:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGCVYj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jul 2023 17:24:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CD1E59;
        Mon,  3 Jul 2023 14:24:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-262e5e71978so3055816a91.1;
        Mon, 03 Jul 2023 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688419478; x=1691011478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpOqp01Y09RT93V73Bd4o1/E/FiGvvP00gnBaCVYads=;
        b=Rl2Z73YdeHlto+tVAu67WSsvlhq7V0s0Eyk2c2gQnf6vcp1omFetn+5UpBF6D2SdaI
         2T3vUTA9vNUxhotbbw9qCFUeSO8xJ9M2uVbLK9VPT9THRnZJiT1zrm3pFYF0Wf6JtM2o
         gqQspcHp1r26sufWATp4dp2sc9S0hdc5IefvTKFlDkSoIC3/ki4qFuZNW7woqNJUfdtv
         5P3pV+39CetjmLgD3b5M74/+d1g/4OoLx7pGeaVNTmhswoC9gbbI37+xkTg4wXylaC5/
         x+i1s1aXa5yfIsBgtaxtBNaFN/dLvxuDgaXpfjs91YoAW7SpTinNE+ugwu1l19LdlDfJ
         PCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688419478; x=1691011478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpOqp01Y09RT93V73Bd4o1/E/FiGvvP00gnBaCVYads=;
        b=VtIsw2IH7le+0nEV22gUh3+VRCB1CAIEy6Hy2sC1CXsYZb4nDbHpdvD/zwTcZHwZuz
         TWDQUGqDeKk0pxSUeW/lkhyIc1KQzNk3saZM80U89DIv03ejuiUMYaDIwM+gQS+Y+n1u
         +Vr+wH/l7y2YW44xq8bG3gQr/Mj6YHMZf93Kuw7MhCX4xG6WAS4xqiRe7KH2KKiSFtRy
         Oqqxa8he3JAStw5nv/ybccjmugjTxk7dQTp9asDFUJQaGoHNgqM6dbfka1LGDOFcAKYs
         UbCtA7nvQ09z79sZYQhreZ9Y1n8883pQvdvcKO6Vpf80494pyWhGqr2WlboobM7cX8Ie
         7jmQ==
X-Gm-Message-State: AC+VfDwosj3+2ZHAqA5Q56up2PCVLcd3hoPSej2tnKypOB6tUh9UJG+m
        TmLnXXtq5mWSMozgyhQkLvc+B31GtiGsFA==
X-Google-Smtp-Source: ACHHUZ5lmFAlkQItaBYHbcoBhvqjOyGTfIZiMst4U+Pdmx0CGL1NZU/0DQeG0dOoaw+LdM+bZyE7Cg==
X-Received: by 2002:a17:90a:68cd:b0:262:c41e:1fcb with SMTP id q13-20020a17090a68cd00b00262c41e1fcbmr22312538pjj.14.1688419478059;
        Mon, 03 Jul 2023 14:24:38 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:d1e:daf:45b5:fd3f? ([2001:df0:0:200c:d1e:daf:45b5:fd3f])
        by smtp.gmail.com with ESMTPSA id cx3-20020a17090afd8300b002633fa95ac2sm9145262pjb.13.2023.07.03.14.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 14:24:37 -0700 (PDT)
Message-ID: <45d9f890-ebe2-4014-2411-953fd9741c2b@gmail.com>
Date:   Tue, 4 Jul 2023 09:24:30 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Content-Language: en-US
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block <linux-block@vger.kernel.org>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <1885875.tdWV9SEqCh@lichtvoll.de>
 <234f57e7-a35f-4406-35ad-a5b9b49e9a5e@gmail.com>
 <4858801.31r3eYUQgx@lichtvoll.de>
 <947340d9-b640-0910-317b-5c8022220a55@xenosoft.de>
 <80266037-f808-c448-c3c7-9d5d5f4253a7@xenosoft.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <80266037-f808-c448-c3c7-9d5d5f4253a7@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christian,

On 4/07/23 02:59, Christian Zigotzky wrote:
>> I am very happy that this bug is fixed now but we have to explain it 
>> to our customers why they can't mount their Linux partitions on the 
>> RDB disk anymore. Booting is of course also affected. (Mounting the 
>> root partition)
>>
>> But maybe simple GParted instructions are a good solution.
> You can apply the patch. I will revert this patch until I find a 
> simple solution for our community.
>
> Thank you for fixing this issue!

Thanks for testing - I'll add your Tested-by: tag now. I have to correct 
the Fixes: tag anyway.

Jens - is the bugfix patch enough, or do you need a new version of the 
entire series?

Cheers,

     Michael


