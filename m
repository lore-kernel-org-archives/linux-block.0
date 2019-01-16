Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF4C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A0920675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FRChQ7BE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391280AbfAPPcI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:32:08 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42127 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394079AbfAPPcH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 10:32:07 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so5169214ioa.9
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 07:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZiQ+uyqTl1b+kMcXwyfjNQaFPy8JWmeE+avUtD8CbTA=;
        b=FRChQ7BE7L6zmXoWceUkMK4c93+ki0+XPg14TBYLRTCH/T+g2p3GXCIqQGwXGyEDgl
         u3z08X+CFam19iMxcZvK7o1oxe/RWgjZhGRxJ155ebLxiakBYmOegMzkrb6fphtHwMhI
         YmWqpFQ8Qjl6554bkHpldpl2066hfhg0VVEIENepDH1ChKAqmslebteviJjNK0cFKb9S
         lL6kvfb9bvG4D8AM7G8nZpZClHfv0wPwM39TrJDZv3aKCTQ0kYsvPXsKjeoThAANCzAe
         DTBdYAdxgHCpRimTRsVwTVL0pj3uJa0QeKvIj5eAovIBPYM0x4T1JpevSrHJvbAhwrMq
         OjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZiQ+uyqTl1b+kMcXwyfjNQaFPy8JWmeE+avUtD8CbTA=;
        b=HrIt5wuRJCQwl0kIjCiZBWr1hHJddsxOrtw0Av0qUuI2M2ZvMC3GDKeG07BQC+0EMH
         d+4eTmcJvSgnuNg+vAWdJ7K7D74yKIbugN0GszQgECXvHCqBObxRBAFFRXj1ABlVLsjz
         08/jt9JXeSLTgQfKDOix94zg9DzjcrDeA5IPF2CcZDHBAtd9yQ7+d4dv5hiVKsLapk67
         i2ym8edZjZlSkCv+rgTPy1kLMJxi4LAtmKdxutKU6arACInm0rooGaXyrylYkcRkXItx
         Vd4pGjAI46JYhSjM5Op/VybaBO3SrF+eL1bOVKt6vA2Wid+wur+aMsjVfWeF38yuoGWh
         AREQ==
X-Gm-Message-State: AJcUukdUvcxoyKQgnbbpnnYRqw3HI3nStjRSlm7+TVRyEf05DYKcmJLp
        CgDJTVc4DVbjjXidd1Xy/HuUUA==
X-Google-Smtp-Source: ALg8bN6Up1D9FTx/nEwVGNAPFfGzW3ol36ks8i/vDS1Rdo9t98qrypSRNGOCc/D6FM4EWnB9bifdvQ==
X-Received: by 2002:a6b:6919:: with SMTP id e25mr4948858ioc.119.1547652726606;
        Wed, 16 Jan 2019 07:32:06 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m81sm3406151itb.43.2019.01.16.07.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 07:32:05 -0800 (PST)
Subject: Re: [PATCH 13/16] io_uring: add support for pre-mapped user IO
 buffers
From:   Jens Axboe <axboe@kernel.dk>
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
Message-ID: <331f63c0-002f-b373-b831-73af9e98f2ef@kernel.dk>
Date:   Wed, 16 Jan 2019 08:32:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <075af26b-c685-a0db-05e4-fa73f8725b8a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 8:14 AM, Jens Axboe wrote:
> On 1/16/19 3:53 AM, Arnd Bergmann wrote:
>> On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>>> index 542757a4c898..e36c264d74e8 100644
>>> --- a/include/linux/syscalls.h
>>> +++ b/include/linux/syscalls.h
>>> @@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
>>>                                 struct io_uring_params __user *p);
>>>  asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
>>>                                 u32 min_complete, u32 flags);
>>> +asmlinkage long sys_io_uring_register(unsigned int fd, unsigned op,
>>> +                               void __user *arg);
>>>
>>
>> Would it be possible to make this a typed pointer instead? If this needs to
>> be extended later to pass a different structure, a new system call may
>> be better for consistency than overloading the argument in various
>> ways.
> 
> As you can see from the later patch for registering files, it'll be used
> for other structs too. Feels a little silly to add an extra system call
> for that. I agree the void * isn't the prettiest thing in the world, but
> at least it allows us to extend the API without having to add even more
> system calls down the line.

With the __u64 changes, we end up with this:

struct io_uring_register_buffers {
	__u64 iovecs;		/* pointer to iovecs array */
	__u32 nr_iovecs;	/* number of iovecs in array */
	__u32 pad;
};

struct io_uring_register_files {
	__u64 fds;
	__u32 nr_fds;
	__u32 pad;
};

which are identical. So the question then becomes if I should just make
these opaque enough to be the same thing, ala:

struct io_uring_register_data {
	__u64 data;
	__u32 nr_elems;
	__u32 pad;
};

and then probably add a bit more reserved space so we have something
that can be extended...

-- 
Jens Axboe

