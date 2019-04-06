Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB99C10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC29213A2
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Wt5OaIz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDFQsV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 12:48:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41545 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfDFQsV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 12:48:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so5028894pfd.8
        for <linux-block@vger.kernel.org>; Sat, 06 Apr 2019 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LzWlk3uF4YZxeG30G1r/CDtXquaEZdEZ1op+LOgeWms=;
        b=Wt5OaIz/6nkdSVyIIWXvht7qJsuQv/5aPAMo6ank9K37IRr2BxrfUWT8rTAlGa0LuG
         3yud7tneOSzUGF30rmCcX/Kh3SnDQ9wy0xCgzNmKo4gT5FOjPWdEnMxxUzgpIiXOrilC
         yTRuU4x0pdyqEQKixOVshf873uoJLtkElW7B6IkteMe0jj/yOVqQRjpcT+u6XC0RRl7y
         pDOQwspvqSxE4qD+thdZe2ISVQn0IYkQX00siNZGGGN4Cpmx7z4WO6E8J3ZlsKhurOMd
         AZbityahrUe9AseMemEwuZuXaB65rO0OmmMY7fg+hULhS6GbwohZhGr1GbqPjn3wMIal
         29cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LzWlk3uF4YZxeG30G1r/CDtXquaEZdEZ1op+LOgeWms=;
        b=ml+Weshi6TlyfOL96U0a2a3QHNkqN1V4sZc6MFao2LPAifMMrtPKl4ezw7iG6vMuS4
         CwdCAVt1umyrXiEdcThXR6LSUln1bj1mSs3/OAJRtTRqh4KQfrEQp1OpBrUzEZnN9bp4
         8bSquMujnDzScS5HAwdjvnsS07lEfPfueR5hYeFm0NPIgSiIsJdHIXAdSMgtlBssIdtd
         2K0Cg0aMZcjiORLbylVK7HDopOc6c4jezyEpx7xXcfDOKrBgNyhRAbgne0w+2Frm4TQb
         VHJReh5L6SKazqeKM/bfPBKDEUKvCQpK/h6M2RkdoT1THaTedJ7wtLJhMClPYXN2omW1
         eEJg==
X-Gm-Message-State: APjAAAV4Tr9q9xhB8Cd7WJ6VA835/JO/d77O56Zko1ymzQNZE5LQPds8
        D5+6bzIO8u59eE8YM9vAg9KHy1v9r8Q1Ag==
X-Google-Smtp-Source: APXvYqzbk4wZ7+dWW7FDWWdaCxr2e/py5rbIzxDX/FLlVbI0wEWgHgSypA9jrNWFiMZYwPdK1FqQqQ==
X-Received: by 2002:a62:5185:: with SMTP id f127mr19723314pfb.199.1554569300185;
        Sat, 06 Apr 2019 09:48:20 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 17sm34783116pgz.52.2019.04.06.09.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 09:48:19 -0700 (PDT)
Subject: Re: [PATCH] block: remove CONFIG_LBDAF
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190405160859.5288-1-hch@lst.de>
 <CAHk-=whUmB7ine4==Z1L4csYCYaQM8-catk8ytNsnyPTs5uwZw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <93406b28-dd53-8c81-e2e0-71be65b5c6fa@kernel.dk>
Date:   Sat, 6 Apr 2019 10:48:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whUmB7ine4==Z1L4csYCYaQM8-catk8ytNsnyPTs5uwZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/19 10:30 AM, Linus Torvalds wrote:
> On Fri, Apr 5, 2019 at 6:09 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> Dropping this option removes a somewhat weird non-default config that
>> has cause various bugs or compiler warnings when actually used.
> 
> I'm ok with this, but let's queue it for 5.2, ok? Jens?

Certainly, wasn't going to queue it up for 5.1 at this point. I'll
stuff it into for-5.2/block

-- 
Jens Axboe

