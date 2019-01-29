Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA31C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CEB2184D
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vFJPoDA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfA2XvQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:51:16 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41916 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfA2XvQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 18:51:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so9475016pgq.8
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 15:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y9uGI6B2RKfKn/gudnCyWcTHbqcvqVA1jT3UdKe1Tkg=;
        b=vFJPoDA4D5Y2O1h/U4KRiHrme5wvZAACBwSuK7mlwuma0LJnFcK0P7XFiJWITB3/xJ
         2/9TF6Hz74cXH9+S6FD1Uv6RxaxC9HsSBdv1DoaZUsG7cRGm30jR9fw6TrQCIx1KWDUM
         SI51T4kTHL6Ceu2riX2qxOl1OsSFmsmQdRABiEgT5LkGWUjfm2SqfRFJalFjzN+qYLX0
         DndDBwkHI/jwFFngesGM0gzwomdsaHaqmo1Ny2G3OvesIaSYacxSZWNhNN0lO+6zzQ29
         WZ1kGOE4/LJO0jd1prS58c13JDrNP6oCD9FuLd7yKm0k9y9BefQ4AVzgQHthc1OclX1S
         0mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y9uGI6B2RKfKn/gudnCyWcTHbqcvqVA1jT3UdKe1Tkg=;
        b=rrFQTmiwk9thJgE5uhpG4PzNj3fWeTJIixlKGwmpG1wNM7uE+RqA+K6mEkM5AAe+8K
         yj5stHtS+ggvcI4au6jL7l1pZfAUShrpWde9J8t+R2QQnnYemHauMASU0733YIi2kRUF
         fiLusLPgZjyGicI9r3RSXyPATiipVss7xXGYh5HRh/Fl0Li0JAO+Bj9+enxSC3t+H0jr
         onT/lpttTzx6WYsNjB+5BopTjiykDNmT8XMaVYEyqwyMoyXSNcsOa8fbILuUljDw+vYl
         LfS3PRBCBFYVxbUpQpyQIu50SUjdS3fEXgRzfCTuWNZAkrbIazaB3cC0LiRHVV5uRiuJ
         1CQA==
X-Gm-Message-State: AJcUukdDvl4T7KM5Z4LG3OpuQLYszhhcFSPOcIm7QX/67De5+hBTcViS
        5OE4xaoZu156fGlDJgutuaLf8Q==
X-Google-Smtp-Source: ALg8bN4f3dYcehIOxCxrSUZbaUx/juH4vHNt1iZyBLR/L+EzpgomhavEKL3zmMbHHG6D5ssOI2BTkw==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr25072094pgf.87.1548805875632;
        Tue, 29 Jan 2019 15:51:15 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e24sm45330099pfi.153.2019.01.29.15.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:51:14 -0800 (PST)
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
 <87b25ce2-a5bc-3e81-ddba-5c932c71b40f@kernel.dk>
 <CAG48ez1m22z0Pqi0cT=UZdsA14SCM5579T1d40cZdyD6KqBw_g@mail.gmail.com>
 <379a631f-e55b-cc31-f84a-ace73fd66ea1@kernel.dk>
 <CAG48ez3Jtq3ka+cSVxQWjMLQU=YRqV2dJuq5Kp2Nx_YLz3FsNQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bfc062e8-7ff3-5003-1aa6-fb103aff06a0@kernel.dk>
Date:   Tue, 29 Jan 2019 16:51:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3Jtq3ka+cSVxQWjMLQU=YRqV2dJuq5Kp2Nx_YLz3FsNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 4:42 PM, Jann Horn wrote:
> On Wed, Jan 30, 2019 at 12:14 AM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/29/19 4:08 PM, Jann Horn wrote:
>>> On Wed, Jan 30, 2019 at 12:06 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>> On 1/29/19 4:03 PM, Jann Horn wrote:
>>>>> On Tue, Jan 29, 2019 at 11:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>> On 1/29/19 3:44 PM, Jann Horn wrote:
>>>>>>> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>> If we have fixed user buffers, we can map them into the kernel when we
>>>>>>>> setup the io_context. That avoids the need to do get_user_pages() for
>>>>>>>> each and every IO.
>>>>>>>>
>>>>>>>> To utilize this feature, the application must call io_uring_register()
>>>>>>>> after having setup an io_uring context, passing in
>>>>>>>> IORING_REGISTER_BUFFERS as the opcode. The argument must be a pointer
>>>>>>>> to an iovec array, and the nr_args should contain how many iovecs the
>>>>>>>> application wishes to map.
>>>>>>>>
>>>>>>>> If successful, these buffers are now mapped into the kernel, eligible
>>>>>>>> for IO. To use these fixed buffers, the application must use the
>>>>>>>> IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
>>>>>>>> set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
>>>>>>>> must point to somewhere inside the indexed buffer.
>>>>>>>>
>>>>>>>> The application may register buffers throughout the lifetime of the
>>>>>>>> io_uring context. It can call io_uring_register() with
>>>>>>>> IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
>>>>>>>> buffers, and then register a new set. The application need not
>>>>>>>> unregister buffers explicitly before shutting down the io_uring context.
> [...]
>> Just folded in this incremental, which should fix all the issues outlined
>> in your email.
>>
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 7364feebafed..d42541357969 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
> [...]
>> @@ -1602,6 +1605,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
>>
>>  static int io_sq_thread(void *data)
>>  {
>> +       struct io_uring_sqe lsqe[IO_IOPOLL_BATCH];
>>         struct sqe_submit sqes[IO_IOPOLL_BATCH];
>>         struct io_ring_ctx *ctx = data;
>>         struct mm_struct *cur_mm = NULL;
>> @@ -1701,6 +1705,14 @@ static int io_sq_thread(void *data)
>>                 i = 0;
>>                 all_fixed = true;
>>                 do {
>> +                       /*
>> +                        * Ensure sqe is stable between checking if we need
>> +                        * user access, and actually importing the iovec
>> +                        * further down the stack.
>> +                        */
>> +                       memcpy(&lsqe[i], sqes[i].sqe, sizeof(lsqe[i]));
>> +                       sqes[i].sqe = &lsqe[i];
>> +
> 
> What if io_submit_sqe() gets an -EAGAIN from __io_submit_sqe() and
> queues io_sq_wq_submit_work()? Could that cause io_sq_wq_submit_work()
> to read from io_sq_thread()'s lsge[i] while io_sq_thread() is already
> in the next loop iteration of the outer loop and has copied new data
> into lsge[i]?

Hmm yes. I think we'll need to both embed a pointer to an sqe into
sqe_submit, and an actual sqe. The former can be used in the fast
path, while the latter will be our copy for the offload path for
io_sq_thread() and io_sq_wq_submit_work().

-- 
Jens Axboe

