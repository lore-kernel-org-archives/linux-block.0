Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C88C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8090A2082F
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xCU8WUas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfAPPrb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:47:31 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54156 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfAPPra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 10:47:30 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so3660693ita.3
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 07:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7CyY2Oz+vVu6rdOO2CKlFF7oBCfkTbvsuspJeqobKkM=;
        b=xCU8WUas6G2Bd/LcsQ4poa9i7oJIF8937Es8l+NbPM4H6QYTxA26KTlMNYeBMULlz1
         +Y6ofuriDCu4xiol91IjSqOPx+HBySh+rL+wvSxd+VgzfQiqcENubcqNdcZoZqOOi72D
         U35fB99wByLcG14AmTQ6VgcibrE1LyvdvPWcQ4sHZoqfsVQHHKEONDr/AumMZ0+Peofj
         uQZZ6u9rcMIv3cKeI4s2GiTkf6+NiIdl1JiYB0gLyC3O9Dfxqq6UjYwwNuH2P66rItyg
         TK5HtVUMipTMn4H3UM7XaleTFsmL5VabZW3y9OfG72G6kaY4t+i/EaUolaSTlyTIdDtx
         OXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7CyY2Oz+vVu6rdOO2CKlFF7oBCfkTbvsuspJeqobKkM=;
        b=N4lfYqvv9SsTiOp8wD3Nzfr6HZGSNTOk1CW+XNymw6H0ShsZEtcNJZ2/xg11QAceba
         dzlZoUfdOHgmgLiqySaTcTHTeB1VtqdwQEHICTC76OuA5gLmHwOv9r0FmZ3RUF/uQ7zF
         ch1IfDkdReZSc0YRvXFGDFjM14E+pnZ2zchCKUBYA9v/jpcYMRMJIcDxcTCrirIOJui2
         HEXmR1EN7JasQ/rA7RBugvVSqCTZfwJlcAf2rx2ehqq8BCDQiz/hnOk5qwgg9oMsJ+O6
         /yBUKR/kKUlhBiLa+H2NpG+9mGDgNbwKf+S+J4Wwa8G3AaUG0+66eb+Gp5RcExLupgrA
         S8xg==
X-Gm-Message-State: AJcUukezwV3voud/1RH3RxgEE38Kh71k5YCCdv0Ru4SrEac0JUoJQN4D
        edEuWLIWPUei4riNNHGa0TV7VQ==
X-Google-Smtp-Source: ALg8bN4okrExDKuAcF4fnDNZ5fZDmdlcEtHmVAbbQpuBJnWLiIsIy5KVZM1yzeY8jse7tnvTGZkigg==
X-Received: by 2002:a24:5c50:: with SMTP id q77mr5567320itb.12.1547653649632;
        Wed, 16 Jan 2019 07:47:29 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c21sm2471648iob.22.2019.01.16.07.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 07:47:28 -0800 (PST)
Subject: Re: [PATCH 13/16] io_uring: add support for pre-mapped user IO
 buffers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Avi Kivity <avi@scylladb.com>
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-14-axboe@kernel.dk>
 <CAK8P3a3aTZ-VEc=uvOeYov4DiaBN1iNuhR41BfP0Qdf3AXx74w@mail.gmail.com>
 <075af26b-c685-a0db-05e4-fa73f8725b8a@kernel.dk>
 <331f63c0-002f-b373-b831-73af9e98f2ef@kernel.dk>
 <CAK8P3a2E8dLoL5sgucp=-LDkGMN=qnG8M_phHoHCBg5ipWgBjQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c5eb06f0-b8ab-81a3-9e79-b31454211a60@kernel.dk>
Date:   Wed, 16 Jan 2019 08:47:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2E8dLoL5sgucp=-LDkGMN=qnG8M_phHoHCBg5ipWgBjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 8:41 AM, Arnd Bergmann wrote:
> On Wed, Jan 16, 2019 at 4:32 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/16/19 8:14 AM, Jens Axboe wrote:
>>> On 1/16/19 3:53 AM, Arnd Bergmann wrote:
>>>> On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>>>>> index 542757a4c898..e36c264d74e8 100644
>>>>> --- a/include/linux/syscalls.h
>>>>> +++ b/include/linux/syscalls.h
>>>>> @@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
>>>>>                                 struct io_uring_params __user *p);
>>>>>  asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
>>>>>                                 u32 min_complete, u32 flags);
>>>>> +asmlinkage long sys_io_uring_register(unsigned int fd, unsigned op,
>>>>> +                               void __user *arg);
>>>>>
>>>>
>>>> Would it be possible to make this a typed pointer instead? If this needs to
>>>> be extended later to pass a different structure, a new system call may
>>>> be better for consistency than overloading the argument in various
>>>> ways.
>>>
>>> As you can see from the later patch for registering files, it'll be used
>>> for other structs too. Feels a little silly to add an extra system call
>>> for that. I agree the void * isn't the prettiest thing in the world, but
>>> at least it allows us to extend the API without having to add even more
>>> system calls down the line.
>>
>> With the __u64 changes, we end up with this:
>>
>> struct io_uring_register_buffers {
>>         __u64 iovecs;           /* pointer to iovecs array */
>>         __u32 nr_iovecs;        /* number of iovecs in array */
>>         __u32 pad;
>> };
>>
>> struct io_uring_register_files {
>>         __u64 fds;
>>         __u32 nr_fds;
>>         __u32 pad;
>> };
>>
>> which are identical. So the question then becomes if I should just make
>> these opaque enough to be the same thing, ala:
>>
>> struct io_uring_register_data {
>>         __u64 data;
>>         __u32 nr_elems;
>>         __u32 pad;
>> };
> 
> Right, that looks good in either form.
> 
>> and then probably add a bit more reserved space so we have something
>> that can be extended...
> 
> Or maybe go the opposite way and pass the two members you have
> directly to the system call:
> 
> int io_uring_register(unsigned int fd, unsigned int opcode, void
> __user *, arg, unsigned count)
> {
>       ...
> }
> 
> Where 'arg' now points to the array of iovecs or the the array of file
> descriptors, or whatever else you need.

I kind of like that, that gets rid of having to wrap it in a struct. If
I later wanted to abuse it, arg could point to a struct...

I'll make this change.

-- 
Jens Axboe

