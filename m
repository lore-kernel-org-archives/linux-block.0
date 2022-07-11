Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10180C43334
	for <linux-block@archiver.kernel.org>; Mon, 11 Jul 2022 17:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiGKRTL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiGKRTJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jul 2022 13:19:09 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE9F2716B
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 10:19:08 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n7so5540026ioo.7
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P/ZbOGRCMUCwsXJG1pP78JzJo4IAGqfVhKppLMaFBWM=;
        b=ZvTDraTPKziHCNOQfWr+33ekuim54lUPDbYxXKWE2zr0fyQjO4WKqYkf3iF4BtILw0
         VCqoW7E1KY3LOO1pTxYJ0SYrEUR++FL1cvVe+wvPBQUMYBFLPamH0VxWeH9EjxJVFNBm
         PJqUZtKL31NeUDwxCf4YJALbx4UYvgc3qfGgp3KqsclFq1wYPD5OWXhJUDvHkZgJoyaa
         NLbfin+YjfJAljGQ+F/veGiiTsDFYJccaJb7kWBNbd5aixAPtSoR/njWyKYmHVromzCI
         skH31e9ZZVQsBAVszOxqpFPqGMXXBwvnQlmSCASQEpzMStCHzL9g8lqUV8hcJBu9uDD+
         xnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P/ZbOGRCMUCwsXJG1pP78JzJo4IAGqfVhKppLMaFBWM=;
        b=CcsJsmI0zOC6Q7R2dKl5VbAXkapwI2tKN9F4bKbOtoT/CsIa+pp73FAIKjSmCOq353
         JewVtvt8UWiPnK3l7ZRxD3Azq7ij/gaxLUESTGd9Tptc800bHAvVUjO3ym17nXKRbpsc
         Fa4ACDYGxmG+V40R0Ls+1caA9PPADTc3K9sKOJoM0DDckLRUWGkNyMGS3ry7Zt8r5cdR
         7PE25LW5dvP2M5l5dIq0KN/Dd8NOAJxgA8+jzMZB+z05/Fo2Q4mMVBjypflhr91HvbJC
         jI34uVERKs34WAq1UoJ10WQVdfggduabVaolwwXvH1cExgbgMMiqpX/OiR5pIgjHYGnu
         lvEg==
X-Gm-Message-State: AJIora+jausr2teE/ZZI1Bk3D1QcMo2e9JbBPGBTnrruyBrpiwXslYgj
        Y9akhJMGO9s9q7hbAQH9a6ZDIQ==
X-Google-Smtp-Source: AGRyM1u0yeGaTkXY9HASGmsozNj1TOs2lYBlJZY0JUhajLVF/LQwTS5mu+PGSzQEJeHVH30LiVqwJg==
X-Received: by 2002:a02:c942:0:b0:339:ec11:d04e with SMTP id u2-20020a02c942000000b00339ec11d04emr10943258jao.174.1657559948356;
        Mon, 11 Jul 2022 10:19:08 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 11-20020a92180b000000b002dc3a66b4b7sm2923791ily.33.2022.07.11.10.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 10:19:07 -0700 (PDT)
Message-ID: <7ce5175e-c4dc-3af1-e47a-5966a999fdfe@kernel.dk>
Date:   Mon, 11 Jul 2022 11:19:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>,
        Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de,
        kbusch@kernel.org
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, asml.silence@gmail.com,
        joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
 <11db8ab2-b41a-967e-8653-7a84b8a984c0@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <11db8ab2-b41a-967e-8653-7a84b8a984c0@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/22 11:00 AM, Sagi Grimberg wrote:
> 
>> Use the leftover space to carve 'next' field that enables linking of
>> io_uring_cmd structs. Also introduce a list head and few helpers.
>>
>> This is in preparation to support nvme-mulitpath, allowing multiple
>> uring passthrough commands to be queued.
>>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> ---
>>   include/linux/io_uring.h | 38 ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
>> index 54063d67506b..d734599cbcd7 100644
>> --- a/include/linux/io_uring.h
>> +++ b/include/linux/io_uring.h
>> @@ -22,9 +22,14 @@ struct io_uring_cmd {
>>       const void    *cmd;
>>       /* callback to defer completions to task context */
>>       void (*task_work_cb)(struct io_uring_cmd *cmd);
>> +    struct io_uring_cmd    *next;
>>       u32        cmd_op;
>> -    u32        pad;
>> -    u8        pdu[32]; /* available inline for free use */
>> +    u8        pdu[28]; /* available inline for free use */
>> +};
> 
> I think io_uring_cmd will at some point become two cachelines and may
> not be worth the effort to limit a pdu to 28 bytes...


-- 
Jens Axboe

