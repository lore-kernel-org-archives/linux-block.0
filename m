Return-Path: <SRS0=PH3O=VQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD00FC76188
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 14:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758872184E
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 14:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hu8g5NNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfGSOvZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:51:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34045 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfGSOvZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jul 2019 10:51:25 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so59034821iot.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jul 2019 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PKJKFhxQRTT1iyySATEFYb9epEIg/+jjIBl768vHUJ4=;
        b=hu8g5NNy4SEJERtfl0elfCqf5iZXCHiwnrxWI/pFDA7ZLboJvwbEhOdYFDOhl49Smn
         dmAnId9OnY8Hgia0IPkjeV5LGG76ZpB9QyuEN3uxvi63djAkk/pmB75LSHqCBr+rfjYo
         I6vsSE1Gj3cTbclCn/GpVbWWQa5stWsBmnGHZBBqcgbVJDv0COTnW8rY8xPL5ZfGaap3
         L7DFUB1D63d54ZhqjLOOKF4SWixdoEjT8SYiSUMqfrjf8otK2mk2icVvpZ7gwcDvkEDV
         ROlvycThaz/CdqtDhpqerGT3WsDQr5odwSJIS590I7aR2LSdHqYKcDR9JHcdaOkSfYD6
         Vaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PKJKFhxQRTT1iyySATEFYb9epEIg/+jjIBl768vHUJ4=;
        b=Q8+V3jyl6+y6j8zVUjSX9EcocxTeYUEfuvwzXrAB6YilmgELCIDnI19wIhiYf3w9sj
         b+OKJjN+79qTKxqRLqgdnsE0QOCgEFbdfN4lfoh3nEMSAPnK7e15PO0zbfQukWTDoVe4
         Si0GpTrOEH1kKA6x079qtNayixS2hSnX81HdCBjR5HFqCJGXY+fO3ZgP4bsvQBxRVovz
         0ADPh1QUqFr1XfgntiyoiyUcfxVeTdIDOhXig7px9JpB2jAIBhODtV3m7EDuyhhcZiF/
         s56AlZkGo6REyh7IFt1nQJWdmVKqZz7xLc6iQWC3msd2+QtH4LZ1u93xQgc53Tj/t4Er
         WrPA==
X-Gm-Message-State: APjAAAWRZHd80g9F6ln1vYBHAWktwKRLe0mcpPqQj3Dh3qIDvu+DiWCL
        QlqhTic2A5cgImlEKACsWPdLAuIvMh4=
X-Google-Smtp-Source: APXvYqwz5YJEi0sNxTf0JXfdCf5i4PByX5SPpTS0/wVnIgPu9LvVHhOi9cka+FQhCWCmkXyUsOUlwQ==
X-Received: by 2002:a6b:4101:: with SMTP id n1mr21514610ioa.138.1563547884454;
        Fri, 19 Jul 2019 07:51:24 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h19sm21304815iol.65.2019.07.19.07.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 07:51:23 -0700 (PDT)
Subject: Re: [RFC PATCH] io_uring: add a memory barrier before atomic_read
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>, source@stbuehler.de
Cc:     linux-block@vger.kernel.org, liuyun01@kylinos.cn
References: <1563453840-19778-1-git-send-email-liuzhengyuan@kylinos.cn>
 <9b8f3de8-48c9-35e3-d985-00bad339b74d@kernel.dk>
 <0c992e5e-e7f7-6b25-9347-04ec90e3e106@kernel.dk>
 <5d3114d7.1c69fb81.fc097.122eSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <60c4dd14-d353-1ce7-c1ae-7ac447b8adc3@kernel.dk>
Date:   Fri, 19 Jul 2019 08:51:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d3114d7.1c69fb81.fc097.122eSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/18/19 6:54 PM, Zhengyuan Liu wrote:
> 
> On 7/19/19 12:43 AM, Jens Axboe wrote:
>> On 7/18/19 9:41 AM, Jens Axboe wrote:
>>> On 7/18/19 6:44 AM, Zhengyuan Liu wrote:
>>>> There is a hang issue while using fio to do some basic test. The issue can
>>>> been easily reproduced using bellow scripts:
>>>>
>>>>             while true
>>>>             do
>>>>                     fio  --ioengine=io_uring  -rw=write -bs=4k -numjobs=1 \
>>>>                          -size=1G -iodepth=64 -name=uring   --filename=/dev/zero
>>>>             done
>>>>
>>>> After serveral minutes, maybe more, fio would block at
>>>> io_uring_enter->io_cqring_wait in order to waiting for previously committed
>>>> sqes to be completed and cann't return to user anymore until we send a SIGTERM
>>>> to fio. After got SIGTERM, fio turns to hang at io_ring_ctx_wait_and_kill with
>>>> a backtrace like this:
>>>>
>>>>             [54133.243816] Call Trace:
>>>>             [54133.243842]  __schedule+0x3a0/0x790
>>>>             [54133.243868]  schedule+0x38/0xa0
>>>>             [54133.243880]  schedule_timeout+0x218/0x3b0
>>>>             [54133.243891]  ? sched_clock+0x9/0x10
>>>>             [54133.243903]  ? wait_for_completion+0xa3/0x130
>>>>             [54133.243916]  ? _raw_spin_unlock_irq+0x2c/0x40
>>>>             [54133.243930]  ? trace_hardirqs_on+0x3f/0xe0
>>>>             [54133.243951]  wait_for_completion+0xab/0x130
>>>>             [54133.243962]  ? wake_up_q+0x70/0x70
>>>>             [54133.243984]  io_ring_ctx_wait_and_kill+0xa0/0x1d0
>>>>             [54133.243998]  io_uring_release+0x20/0x30
>>>>             [54133.244008]  __fput+0xcf/0x270
>>>>             [54133.244029]  ____fput+0xe/0x10
>>>>             [54133.244040]  task_work_run+0x7f/0xa0
>>>>             [54133.244056]  do_exit+0x305/0xc40
>>>>             [54133.244067]  ? get_signal+0x13b/0xbd0
>>>>             [54133.244088]  do_group_exit+0x50/0xd0
>>>>             [54133.244103]  get_signal+0x18d/0xbd0
>>>>             [54133.244112]  ? _raw_spin_unlock_irqrestore+0x36/0x60
>>>>             [54133.244142]  do_signal+0x34/0x720
>>>>             [54133.244171]  ? exit_to_usermode_loop+0x7e/0x130
>>>>             [54133.244190]  exit_to_usermode_loop+0xc0/0x130
>>>>             [54133.244209]  do_syscall_64+0x16b/0x1d0
>>>>             [54133.244221]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>
>>>> The reason is that we had added a req to ctx->pending_async at the very end, but
>>>> it got no chance to be processed anymore. How could this be happened?
>>>>
>>>>             fio#cpu0                                        wq#cpu1
>>>>
>>>>             io_add_to_prev_work                    io_sq_wq_submit_work
>>>>
>>>>               atomic_read() <<< 1
>>>>
>>>>                                                       atomic_dec_return() << 1->0
>>>>                                                       list_empty();    <<< true;
>>>>
>>>>               list_add_tail()
>>>>               atomic_read() << 0 or 1?
>>>>
>>>> As was said in atomic_ops.rst, atomic_read does not guarantee that the runtime
>>>> initialization by any other thread is visible yet, so we must take care of that
>>>> with a proper implicit or explicit memory barrier;
>>> Thanks for looking at this and finding this issue, it does looks like a problem.
>>> But I'm not sure about the fix. Shouldn't we just need an smp_mb__after_atomic()
>>> on the atomic_dec_return() side of things? Like the below.
>>>
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 5ec06e5ba0be..3c2a6f88a6b0 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -1881,6 +1881,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>>>     	 */
>>>     	if (async_list) {
>>>     		ret = atomic_dec_return(&async_list->cnt);
>>> +		smp_mb__after_atomic();
>>>     		while (!ret && !list_empty(&async_list->list)) {
>>>     			spin_lock(&async_list->lock);
>>>     			atomic_inc(&async_list->cnt);
>>> @@ -1894,6 +1895,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>>>     				goto restart;
>>>     			}
>>>     			ret = atomic_dec_return(&async_list->cnt);
>>> +			smp_mb__after_atomic();
>>>     		}
>>>     	}
>>>     
>>>
>> I don't think this is enough, I actually think your fix is the most
>> appropriate. I will apply it, thank you!
>>
> 
> Hi, Jens.
> I have tested you fix and the issue still existed. Actually the
> implementation of atomic_dec_return has been implicitly surrounded
> already by mb()  and as I know, smp_mb__after/before_atomic are not
> suitable for atomic_t operation which does not return a value.

We aren't guaranteed to see the atomic_dec_return() update if it happens
at the same time. So we can either force ordering with the smp_mb(), or
we can do something ala:

	if (!atomic_sub_return(0, &list->cnt)) {
		...

io_add_to_prev_work() to achieve the same sort of effect. That should
work as well.

-- 
Jens Axboe

