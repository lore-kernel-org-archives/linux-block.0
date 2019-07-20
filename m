Return-Path: <SRS0=aPd3=VR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C1BC76188
	for <linux-block@archiver.kernel.org>; Sat, 20 Jul 2019 15:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED672084C
	for <linux-block@archiver.kernel.org>; Sat, 20 Jul 2019 15:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OwAmTfF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfGTPTH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Jul 2019 11:19:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45710 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfGTPTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jul 2019 11:19:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so15417393pfq.12
        for <linux-block@vger.kernel.org>; Sat, 20 Jul 2019 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZEnAm48yTi9fnAzGiWdkJH19cisaISenTx3bYxKHZuc=;
        b=OwAmTfF8Y0HnuoueTlJ3pFgx+gDwVRW0Nsgwvh4vfA7jktgi2aY1XRTzn2VNFVQJPb
         hf++V9HRTLUlTYmXe6MTcTMVQtRUL3npbvatUstR2RWFRJFSf7dyQpoKX6Uxmu2ktSdI
         RXW6CMT9GWjAOueFqmQ8b7p5NQdO50Ly7Xa8GQyJgLd1FdTA9TQ8y8TgEu9me6R24ef7
         u8TiDcGhW6rex28jeRH0B6/aqv8Vh/SNOH6SETtPwdJ51pEyQItARCK/wG4rUNnf9mUA
         BLhAqsq+YF+E4IQ5AzUkZerAaSN8OJMWWVZzXZztDznipBH1Pq6W5Ij4uc3auNBOqnRW
         G6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZEnAm48yTi9fnAzGiWdkJH19cisaISenTx3bYxKHZuc=;
        b=lMFrEPQyOo8XV7CL8XFNw8aREx6aEyXP07rnuiBvy9ef/C+hLe7AB8SzIr/Z/8KbeV
         MNmIC5vgIMJpMrDEF8qSQ0LsrszeQwy2tQfxxL+nI4hDC+C96B2yGcfNo9vHci4xxjN/
         S2ZQJFU2ezRDL4q8lHngoeyPY2p2IMmHGSQLNPMJH34Kss0OuNhVUHCH/ygP4yrQSlf/
         Pwd8ZXpNt9p9F1GaBtvdlCIoPVeaiP9Tvu5QcthgOxrtWDXe8KUaVTHVu0In8//EKMZw
         PFHowmQ1/5/0bp9JyiDAJXrTIfcYp/K8cPoAqq2DORDZcJNIOYO6c6oHOms35TFYf8DY
         qzPQ==
X-Gm-Message-State: APjAAAUUi/A+IsKshXpikzZ2TvorREOnhzCiNN8fqhxjZB1zTNMUtZ3w
        sxfr6K/8mgKkBbgcEWajD0DDQPRq2KI=
X-Google-Smtp-Source: APXvYqwtBki9t4eFh9oGcZHQ0+twLcaZkCTPp8yHGJY6CufscJ0pRLU51A1LMSrB8veaChI07jQCcg==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr65729777pjt.29.1563635946607;
        Sat, 20 Jul 2019 08:19:06 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id e11sm41908514pfm.35.2019.07.20.08.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 08:19:05 -0700 (PDT)
Subject: Re: [RFC PATCH] io_uring: add a memory barrier before atomic_read
To:     Zhengyuan Liu <liuzhengyuang521@gmail.com>
Cc:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>, source@stbuehler.de,
        linux-block@vger.kernel.org,
        =?UTF-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>
References: <1563453840-19778-1-git-send-email-liuzhengyuan@kylinos.cn>
 <9b8f3de8-48c9-35e3-d985-00bad339b74d@kernel.dk>
 <0c992e5e-e7f7-6b25-9347-04ec90e3e106@kernel.dk>
 <5d3114d7.1c69fb81.fc097.122eSMTPIN_ADDED_BROKEN@mx.google.com>
 <60c4dd14-d353-1ce7-c1ae-7ac447b8adc3@kernel.dk>
 <CAOOPZo7XTf9-pvZ_yhS2cADe1o2Pym897JWbFAEm3WsuDMt=2g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3177f01a-e63e-ed45-6b7f-b31e3aa42c22@kernel.dk>
Date:   Sat, 20 Jul 2019 09:19:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOOPZo7XTf9-pvZ_yhS2cADe1o2Pym897JWbFAEm3WsuDMt=2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/19 9:14 AM, Zhengyuan Liu wrote:
> On Sat, Jul 20, 2019 at 2:27 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 7/18/19 6:54 PM, Zhengyuan Liu wrote:
>>>
>>> On 7/19/19 12:43 AM, Jens Axboe wrote:
>>>> On 7/18/19 9:41 AM, Jens Axboe wrote:
>>>>> On 7/18/19 6:44 AM, Zhengyuan Liu wrote:
>>>>>> There is a hang issue while using fio to do some basic test. The issue can
>>>>>> been easily reproduced using bellow scripts:
>>>>>>
>>>>>>              while true
>>>>>>              do
>>>>>>                      fio  --ioengine=io_uring  -rw=write -bs=4k -numjobs=1 \
>>>>>>                           -size=1G -iodepth=64 -name=uring   --filename=/dev/zero
>>>>>>              done
>>>>>>
>>>>>> After serveral minutes, maybe more, fio would block at
>>>>>> io_uring_enter->io_cqring_wait in order to waiting for previously committed
>>>>>> sqes to be completed and cann't return to user anymore until we send a SIGTERM
>>>>>> to fio. After got SIGTERM, fio turns to hang at io_ring_ctx_wait_and_kill with
>>>>>> a backtrace like this:
>>>>>>
>>>>>>              [54133.243816] Call Trace:
>>>>>>              [54133.243842]  __schedule+0x3a0/0x790
>>>>>>              [54133.243868]  schedule+0x38/0xa0
>>>>>>              [54133.243880]  schedule_timeout+0x218/0x3b0
>>>>>>              [54133.243891]  ? sched_clock+0x9/0x10
>>>>>>              [54133.243903]  ? wait_for_completion+0xa3/0x130
>>>>>>              [54133.243916]  ? _raw_spin_unlock_irq+0x2c/0x40
>>>>>>              [54133.243930]  ? trace_hardirqs_on+0x3f/0xe0
>>>>>>              [54133.243951]  wait_for_completion+0xab/0x130
>>>>>>              [54133.243962]  ? wake_up_q+0x70/0x70
>>>>>>              [54133.243984]  io_ring_ctx_wait_and_kill+0xa0/0x1d0
>>>>>>              [54133.243998]  io_uring_release+0x20/0x30
>>>>>>              [54133.244008]  __fput+0xcf/0x270
>>>>>>              [54133.244029]  ____fput+0xe/0x10
>>>>>>              [54133.244040]  task_work_run+0x7f/0xa0
>>>>>>              [54133.244056]  do_exit+0x305/0xc40
>>>>>>              [54133.244067]  ? get_signal+0x13b/0xbd0
>>>>>>              [54133.244088]  do_group_exit+0x50/0xd0
>>>>>>              [54133.244103]  get_signal+0x18d/0xbd0
>>>>>>              [54133.244112]  ? _raw_spin_unlock_irqrestore+0x36/0x60
>>>>>>              [54133.244142]  do_signal+0x34/0x720
>>>>>>              [54133.244171]  ? exit_to_usermode_loop+0x7e/0x130
>>>>>>              [54133.244190]  exit_to_usermode_loop+0xc0/0x130
>>>>>>              [54133.244209]  do_syscall_64+0x16b/0x1d0
>>>>>>              [54133.244221]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>>>
>>>>>> The reason is that we had added a req to ctx->pending_async at the very end, but
>>>>>> it got no chance to be processed anymore. How could this be happened?
>>>>>>
>>>>>>              fio#cpu0                                        wq#cpu1
>>>>>>
>>>>>>              io_add_to_prev_work                    io_sq_wq_submit_work
>>>>>>
>>>>>>                atomic_read() <<< 1
>>>>>>
>>>>>>                                                        atomic_dec_return() << 1->0
>>>>>>                                                        list_empty();    <<< true;
>>>>>>
>>>>>>                list_add_tail()
>>>>>>                atomic_read() << 0 or 1?
>>>>>>
>>>>>> As was said in atomic_ops.rst, atomic_read does not guarantee that the runtime
>>>>>> initialization by any other thread is visible yet, so we must take care of that
>>>>>> with a proper implicit or explicit memory barrier;
>>>>> Thanks for looking at this and finding this issue, it does looks like a problem.
>>>>> But I'm not sure about the fix. Shouldn't we just need an smp_mb__after_atomic()
>>>>> on the atomic_dec_return() side of things? Like the below.
>>>>>
>>>>>
>>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>>> index 5ec06e5ba0be..3c2a6f88a6b0 100644
>>>>> --- a/fs/io_uring.c
>>>>> +++ b/fs/io_uring.c
>>>>> @@ -1881,6 +1881,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>>>>>               */
>>>>>              if (async_list) {
>>>>>                      ret = atomic_dec_return(&async_list->cnt);
>>>>> +           smp_mb__after_atomic();
>>>>>                      while (!ret && !list_empty(&async_list->list)) {
>>>>>                              spin_lock(&async_list->lock);
>>>>>                              atomic_inc(&async_list->cnt);
>>>>> @@ -1894,6 +1895,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>>>>>                                      goto restart;
>>>>>                              }
>>>>>                              ret = atomic_dec_return(&async_list->cnt);
>>>>> +                   smp_mb__after_atomic();
>>>>>                      }
>>>>>              }
>>>>>
>>>>>
>>>> I don't think this is enough, I actually think your fix is the most
>>>> appropriate. I will apply it, thank you!
>>>>
>>>
>>> Hi, Jens.
>>> I have tested you fix and the issue still existed. Actually the
>>> implementation of atomic_dec_return has been implicitly surrounded
>>> already by mb()  and as I know, smp_mb__after/before_atomic are not
>>> suitable for atomic_t operation which does not return a value.
>>
>> We aren't guaranteed to see the atomic_dec_return() update if it happens
>> at the same time. So we can either force ordering with the smp_mb(), or
>> we can do something ala:
>>
>>          if (!atomic_sub_return(0, &list->cnt)) {
>>                  ...
>>
>> io_add_to_prev_work() to achieve the same sort of effect. That should
>> work as well.
> 
> Yeah,  but I'd prefer smp_mb(), since atomic_sub_return(0, &list->cnt) isn't
> such clear.

In some ways I actually think it's more clear, as it makes it explicit
what we're synchronizing with, and it's then up to the atomic primitives
to use the right barrier. But I'm fine with the smp_mb() and that's what
I already queued up, so let's just stick with that.

-- 
Jens Axboe

