Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD4C282CB
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 00:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AC22183E
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 00:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zbdzXkhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfBFA1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:27:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35557 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfBFA1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Feb 2019 19:27:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so2298218pfi.2
        for <linux-block@vger.kernel.org>; Tue, 05 Feb 2019 16:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k4/7LZeOMb7D9n3m8P/yZxaDg8NfwnhPX5SckWKYQpI=;
        b=zbdzXkhMmBG3iNIkI3n4gkqwIoqSE72j9xIXc4UVi3dsR+ezDmdpmfBEuzP5vG3BeH
         1WXldOeCbs4cGTLfEmT1J3aF8jHn4PQmj2GwwAMG/Fc+snQ9XqUvhpDwPATnQ3Yp1717
         OGgf2Qdj1zH7risXGoSWpLYGtMNwx4VM75rXhJqH21E2+Z50di5FPKWMzf6VbzOE0OiS
         P85glPFKPloOEKR3KU7MdvQG4Sc47nlkyGOyobyR2r6eQZEcf/6CSUwh67tKnwLodhmu
         pg3Nbriop5VK4EjNDLlAY28G/zWxSo+SCErS5gkSgl1/J8lo8uUXpupWUuXkPAllruQP
         0ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k4/7LZeOMb7D9n3m8P/yZxaDg8NfwnhPX5SckWKYQpI=;
        b=dRAA5P4Q54AvSk8YfrvtILm/4GyYJEvadNNXGT7QMZCrV1G+y+tIedcu0pcjNvEgKX
         XzcF2okRlx9KWn0kmxz65kWShQAs3YhDI1K+APY+XrW93AGxK7yUH1w07rkbkQqh/8ml
         RLFNlkt/nllS12M1xrKRtI3aAvHNhdWmqk3bxMxbVeP7mFFn9Z+EVHb6bTn2mbFOpMRt
         pNyKQB02xU6NqH2AVmpY7yTYz/VVCBor6lEh+JquNtysqVOuZmrCdcYZ2Rdh6JhkQQ+H
         lIwCaMnNar7kM9i/7+sZW/ULTwfdChssYPN6IvjJ8MH8u+6MP26Zc9fZ54LGMaDyo3gr
         oW2A==
X-Gm-Message-State: AHQUAuYa0m9ct+MXFTp6wppBD2rm5Zjlz0HIQWYmGxTm1SNRNLAaX9SQ
        bZ92xGkqBuETgoDnEl11+Mi4+PGuyUg=
X-Google-Smtp-Source: AHgI3Ia/Hjzwfe0taq5knjocXldpUN8pFWvoRR3bT48yWeZxJ5CnUfbZKoC7I5KvOTJa+36E1fn8lg==
X-Received: by 2002:a62:22d4:: with SMTP id p81mr7965996pfj.16.1549412852965;
        Tue, 05 Feb 2019 16:27:32 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w10sm4964889pgr.42.2019.02.05.16.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 16:27:30 -0800 (PST)
Subject: Re: [PATCH 13/18] io_uring: add file set registration
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com, linux-fsdevel@vger.kernel.org
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-14-axboe@kernel.dk>
 <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
 <20190204025612.GR2217@ZenIV.linux.org.uk>
 <785c6db4-095e-65b0-ded5-72b41af5174e@kernel.dk>
 <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
 <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
Message-ID: <0d2e5085-32ff-e86e-d628-6000071fd132@kernel.dk>
Date:   Tue, 5 Feb 2019 17:27:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/5/19 12:08 PM, Jens Axboe wrote:
> On 2/5/19 10:57 AM, Jens Axboe wrote:
>> On 2/4/19 7:19 PM, Jens Axboe wrote:
>>> On 2/3/19 7:56 PM, Al Viro wrote:
>>>> On Wed, Jan 30, 2019 at 02:29:05AM +0100, Jann Horn wrote:
>>>>> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>> We normally have to fget/fput for each IO we do on a file. Even with
>>>>>> the batching we do, the cost of the atomic inc/dec of the file usage
>>>>>> count adds up.
>>>>>>
>>>>>> This adds IORING_REGISTER_FILES, and IORING_UNREGISTER_FILES opcodes
>>>>>> for the io_uring_register(2) system call. The arguments passed in must
>>>>>> be an array of __s32 holding file descriptors, and nr_args should hold
>>>>>> the number of file descriptors the application wishes to pin for the
>>>>>> duration of the io_uring context (or until IORING_UNREGISTER_FILES is
>>>>>> called).
>>>>>>
>>>>>> When used, the application must set IOSQE_FIXED_FILE in the sqe->flags
>>>>>> member. Then, instead of setting sqe->fd to the real fd, it sets sqe->fd
>>>>>> to the index in the array passed in to IORING_REGISTER_FILES.
>>>>>>
>>>>>> Files are automatically unregistered when the io_uring context is
>>>>>> torn down. An application need only unregister if it wishes to
>>>>>> register a new set of fds.
>>>>>
>>>>> Crazy idea:
>>>>>
>>>>> Taking a step back, at a high level, basically this patch creates sort
>>>>> of the same difference that you get when you compare the following
>>>>> scenarios for normal multithreaded I/O in userspace:
>>>>
>>>>> This kinda makes me wonder whether this is really something that
>>>>> should be implemented specifically for the io_uring API, or whether it
>>>>> would make sense to somehow handle part of this in the generic VFS
>>>>> code and give the user the ability to prepare a new files_struct that
>>>>> can then be transferred to the worker thread, or something like
>>>>> that... I'm not sure whether there's a particularly clean way to do
>>>>> that though.
>>>>
>>>> Using files_struct for that opens a can of worms you really don't
>>>> want to touch.
>>>>
>>>> Consider the following scenario with any variant of this interface:
>>>> 	* create io_uring fd.
>>>> 	* send an SCM_RIGHTS with that fd to AF_UNIX socket.
>>>> 	* add the descriptor of that AF_UNIX socket to your fd
>>>> 	* close AF_UNIX fd, close io_uring fd.
>>>> Voila - you've got a shiny leak.  No ->release() is called for
>>>> anyone (and you really don't want to do that on ->flush(), because
>>>> otherwise a library helper doing e.g. system("/bin/date") will tear
>>>> down all the io_uring in your process).  The socket is held by
>>>> the reference you've stashed into io_uring (whichever way you do
>>>> that).  io_uring is held by the reference you've stashed into
>>>> SCM_RIGHTS datagram in queue of the socket.
>>>>
>>>> No matter what, you need net/unix/garbage.c to be aware of that stuff.
>>>> And getting files_struct lifetime mixed into that would be beyond
>>>> any reason.
>>>>
>>>> The only reason for doing that as a descriptor table would be
>>>> avoiding the cost of fget() in whatever uses it, right?  Since
>>>
>>> Right, the only purpose of this patch is to avoid doing fget/fput for
>>> each IO.
>>>
>>>> those are *not* the normal syscalls (and fdget() really should not
>>>> be used anywhere other than the very top of syscall's call chain -
>>>> that's another reason why tossing file_struct around like that
>>>> is insane) and since the benefit is all due to the fact that it's
>>>> *NOT* shared, *NOT* modified in parallel, etc., allowing us to
>>>> treat file references as stable... why the hell use the descriptor
>>>> tables at all?
>>>
>>> This one is not a regular system call, since we don't do fget, then IO,
>>> then fput. We hang on to it. But for the non-registered case, it's very
>>> much just like a regular read/write system call, where we fget to do IO
>>> on it, then fput when we are done.
>>>
>>>> All you need is an array of struct file *, explicitly populated.
>>>> With net/unix/garbage.c aware of such beasts.  Guess what?  We
>>>> do have such an object already.  The one net/unix/garbage.c is
>>>> working with.  SCM_RIGHTS datagrams, that is.
>>>>
>>>> IOW, can't we give those io_uring descriptors associated struct
>>>> unix_sock?  No socket descriptors, no struct socket (probably),
>>>> just the AF_UNIX-specific part thereof.  Then teach
>>>> unix_inflight()/unix_notinflight() about getting unix_sock out
>>>> of these guys (incidentally, both would seem to benefit from
>>>> _not_ touching unix_gc_lock in case when there's no unix_sock
>>>> attached to file we are dealing with - I might be missing
>>>> something very subtle about barriers there, but it doesn't
>>>> look likely).
>>>
>>> That might be workable, though I'm not sure we currently have helpers to
>>> just explicitly create a unix_sock by itself. Not familiar with the
>>> networking bits at all, I'll take a look.
>>>
>>>> And make that (i.e. registering the descriptors) mandatory.
>>>
>>> I don't want to make it mandatory, that's very inflexible for managing
>>> tons of files. The registration is useful for specific cases where we
>>> have high frequency of operations on a set of files. Besides, it'd make
>>> the use of the API cumbersome as well for the basic case of just wanting
>>> to do async IO.
>>>
>>>> Hell, combine that with creating io_uring fd, if we really
>>>> care about the syscall count.  Benefits:
>>>
>>> We don't care about syscall count for setup as much. If you're doing
>>> registration of a file set, you're expected to do a LOT of IO to those
>>> files. Hence having an extra one for setup is not a concern. My concern
>>> is just making it mandatory to do registration, I don't think that's a
>>> workable alternative.
>>>
>>>> 	* no file_struct refcount wanking
>>>> 	* no fget()/fput() (conditional, at that) from kernel
>>>> threads
>>>> 	* no CLOEXEC-dependent anything; just the teardown
>>>> on the final fput(), whichever way it comes.
>>>> 	* no fun with duelling garbage collectors.
>>>
>>> The fget/fput from a kernel thread can be solved by just hanging on to
>>> the struct file * when we punt the IO. Right now we don't, which is a
>>> little silly, that should be changed.
>>>
>>> Getting rid of the files_struct{} is doable.
>>
>> OK, I've reworked the initial parts to wire up the io_uring fd to the
>> AF_UNIX garbage collection. As I made it to the file registration part,
>> I wanted to wire up that too. But I don't think there's a need for that
>> - if we have the io_uring fd appropriately protected, we'll be dropping
>> our struct file ** array index when the io_uring fd is released. That
>> should be adequate, we don't need the garbage collection to be aware of
>> those individually.
>>
>> The only part I had to drop for now is the sq thread polling, as that
>> depends on us carrying the files_struct. I'm going to fold that in
>> shortly, but just make it be dependent on having registered files. That
>> avoids needing to fget/fput for that case, and needing registered files
>> for the sq side submission/polling is not a usability issue like it
>> would be for the "normal" use cases.
> 
> Proof is in the pudding, here's the main commit introducing io_uring
> and now wiring it up to the AF_UNIX garbage collection:
> 
> http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=158e6f42b67d0abe9ee84886b96ca8c4b3d3dfd5
> 
> How does that look? Outside of the inflight hookup, we simply retain
> the file * for punting to the workqueue. This means that buffered
> retry does NOT need to do fget/fput, so we don't need a files_struct
> for that anymore.
> 
> In terms of the SQPOLL patch that's further down the series, it doesn't
> allow that mode of operation without having fixed files enabled. That
> eliminates the need for fget/fput from a kernel thread, and hence the
> need to carry a files_struct around for that as well.

This should be better, passes some basic testing, too:

http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=01a93aa784319a02ccfa6523371b93401c9e0073

Verified that we're grabbing the right refs, and don't hold any
ourselves. For the file registration, forbid registration of the
io_uring fd, as that is pointless and will introduce a loop regardless
of fd passing.

-- 
Jens Axboe

