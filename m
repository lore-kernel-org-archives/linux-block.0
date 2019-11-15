Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F83C432C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 18:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC61820732
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 18:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aJTF8vWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKOSir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:38:47 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41640 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSir (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 13:38:47 -0500
Received: by mail-il1-f193.google.com with SMTP id q15so9999971ils.8
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 10:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pOxtdnBlf400UFejhsn5PA0wzxRAH7tUC0YEWQoz7Sk=;
        b=aJTF8vWcLLieo99J4Vf7oxXJQZ3TVsoxbYA4wnDuGUZQGQ7Cpf7civp39orFKnXIMd
         HJqCdt3nD//124kt9MpeYzup3tPzk3o0ztCdXB/ugbXU3iTV1k6p3ZfIIQEQTOSnUkQp
         SKIH6Os/MuvXajhyUYJSplCgkG6gE4s1/8zt6nBVZSBY+LyMM9OE22mzw0/NMfOrNBjo
         n0GYzmc9tgwupv7oAaV+YKWs4TVUc5jxEFIXFKrR7ClEhVHaBbTGpHyWONoOtziGeZBJ
         u1IxIs84KlIRHjVURleIZ674Rgk/Tb7t7C+6fxVHQgBDihj6suKs3qLyUSpUd0hmTVO6
         9xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOxtdnBlf400UFejhsn5PA0wzxRAH7tUC0YEWQoz7Sk=;
        b=gz9fQuJ4x/ZIDsKzOcj3+o95TM1+l2ueKcjg6gcbrQMsX8z2OSSrj249osqJSDDgqX
         wzS9OjtMB8kLSqHT78J6IUL3kgKYw/MK7mD85LvDTIAoVfmvQGfKLPegcQBnf4OpTvmS
         f7paAd2X8Tdm6Z9wTlN9/N7YF55j4adI8mVOPN8+buzXyi9eIAVdR6SpyVXojtFdVJjr
         9lte2VgphzmT3+yBhkmsSo8l+4FtQ2Cyv+cRNUA+yaSxaH6gYGVsUqBz2tWN+ibCF51J
         WUTbXEnGuk465Fpr1E2gAkjs2fd8qqaUlxtpW0pIYkpX7aJtTxUKHhEd6zZ48/AS00T4
         c6Pg==
X-Gm-Message-State: APjAAAWqSpq0LDvR0jaJpD4NwNKIjYVBkZ9ixge9FRVB9cBlY99iSv5r
        sPRFxiqGrImK41RukxDv4xAMEQ==
X-Google-Smtp-Source: APXvYqx7k/MmhaqpIpT/xu70QNAHn7f+w7xOvU2Gu5r6YGANAiB7uVQqRgXGq3z5v4l18Rn2+Ontbg==
X-Received: by 2002:a92:d390:: with SMTP id o16mr2353175ilo.110.1573843126130;
        Fri, 15 Nov 2019 10:38:46 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x18sm1318752iob.70.2019.11.15.10.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 10:38:45 -0800 (PST)
Subject: Re: [PATCH BUGFIX V2 1/1] block, bfq: deschedule empty bfq_queues not
 referred by any process
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        tschubert@bafh.org, patdung100@gmail.com, cevich@redhat.com
References: <20191114093311.47877-1-paolo.valente@linaro.org>
 <20191114093311.47877-2-paolo.valente@linaro.org>
 <89dde326-fc76-10cc-5ec9-ec5fd4dae4ac@applied-asynchrony.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <79c4f395-4396-a874-d788-ef9ab0381b0d@kernel.dk>
Date:   Fri, 15 Nov 2019 11:38:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <89dde326-fc76-10cc-5ec9-ec5fd4dae4ac@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/19 11:32 AM, Holger Hoffstätte wrote:
> On 11/14/19 10:33 AM, Paolo Valente wrote:
>> Since commit 3726112ec731 ("block, bfq: re-schedule empty queues if
>> they deserve I/O plugging"), to prevent the service guarantees of a
>> bfq_queue from being violated, the bfq_queue may be left busy, i.e.,
>> scheduled for service, even if empty (see comments in
>> __bfq_bfqq_expire() for details). But, if no process will send
>> requests to the bfq_queue any longer, then there is no point in
>> keeping the bfq_queue scheduled for service.
>>
>> In addition, keeping the bfq_queue scheduled for service, but with no
>> process reference any longer, may cause the bfq_queue to be freed when
>> descheduled from service. But this is assumed to never happen, and
>> causes a UAF if it happens. This, in turn, caused crashes [1, 2].
>>
>> This commit fixes this issue by descheduling an empty bfq_queue when
>> it remains with not process reference.
>>
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1767539
>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=205447
>>
>> Fixes: 3726112ec731 ("block, bfq: re-schedule empty queues if they deserve I/O plugging")
>> Reported-by: Chris Evich <cevich@redhat.com>
>> Reported-by: Patrick Dung <patdung100@gmail.com>
>> Reported-by: Thorsten Schubert <tschubert@bafh.org>
>> Tested-by: Thorsten Schubert <tschubert@bafh.org>
>> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> 
> Jens,
> 
> can you please also tag this for stable-5.3 before the next push?
> The original problem was found on 5.3 after all, and hoping for the
> stable-bot to pick it up automagically is a bit unreliable.

Too late for that, but we can point stable@ at it once it's merged.

-- 
Jens Axboe

