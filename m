Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BBCC433FE
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 23:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD58A60EBC
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 23:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhKAXEF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 19:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhKAXEF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 19:04:05 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4AC061764
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 16:01:30 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r194so23443836iod.7
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 16:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k5TM4KH99dM3hHBXqilkxnYCnw9teDhBlgbQBwvpAnI=;
        b=Iv7j9dgzCQHYNAWyFZGqdKFGeQ7DjuqM09ciVhI288XIZz0NTtbQ6ifQzDhldPsOVm
         TcfuPznM2G8/Qmc/SBdYba7+5oI3Pw8iu/GxquJHMgtOkFieUwzOj3PTA0WqUB4L8brN
         OQhIsOLh2ruEN3NpU1o1CkuRARJP3+VGln8lK9x6JrH1cP3ON685Pjxo0FNq/UyXzCjW
         lPsd+O6SPMi7SYHqoOUECk5dPY+RiLsmGwr0eTwoQVdN84t4L77Hb0iwMT+Yidg6oNKg
         XnVAsc2U05QbiOuNDMjo/7A/72qc09p4JzWNG87hFeRDky5WwhQusR89CStflCoiscLW
         YjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k5TM4KH99dM3hHBXqilkxnYCnw9teDhBlgbQBwvpAnI=;
        b=lje9YVvWuwQDnVmhRAZVUiKyvCLSZDwujSRr6fa4zzMr7+kHwIZBCR0OqLm/1/KDxq
         3LYGcVEp6uRLORZab9HQZetn5eP0fJXzo0+NK0oHI4I6otO6mPhsfTdLi5LEJYKkK2wu
         hhOKwU9TV2ngWYVW0YqYTwn6WS9inewboR7xWh43zZkiPxW5XMvvhgMxLh7CdSH+D2RD
         HinrxbNYYPIf6+6tQ3FUq3FX+mb8miQi3MMqXaFITdRVrQbiHOsN1TI/N1TqRV/8WM3w
         +FiiuzJAH+WcaTN/PMksXQyUQmE4XAlskdt/Yb173umZ2gr+1IMSa5KpBD/+2TdC3YwO
         MTjg==
X-Gm-Message-State: AOAM532JKlwiexn0E43pbpUcR7ehSSw9ONHkOE7Wf6mzD8utIf7Tdfk/
        nON+46QSWT/Y5Cebq7VVJdN7vQ==
X-Google-Smtp-Source: ABdhPJy8CUVbiIE+iAfz4h7ASi1w7al4dW3Mrt8Zf1J2aW9S+e3AijS1kaD2JtO+6JtVUjGBMmDovA==
X-Received: by 2002:a5d:9b0f:: with SMTP id y15mr23287040ion.5.1635807690377;
        Mon, 01 Nov 2021 16:01:30 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z7sm8093218ioj.38.2021.11.01.16.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 16:01:29 -0700 (PDT)
Subject: Re: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
From:   Jens Axboe <axboe@kernel.dk>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20211101083417.fcttizyxpahrcgov@shindev>
 <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
Message-ID: <f56c7b71-cef4-10be-7804-b171929cfb76@kernel.dk>
Date:   Mon, 1 Nov 2021 17:01:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/21 6:41 AM, Jens Axboe wrote:
> On 11/1/21 2:34 AM, Shinichiro Kawasaki wrote:
>> I tried the latest linux-block/for-next branch tip (git hash b43fadb6631f and
>> observed a process hang during blktests block/005 run on a NVMe device.
>> Kernel message reported "INFO: task check:1224 blocked for more than 122
>> seconds." with call trace [1]. So far, the hang is 100% reproducible with my
>> system. This hang is not observed with HDDs or null_blk devices.
>>
>> I bisected and found the commit 4f5022453acd ("nvme: wire up completion batching
>> for the IRQ path") triggers the hang. When I revert this commit from the
>> for-next branch tip, the hang disappears. The block/005 test case does IO
>> scheduler switch during IO, and the completion path change by the commit looks
>> affecting the scheduler switch. Comments for solution will be appreciated.
> 
> I'll take a look at this.

I've tried running various things most of the day, and I cannot
reproduce this issue nor do I see what it could be. Even if requests are
split between batched completion and one-by-one completion, it works
just fine for me. No special care needs to be taken for put_many() on
the queue reference, as the wake_up() happens for the ref going to zero.

Tell me more about your setup. What does the runtimes of the test look
like? Do you have all schedulers enabled? What kind of NVMe device is
this?

FWIW, this is upstream now, so testing with Linus -git would be
preferable.

-- 
Jens Axboe

