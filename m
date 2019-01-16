Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948D5C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63144205C9
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wHYQXziJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfAPPZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:25:26 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55663 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390553AbfAPPZ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 10:25:26 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so3510255ith.5
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 07:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D0E22Hby5Pao2cSGvZHIa8ii3artikW4blfeIIldMd0=;
        b=wHYQXziJUiAppRoIEXCWKPL7IlXBnex+9yVagODZ04l3qT8fRO/9BiwFa4sGCAH39G
         4jJCc9chKodwfVxMRDFgzdshnpcP4HDmRZBPDzg15S84U2KfH5sIVNDxmwLXHDENlH25
         dPd6BxDgDoguueyFDbWNzTkCCKZ/zOvbCagRXv3o691w1OUQG42SUUkhU5pUvBgqiZqQ
         yFhi6UG+9IzkSLN5o/ZTjC866PaaXHfrJ99MeZQT6fjNJa7czJm6PC7RbuVBdlJwQQAm
         lSjIHf3+UxStQWg2ySizCiILXtkVuME1Kb8B2VrC3ehkdKvPrs+ardjqbQyZW/HRgXqT
         JpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D0E22Hby5Pao2cSGvZHIa8ii3artikW4blfeIIldMd0=;
        b=VAMBJO11xNobhy/hXXXbHnoPLXjkEX1PzEWr/DWiLz3yn5q9rLIJygIwxWmuCyN17S
         P1zRCzc8KlhMOHwkMlPDFoOiaUW2hYqrtGElDL9ZFtlknBz8ZTiQu60vQ9AwYwCLpynu
         Yc9WusKTrPGDM21SbmZBj3HKjYYDXS1aH/3y09sDhoSKjGyUBKbUr8zNj5/XCfd8gElx
         AyQmHzFad65t6w23IoIOwgp/Uhv+xIsZsl7SYyrAY88KFFJ02uOHy7W8p+YiswJmnEFy
         qtmsRICz1Kk4BrhmPRu3OxjoAJrVLpAdjQ7vkKpqkVytFQC389faM1Bc2XLE+ilm/8DE
         CbQQ==
X-Gm-Message-State: AJcUukexYnSahgMGzbClcM5sG7ICEkhR1fs74VJ5L/Oddv9szL+WrnoF
        3GLs1me8dXRtHVq2M1KCj506rg==
X-Google-Smtp-Source: ALg8bN4S08UUWqbIrMre1jsuHPOP5jNs8ak9lpP/eDaOnHnI10UDLs/RR0y5MsIL8pV6zwa/X63ZzA==
X-Received: by 2002:a24:89:: with SMTP id 131mr5479335ita.105.1547652324969;
        Wed, 16 Jan 2019 07:25:24 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r16sm2561959ioa.16.2019.01.16.07.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 07:25:23 -0800 (PST)
Subject: Re: [PATCH 05/16] Add io_uring IO interface
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Avi Kivity <avi@scylladb.com>
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-6-axboe@kernel.dk>
 <CAK8P3a19ie7wcndDW7oxmUGh5c9aaarJycKBVOQ2F9+eHj=nsg@mail.gmail.com>
 <15b06ccb-4501-f104-9a3a-f028218a0d70@kernel.dk>
 <CAK8P3a2MuO-wRjYxscP-AOAUjwg6fHRc99Am6xqUmXYrJRt44w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6713aff7-115b-bb94-fb8c-b4fac86247f1@kernel.dk>
Date:   Wed, 16 Jan 2019 08:25:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2MuO-wRjYxscP-AOAUjwg6fHRc99Am6xqUmXYrJRt44w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 8:16 AM, Arnd Bergmann wrote:
> On Wed, Jan 16, 2019 at 4:12 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/16/19 3:41 AM, Arnd Bergmann wrote:
>>> On Tue, Jan 15, 2019 at 3:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
>>>> index 3cf7b533b3d1..194e79c0032e 100644
>>>> --- a/arch/x86/entry/syscalls/syscall_32.tbl
>>>> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
>>>> +SYSCALL_DEFINE2(io_uring_setup, u32, entries,
>>>> +               struct io_uring_params __user *, params)
>>>> +{
>>>> +       return io_uring_setup(entries, params, false);
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_COMPAT
>>>> +COMPAT_SYSCALL_DEFINE2(io_uring_setup, u32, entries,
>>>> +                      struct io_uring_params __user *, params)
>>>> +{
>>>> +       return io_uring_setup(entries, params, true);
>>>> +}
>>>> +#endif
>>>
>>> The compat syscall has the same calling conventions as the
>>> native one here, so I think you can just use that directly.
>>
>> Not sure I understand what you mean here. I need to know if it's the
>> compat one, hence 'true' vs 'false', so I know what the size of the user
>> pointers/structs are.
> 
> My mistake, I missed the true/false difference between the two
> functions.
> 
>>>> +/*
>>>> + * IO submission data structure (Submission Queue Entry)
>>>> + */
>>>> +struct io_uring_sqe {
>>>> +       __u8    opcode;         /* type of operation for this sqe */
>>>> +       __u8    flags;          /* as of now unused */
>>>> +       __u16   ioprio;         /* ioprio for the request */
>>>> +       __s32   fd;             /* file descriptor to do IO on */
>>>> +       __u64   off;            /* offset into file */
>>>> +       union {
>>>> +               void    *addr;  /* buffer or iovecs */
>>>> +               __u64   __pad;
>>>> +       };
>>>
>>> It seems a bit unfortunate to keep the pointer field only
>>> almost compatible between 32-bit and 64-bit big-endian
>>> architectures, as that requires an in_compat_syscall()
>>> check whenever we access the pointer from the kernel.
>>>
>>> Could you use a __u64 field to store the pointer itself
>>> instead?
>>
>> I feel like I'm missing something here, we'll still need the compat code
>> on the kernel side for 32-bit app on 64-bit kernel, so what would we
>> solve by making this an __u64?
> 
> It means you don't have to define a compat_io_uring_sqe
> structure with a compat_uptr_t member in it.

Yeah, I finally got it, I'm making the change. Thanks!

-- 
Jens Axboe

