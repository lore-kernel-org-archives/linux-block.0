Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFC0C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C182610CF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhJTTOT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhJTTOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 15:14:19 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4962C061749
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:12:04 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h2so2609598ili.11
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jNoymx0zh+2RWN7VF6IEjDOmMNqfOUo664s7H3sWF1A=;
        b=r3UTTcCcotFvKvWtJeEtb7gxBQ9W2Lsy2y0O4AN6fbwXlUSYzucWt6SkXj+D93tXzd
         33IrlgrIHXZDj17yxKGz2OoRQDJhGxR6F0p+3y65ZyuCseJMk80cdF7dil5NRsRvxQeY
         8UIQXvF/FErSRWIwGNIjRVsoXGCNwHfhezSL/u5/KFSR4wLsyp8w2RSOs5bx7EALh3JR
         qKV6ZB6KdjMJtoPpj7Sxi7M4mLKp/pz3KegjRorZhVAbrhBYtPwpaqpZIMxsJ9T827c/
         Ce7TaunQI0Wka/BemiWk/RmjEVK/fqOBn2ZT0iVJGptMPlQnKCmihG0CCk5IPQdq6dmu
         WHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jNoymx0zh+2RWN7VF6IEjDOmMNqfOUo664s7H3sWF1A=;
        b=nv4ChZ6nz6duoHxoaxK21BfpSRlVOfLmdGLCUX3FhiDLRB62m5F/8jI75Q6vRCbeI3
         zwCUMxHukKQy+7+bHCq6xIpRYeOSz9svwnYhXC+Iu1UXXKbC8uNyQLF0XgvZUZk/lcsv
         abyYNfuQw2lDSeKTbWIt5sOD9B3HNwbtbBk9HCmZCyDptVnl9I24vWxPpmZJbesHyYRF
         rJOyaUMpPpuqgwt2TAL6OodAUqgxXETrEOnzC0kX0lXl+qZe3Aja0em5Ab26FN59CI5p
         Hq1+gUkpqDG8zfWJQBNfOpm4z6HwiH6mMiL08C3i0avbUDEMrtx2Qr/csgOapRhm5niR
         kamQ==
X-Gm-Message-State: AOAM532Kq7SwVaNPI7HG2GodtVqWIs+2e/pFvKFd2DB+TTtPECYkFRPI
        apZPHbs5L9JXtFV39I0OhfouKg==
X-Google-Smtp-Source: ABdhPJy4dwVqTWsrgaoT0wCVDKHDOzPujeFMUwVFP6Hl7nxZz30QgvfeA4C2AgWxbuKCRQq2wkYeTg==
X-Received: by 2002:a05:6e02:1402:: with SMTP id n2mr627747ilo.208.1634757124032;
        Wed, 20 Oct 2021 12:12:04 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o1sm1470221ilj.41.2021.10.20.12.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 12:12:03 -0700 (PDT)
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
 <x498ryno93g.fsf@segfault.boston.devel.redhat.com>
 <16a7a029-0d23-6a14-9ae9-79ab8a9adb34@kernel.dk>
 <x494k9bo84w.fsf@segfault.boston.devel.redhat.com>
 <80244d5b-692c-35ac-e468-2581ff869395@kernel.dk>
 <8f5fdbbf-dc66-fabe-db3b-01b2085083b0@kernel.dk>
 <x49zgr3mrzs.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a60158d1-6ee0-6229-dc62-19ec40674585@kernel.dk>
Date:   Wed, 20 Oct 2021 13:12:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <x49zgr3mrzs.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 1:11 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 10/20/21 12:41 PM, Jens Axboe wrote:
>>> Working on just changing it to a 64-bit type instead, then we can pass
>>> in both at once with res2 being the upper 32 bits. That'll keep the same
>>> API on the aio side.
>>
>> Here's that as an incremental. Since we can only be passing in 32-bits
>> anyway across 32/64-bit, we can just make it an explicit 64-bit instead.
>> This generates the same code on 64-bit for calling ->ki_complete, and we
>> can trivially ignore the usb gadget issue as we now can pass in both
>> values (and fill them in on the aio side).
> 
> Yeah, I think that should work.

Passed test and allmodconfig sanity check, sent out as v2 :)

-- 
Jens Axboe

