Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88C0C2D0C7
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 23:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC84214AF
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 23:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lNMQ0l96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLKXl6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:41:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40798 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLKXl5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 18:41:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so137973pgt.7
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 15:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kpNlzVcv7JN7E6YhjIPCUm4BYR7x79EcBxfrlw22S00=;
        b=lNMQ0l96BGpM2u4/wCZBoSrFB93g3IOanTEQQ+kdic7G16RGwofrZTW8qUp1QNENny
         T1Eb/+YV7QhwyPRj9GARsbeTzqugStumohKT6y0N2LcAsgp11lKJYqym6sJkQoYWcML7
         tv6Tk038FmRqpyXdZbMU1yMUeYzTbL+KVUXE3j9+u5tYvO14L9z7nNlWu7bUQ50bxPfh
         X+12YPIyy3eQjnNp9WFgw5NnextOhh69DfsoZEJbYUYw9qT4jmF2nAKnOliEKnQjAPc6
         0f/gEoMuhK3OcD1hyPTntiz+91l7s6taPogaoXlu5MaMRGRPWbjPtG7F4qOLOQld1YYJ
         v+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kpNlzVcv7JN7E6YhjIPCUm4BYR7x79EcBxfrlw22S00=;
        b=Yo2pfyOuANSKX9pe6cO/xrDYjF5eHiDWhAp3SFOqT+AT56/mQlDnh4EBvR6dJScWWX
         7bVxdbuAF7lUsx66+9Z5qh2d4y2DqkE9nOvj+ZGTgooNlLfe9pKWi9S2eYwzzVrmgjqc
         WKPwJmifLQRqYfUHdHNDAd/MsHNDLVwD+8BuPNF/gdcXglYasAOcBzeU1GjUJAu5jHwZ
         C4tj14S2Q44qFlfMywR5r0ufXw+nMWLJR2rrX78/DaDEZ8Gp2Jcuf1HFwzPJezZrf1Pv
         GKG5Dx3RMEH1wIKTPZ0gMAl+b8crezNmlbO+l1nBUy89tgA+6l/cnpoypmvmoe5NcIXM
         vTKQ==
X-Gm-Message-State: APjAAAWoh0VzBUCu7cHxe+STuXKzE5ybTSxouqCPP88689QCWAeQS/Wu
        Tj9ZClz+/qlOAgQ2pcL28lFA8w==
X-Google-Smtp-Source: APXvYqwGOwKUwd/HWjO/NJjda16cvXL4uvMFEOj+dWRqjsE0z2VrBX/uK93JoRyDrVWFrEuUz+X4rg==
X-Received: by 2002:aa7:801a:: with SMTP id j26mr6656838pfi.50.1576107715544;
        Wed, 11 Dec 2019 15:41:55 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id s27sm4414042pfd.88.2019.12.11.15.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 15:41:54 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
Date:   Wed, 11 Dec 2019 16:41:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/19 1:18 PM, Linus Torvalds wrote:
> On Wed, Dec 11, 2019 at 12:08 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> $ cat /proc/meminfo | grep -i active
>> Active:           134136 kB
>> Inactive:       28683916 kB
>> Active(anon):      97064 kB
>> Inactive(anon):        4 kB
>> Active(file):      37072 kB
>> Inactive(file): 28683912 kB
> 
> Yeah, that should not put pressure on some swap activity. We have 28
> GB of basically free inactive file data, and the VM is doing something
> very very bad if it then doesn't just quickly free it with no real
> drama.
> 
> In fact, I don't think it should even trigger kswapd at all, it should
> all be direct reclaim. Of course, some of the mm people hate that with
> a passion, but this does look like a prime example of why it should
> just be done.

For giggles, I ran just a single thread on the file set. We're only
doing about 100K IOPS at that point, yet when the page cache fills,
kswapd still eats 10% cpu. That seems like a lot for something that
slow.

> MM people - mind giving this a look?  Jens, if you have that NOACCESS
> flag in a git tree too and a trivial way to recreate your load, that
> would be good for people to be able to just try things out.

I've pushed the NOACCESS thing to my buffered-uncached branch as well,
and fio has a 'noaccess' branch that enables it for pvsync2 (which is
preadv2/pwritev2) and the io_uring engine.

Here's what I did to reproduce:

- Boot the box with 32G of memory.
- On a fast device, create 10x RAM size of files. I used 32 files, each
  10G. Mine are in /data, and they are named file[1-32].
- Run a buffered read workload on those files.

For pvsync2, something ala:

$ cat job.fio
[test]
ioengine=pvsync2
#uncached=1
#noaccess=1
iodepth=4
bs=4k
group_reporting=1
rw=randread
norandommap
buffered=1
directory=/data
filename=file1:file2:file3:file4:file5:file6:file7:file8:file9:file10:file11:file12:file13:file14:file15:file16:file17:file18:file19:file20:file21:file22:file23:file24:file25:file26:file27:file28:file29:file30:file31:file32

If you want to use more than one thread, add:

numjobs=4

for 4 threads. Uncomment the 'uncached=1' and/or 'noaccess=1' to enable
either RWF_UNCACHED or RWF_NOACCESS.

-- 
Jens Axboe

