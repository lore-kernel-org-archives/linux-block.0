Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C31DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 18:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16B260EE2
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 18:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhJTSnY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhJTSnY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 14:43:24 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88849C061749
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 11:41:09 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id k3so23176023ilu.2
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 11:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kqXL5R7sv6GYdsVFxksvVBBrM2KPUAHjGfiCvmclQcE=;
        b=fiH18+XkwwgArVJp4aYy0F2No3UL7CfV5NR5SpH9UJEWq7EKuYa6Y67OlMO8NTc1Ju
         F/sFO6LCg9y4hvI1LMfuqmgHkrljnNSWa4SjsOlr2AYhIsN72/u/uAjIXp8d8e+X8LE0
         gQ/xRRTQ6cwAShJxxw7mO/aGGg79g1DYgN51q16MVWKMr2d2/1wEv0cRUBDzDuyHxfUg
         Toja+cxEOSf3D0amFMziG2zYRklueZXbepSIXeNsxFuWALTp04RChC80iNwgnj/TUnBm
         kjobmNR7RD1CQrQXSFoxFlzgQ8rpJsE61an9WL77eNb8vNo490TlU6Vki2i5yo0XpYkz
         O2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kqXL5R7sv6GYdsVFxksvVBBrM2KPUAHjGfiCvmclQcE=;
        b=AkQbLDNHnAlUHgiHJ5FffqNitIG0mjRQ2pZD2tevD71cpzmWzzXGaXTYNEwlVmjlqi
         bpov7E+VwmTiqo4UhctiY9kwsAls1Fq7C5BFbMXX4oOmhhVFiAPqNGGOPeBzLoOgiiz8
         8aQYQmj59Mjdt2QsgqdfkjFaYUZusrHtIpJYSUUypGXLtW3B9NEgCoui5IshcLzArw78
         Hi9w071eW9p7q4tczLidjNvpnphIhZvWGz/JnuszhzN4JaM9L7+nzNeVdEDSP0zbQVI1
         4k/Mi1Av11et33PiaAVYcnG3+L7uekGLP8G03hQJfBU7YwBlZ4eYfjGGBRFZDlECrz/i
         hzUA==
X-Gm-Message-State: AOAM531SK3g4woOuNmoWyhH37UiML5pjybbPjJ3oCqyT1d8dJvBUkiVH
        Rei2lVTXReLzHhBHmLrWJSlw1A==
X-Google-Smtp-Source: ABdhPJzqwcI28JSC/TQV96dSEONSfyi8Gsw3dd5Ae+55ztxzqLcrx8uqaGh5erYkMYoXSZqfl/qHqw==
X-Received: by 2002:a92:d03:: with SMTP id 3mr511176iln.163.1634755268850;
        Wed, 20 Oct 2021 11:41:08 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j15sm1611558ile.65.2021.10.20.11.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 11:41:08 -0700 (PDT)
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
 <x498ryno93g.fsf@segfault.boston.devel.redhat.com>
 <16a7a029-0d23-6a14-9ae9-79ab8a9adb34@kernel.dk>
 <x494k9bo84w.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <80244d5b-692c-35ac-e468-2581ff869395@kernel.dk>
Date:   Wed, 20 Oct 2021 12:41:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <x494k9bo84w.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 12:37 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 10/20/21 12:16 PM, Jeff Moyer wrote:
>>> Hi, Jens,
>>>
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> It's not used for anything, and we're wasting time passing in zeroes
>>>> where we could just ignore it instead. Update all ki_complete users in
>>>> the kernel to drop that last argument.
>>>
>>> What does "wasting time passing in zeroes" mean?
>>
>> That everybody but the funky usb gadget code passes in zero, hence it's
>> a waste of time to pass it in as an argument.
> 
> OK.  Just making sure you hadn't found some performance gain from this.
> :)

Oh there certainly is, not uncommon to see an extra register cleared and
used just for passing in this 0.

>>> We can't know whether some userspace implementation relies on this
>>> behavior, so I don't think you can change it.
>>
>> Well, I think we should find out, particularly as it's the sole user of
>> that extra argument.
> 
> How can we find out?  Anyone can write userspace usb gadget code.  Some
> of those users may be proprietary.  Is that likely?  I don't know.  I'd
> rather err on the side of not (potentially) breaking existing
> applications, though.

Yeah I don't want to risk that either. And since I can see this turning
into a discussion on what potentially would be using it, seems like the
path of less resistance...

Working on just changing it to a 64-bit type instead, then we can pass
in both at once with res2 being the upper 32 bits. That'll keep the same
API on the aio side.

-- 
Jens Axboe

