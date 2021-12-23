Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AD6C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 14:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbhLWONQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 09:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbhLWONP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 09:13:15 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B391C061401
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 06:13:15 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y70so7266939iof.2
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 06:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gdVfmYGq3Z7qrjMYIT/NmlP7WMp3LTABMfNNFMsFt48=;
        b=6Yzy/6kKs+2FpsKLGe2Povb8icl7PH4l/bEq7Ft2IXncFWXlJuuGvU45h3GkevypKX
         vBuLGsKSb6Auc9G3u83xIXKcnKDg4fbKYmr9GPlllkiq6TUWFFGZpVJTXgO880zlvG2s
         vbvv4YYVtkPRT6GbOZfRG+UWZhCgSkUJbCfXp6m7bWcrV/HsPIXyb03HXBnhm8lQRQhe
         FWNo9FGhPVX5qMs/rwB+CQVgXSPhesGQIb1JNUIsaKvVgas0g/4dz9SUgc/MXp52HbLj
         /A3ekAPxohaJeKb5qfahim2K8K9AKUf3zsfnDOTwzC7LDzuJc9QX4Cu/vPD0mDi6d3W9
         09ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gdVfmYGq3Z7qrjMYIT/NmlP7WMp3LTABMfNNFMsFt48=;
        b=vV6rN/tb6gQu5FfGGvZJxkWa0reDDNsmEudA/kfQGsu4v7OGaQ2ix7dCwJk2aFIOXI
         G9TtLJWJR9GhZ2pUazmenSoQkrbRFhMcQoTMarC2sd/pK65UeEl3KOD05aCSPKeWGv8W
         I7wCMwDkSy5Y3qIEdCknMOY6d4xm57R58M/O74u7FQtZIlL7H/nZUHBea5DkSJ1eodHq
         p8eCYnwAymgIfuXNSrDkD+h/BE8NQ1tmEDNoJ8CdMmeQYg2/AQSOzI8PaBlyyeBAizgm
         6ji70BOeCxHcmc6ythvRFoPUclGQ5MBaRpxgEm90iLyhOMCoVA03QAHyKj5J5el8NYcb
         +NNA==
X-Gm-Message-State: AOAM5330u+kmr4MPHJDQIuLO+gkhaAQrSxlT+vSONEWIIKBMG5DNx0Dz
        syR9Eulp0FV4I0jU5I8uxYP5Lg==
X-Google-Smtp-Source: ABdhPJylmesxiImGWWEubaY1Fjem9CdN1Bz9jPJn4kBoH2xqZPls4xhX8YazlXzR75NfUzrX1of+qw==
X-Received: by 2002:a02:9f92:: with SMTP id a18mr1313020jam.4.1640268794353;
        Thu, 23 Dec 2021 06:13:14 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b8sm3482777iow.2.2021.12.23.06.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 06:13:13 -0800 (PST)
Subject: Re: [PATCH 2/2] loop: use task_work for autoclear operation
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
References: <e9f59c70-5dc9-45ce-be93-9f149028f922@i-love.sakura.ne.jp>
 <9eff2034-2f32-54a3-e476-d0f609ab49c0@i-love.sakura.ne.jp>
 <da951c17-8a2f-4731-c34d-e08921824414@kernel.dk>
 <ae5848e6-aaeb-4f5a-ade7-f09d0f5d4d0b@i-love.sakura.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b6db3cb-a942-6fd6-fdbf-8f355103cb55@kernel.dk>
Date:   Thu, 23 Dec 2021 07:13:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ae5848e6-aaeb-4f5a-ade7-f09d0f5d4d0b@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/23/21 12:01 AM, Tetsuo Handa wrote:
> On 2021/12/23 0:56, Jens Axboe wrote:
>> On 12/22/21 8:27 AM, Tetsuo Handa wrote:
>>> The kernel test robot is reporting that xfstest can fail at
>>>
>>>   umount ext2 on xfs
>>>   umount xfs
>>>
>>> sequence, for commit 322c4293ecc58110 ("loop: make autoclear operation
>>> asynchronous") broke what commit ("loop: Make explicit loop device
>>> destruction lazy") wanted to achieve.
>>>
>>> Although we cannot guarantee that nobody is holding a reference when
>>> "umount xfs" is called, we should try to close a race window opened
>>> by asynchronous autoclear operation.
>>>
>>> Try to make the autoclear operation upon close() synchronous, by calling
>>> __loop_clr_fd() from current thread's task work rather than a WQ thread.
>>
>> Doesn't this potentially race with fput?
>>
> 
> What race?
> 
> loop_schedule_rundown() is called from lo_release() from blkdev_put()
> from blkdev_close() from __fput() from task_work_run(). And
> loop_schedule_rundown() calls kobject_get(&bdev->bd_device.kobj)
> before put_device() from blkdev_put_no_open() from blkdev_put() from
> blkdev_close() from __fput() from task_work_run() calls
> kobject_put(&bdev->bd_device.kobj).

Race is the wrong word, I mean ordering issues. If the fput happens
before you queue your task_work, then it'll be run before that.

-- 
Jens Axboe

