Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D4EB64DD
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 22:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjGEW0I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 18:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEW0H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 18:26:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAEA1725;
        Wed,  5 Jul 2023 15:26:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6686708c986so154684b3a.0;
        Wed, 05 Jul 2023 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688595966; x=1691187966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RmTqJzAUgYc+uRfHjZrNduvCihVno9TPlZB2tG/vzYU=;
        b=DXu6KFerICTEr9NA8iR+1Q+UwXsJoaorSDrIO+78HvABXiXwHdtTeSsYQrOoJr0/Oa
         vREWVi7wDBdHzbdlTL0nNEIbWAtZLEVgBxQGvWbrkDYb7XQ+Gt38rH4dr8AsEnxCefzi
         tHT5VlwnLJxhouyDgBEQeokATmLU0pVumDXr3+/p2lSp9k9kzi8SMjh53qNqT+ZUvBGi
         2bVaHJcDcZJAq4J+dz8ZAt5r7lBS3qr6mGCuTMDZDBslw1CIIdt84rzHOihlBX92JYEE
         Ir3/5+xRl4S2i+M7PYlCxQ1ZvTNcte9JvheOFeGvIGkAbihiPUoD4w++xJIRGjUJGgG4
         Boqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688595966; x=1691187966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmTqJzAUgYc+uRfHjZrNduvCihVno9TPlZB2tG/vzYU=;
        b=Pz6Zzc5Xw5gzyR/1w6FwqOeus4e7BwO3/8MN+mqQjQ5N0iBwYu0naTE1CLqY+ZkPuo
         l0Ejt8flxKEsiwmFpUc599q5PKE+LZAtyy3i6WfgBiHZMp7b8ovaMPT+EAtiZ4ERom40
         epI153we2fx9elwiqXODfT+WDALNCyG3KaQybNiL2UD0v3OzRv0ornOEslF90WGI5TKL
         CaCJZKL5WY368IZJiolKTbhCnMQmwFsBdoNVU9Xc8wsbJbNLYahHi9Hzo4wk2HO9vINL
         tq4KyPLVmi0a96vQYyPSbdQlkP6y8KtdcQ0K94W8bLpcsqBtVVD5jzgH7Irb5i3PH5Mr
         yAqg==
X-Gm-Message-State: ABy/qLaZdZhjfxwImdUogv8C8lT2XdkwISrzodp6wv0XFyba0JvcCwi4
        FcYFYa+BZzjbaII5Zn6nY2g=
X-Google-Smtp-Source: APBJJlFw6Uel7xU6c1btuq6mW6FnreF7prluUcRA4u2aLqgq6RcWk7n38ZTzhZMBtIT1ExRoIM2MoQ==
X-Received: by 2002:a05:6a00:180c:b0:680:98c:c595 with SMTP id y12-20020a056a00180c00b00680098cc595mr273282pfa.13.1688595965913;
        Wed, 05 Jul 2023 15:26:05 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:65c6:1730:4701:8c0b? ([2001:df0:0:200c:65c6:1730:4701:8c0b])
        by smtp.gmail.com with ESMTPSA id i17-20020aa787d1000000b00682b2044149sm42766pfo.4.2023.07.05.15.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 15:26:05 -0700 (PDT)
Message-ID: <1bed3177-4d1f-ae04-7ae2-353afb314cbc@gmail.com>
Date:   Thu, 6 Jul 2023 10:25:59 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check
 patch
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com>
 <a84267a2-e353-4401-87d0-e9fdcf4c81a0@kernel.dk>
 <6411e623-8928-3b83-4482-6c1d1b5b2407@gmail.com>
 <f61ba21f-a8a0-756c-2a41-b831a0302395@kernel.dk>
 <01cf1491-a9b3-2342-3fd6-f4cae212bc43@gmail.com>
 <49192b95-8fc8-7dcd-f062-a4876731e347@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <49192b95-8fc8-7dcd-f062-a4876731e347@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On 6/07/23 10:13, Jens Axboe wrote:
>>> should be enough for it to go into stable from 5.2 and onwards.
>> OK - I wasn't certain whether you wanted the Fixes or stable tag dropped.
>>>> (Greg didn't seem to object to the Fixes: as such, just to the
>>>> incorrect version prereq)
>>> I think it's really confusing... A patch should only have a Fixes tag if
>>> it's fixing a specific bug in that patch. Either it is, in which case
>>> you would not need Cc stable at all since it's only in 6.5-rc, or it
>> It is fixing a bug in b6f3f28f60. I should have checked whether the
>> patch series had already gone to release, not just -rc, instead of
>> just adding the stable tag out of caution.
> But this is the confusion - if it's fixing a bug in b6f3f28f60, then why
> is it marked as needing to get backported much further back, predating
> that commit?

I see - it doesn't need to be backported that far back _alone_. It only 
needs to be applied after  b6f3f28f60 once that one has been backported.

Cheers,

     Michael




