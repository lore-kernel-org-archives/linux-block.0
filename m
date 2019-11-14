Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1952C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 15:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857902070E
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 15:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KW8h3Za2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfKNPT3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:19:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39098 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfKNPT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 10:19:29 -0500
Received: by mail-io1-f67.google.com with SMTP id k1so7192541ioj.6
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 07:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tDdQmYavPXfwAMVihcceAngcVZVudc5stPylZ/TzqA4=;
        b=KW8h3Za2bC42GqVYn+81yUge003EoXRT6bhf3lE2zZrul4V+Gkvzwr017Ci3NlD1CT
         iCxfP5AZIwtMZ2dyTQwlJhi2TMfa9d9FQMfXg+3JCOXBbQKWSX3NoKh6yQxVi+LQyqQU
         T2N39MKmqmYxrPGzwUHe2g1dS+xzYRd6HI3TZpRz93G9TLB+dZMcdZNJ48JgOGhCDVMd
         8sJc/8StxjsboVRGCFYQgTnqg9KrhjhZaqBUXYC5LnCkAncavzLwdq1z/1OxE0YkmFb3
         cdFL1kIaLDqTkiDk9aShO5sZHdEGjwb9lm3oXOxpefxZw+uxHKRopTRM9TpIVNXVibuV
         DdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tDdQmYavPXfwAMVihcceAngcVZVudc5stPylZ/TzqA4=;
        b=YCGLE7HFSmAhcrAiTMH+j6uTW/LSCQajYTilCtyQWOqYEkmwQgg8ePrPCAE/j4KO8w
         jrxFCibnX6+R5BbpB4boWUhT6Xkw21bAR6cQY2IBgE0+9ure7iA3mXSqeH7SA4beAvHo
         9O9jWq9uGydmQGgksbEGk41YX/C8cE+IiOleQtPsnm/Ocs5xrzM141DOu5hM5EoR6X6i
         Z7WptaNG8u5up624HuwC4UJL05tnb9J0tz/ydu35pOUtmSJnvFMYxedNgxWC4Kuk8PnW
         R8IvIXMijpe5X0w01fRSazVdzLh0APeLTIWr+18uXE1tzobiIQusjcGijQJyPJrqDv39
         Tlgw==
X-Gm-Message-State: APjAAAWY+vXl/oi4bYyGcUpJfq9Dm9tsN4YvMXZbeu/BSXtLR9ZC07B6
        OvJzlDQQsA1vIFwuaX0XOLM3AA==
X-Google-Smtp-Source: APXvYqwOocapzh/vXy7B7ZyJ8zCjfx/xWNzIdTKhoK/SsGvYxKriRPokthX4D8cafUhLCmR42mesbQ==
X-Received: by 2002:a6b:7f43:: with SMTP id m3mr9135039ioq.72.1573744768914;
        Thu, 14 Nov 2019 07:19:28 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k4sm531229iof.61.2019.11.14.07.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 07:19:28 -0800 (PST)
Subject: Re: [PATCH BUGFIX V2 0/1] block, bfq: deschedule empty bfq_queues not
 referred by any process
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        tschubert@bafh.org, patdung100@gmail.com, cevich@redhat.com
References: <20191114093311.47877-1-paolo.valente@linaro.org>
 <0cb0a853-e036-9884-5681-f4617de5c662@kernel.dk>
 <A2E68F00-EFEA-428E-A6C1-267E57450FF6@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cc6d7197-2021-f86a-440a-c1d9c11ce191@kernel.dk>
Date:   Thu, 14 Nov 2019 08:19:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <A2E68F00-EFEA-428E-A6C1-267E57450FF6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/19 8:14 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 14 nov 2019, alle ore 15:02, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 11/14/19 2:33 AM, Paolo Valente wrote:
>>> Hi Jens,
>>> change from V1: added check to correctly work only on bfq-queues
>>> scheduled for service, and not on in-service bfq-queues (it makes no
>>> sense, and it creates inconsistencies, to deschedule an in-service
>>> bfq-queue).
>>>
>>> Differently from V1, which was still under test when I submitted it,
>>> this version has already been tested, by those who reported V1's
>>> failures.
>>
>> I'm a bit miffed that you'd send out a patch for an issue, this late
>> in the cycle, and then it not being tested at all. That's not very
>> confidence inspiring. I have applied this one, just letting you know
>> that that is not acceptable at all.
>>
> 
> I'm sorry for irritating you.  Yet I don't fully get your point.  I
> have sent this fix now, simply because this bug was found ten days
> ago, and I've tried to fix it as soon as possible.  I did test my
> patch before sending it.  As for public testing, how could Oleksandr
> or any other user/dev have had a chance to test this patch if I had
> not submitted it here?

If that's the case, then make it clear that you don't expect it to
be merged right now. As it stands, when you sent it out, all I know is
that it's an issue that's crashing current kernels, and we're winding
down this release. Hence there's a sense of urgency there, as we
could be releasing this kernel as soon as this weekend.

If you have a potential fix, but it isn't tested yet, then make that
clear by submitting it as an RFC. You'd say something like:

"This is a potential fix for X/Y/Z, let's wait for the original reporters
to verify this before including it."

And make that clear with RFC in the subject line. Your patch had none
of that, in fact it said:

[PATCH BUGFIX]

and the commit message had no references to this needing any further
testing.

-- 
Jens Axboe

