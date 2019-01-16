Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA69C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC5B20840
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S2SubGSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfAPXRG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:17:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38502 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfAPXRF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 18:17:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so3811646pfi.5
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 15:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8uscjfs9KYoR1JSWPlxk5jvDeiuQcOBYO5ZOfRO5uYE=;
        b=S2SubGSyINQBlZ39+O9PHKiC0x+pF/TA0iUMJV4mcOk4QZp0PomBgevpbBPk44H3qf
         GfbPHds6POb3+V/qtO1xgVis92+Gl5roED/hV/JUNGjoBWLabZQ0RZOrcliDDrFrjQ6V
         kr7NOy1cE0/lXo/PwFk13HmDeOPYy+oZTLmDuoodoi+pqLZLY0fJDbPZDylhZZ8xV1R7
         mgvjVBIEyC68reQBSxGtkTQMR2UeBh/bhhYRTeAOH2X7mCERntzOwnbCEfj1+BiAd2VW
         3KkxKkr6sNRN1rzQwOUEOK+9WqWXr8yQFI0ART3sOl1lfXCX2y3co+g131Tt6IgePWEB
         NwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8uscjfs9KYoR1JSWPlxk5jvDeiuQcOBYO5ZOfRO5uYE=;
        b=koMsmHrerPKcerfLDUuHgSD3PxRIhpjAmvLGmc2UG54lsYm39y2kg8j5SVHn6LDypg
         OnazzlcjLS3vqF0B/LaAj/aDX4zY2PbMaI9dStZ/xpkmoo15vdB/SCS3K/lavk4xSM5Q
         8HyqIj5UFMP+MG9Gr7aecg2tEJkW6X29vkOXM92FUjFB7ZJACHGtPus1NfniMyUhcZ8A
         WdJqaeLHM2i9nDH5sPefmUYHR3AerlPnMJ3+A0KgqDgX2QQk+U3/tFjArWp7TqXf5C8V
         tdjTQ1s1B+i3bPdVSFxKUqe4j5vYwrca8MD9hpVv3zLRS8UDXIX71hPl/cmeEboAfnVb
         iBgg==
X-Gm-Message-State: AJcUukeYUYtnOhVRlnK+25i1+rMPlF3BSBcVZl4qXC3moqvyLEL7uIA9
        JGqYUI1A95ju0XX5uexHLCCCPQ==
X-Google-Smtp-Source: ALg8bN4ppODphmzFFddYIXMrM4HMkIazOC1TZ+aFqJbMlmxkowpgNjhfPX+rysTljas2ES675gemMg==
X-Received: by 2002:a62:b15:: with SMTP id t21mr12766762pfi.136.1547680624587;
        Wed, 16 Jan 2019 15:17:04 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q75sm13727241pfa.38.2019.01.16.15.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 15:17:03 -0800 (PST)
Subject: Re: [PATCH 12/15] io_uring: add support for pre-mapped user IO
 buffers
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-13-axboe@kernel.dk> <20190116205338.GQ4205@dastard>
 <9db63405-6797-9305-3ce1-fdc11edbf49c@kernel.dk>
 <20190116220938.GR4205@dastard>
 <7fd5cb40-2288-3c54-41d1-3163098b25ef@kernel.dk>
 <20190116230920.GT4205@dastard>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <29622208-d155-4f76-78d5-e7dd54ee807b@kernel.dk>
Date:   Wed, 16 Jan 2019 16:17:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116230920.GT4205@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 4:09 PM, Dave Chinner wrote:
> On Wed, Jan 16, 2019 at 03:21:21PM -0700, Jens Axboe wrote:
>> On 1/16/19 3:09 PM, Dave Chinner wrote:
>>> On Wed, Jan 16, 2019 at 02:20:53PM -0700, Jens Axboe wrote:
>>>> On 1/16/19 1:53 PM, Dave Chinner wrote:
>>>> I'd be fine with that restriction, especially since it can get relaxed
>>>> down the line. Do we have an appropriate API for this?  And why isn't
>>>> get_user_pages_longterm() that exact API already?
>>>
>>> get_user_pages_longterm() is the right thing to use to ensure DAX
>>> doesn't trip over this - it's effectively just get_user_pages()
>>> with a "if (vma_is_fsdax(vma))" check in it to abort and return
>>> -EOPNOTSUPP. IOWs, this is safe on DAX but it's not safe on anything
>>> else. :/
>>>
>>> Unfortunately, disallowing userspace GUP pins on non-DAX file backed
>>> pages will break existing "mostly just work" userspace apps all over
>>> the place. And so right now there are discussions ongoing about how
>>> to map gup references avoid the writeback races and be able to be
>>> seen/tracked by other kernel infrastructure (see the long, long
>>> thread "[PATCH 0/2] put_user_page*(): start converting the call
>>> sites" on -fsdevel). Progress is slow, but I think we're starting to
>>> close on a workable solution.
>>>
>>> FWIW, this doesn't solve the "long term user pin will block
>>> filesystem operations until unpin" problem, that's what moving to
>>> using revocable file layout leases is intended to solve. There have
>>> been patches posted some time ago to add this user API for this, but
>>> we've got to solve the other problems first....
>>>
>>>> Would seem that most
>>>> (all?) callers of this API is currently broken then.
>>>
>>> Yup, there's a long, long history of machines using userspace RDMA
>>> panicing because filesystems have detected or tripped over invalid
>>> page cache state during writeback attempts. This is not a new
>>> problem....
>>
>> Thanks for your detailed answer, Dave! I didn't see it before I sent
>> out the previous email. FWIW, I've updated the patch:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=0c8f2299f8069af6b2fa8f99a10d81646d1237a7
>>
>> Checks for file backed memory, fails the registration with EOPNOTSUPP
>> if the check fails.
> 
> Doesn't it need to call put_pages() on all the pages picked up by
> get_user_pages_longterm() when it returns -EOPNOTSUPP? They haven't
> been mapped into the imu->bvec array yet, so AFAICT there's nothing
> to release the page references on teardown here.

Oops, yes good point. The usual error handling won't work for this, need
to put them.

> Also, not a vma expert here, but the vma array contents may only be
> valid while the mmap_sem is held - I think vmas can come and go
> after it has been dropped and so accessing vmas to check
> vma->vm_file after the mmap_sem has been dropped may be open to
> read-after-free races.

I did fix that one right after sending out the email:

http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=d2b44723d5bceeb9966c858255a03596ed62929c

I'll fix the missing put_pages() on error and update it.

>> That should handle the issue on the io_uring side at least, and it's a
>> restriction that can always be relaxed/lifted, when appropriate solutions
>> to file backed buffers exists.
> 
> Modulo the issue above, that works for me.

Great!

-- 
Jens Axboe

