Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015B0C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 04:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0C7207E0
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 04:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PDHtxE7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCIEjd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:39:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46457 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfCIEjd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 23:39:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id a22so3103459pgg.13
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 20:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hNe6OZwlHFbTc40GD4btDGum6yn5/NxhusXrJipaaIk=;
        b=PDHtxE7WRKyy4rqcXIGrB8IKItK1OERdxSLdvswPmS/mrvIRkcA4gNfOVv3YR9oL0U
         R1BqWvCNga3LJS6ziLgKx1gQ+iCNTnOaa8KcN45XlSYsnO0jOmgYSxwzWiKfChnc5hMf
         +QLpFQ/pqY9ZsVETGZmq/yerNEbV9xgO7pVXlNu89VimGX9NJK1aimY97OL7L25j4ARf
         +Uop6SBd9LzGmcROZsNHVadbeNYnh6w9S2kyYORCmmxpkj3M/rEX60N3KHJEUvR9SIE/
         GeAvb98afxozICXSC6N4xGPWZ/g16IegfMNeVluhtXRLJoBNq0nbU5PY+C+qoxFI6Ir4
         ZVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hNe6OZwlHFbTc40GD4btDGum6yn5/NxhusXrJipaaIk=;
        b=B0l03aSEobNJwXI6ZCdviQYV5Bnti+b5FT6bfAC+VtkJJKCCob60lc2DAfpgbRapMe
         3FQTNf18S14K4KekhqJF3f95kxw67Zb2E0b8H4m8x8tv0Lp3R/KejqEkRL+1bvAIwWBM
         rynaPhxu8H3OYbFqYhTEj5hI1If2vG/CL/URFx880jmR9caGLF1BmgVM6H0M92fWk+v4
         4ICe6zmuQG1yCe5sr3L8Sjf2if4M0fE5AtCdCKTqOFRg9sS29r2v9A79Tidqiu3iWqeV
         ROB/eia1D/nGsgZ7TYYgN8xyeTKQ54VkwZAc3EbynHmNqJ1cq+R7ewa425aptldMqO1O
         y8ag==
X-Gm-Message-State: APjAAAUuuBTQpxTvCUMMkDWEcbiDo57ajr1qjWOZz50E5/nSNXn7wyPw
        aSng62xsnb/t8HmNRegg5r2/sg==
X-Google-Smtp-Source: APXvYqzVlKt3PyOXaOocnIB9ZxepU0TR73FLPAdqgm5WvMaXu2cY6SZOi5loG7si/uJ5VIfLnalEVA==
X-Received: by 2002:a65:5281:: with SMTP id y1mr20438260pgp.59.1552106372339;
        Fri, 08 Mar 2019 20:39:32 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q13sm11223420pgh.24.2019.03.08.20.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:39:31 -0800 (PST)
Subject: Re: [GIT PULL] Support for the io_uring IO interface
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
References: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
 <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk>
 <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
 <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com>
 <CAHk-=whu3uojbKwdtaq8vwGfsvSpVUPfhvJPv+LMR=6kNT0XgA@mail.gmail.com>
 <CAHk-=wh36F+2iXMz1dxGxVebfFYtqypGXRchqttJuJ_=A9ctZw@mail.gmail.com>
 <6cc0763f-8a48-c61a-b831-4326345aa68c@kernel.dk>
 <CAHk-=wjF5Pbuo-cOUzCESA4mrrQXA26OsYDvnXr3+W8ve9a=MA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ac1db664-b02e-3cae-28b8-4ce1d216e6c9@kernel.dk>
Date:   Fri, 8 Mar 2019 21:39:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjF5Pbuo-cOUzCESA4mrrQXA26OsYDvnXr3+W8ve9a=MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/19 9:33 PM, Linus Torvalds wrote:
> On Fri, Mar 8, 2019 at 8:25 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>              I'll take a look
>> at the patches that went into aio and apply the same fix(es) to
>> io_uring.
> 
> Note that they are not upstream yet, there's a work-in-progress branch
> in Al's tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.aio
> 
> so you can see what the fixes are, but they are not in their final form yet.

That explains it, was looking at mainline and saw just the fget/fput
related parts so far.

If all else fails, it's also trivial to yank the poll command support for
now, which would kill the io_req refs. But I'll look at Al's pending
fixes first, thanks.

-- 
Jens Axboe

