Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10FFC433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 02:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiCVCRj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 22:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiCVCRa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 22:17:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD83C22B35
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 19:15:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so1118595pjb.4
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 19:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b53O8gUQRw1wuYMU9Nq+V2zuBp+ZrENNjLnvyUfGobs=;
        b=xRrswrMTjS8yGW2ye96A8H0yNALnZujXKzTo2WKFzvxqh26G56Xg1N6r4uRlZRqUMW
         zTxHLK+TmwCZy5sViubqJyEyjKKlbcTM4DIetqoca1eK4JRfp+7xWAogZdMpj6560EOw
         Affvw9yoFpml0Tye0uKNkpsyOpgzZfHf6gsRH6i+zN/+B8ZdRCwESXJl4LH1aIk+mcwx
         fZattT3fRYgl2x13h7sYA7bth7gfbl+bdcKIVP+vHyCaD3WpK9yqG6coCyNsAZrTvyG5
         R0mhefjd1G+dakjVYFSd6IgZoBjn8DXbZk6BWLqhp/gtFIxwKv9itDdJr8zqvhnJlRT4
         qzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b53O8gUQRw1wuYMU9Nq+V2zuBp+ZrENNjLnvyUfGobs=;
        b=iZIiAL24tgE0VIV37NNvR0PYBWsAS/T63itbqm61BfbatCJ7R32gl6R6UzF1pWAmeu
         VqAIwhtLGg0nV8nIRy1p81hdY8lDsRdpR5i+KjMTu4bpyKlSecHG/6kTfgTl8el832+c
         7OZyVFwT729HjKfVPYFz9/YBfD1EBbRBHDfxwkGLamFLI+QxoR09np/T8O4x+toS9gf+
         JWoNujXw5276WEKcD1mvBRAU2vquSBslIF1i9JrXBnP7eqEEQ9ORZSCo+JkkqkV8zy9Y
         0gXBhA3g9nAwNe0mtxWIcbtyZhGkRPwp1ZhikaugWFQt17PwflNxRH+pFAoy4/0tYhfC
         v2Dg==
X-Gm-Message-State: AOAM530jPRz9amTeeGNGDqUnAb4mU7OrI5iWlmqqtF3UMN7GAuOVT22g
        eLPsnNXbGI17zPRUJlIxZLyUoMWIFnc8s8fp
X-Google-Smtp-Source: ABdhPJyDvyWzYyfSJ5JsOmL24PQ2DITLQrNvgsOHu8GPfVjCf46vGDVmC7Ez9siYf5e8iCMMik0Bjw==
X-Received: by 2002:a17:90a:3842:b0:1c6:d666:b01 with SMTP id l2-20020a17090a384200b001c6d6660b01mr2264197pjf.161.1647915300291;
        Mon, 21 Mar 2022 19:15:00 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ot17-20020a17090b3b5100b001c746bfba10sm711841pjb.35.2022.03.21.19.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 19:14:59 -0700 (PDT)
Message-ID: <799b2135-ddb3-225e-761f-a03c82e7c12e@kernel.dk>
Date:   Mon, 21 Mar 2022 20:14:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GIT PULL] Block driver updates for 5.18-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <83ce22b4-bae1-9c97-1ad5-10835d6c5424@kernel.dk>
 <CAHk-=wiXy_WR5=z+tWFY8NiuXtwfnOC5cOZeFN41MjBGcG4tsg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiXy_WR5=z+tWFY8NiuXtwfnOC5cOZeFN41MjBGcG4tsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/22 6:13 PM, Linus Torvalds wrote:
> On Fri, Mar 18, 2022 at 2:59 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> This will throw a merge conflict in drivers/nvme/target/configfs.c,
>> resolution is just to delete the two discovery helpers and the configfs
>> attribute, basically everything in the conflict section. This is due to
>> conflicting with a last minute revert in 5.17.
> 
> Only because I looked at this conflict did I notice that some of the
> changes are kind of pointless..
> 
> I mean, this is well-meaning, but I'm really not convinced it's
> actually *useful*:
> 
>   -   return sprintf(page, "\n");
>   +   return snprintf(page, PAGE_SIZE, "\n");
> 
> It's not like a two-byte copy can ever overflow PAGE_SIZE.
> 
> Sometimes 'sprintf() -> snprintf()' conversions don't really buy you
> anything.

Yeah agree, that does seem kind of pointless as an isolated change. At
least maybe it helps cut down on copy/paste related issues, where
someone copies it and changes it to dump more into 'page'.

-- 
Jens Axboe

