Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EE0C433F5
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 13:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5103A61B2C
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 13:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhKONTb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Nov 2021 08:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhKONTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 08:19:18 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80675C061746
        for <linux-block@vger.kernel.org>; Mon, 15 Nov 2021 05:16:21 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id v65so21318607ioe.5
        for <linux-block@vger.kernel.org>; Mon, 15 Nov 2021 05:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6HJ70EKxinwIoQ3f980BpKqJ3ld3FweZelt/34EjkOk=;
        b=S+FFdDb51vZtuqPbVLbcj/KRioeY5L/Nsmu8PzFF2eDckGRQnIE6pwpC9hqARC+6We
         3Zx7S5odZIUpGrldgky2D22cDpqH9OCt7yjehxz70TbhxGAr22z8rE3spGhRbrs360W4
         30L7HbzDAdDvnWPIH1Vc0RcP2NQ7Itebb9ZnE4V4uDB3LlZ7kx/IJ9LU42S+5Np2NgJs
         bDadZKOFKDo8lAG5WeYR7qK1flD7X6kKSXYiTfa1yfkMhxCC9F9UOVn2PXGLI0I8rWSk
         FnmVClKk2UIMvVxlsSUsu1fNIgLQFk8XTA4Wjin4VbTGO1fIB7QLZitfVGNGwAImcCpG
         kYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6HJ70EKxinwIoQ3f980BpKqJ3ld3FweZelt/34EjkOk=;
        b=PR5PErrbo0qK10f6jO2mM6+fkCTvxtQ3Bw2mNy7k5k1xrEDRKKtGnLGUEvjuUK/ekn
         FXtdbfO5mF33ywJEfBhIqKyBORKhzAoLZ/4EPpG9aBg6viFgc141Jqnw1HHdFNeZrIN1
         HL+EzzQAcV7DX0IH7cC6FUIK+R7ulwYndbvNhrIS0i5B6vL5VMaxJ09mCFZ2MbcOnQkz
         p/Lq3g5vCVX5lqRx0oTnPP7fQXNEgQ+aR+kSBvHu/y1C6x7xUPY5UzqMwqsLvVYoJehj
         PP5z+o2eTzFiZzHB8ORTTky0yi2QCWFEH/YRn7+Kj9+/TCGDSMtUAqRojmaCOs+WVydX
         DdKA==
X-Gm-Message-State: AOAM533aauOHSTHHPb4P979qpFxNeG5XtFkTp94Zl3CP/DB/r2mx+GoA
        27gXg4kyPBQl1hapR8s6d23+uDvPCUqvw+3Z
X-Google-Smtp-Source: ABdhPJz94dVsETHD3C06BfJ5k97K7NYPCK/WKmqxUl03y6x4XI50yERnh3Z+qkxzyAUeLUJeg+l7VA==
X-Received: by 2002:a02:7053:: with SMTP id f80mr29843961jac.28.1636982180667;
        Mon, 15 Nov 2021 05:16:20 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g10sm11014551ila.34.2021.11.15.05.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 05:16:20 -0800 (PST)
Subject: Re: raid0 vs io_uring
To:     Avi Kivity <avi@scylladb.com>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <c978931b-d3ba-89c7-52ef-30eddf740ba6@scylladb.com>
 <ee22cbab-950f-cdb0-7ef0-5ea0fe67c628@kernel.dk>
 <78ccd535-29fa-9d03-0adc-746d1ed62373@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e04ee73e-04a9-c3cd-152c-b12e0c19c264@kernel.dk>
Date:   Mon, 15 Nov 2021 06:16:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <78ccd535-29fa-9d03-0adc-746d1ed62373@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/21 1:05 AM, Avi Kivity wrote:
> On 11/14/21 20:23, Jens Axboe wrote:
>> On 11/14/21 10:07 AM, Avi Kivity wrote:
>>> Running a trivial randread, direct=1 fio workload against a RAID-0
>>> composed of some nvme devices, I see this pattern:
>>>
>>>
>>>                fio-7066  [009]  1800.209865: function: io_submit_sqes
>>>                fio-7066  [009]  1800.209866: function:
>>> rcu_read_unlock_strict
>>>                fio-7066  [009]  1800.209866: function:
>>> io_submit_sqe
>>>                fio-7066  [009]  1800.209866: function:
>>> io_init_req
>>>                fio-7066  [009]  1800.209866:
>>> function:                      io_file_get
>>>                fio-7066  [009]  1800.209866:
>>> function:                         fget_many
>>>                fio-7066  [009]  1800.209866:
>>> function:                            __fget_files
>>>                fio-7066  [009]  1800.209867:
>>> function:                               rcu_read_unlock_strict
>>>                fio-7066  [009]  1800.209867: function:
>>> io_req_prep
>>>                fio-7066  [009]  1800.209867:
>>> function:                      io_prep_rw
>>>                fio-7066  [009]  1800.209867: function:
>>> io_queue_sqe
>>>                fio-7066  [009]  1800.209867:
>>> function:                      io_req_defer
>>>                fio-7066  [009]  1800.209867:
>>> function:                      __io_queue_sqe
>>>                fio-7066  [009]  1800.209868:
>>> function:                         io_issue_sqe
>>>                fio-7066  [009]  1800.209868:
>>> function:                            io_read
>>>                fio-7066  [009]  1800.209868:
>>> function:                               io_import_iovec
>>>                fio-7066  [009]  1800.209868:
>>> function:                               __io_file_supports_async
>>>                fio-7066  [009]  1800.209868:
>>> function:                                  I_BDEV
>>>                fio-7066  [009]  1800.209868:
>>> function:                               __kmalloc
>>>                fio-7066  [009]  1800.209868:
>>> function:                                  kmalloc_slab
>>>                fio-7066  [009]  1800.209868: function: __cond_resched
>>>                fio-7066  [009]  1800.209868: function:
>>> rcu_all_qs
>>>                fio-7066  [009]  1800.209869: function: should_failslab
>>>                fio-7066  [009]  1800.209869:
>>> function:                               io_req_map_rw
>>>                fio-7066  [009]  1800.209869:
>>> function:                         io_arm_poll_handler
>>>                fio-7066  [009]  1800.209869:
>>> function:                         io_queue_async_work
>>>                fio-7066  [009]  1800.209869:
>>> function:                            io_prep_async_link
>>>                fio-7066  [009]  1800.209869:
>>> function:                               io_prep_async_work
>>>                fio-7066  [009]  1800.209870:
>>> function:                            io_wq_enqueue
>>>                fio-7066  [009]  1800.209870:
>>> function:                               io_wqe_enqueue
>>>                fio-7066  [009]  1800.209870:
>>> function:                                  _raw_spin_lock_irqsave
>>>                fio-7066  [009]  1800.209870: function:
>>> _raw_spin_unlock_irqrestore
>>>
>>>
>>>
>>>   From which I deduce that __io_file_supports_async() (today named
>>> __io_file_supports_nowait) returns false, and therefore every io_uring
>>> operation is bounced to a workqueue with the resulting great loss in
>>> performance.
>>>
>>>
>>> However, I also see NOWAIT is part of the default set of flags:
>>>
>>>
>>> #define QUEUE_FLAG_MQ_DEFAULT   ((1 << QUEUE_FLAG_IO_STAT) |            \
>>>                                    (1 << QUEUE_FLAG_SAME_COMP) |          \
>>>                                    (1 << QUEUE_FLAG_NOWAIT))
>>>
>>> and I don't see that md touches it (I do see that dm plays with it).
>>>
>>>
>>> So, what's the story? does md not support NOWAIT? If so, that's a huge
>>> blow to io_uring with md. If it does, are there any clues about why I
>>> see requests bouncing to a workqueue?
>> That is indeed the story, dm supports it but md doesn't just yet.
> 
> 
> Ah, so I missed md clearing the default flags somewhere.
> 
> 
> This is a false negative from io_uring's point of view, yes? An md on 
> nvme would be essentially nowait in normal operation, it just doesn't 
> know it. aio on the same device would not block on the same workload.

There are still conditions where it can block, it just didn't in your
test case.

-- 
Jens Axboe

