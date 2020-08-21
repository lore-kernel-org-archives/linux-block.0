Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA46EC433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C857E206DA
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgHUUUt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:20:49 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39609 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgHUUUr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 16:20:47 -0400
Received: by mail-pj1-f65.google.com with SMTP id j13so1287818pjd.4
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 13:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dJMzHfviirM1U8lBLyKGc//MVf+tB6J0uF/OqxxaWTw=;
        b=tz0maaeziq01K7eg6evDoOVULG4LQ6fLLHGWjZmQFpg/AvKkwaCMcvduZrn0CUxsbq
         cX+3pW3M1bowbhRYMlZf8LsAzjwqnJbYqdp6y8uslF7391SSDdHIiSU1lu/A+slzIw79
         /nuLgM2Etjwxi1MU1oSR6QCv1+BQvPl3RPvlWHeX4To2WF3ihDYYqArM2HTulwbTm89N
         xoGdqsqqpQxFqzxsZs4q9924/BvvRdL4VH0gZ8yf+8oQZuGTN9bev9AJB1/zU93u9kD1
         lWLempQQ3zLUYYbBjx4GsPUkWJUOgX7fgwRzZhOiSM3vVIrMR+xYozabwnWzcxYrd0iE
         xJUw==
X-Gm-Message-State: AOAM531GjraS87NCtIgh4MAWzHDmxe4RgZ/pLnaVBN4rTdic6+e/Kupj
        z4nEFM4z5hLPEpbIwTxBU2l5cWft6Tv0bQ==
X-Google-Smtp-Source: ABdhPJxFXJiwnVJXLTG0fTB1XlRaZIzywZpgTA9Id7ObhHVVrknMkK1ybYTt3ImA+BlbNcR1D415UQ==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr3877687pjg.197.1598041246812;
        Fri, 21 Aug 2020 13:20:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95a5:8a0f:6e94:b712? ([2601:647:4802:9070:95a5:8a0f:6e94:b712])
        by smtp.gmail.com with ESMTPSA id il13sm2583060pjb.0.2020.08.21.13.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 13:20:46 -0700 (PDT)
Subject: Re: [PATCH 2/3] nvme-core: fix deadlock when reconnect failed due to
 nvme_set_queue_count timeout
To:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com
References: <20200820035406.1720-1-lengchao@huawei.com>
 <20200821075034.GB30216@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dbf66315-9e36-2105-535e-a90352ec5306@grimberg.me>
Date:   Fri, 21 Aug 2020 13:20:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821075034.GB30216@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> A deadlock happens When we test nvme over roce with link blink. The
>> reason: link blink will cause error recovery, and then reconnect.If
>> reconnect fail due to nvme_set_queue_count timeout, the reconnect
>> process will set the queue count as 0 and continue , and then
>> nvme_start_ctrl will call nvme_enable_aen, and deadlock happens
>> because the admin queue is quiesced.
>>
>> log:
>> Aug  3 22:47:24 localhost kernel: nvme nvme2: I/O 22 QID 0 timeout
>> Aug  3 22:47:24 localhost kernel: nvme nvme2: Could not set queue count
>> (881)
>> stack:
>> root     23848  0.0  0.0      0     0 ?        D    Aug03   0:00
>> [kworker/u12:4+nvme-wq]
>> [<0>] blk_execute_rq+0x69/0xa0
>> [<0>] __nvme_submit_sync_cmd+0xaf/0x1b0 [nvme_core]
>> [<0>] nvme_features+0x73/0xb0 [nvme_core]
>> [<0>] nvme_start_ctrl+0xa4/0x100 [nvme_core]
>> [<0>] nvme_rdma_setup_ctrl+0x438/0x700 [nvme_rdma]
>> [<0>] nvme_rdma_reconnect_ctrl_work+0x22/0x30 [nvme_rdma]
>> [<0>] process_one_work+0x1a7/0x370
>> [<0>] worker_thread+0x30/0x380
>> [<0>] kthread+0x112/0x130
>> [<0>] ret_from_fork+0x35/0x40
>>
>> Many functions which call __nvme_submit_sync_cmd treat error code in two
>> modes: If error code less than 0, treat as command failed. If erroe code
>> more than 0, treat as target not support or other and continue.
>> NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both are cancled io
>> by host, is not the real error code return from target. So we need set
>> the flag:NVME_REQ_CANCELLED. Thus __nvme_submit_sync_cmd translate
>> the error to INTR, nvme_set_queue_count will return error, reconnect
>> process will terminate instead of continue.
> 
> But we could still race with a real completion.  I suspect the right
> answer is to translate NVME_SC_HOST_ABORTED_CMD and
> NVME_SC_HOST_PATH_ERROR to a negative error code in
> __nvme_submit_sync_cmd.

So the scheme you suggest is:
- treat any negative status or !DNR as "we never made it to
the target"
- Any positive status with DNR is a "controller generated status"

This will need a careful audit of all the call-sites we place such
assumptions...
