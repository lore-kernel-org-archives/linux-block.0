Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789FFC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5DD20675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jzFocxFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393927AbfAPPMe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:12:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40707 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393926AbfAPPMe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 10:12:34 -0500
Received: by mail-io1-f67.google.com with SMTP id k2so5129719iog.7
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C2g6hRlFV5N1ETDLq54Ts1QT+I3VAwwR+9xjO7R8OxU=;
        b=jzFocxFH0Di3TZi24klW8IJC6ZdXccCDD4enzb8pFec3nU59q24QlXxD30233UXFNn
         4WCeVTBwfWWt6q/pPMk2L89Z+kzUEqRFPEAggEvkhRVZMnGu7enUjw4f6aTBR8kOzx40
         cV584oXGTS9UBx2JjcpQlcQ4S10i1ekq3jthVvU8tZDBR2g6+tHzul1GurdxV9/5TucA
         1PiozuOHEc21WwWS5ddDBp2+Tkp60xVRnmMiMZwLZjmFSf4ZDzJYP9ShxgB60H7nXMmS
         TxXwIc6y7GXizk9/KHyBmo9GorfApgeTDspRym6URtor0UpxQT4bOxkMU7EYdTe0q3ts
         lsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C2g6hRlFV5N1ETDLq54Ts1QT+I3VAwwR+9xjO7R8OxU=;
        b=Y9dCPGTI9T5zMNFPSx7Ez4oR4tzWwyQ1zqBdSIigThvibec7hLkiUg9D8SyI0soH2Y
         N2ePtr/kddYqn18Mnf2Yc3NjV0GEvAKHY/XdGBBs2s5xc5sdr7s/r67SKTysASpu1HS/
         a5G6XFTssMcDvOCrT/kerlf6vsxg/XTC4crYY+vukRX5nYgIKhs2Rt0jr2CFxMG5ttoe
         W7f3Ts+KpMUbE63L2gO6HUnhagsY0onMNj3rBVfdRvTYk5mOegY0GgUxk3srpSGwFPhs
         adY0P2Wz3J6y4FwWLM9jpNCqFtu5+WfewzYRwC2kr+MWj8vqGvSvwq0NuB2/QKYMOIJX
         znqg==
X-Gm-Message-State: AJcUukcc+J1fD4aCuHVfFvefQT8sJCQhzmhg5ouXzBWjk4kEI2pwkRdE
        7CPYZSYrYc8fnMcSTUPHC+n3Uw==
X-Google-Smtp-Source: ALg8bN474LxgaXplqZZlS/AqWvPtxp4PaHHF4QhrjlbTxC1ZMxpXdW9JB33inXa+HceFdi/Uh+m2Ig==
X-Received: by 2002:a6b:7716:: with SMTP id n22mr5093009iom.88.1547651553149;
        Wed, 16 Jan 2019 07:12:33 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 18sm3529585itk.28.2019.01.16.07.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 07:12:30 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <15b06ccb-4501-f104-9a3a-f028218a0d70@kernel.dk>
Date:   Wed, 16 Jan 2019 08:12:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a19ie7wcndDW7oxmUGh5c9aaarJycKBVOQ2F9+eHj=nsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 3:41 AM, Arnd Bergmann wrote:
> On Tue, Jan 15, 2019 at 3:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
>> index 3cf7b533b3d1..194e79c0032e 100644
>> --- a/arch/x86/entry/syscalls/syscall_32.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
>> @@ -398,3 +398,5 @@
>>  384    i386    arch_prctl              sys_arch_prctl                  __ia32_compat_sys_arch_prctl
>>  385    i386    io_pgetevents           sys_io_pgetevents               __ia32_compat_sys_io_pgetevents
>>  386    i386    rseq                    sys_rseq                        __ia32_sys_rseq
>> +387    i386    io_uring_setup          sys_io_uring_setup              __ia32_compat_sys_io_uring_setup
>> +388    i386    io_uring_enter          sys_io_uring_enter              __ia32_sys_io_uring_enter
>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>> index f0b1709a5ffb..453ff7a79002 100644
>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>> @@ -343,6 +343,8 @@
>>  332    common  statx                   __x64_sys_statx
>>  333    common  io_pgetevents           __x64_sys_io_pgetevents
>>  334    common  rseq                    __x64_sys_rseq
>> +335    common  io_uring_setup          __x64_sys_io_uring_setup
>> +336    common  io_uring_enter          __x64_sys_io_uring_enter
> 
> In my series for the y2038 system calls, I'm trying to move to having the
> same numbers across all architectures. Unfortunately, that clashes
> with newly assigned numbers here, so one of us needs to pick new
> numbers.
> 
> If my series gets merged without other changes to the numbers, the next
> available numbers on all architectures become 424 and 425.
> 
> Could you use those here?

Yeah that's totally fine, I don't really care what the numbers end up
being, that side isn't fixed for me.

>> +SYSCALL_DEFINE2(io_uring_setup, u32, entries,
>> +               struct io_uring_params __user *, params)
>> +{
>> +       return io_uring_setup(entries, params, false);
>> +}
>> +
>> +#ifdef CONFIG_COMPAT
>> +COMPAT_SYSCALL_DEFINE2(io_uring_setup, u32, entries,
>> +                      struct io_uring_params __user *, params)
>> +{
>> +       return io_uring_setup(entries, params, true);
>> +}
>> +#endif
> 
> The compat syscall has the same calling conventions as the
> native one here, so I think you can just use that directly.

Not sure I understand what you mean here. I need to know if it's the
compat one, hence 'true' vs 'false', so I know what the size of the user
pointers/structs are.

>> +/*
>> + * IO submission data structure (Submission Queue Entry)
>> + */
>> +struct io_uring_sqe {
>> +       __u8    opcode;         /* type of operation for this sqe */
>> +       __u8    flags;          /* as of now unused */
>> +       __u16   ioprio;         /* ioprio for the request */
>> +       __s32   fd;             /* file descriptor to do IO on */
>> +       __u64   off;            /* offset into file */
>> +       union {
>> +               void    *addr;  /* buffer or iovecs */
>> +               __u64   __pad;
>> +       };
> 
> It seems a bit unfortunate to keep the pointer field only
> almost compatible between 32-bit and 64-bit big-endian
> architectures, as that requires an in_compat_syscall()
> check whenever we access the pointer from the kernel.
> 
> Could you use a __u64 field to store the pointer itself
> instead?

I feel like I'm missing something here, we'll still need the compat code
on the kernel side for 32-bit app on 64-bit kernel, so what would we
solve by making this an __u64?

>> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
>> index ab9d0e3c6d50..ee5e523564bb 100644
>> --- a/kernel/sys_ni.c
>> +++ b/kernel/sys_ni.c
>> @@ -46,6 +46,8 @@ COND_SYSCALL(io_getevents);
>>  COND_SYSCALL(io_pgetevents);
>>  COND_SYSCALL_COMPAT(io_getevents);
>>  COND_SYSCALL_COMPAT(io_pgetevents);
>> +COND_SYSCALL(io_uring_setup);
>> +COND_SYSCALL(io_uring_enter);
> 
> Unless you remove the compat_sys_io_uring_setup() definition,
> this should also have a corresponding COND_SYSCALL_COMPAT()
> entry.

Gotcha, thanks! I'll make that change.

-- 
Jens Axboe

