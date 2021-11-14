Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5C4C433F5
	for <linux-block@archiver.kernel.org>; Sun, 14 Nov 2021 18:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A11E60F51
	for <linux-block@archiver.kernel.org>; Sun, 14 Nov 2021 18:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhKNS0S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Nov 2021 13:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhKNS0O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Nov 2021 13:26:14 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17FCC061766
        for <linux-block@vger.kernel.org>; Sun, 14 Nov 2021 10:23:19 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id z26so18308114iod.10
        for <linux-block@vger.kernel.org>; Sun, 14 Nov 2021 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NEgiKsV/nj37AplLJghWcA2B0XU+8MeUnV382KJC88c=;
        b=imx4KobIejxnrqLWPj30+iofk0L684kSz1MxAyJiJMpAtLC008ntZwxRx+q9qaceES
         GW8y+Se3O7r3v0L4rODlTLW0J/mtzMYy3QHnWqRfiWm4HRkyOPcH7au8h5SsPdgnP60l
         /LR5r+y9v3dbfgBBGKsqG2XzJOmp0mExgkRpMlqiFEfLhF5V6wBFEz8Dcvi1QjiGNhW6
         iT3XYZGEZlAanAcQyYOjBRa1gUvxb9/s9gfvWRZadZTtdok3bKN713RayXCHV4/XxPyJ
         cWMokiPbaThil1cpDA2Dl9UYgadCzyZ6kTapnifUN8B+SCiaPvaGMGlo/N20VwiT1Yc6
         2aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NEgiKsV/nj37AplLJghWcA2B0XU+8MeUnV382KJC88c=;
        b=KFx0pCV+lBMD3L+EK4Dnp1wE1tKcaJncZEt7jKGHjeuG3S5U8X1NPoPizHst7TquHi
         bCgiH36Fr5P8ftNoySBI40iWCOOfkYCi0m3Z+1zUa7mJvtDLMqZaK5oju/dxa0rkeDgz
         vI+15gFqLK3ZibwAhvQilYhWp94KPVU0L7E0ZZlyG9MrKVICnLbSLuz4UnogVONhIG1f
         a9LQ9tmgFYW/rIv547XDv42T1twHf6ZVyMzVEWZ6Wl87pIMBsKWW3O/XBdsadN6kQ1jk
         YRWtzVB3OSGlMWTQquHYoHoLOJaNi4Hi+aXANKb+pzE1GQ80gL6Xni+P6LdVSziTKp72
         hVPQ==
X-Gm-Message-State: AOAM533IW1WMfo2pS7pNHLtdpE4fBuY5tDu6G3Cw5p2Uprx3GPEosW8u
        bVjezeA1bQZVHtl7JEzw2vvxeF86//JA1eCd
X-Google-Smtp-Source: ABdhPJy4eu4BtwxqwE1JL9gvA9qhfR51Px1qPs03jQYlNcy1wQXO+RJlQeFEtvkITQa0duh9sQchPA==
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr24450034jad.21.1636914198777;
        Sun, 14 Nov 2021 10:23:18 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h17sm7856235ilj.69.2021.11.14.10.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 10:23:18 -0800 (PST)
Subject: Re: raid0 vs io_uring
To:     Avi Kivity <avi@scylladb.com>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <c978931b-d3ba-89c7-52ef-30eddf740ba6@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ee22cbab-950f-cdb0-7ef0-5ea0fe67c628@kernel.dk>
Date:   Sun, 14 Nov 2021 11:23:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c978931b-d3ba-89c7-52ef-30eddf740ba6@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/21 10:07 AM, Avi Kivity wrote:
> Running a trivial randread, direct=1 fio workload against a RAID-0 
> composed of some nvme devices, I see this pattern:
> 
> 
>               fio-7066  [009]  1800.209865: function: io_submit_sqes
>               fio-7066  [009]  1800.209866: function:                
> rcu_read_unlock_strict
>               fio-7066  [009]  1800.209866: function:                
> io_submit_sqe
>               fio-7066  [009]  1800.209866: function:                   
> io_init_req
>               fio-7066  [009]  1800.209866: 
> function:                      io_file_get
>               fio-7066  [009]  1800.209866: 
> function:                         fget_many
>               fio-7066  [009]  1800.209866: 
> function:                            __fget_files
>               fio-7066  [009]  1800.209867: 
> function:                               rcu_read_unlock_strict
>               fio-7066  [009]  1800.209867: function:                   
> io_req_prep
>               fio-7066  [009]  1800.209867: 
> function:                      io_prep_rw
>               fio-7066  [009]  1800.209867: function:                   
> io_queue_sqe
>               fio-7066  [009]  1800.209867: 
> function:                      io_req_defer
>               fio-7066  [009]  1800.209867: 
> function:                      __io_queue_sqe
>               fio-7066  [009]  1800.209868: 
> function:                         io_issue_sqe
>               fio-7066  [009]  1800.209868: 
> function:                            io_read
>               fio-7066  [009]  1800.209868: 
> function:                               io_import_iovec
>               fio-7066  [009]  1800.209868: 
> function:                               __io_file_supports_async
>               fio-7066  [009]  1800.209868: 
> function:                                  I_BDEV
>               fio-7066  [009]  1800.209868: 
> function:                               __kmalloc
>               fio-7066  [009]  1800.209868: 
> function:                                  kmalloc_slab
>               fio-7066  [009]  1800.209868: function: __cond_resched
>               fio-7066  [009]  1800.209868: function:                
> rcu_all_qs
>               fio-7066  [009]  1800.209869: function: should_failslab
>               fio-7066  [009]  1800.209869: 
> function:                               io_req_map_rw
>               fio-7066  [009]  1800.209869: 
> function:                         io_arm_poll_handler
>               fio-7066  [009]  1800.209869: 
> function:                         io_queue_async_work
>               fio-7066  [009]  1800.209869: 
> function:                            io_prep_async_link
>               fio-7066  [009]  1800.209869: 
> function:                               io_prep_async_work
>               fio-7066  [009]  1800.209870: 
> function:                            io_wq_enqueue
>               fio-7066  [009]  1800.209870: 
> function:                               io_wqe_enqueue
>               fio-7066  [009]  1800.209870: 
> function:                                  _raw_spin_lock_irqsave
>               fio-7066  [009]  1800.209870: function: 
> _raw_spin_unlock_irqrestore
> 
> 
> 
>  From which I deduce that __io_file_supports_async() (today named 
> __io_file_supports_nowait) returns false, and therefore every io_uring 
> operation is bounced to a workqueue with the resulting great loss in 
> performance.
> 
> 
> However, I also see NOWAIT is part of the default set of flags:
> 
> 
> #define QUEUE_FLAG_MQ_DEFAULT   ((1 << QUEUE_FLAG_IO_STAT) |            \
>                                   (1 << QUEUE_FLAG_SAME_COMP) |          \
>                                   (1 << QUEUE_FLAG_NOWAIT))
> 
> and I don't see that md touches it (I do see that dm plays with it).
> 
> 
> So, what's the story? does md not support NOWAIT? If so, that's a huge 
> blow to io_uring with md. If it does, are there any clues about why I 
> see requests bouncing to a workqueue?

That is indeed the story, dm supports it but md doesn't just yet. It's
being worked on right now, though:

https://lore.kernel.org/linux-raid/20211101215143.1580-1-vverma@digitalocean.com/

Should be pretty simple, and then we can push to -stable as well.

-- 
Jens Axboe

