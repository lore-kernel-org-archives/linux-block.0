Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB5C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 21:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FB921473
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 21:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GU/9ahZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfA2Vdj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:33:39 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36085 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfA2Vdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 16:33:39 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so7043064itj.1
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 13:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=11AdgOeFmvnVXI9kGa5IWaSSAkW/Ao24eqrEu9Q6KCE=;
        b=GU/9ahZKgxGTSz3JzYNP3canjWoIi3nBp1jEhduKbHuP+8t+cqt1geJ2Z7apiSM8Vh
         Hm7Ti8Shs6iZ40Wm733UAW03QvDgVLS/k1lgExfO9U8mh8Dh9NRyx6Amc1zAxl5EtQeF
         OjRfKC7Sz3VA3EBi5SwqVQzNZ3p6AhFN1lXYwa288etOUyIqXEct6INTvM72TZeVPQEw
         E6tPG1U5Ej4dndkTkP3i+8C8Fzyk7OP9e+QIFPGQTw9izygzXi3g6Hv3PY2DxWHVNKFH
         jNtIwYBaBp3sqDSyActZXqZjbbLkAh7+2TKSnCNS1dEM+WRczmJiaH0W3mI99pNnphDR
         SbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=11AdgOeFmvnVXI9kGa5IWaSSAkW/Ao24eqrEu9Q6KCE=;
        b=R5HZz+q7C2mcp/p06Aijor2i7lfl04+SmkAw7ja5KMPRCtE/zGEbny9f5f8SP8VGqQ
         I4B36r9NdkC2jrBc5KjIDDmOfag5FJQEyU/ZkFQ/u24WhiohuBbVXhcyl4LgaDNsusW0
         82t29VmkB2BFrgud9DuiVhfo6tSsTRJhIKhXbcRQsTU/F6ycLQj576cELXwB51CSqJJU
         YaPAXNqH3cFQnmHJw2nsOgDiloB7vAxIJibhWVzrrs92eN8Ij81IYSVigIvS6tO6W3ey
         8HBE6I+BhuOlAPJ3yURei3X6eTe9pd+qpqneGd1+L6uNrB1DlfA6NmfAGYoS7wHEbxSP
         hBzQ==
X-Gm-Message-State: AJcUukeVGoogHuQKUPg9OTp4lf8PTlGP2EYmEOljitUtE7DCBFAPR5rS
        9rNb/yLxjc5f0/eyEAaREiB8sg==
X-Google-Smtp-Source: ALg8bN45/2lUH/E5k7HTLU1FeW3R1YhMqGJPv2LSoMiF3IPhCUl6QX0JjT8GE483OIUJ3H3Wp45Jiw==
X-Received: by 2002:a05:660c:54d:: with SMTP id w13mr4223007itk.50.1548797618703;
        Tue, 29 Jan 2019 13:33:38 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y12sm14713196ion.62.2019.01.29.13.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 13:33:37 -0800 (PST)
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-8-axboe@kernel.dk>
 <CAG48ez270gG64wmHtG8pNUoBWiSwYiGxsyuSCQ_4wn7v_n_h_w@mail.gmail.com>
 <7337bdfc-39b5-2383-4b58-a9efc3dea1cb@kernel.dk>
 <CAG48ez1uZocSQ6rcT8469SUQtyw3btnP8Js3Ht6VNFb_kfDUDQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a30b8cd5-9986-7e77-d391-385dd8b004b9@kernel.dk>
Date:   Tue, 29 Jan 2019 14:33:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1uZocSQ6rcT8469SUQtyw3btnP8Js3Ht6VNFb_kfDUDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 2:10 PM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 9:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/29/19 1:47 PM, Jann Horn wrote:
>>> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> Add support for a polled io_uring context. When a read or write is
>>>> submitted to a polled context, the application must poll for completions
>>>> on the CQ ring through io_uring_enter(2). Polled IO may not generate
>>>> IRQ completions, hence they need to be actively found by the application
>>>> itself.
>>>>
>>>> To use polling, io_uring_setup() must be used with the
>>>> IORING_SETUP_IOPOLL flag being set. It is illegal to mix and match
>>>> polled and non-polled IO on an io_uring.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> [...]
>>>> @@ -102,6 +102,8 @@ struct io_ring_ctx {
>>>>
>>>>         struct {
>>>>                 spinlock_t              completion_lock;
>>>> +               bool                    poll_multi_file;
>>>> +               struct list_head        poll_list;
>>>
>>> Please add a comment explaining what protects poll_list against
>>> concurrent modification, and ideally also put lockdep asserts in the
>>> functions that access the list to allow the kernel to sanity-check the
>>> locking at runtime.
>>
>> Not sure that's needed, and it would be a bit difficult with the SQPOLL
>> thread and non-thread being different cases.
>>
>> But comments I can definitely add.
>>
>>> As far as I understand:
>>> Elements are added by io_iopoll_req_issued(). io_iopoll_req_issued()
>>> can't race with itself because, depending on IORING_SETUP_SQPOLL,
>>> either you have to come through sys_io_uring_enter() (which takes the
>>> uring_lock), or you have to come from the single-threaded
>>> io_sq_thread().
>>> io_do_iopoll() iterates over the list and removes completed items.
>>> io_do_iopoll() is called through io_iopoll_getevents(), which can be
>>> invoked in two ways during normal operation:
>>>  - sys_io_uring_enter -> __io_uring_enter -> io_iopoll_check
>>> ->io_iopoll_getevents; this is only protected by the uring_lock
>>>  - io_sq_thread -> io_iopoll_check ->io_iopoll_getevents; this doesn't
>>> hold any locks
>>> Additionally, the following exit paths:
>>>  - io_sq_thread -> io_iopoll_reap_events -> io_iopoll_getevents
>>>  - io_uring_release -> io_ring_ctx_wait_and_kill ->
>>> io_iopoll_reap_events -> io_iopoll_getevents
>>>  - io_uring_release -> io_ring_ctx_wait_and_kill -> io_ring_ctx_free
>>> -> io_iopoll_reap_events -> io_iopoll_getevents
>>
>> Yes, your understanding is correct. But of important note, those two
>> cases don't co-exist. If you are using SQPOLL, then only the thread
>> itself is the one that modifies the list. The only valid call of
>> io_uring_enter(2) is to wakeup the thread, the task itself will NOT be
>> doing any issues. If you are NOT using SQPOLL, then any access is inside
>> the ->uring_lock.
>>
>> For the reap cases, we don't enter those at shutdown for SQPOLL, we
>> expect the thread to do it. Hence we wait for the thread to exit before
>> we do our final release.
>>
>>> So as far as I can tell, you can have various races around access to
>>> the poll_list.
>>
>> How did you make that leap?
> 
> Ah, you're right, I missed a check when going through
> __io_uring_enter(), never mind.

OK good, thanks for confirming, was afraid I was starting to lose my
mind.

-- 
Jens Axboe

