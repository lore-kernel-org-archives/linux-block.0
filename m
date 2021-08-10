Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBBCC4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 13:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE1260295
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 13:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhHJN4f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbhHJN4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 09:56:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D9C061798
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 06:56:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso4487792pjb.2
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=umoh5/6IQIa7zDuK80XEuvvA4ETsM1msFfzxzPHJkew=;
        b=yxIWO6J3RO5BHpkybfI3ZNP3WdHc7rBWlLZG2qqFwQk1ALcjJoTvFnrBkb1ZlX2Drh
         cR660SeL73pwDfSD9ImJ3i/w39gW7wRnDodpqf+Xuib0i4tvJ0v4+4dz50djr62L9mGz
         REfW6Em8h7Qz61wgh0a6qrsQ4AUFiA0+MGwQFv3lOHcG42E8IbJcFxBc36bzCWMGbd/o
         WM00w8yYOvbYm38NHszsdCrau0UGPk4xR0kTNqApAzRO8kDgVnww+FkAsUmh+AKOGJIZ
         tY4hTPIPT0GyGUFxpgKkSvTvDGkraqUIZQ/FwPqkUKMaq2HhDv0ZD0ZqEfprHqGLW/Br
         1omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=umoh5/6IQIa7zDuK80XEuvvA4ETsM1msFfzxzPHJkew=;
        b=XGJcXqBT4ChhdXKg0Msc7t+Ev/j1HTgpSuP7O7uIHMmrZ2Nk96AnK6VON6nKsNXDEm
         ohZpAsZm4kyRVdF+6kYcwwpH8qPp8jBGkANPvLjKnBC+PrWqawF4YyCGSzzuNgaq5Ap2
         MKDkCd0UyPankMAGHGp8yF53gwkc1Cwnhz1fAuAJCDGdbAnX4x6APkt/rprxcUPDyk4d
         yfTwro4sZizFqCEorLqNuwA22DRqXe9S0jw3ZC7lgtPdTmZnmVlbkbVRA25zWleORnhy
         oBpWsM/d+iJa5Y1BYtiU7Y8RMy1CskZazIomGhHv2CWvVFlUu6PI+uWcipoKgUCpCEJ2
         HHAw==
X-Gm-Message-State: AOAM5311mewoW2cfPuU4eNZL/02C4/DBuMacgtk7N9tzpv5J1LgktTh0
        IVtbe7XmH3+2j4Gks6t2d+Q0IAAYNBuZitlk
X-Google-Smtp-Source: ABdhPJxv0udrj7CnLvtWWd62E0GYe6D5/3rPyadOkg9tPuF4naHjROKDDurBDFU66Z4tYEcEgfOvQQ==
X-Received: by 2002:a17:902:e786:b029:12d:2a7:365f with SMTP id cp6-20020a170902e786b029012d02a7365fmr15035087plb.21.1628603766879;
        Tue, 10 Aug 2021 06:56:06 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id mq7sm3577320pjb.50.2021.08.10.06.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 06:56:06 -0700 (PDT)
Subject: Re: [PATCH 4/4] block: enable use of bio allocation cache
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20210809212401.19807-1-axboe@kernel.dk>
 <20210809212401.19807-5-axboe@kernel.dk>
 <CA+1E3rKS+m6kuci7PmRw7LUbwVmF-ge6AV78SSnAkdegK0__Gw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7557849c-c23b-a6c6-b542-2335f10eafb1@kernel.dk>
Date:   Tue, 10 Aug 2021 07:56:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+1E3rKS+m6kuci7PmRw7LUbwVmF-ge6AV78SSnAkdegK0__Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/21 6:39 AM, Kanchan Joshi wrote:
> On Tue, Aug 10, 2021 at 6:40 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> If a kiocb is marked as being valid for bio caching, then use that to
>> allocate a (and free) new bio if possible.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/block_dev.c | 30 ++++++++++++++++++++++++++----
>>  1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 9ef4f1fc2cb0..36a3d53326c0 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -327,6 +327,14 @@ static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
>>         return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);
>>  }
>>
>> +static void dio_bio_put(struct blkdev_dio *dio)
>> +{
>> +       if (!dio->is_sync && (dio->iocb->ki_flags & IOCB_ALLOC_CACHE))
>> +               bio_cache_put(&dio->bio);
> 
> I think the second check (against IOCB_ALLOC_CACHE) is sufficient here.

Yes probably don't need the sync check here, I'll kill it.

-- 
Jens Axboe

