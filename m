Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC0EC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCED205C9
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MzDKKL6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfAPPOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:14:23 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54875 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393957AbfAPPOX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 10:14:23 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so3446080ita.4
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 07:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cGPNWZBEeWqQTY2P4CmZZJw1Gsz7QMR1VfnLKACc2k4=;
        b=MzDKKL6vfIXKsUS/eNR+t0nmasDKMZJDHox2jMou33cylbQpxjSMjLaDVc9uk7p/lE
         oD5aLWfPnHaOtnDuTgLrQNhykkjAl+n4GQMjTzCbs14jKUgnmc9ZDSFQOi5ppzRTWp7m
         MYi/Wv3BqaKq4cIWG3mDr3wXmucVfOGlRJCWzlnAmzqUw/kM2NL0vX1Yz0ofWhREOmKz
         QKzz4715+2T19mx7vZq6npIjIxNS52/ye5Bg1IybfikwbCnuOKAOmlHtiRofr7ZMGjqo
         mlfPTT9HT6Tbas0NLFVMHuGy6na//mGHsnZMWiuemoKysVSpLocxAHEB8QMU+Pe14M6B
         tXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cGPNWZBEeWqQTY2P4CmZZJw1Gsz7QMR1VfnLKACc2k4=;
        b=p0QZS7kh10lRWI5bEf0Z8yFQwXvrRIJoxlKR8mpmketTi37QDu3uCVgQ5FjiF7HC7v
         7Z3OQhXBnyX8PJC+J7TsZHahsRZK6YJCZL6wsdbLVtr/I43bAeV1zsHe3YxJDBSj/Ceq
         SWQTvLmupCB+q8NpyZ2LqHv+We2jrYm+txB3g1H/QjYnES9gm0MAsGWBMWRBpy6nDYa4
         k3WvWuFV56Y/L9OkIl7Wmc5DPPocm66upXpzQTi2mK/oJp2CJQzlHz8q9oReqt9ADx0H
         kxccgoWvP2VKKUIxtfTbLsPucSzN1bFBZlPTYEiGuIXeU0Nuw3ZX4ClZpgVHnWVGPm4v
         jbvg==
X-Gm-Message-State: AJcUukf+KoGhfzdG4+a+IUXYccIdKcGMfv3NTc5/uMutdUGMT3fAH3YC
        MH4eYAAsmhxgJt358P/75qeBbA==
X-Google-Smtp-Source: ALg8bN49a4mkOSCX/uT/4fhFzqlbVf36YXRtsXlYFvw7IiWCFK9VvAYUfzRlG7U9sSjQSFFL6rCQZg==
X-Received: by 2002:a24:a141:: with SMTP id n1mr5953259iti.31.1547651662034;
        Wed, 16 Jan 2019 07:14:22 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d128sm2593241iof.37.2019.01.16.07.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 07:14:18 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <075af26b-c685-a0db-05e4-fa73f8725b8a@kernel.dk>
Date:   Wed, 16 Jan 2019 08:14:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3aTZ-VEc=uvOeYov4DiaBN1iNuhR41BfP0Qdf3AXx74w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 3:53 AM, Arnd Bergmann wrote:
> On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:
> 
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 542757a4c898..e36c264d74e8 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
>>                                 struct io_uring_params __user *p);
>>  asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
>>                                 u32 min_complete, u32 flags);
>> +asmlinkage long sys_io_uring_register(unsigned int fd, unsigned op,
>> +                               void __user *arg);
>>
> 
> Would it be possible to make this a typed pointer instead? If this needs to
> be extended later to pass a different structure, a new system call may
> be better for consistency than overloading the argument in various
> ways.

As you can see from the later patch for registering files, it'll be used
for other structs too. Feels a little silly to add an extra system call
for that. I agree the void * isn't the prettiest thing in the world, but
at least it allows us to extend the API without having to add even more
system calls down the line.

>> + * io_uring_register(2) opcodes and arguments
>> + */
>> +#define IORING_REGISTER_BUFFERS                0
>> +#define IORING_UNREGISTER_BUFFERS      1
>> +
>> +struct io_uring_register_buffers {
>> +       union {
>> +               struct iovec *iovecs;
>> +               __u64 pad;
>> +       };
>> +       __u32 nr_iovecs;
>> +};
> 
> As before, I'd suggest making this structure compatible between 32-bit
> and 64-bit architectectures, by avoiding pointer and implied padding
> fields.

I'll await an answer to my previous question on that.

-- 
Jens Axboe

