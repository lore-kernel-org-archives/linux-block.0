Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28821C10F14
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 13:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85942070B
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 13:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RtCcRutq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfJHNBu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:01:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35109 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHNBu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 09:01:50 -0400
Received: by mail-io1-f65.google.com with SMTP id q10so36291055iop.2
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2019 06:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=u+X5MfneS6nWwqvRcDHA7FUbb9javidkttifNgM1FnM=;
        b=RtCcRutqFpUI7GwS8dxocWVGJFMv9RfUwhQCaWlz9OvIl1sKBVC9ANt8IR63ZpaflJ
         1EyrBWet+JWRmEohX4i81FgOdC6EWHE3+5u7+KnnPZ5QHj6hrkt47K5QBfRlv5i4qsDV
         s/M1M3gCRlJOcgkRz2fIZqO8h5loayrZuj+gdOrmNzPcFdAI9Fsc/gfdB3JQTft5UCNb
         nz+ttfrwC2vK+IS+2NbQmNpjQuwzBz7c8o2icF6kXjsceMW2T9YMGgasoMwOB7r7GOAm
         lTzHWpJF4Sq1OkMuUzNiflAJ0vhtixKSrUAgzxJjFQIMxn/hNumlewB3QCwtpnSXYcKz
         S0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u+X5MfneS6nWwqvRcDHA7FUbb9javidkttifNgM1FnM=;
        b=rpcwLZ6uYPycXUAJBdUXacUqAgz5CCxnoLmd/bpaFcUrAIIDuslZW9r6iQ6MfAaJga
         P3rZyQ4jMeUGMi52UtFOOUTSbkUMFNvANkEXuNBts/gPCsgfAsCGuwnHyc92YoLZEXzt
         kvp1RFcSF0AUc7nPXENkdiNVKfbx9I+eP16xhcLSl5b+ci6w31nqQgYc3fbpgSA/XKEv
         9HAnYCwHLHr3idQuUbc6l+Mt1Fi1VFGjT1d9vxebq7Nry+juBGKNy7xXvxZojdF9C905
         Aiwk5PsleAhiW5zi0K3+eA65GhrtnJ6Qb3NWzoziXiN7zi7OPa6YD0+xCyjfR3gvvmWn
         KUqw==
X-Gm-Message-State: APjAAAXIZtPNiHvTzDgdim2yKttHDA8kqETS3g0ImfwFghfmH6ZOodIk
        gUGNhUiVTdi8NAsG5LQLYnpl2viBtT6i4w==
X-Google-Smtp-Source: APXvYqzCQRxLJ1nZHqXzzevVsZUQX0bb+TAL3+8bhCCiqxXHrZP14Noxsouny61FH7MNddqHmilivw==
X-Received: by 2002:a92:dc89:: with SMTP id c9mr33341596iln.215.1570539706572;
        Tue, 08 Oct 2019 06:01:46 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s78sm11387380ila.40.2019.10.08.06.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 06:01:43 -0700 (PDT)
Subject: Re: [RFC v1] io_uring: add io_uring_link trace event
To:     Dmitry Dolgov <9erthalion6@gmail.com>, linux-block@vger.kernel.org
References: <20191008125357.25265-1-9erthalion6@gmail.com>
 <CA+q6zcX1EiFVR8W=2rcFdb3mSRC7D+bfV44UeL5VFAvy2FEdvw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b86e5648-9464-1f1a-0faa-15b489fda26a@kernel.dk>
Date:   Tue, 8 Oct 2019 07:01:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+q6zcX1EiFVR8W=2rcFdb3mSRC7D+bfV44UeL5VFAvy2FEdvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/19 6:54 AM, Dmitry Dolgov wrote:
>> On Tue, Oct 8, 2019 at 2:52 PM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>>
>> To trace io_uring activity one can get an information from workqueue and
>> io trace events, but looks like some parts could be hard to identify.
>> E.g. it's not easy to figure out that one work was started after another
>> due to a link between them.
>>
>> For that purpose introduce io_uring_link trace event, that will be fired
>> when a request is added to a link_list.
>>
>> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
>> ---
>>   fs/io_uring.c                   |  4 ++++
>>   include/Kbuild                  |  1 +
>>   include/trace/events/io_uring.h | 42 +++++++++++++++++++++++++++++++++
>>   3 files changed, 47 insertions(+)
>>   create mode 100644 include/trace/events/io_uring.h
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index bfbb7ab3c4e..63e4b592d69 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -71,6 +71,9 @@
>>   #include <linux/sizes.h>
>>   #include <linux/hugetlb.h>
>>
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/io_uring.h>
>> +
>>   #include <uapi/linux/io_uring.h>
>>
>>   #include "internal.h"
>> @@ -2488,6 +2491,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
>>
>>                  s->sqe = sqe_copy;
>>                  memcpy(&req->submit, s, sizeof(*s));
>> +               trace_io_uring_link(&req->work, &prev->work);
>>                  list_add_tail(&req->list, &prev->link_list);
>>          } else if (s->sqe->flags & IOSQE_IO_LINK) {
>>                  req->flags |= REQ_F_LINK;
>> diff --git a/include/Kbuild b/include/Kbuild
>> index ffba79483cc..61b66725d25 100644
>> --- a/include/Kbuild
>> +++ b/include/Kbuild
>> @@ -1028,6 +1028,7 @@ header-test-                      += trace/events/fsi_master_gpio.h
>>   header-test-                   += trace/events/huge_memory.h
>>   header-test-                   += trace/events/ib_mad.h
>>   header-test-                   += trace/events/ib_umad.h
>> +header-test-                   += trace/events/io_uring.h
>>   header-test-                   += trace/events/iscsi.h
>>   header-test-                   += trace/events/jbd2.h
>>   header-test-                   += trace/events/kvm.h
>> diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
>> new file mode 100644
>> index 00000000000..56245c31a1e
>> --- /dev/null
>> +++ b/include/trace/events/io_uring.h
>> @@ -0,0 +1,42 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM io_uring
>> +
>> +#if !defined(_TRACE_IO_URING_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_IO_URING_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +/**
>> + * io_uring_link - called immediately before the io_uring work added into
>> + *                                link_list of the another request.
>> + * @work:                      pointer to linked struct work_struct
>> + * @target_work:       pointer to previous struct work_struct,
>> + *                                     that would contain @work
>> + *
>> + * Allows to track linked requests in io_uring.
>> + */
>> +TRACE_EVENT(io_uring_link,
>> +
>> +       TP_PROTO(struct work_struct *work, struct work_struct *target_work),
>> +
>> +       TP_ARGS(work, target_work),
>> +
>> +       TP_STRUCT__entry (
>> +               __field(  void *,       work                    )
>> +               __field(  void *,       target_work             )
>> +       ),
>> +
>> +       TP_fast_assign(
>> +               __entry->work                   = work;
>> +               __entry->target_work    = target_work;
>> +       ),
>> +
>> +       TP_printk("io_uring work struct %p linked after %p",
>> +                         __entry->work, __entry->target_work)
>> +);
>> +
>> +#endif /* _TRACE_IO_URING_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> --
>> 2.21.0
>>
> 
> If I'm missing something and it doesn't make sense, then I would be
> glad to hear if there are any best practices or ideas, and in general
> how to look at io_uring from the tracing point of view.

I think it makes sense, and in fact I'd encourage you to expand the
tracing so we can get better insight into io_uring doing what it should
be doing.

-- 
Jens Axboe

