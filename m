Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D50C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D617C2175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WyfoPTwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfA2XGl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:06:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36421 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfA2XGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 18:06:41 -0500
Received: by mail-io1-f66.google.com with SMTP id m19so17783746ioh.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 15:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qixUbvCMWRhLa+R4wv1WhtSBt9alr6ATtIhM9JOrdGA=;
        b=WyfoPTwt9vSq7ERVQ0OOLnOOapLjKkH9Dj6hcrBBDjexmNX3jazrGSKvO/xzzSNBj4
         uff3HZknR3sKCxV4Jd7mL5+IZ13RF4t99isaUE412CUMuGD3Fiv+Ick2U8aLwtH+iUD3
         bYEk9DN1QkVqmCKojO2jrIk/Hd2Nk84agsiWdrJlQn9KTEn51kB3g5mi0+8mmycn9E0e
         MNUAC4FA0H/tSS/gHuf4MSavRbU8DlTD5+j3/GsNjFl117RiyCz+nb5RhRU+sbo8u5gO
         7401Ql3UYpUOIjqDRyZ3NDizyQmNhGdznHXpxz5ARFO+ICHdrzX6HCCSxDGXpr8lubSU
         S9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qixUbvCMWRhLa+R4wv1WhtSBt9alr6ATtIhM9JOrdGA=;
        b=sMBVuLl07e1DXiOzTw2QM6qav1oowdzgpiQRg5wYn8yfAiqnAf7sjuO6OaSEz5TIaX
         wIJNe5qPuREZpDswhiLjEPOLeuoxuncBlPMHneHck+txO1hMriUSexeQxRzgE+yXI4bx
         Q0AbSJ5hHke/jeOH7PrpqXz/hlWu/ay8wfXn1eZNg+NuSW2HtSzzdGFB6BJN31XowRsc
         vlBp0Unmx4rF4fPVfT0eTu7TrFUcnNnck4M/ZkisfeSqX2wmLEggidPiwClXiyIJYlzT
         /LHgpX0A88sti/eK7s8Cj6pjsVIhY8/MCTuxVzx+g4BgRgFbGFgvhXr9DAnouz/ifFOS
         BK6A==
X-Gm-Message-State: AHQUAubqNZRzAMv57p6otxEOrprxPXxLkkbHNiPWgBTz45iVX4HJL6Ho
        MKP9r2n2xxX8eAZikKrUTzU9Yg==
X-Google-Smtp-Source: ALg8bN54shY4VsC8lCl1loTTCwr3ufqm4mtTVXe54N63E21N6wvRu3Lyg292Rix6JjkDxWaZo2/+uw==
X-Received: by 2002:a6b:6d15:: with SMTP id a21mr15949617iod.92.1548803199809;
        Tue, 29 Jan 2019 15:06:39 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c21sm15052045iob.22.2019.01.29.15.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:06:38 -0800 (PST)
Subject: Re: [PATCH 12/18] io_uring: add support for pre-mapped user IO
 buffers
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-13-axboe@kernel.dk>
 <CAG48ez2VkeSEZA+9H4UAcg86uC77gU=UkTG8L1V58TuR9pDEqg@mail.gmail.com>
 <dd366179-c003-752f-743d-2bea4f6b796c@kernel.dk>
 <CAG48ez3x5x+P=8L1p-bHvcUnypeT1TizkXq2+Q0bCP0GdE-bog@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87b25ce2-a5bc-3e81-ddba-5c932c71b40f@kernel.dk>
Date:   Tue, 29 Jan 2019 16:06:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3x5x+P=8L1p-bHvcUnypeT1TizkXq2+Q0bCP0GdE-bog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 4:03 PM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 11:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/29/19 3:44 PM, Jann Horn wrote:
>>> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> If we have fixed user buffers, we can map them into the kernel when we
>>>> setup the io_context. That avoids the need to do get_user_pages() for
>>>> each and every IO.
>>>>
>>>> To utilize this feature, the application must call io_uring_register()
>>>> after having setup an io_uring context, passing in
>>>> IORING_REGISTER_BUFFERS as the opcode. The argument must be a pointer
>>>> to an iovec array, and the nr_args should contain how many iovecs the
>>>> application wishes to map.
>>>>
>>>> If successful, these buffers are now mapped into the kernel, eligible
>>>> for IO. To use these fixed buffers, the application must use the
>>>> IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
>>>> set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
>>>> must point to somewhere inside the indexed buffer.
>>>>
>>>> The application may register buffers throughout the lifetime of the
>>>> io_uring context. It can call io_uring_register() with
>>>> IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
>>>> buffers, and then register a new set. The application need not
>>>> unregister buffers explicitly before shutting down the io_uring context.
> [...]
>>>> +       imu = &ctx->user_bufs[index];
>>>> +       buf_addr = READ_ONCE(sqe->addr);
>>>> +       if (buf_addr < imu->ubuf || buf_addr + len > imu->ubuf + imu->len)
>>>
>>> This can wrap around if `buf_addr` or `len` is very big, right? Then
>>> you e.g. get past the first check because `buf_addr` is sufficiently
>>> big, and get past the second check because `buf_addr + len` wraps
>>> around and becomes small.
>>
>> Good point. I wonder if we have a verification helper for something like
>> this?
> 
> check_add_overflow() exists, I guess that might help a bit. I don't
> think I've seen a more specific helper for this situation.

Hmm, not super appropriate. How about something ala:

if (buf_addr + len < buf_addr)
    ... overflow ...

?

-- 
Jens Axboe

