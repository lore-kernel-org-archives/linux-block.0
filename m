Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3842DC433F5
	for <linux-block@archiver.kernel.org>; Sun, 14 Nov 2021 20:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01905610F9
	for <linux-block@archiver.kernel.org>; Sun, 14 Nov 2021 20:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbhKNU6U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Nov 2021 15:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbhKNU6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Nov 2021 15:58:18 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C4CC061766
        for <linux-block@vger.kernel.org>; Sun, 14 Nov 2021 12:55:24 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id k22so18522917iol.13
        for <linux-block@vger.kernel.org>; Sun, 14 Nov 2021 12:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vnrrgUlslUtgQe5ZPoXgYoB8Ny1MSFL5eMSCV1rYDUE=;
        b=n2m0gMtldmYpPXsUbVYEx5I8faeNqP6HLFRz7mOkwhupuLGzFixSvXlt31rAJHRncW
         TYbYiSul/fXsM91lF/UVaf96N6dLJ2yFnleatQf9xDFKyfj+LCyvKKCj8PJWyBFozE8E
         ZTjmGg1xgZtiv0xRGpvI/wlpTbmneAM+Vv+bCS8gUpcb55LvKJUM+ftEH5KgaLL2btdx
         kYTyIWvk/JQjpCtAD0y3WiimdPc925deQbfg6+6kEMzQwgRrJ1g17wu4JigtLVPbUUIC
         4Csswn5Cc8MVF6JMe1+oIsVTBTdE+2Ob+hMmmhxeuwZNBfM2NpfARW/V1VDVQrfbusGj
         Fl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vnrrgUlslUtgQe5ZPoXgYoB8Ny1MSFL5eMSCV1rYDUE=;
        b=m4vJiCwUjboxP9EW7Bwsuj3EK/mkezRcZX47g+eDJR7rezS1zkqM2zBJ8lfWndNn+5
         M8XOwlRSQzabSuCwIEGGJCTBfRjT4A6sPcPr7hIyYd/4VaO4e20KBoeoKWlEU1aq2ANG
         BKOEeK6ekUEzW+hGwsyMIE8D058P2XIaBvBPRD7eX3x0+JWdykpLq17ug4RkTYpXMwao
         O1iU9CulJ6NKjOQwLEKmHSS6ZrVKd2VRo7pFHmMb/ll4qRu9jmVgrps3dS82PjFcVcwx
         wF1YyTJNMtT+cbUw1TzKkxk3+VvqDBBdrviA/DOSLHA3wMN+z3si44XAsHrOthXVv/ma
         BKVA==
X-Gm-Message-State: AOAM532e8SUgJ4yPqXa0qNF3nZxwTAmEBODPivnhS982PYCfFuXwZ8fn
        NOhZx0p4i1Bja73M721FCUJ+Bw==
X-Google-Smtp-Source: ABdhPJykvT2tu9oqZDQSQZiO4FtXm65JDqct0FZyOkbGCoXAwdl+pn38AL5+JD5wAI4bLz5caMmIUQ==
X-Received: by 2002:a5d:8451:: with SMTP id w17mr22666918ior.139.1636923322965;
        Sun, 14 Nov 2021 12:55:22 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g10sm9442396ila.34.2021.11.14.12.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 12:55:22 -0800 (PST)
Subject: Re: uring regression - lost write request
To:     Daniel Black <daniel@mariadb.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <CABVffENnJ8JkP7EtuUTqi+VkJDBFU37w1UXe4Q3cB7-ixxh0VA@mail.gmail.com>
 <8cd3d258-91b8-c9b2-106c-01b577cc44d4@gmail.com>
 <CABVffEOMVbQ+MynbcNfD7KEA5Mwqdwm1YuOKgRWnpySboQSkSg@mail.gmail.com>
 <23555381-2bea-f63a-1715-a80edd3ee27f@gmail.com>
 <YXz0roPH+stjFygk@eldamar.lan>
 <CABVffEO4mBTuiLzvny1G1ocO7PvTpKYTCS5TO2fbaevu2TqdGQ@mail.gmail.com>
 <CABVffEMy+gWfkuEg4UOTZe3p_k0Ryxey921Hw2De8MyE=JafeA@mail.gmail.com>
 <f4f2ff29-abdd-b448-f58f-7ea99c35eb2b@kernel.dk>
 <ef299d5b-cc48-6c92-024d-27024b671fd3@kernel.dk>
 <CABVffEOpuViC9OyOuZg28sRfGK4GRc8cV0CnkOU2cM0RJyRhPw@mail.gmail.com>
 <e9b4d07e-d43d-9b3c-ac4c-f8b88bb987d4@kernel.dk>
 <1bd48c9b-c462-115c-d077-1b724d7e4d10@kernel.dk>
 <c6d6bffe-1770-c51d-11c6-c5483bde1766@kernel.dk>
 <bd7289c8-0b01-4fcf-e584-273d372f8343@kernel.dk>
 <6d0ca779-3111-bc5e-88c0-22a98a6974b8@kernel.dk>
 <281147cc-7da4-8e45-2d6f-3f7c2a2ca229@kernel.dk>
 <c92f97e5-1a38-e23f-f371-c00261cacb6d@kernel.dk>
 <CABVffEN0LzLyrHifysGNJKpc_Szn7qPO4xy7aKvg7LTNc-Fpng@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <00d6e7ad-5430-4fca-7e26-0774c302be57@kernel.dk>
Date:   Sun, 14 Nov 2021 13:55:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABVffEN0LzLyrHifysGNJKpc_Szn7qPO4xy7aKvg7LTNc-Fpng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/21 1:33 PM, Daniel Black wrote:
> On Fri, Nov 12, 2021 at 10:44 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Alright, give this one a go if you can. Against -git, but will apply to
>> 5.15 as well.
> 
> 
> Works. Thank you very much.
> 
> https://jira.mariadb.org/browse/MDEV-26674?page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel&focusedCommentId=205599#comment-205599
> 
> Tested-by: Marko Mäkelä <marko.makela@mariadb.com>

Awesome, thanks so much for reporting and testing. All bugs are shallow
when given a reproducer, that certainly helped a ton in figuring out
what this was and nailing a fix.

The patch is already upstream (and in the 5.15 stable queue), and I
provided 5.14 patches too.

-- 
Jens Axboe

