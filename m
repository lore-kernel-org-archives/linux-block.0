Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7144DC433FE
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 15:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F236187D
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 15:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354688AbhJAPES (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 11:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354739AbhJAPER (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Oct 2021 11:04:17 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE2DC06177C
        for <linux-block@vger.kernel.org>; Fri,  1 Oct 2021 08:02:30 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h129so12021383iof.1
        for <linux-block@vger.kernel.org>; Fri, 01 Oct 2021 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NaTmLQHutOXSYvks1euo385cJGTEqbXqI4mBttmOtvg=;
        b=Z8PQZy2fPVLka1su7mx6sXp/mDWSSTWeuMeVVVq8o7U7s9m9/60dQoaYR5ZDmPh44S
         ejJIXTpVEdwZMH+92h/qg6nngVARrV/sGm5z1FUqkSq67I1X3dc1sOPq7r1dF52t0A2c
         4bGmUNS81U5bL4WAXoaiQjKycdoWdq2ofev+loDjKCJ8fn23X6vWNhod3K7tA5hkEuM1
         PRM4gT+oSQTdW4Lc3w5oH1swOEhtq/a6BL7d63DZ9jq+py70E6aX8otlSZoecjHVYF1Q
         xK5xtk0y/HTA2wnGxyZolvcTc0uCiq28F/G2AKXnYh+c+CClxMj5tLzsIRAUCtJzoj0d
         fjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NaTmLQHutOXSYvks1euo385cJGTEqbXqI4mBttmOtvg=;
        b=wUxDNTdNIzmPRLP0UZxrenl+HWnxdWiWExvzk94io4ymN4RY7BB0iOxXKmd9SINQNP
         BuxMPc2HmFks87a0vlfAjunHs3kC+KmoEL0IrLLKsa3EJAVnkFYSldWFp2FHEI8yimSW
         EjHnixshWavwWXKp+o1IDDp/49juyoKGvqEMnR0cHVjQmGRFp/C2mMfdb1R4pDsF7aw4
         1klaDiRV760e4+ydc07/rWaWMD7zWAEvxtA4qc8MQ2hvVqJO5Sx8YS9RKLj4TogwJrte
         hvp+lXvaLiHw04x0o7xggc1xu6QHQIm1Sa2g5RSCXxk35aACZhR3z9raTHLjzRE8+ADb
         v/Tg==
X-Gm-Message-State: AOAM5337DHANeLkCjBtikxmY8/HRR+MFtgqVbi4lY3LPzeHXELQI6b+K
        Z5KT1qC9Vnu+971BTCtB5QfN2t9fGQFVKkYKVFA=
X-Google-Smtp-Source: ABdhPJy8UlhmOPUHsoI8FAXWb/rucZsNMvv2SmhthlVHBgCgpxHOdlNOsVMRQr3U/JPu/j2M4vVOXw==
X-Received: by 2002:a6b:6302:: with SMTP id p2mr8524609iog.105.1633100549748;
        Fri, 01 Oct 2021 08:02:29 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p11sm3937686ilh.38.2021.10.01.08.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 08:02:29 -0700 (PDT)
Subject: Re: [BUG] kernel BUG at mm/slub.c - possible BFQ issue?
To:     torvic9@mailbox.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1624640454.149631.1632987871186@office.mailbox.org>
 <1889051823.161943.1633100469857@office.mailbox.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2abec603-cad9-d87e-356c-9fe49dbbb3a3@kernel.dk>
Date:   Fri, 1 Oct 2021 09:02:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1889051823.161943.1633100469857@office.mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/21 9:01 AM, torvic9@mailbox.org wrote:
>> torvic9@mailbox.org hat am 30.09.2021 09:44 geschrieben:
>>
>>  
>> Hello,
>>
>> I encounter a hard freeze on both 5.14 and 5.15 when using BFQ.
>> Unfortunately, I do not have a full error log, because the computer
>> totally freezes and slightly corrupts the display, so it's
>> impossible to read the entire message.
>>
>> However, what I could get is the following:
>>
>>   kernel BUG at mm/slub.c:379
>>   invalid opcode: 0000 [#1]
>>   RIP: 0010:__slab_free
>>   [...]
>>   Call Trace:
>>   bfq_set_next_ioprio_data
>>   [...]
>>   bfq_put_queue
>>   bfq_insert_requests
>>   [...]
>>
>> This issue appears more or less randomly and it sometimes takes a
>> little while to reproduce it (running fio helps).
>> The call trace always contains references to BFQ, but they are not
>> always the exact same. Once, I could see on the corrupted display
>> the message "general protection fault".
>> I could reproduce this issue on two computers.
>>
>> Not quite sure but I *think* the issue first appeared somewhere around
>> 5.14.5 or 5.14.6, during which time BFQ only got the following commit:
>>
>>   (88013a0c5d99) block, bfq: honor already-setup queue merges
> 
> I have now reverted the above commit and launched some heavy I/O like
> e.g. git kernel, fio, xz compression, and so far, no freezes anymore!
> Too early to say that this commit really is the cause though.
> Would be great if someone could have a look at it.

It's known buggy, and a revert has been queued up since earlier this
week. It'll go to Linus for 5.15-rc4, and will hit 5.14 stable shortly
thereafter.

-- 
Jens Axboe

