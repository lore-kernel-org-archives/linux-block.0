Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B655CC76196
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 16:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825BC21849
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 16:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dwYd3h6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbfGRQnw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:43:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40431 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRQnw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 12:43:52 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so52454359iom.7
        for <linux-block@vger.kernel.org>; Thu, 18 Jul 2019 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4S01q7PRC4bVy5u9EKoAHQNSU/W3Ucducv9jvcq+R/c=;
        b=dwYd3h6BgNhn8ktuVr4AFdXOQieeFTdWjs6agB43mlP/oFIlucpWO5zU4xVS0A1Lt1
         dKmK/93NCg3eByjtLdbFHLi7dwlfuxI04xZHTRvRX5iEu/gzAwbgXaC2o3tcixv9iBF9
         N5ERnRUrFl65XJei6YZjnaeK0xvamm9L/plinSfpTEMP4Nuf60jA/PRVL1pvZlROxZoU
         oRWIVwjQGe3O5NJG+8sEM6/nNeg5tiOHHbSWQpUjRVc9FaDjTyuuLuEaJc8lmBpiLgYc
         AxlHL9tz+J9GegF9jpmX9G8k2FIxrRiDU+JMkpkxnIEdjlggr42D3CAuwrNP6aAdCLz4
         ChDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4S01q7PRC4bVy5u9EKoAHQNSU/W3Ucducv9jvcq+R/c=;
        b=h5Tm8t3nhv874VpM/dXoiBq6z7jOnraUaAyhuVvbzJyxGHvQUXQOP+yox28yy9PsrU
         7SBtJM4s74L9FiIiBSfTnS1cfAK1QoelNHsDtBbbnjdFCCkDXJ8/vF+0V9jm8BfYyg5n
         mc3gGi9w+ujR++8l0MxgRArJqJsgr0n4+9Jsup/QZTBTg/25r6ea4qC+Mzcr8o1mCYC/
         lRaVcZYIkxFUuehBjqRDyltg3DlhufrLSqIGGX6H+Enp4mZyxnjObeuUSUSJX8RP9F/h
         YsFqFRzrXOf/1AY1AAjrnKxW2xwizwGBalDoTBCsBJsRSICtyJyjgbGtu9qVTiZ3twsG
         NHwg==
X-Gm-Message-State: APjAAAWgKCAwKRXy7yYFJ8hnd1SsG6mI862a2135F8tKZsPujE3C8+tM
        xZHZ55jcXjEt0kEao2pxKnRURVNic0s=
X-Google-Smtp-Source: APXvYqwcYPq7Bc2pJjnWwoLQKFDNttRtosyvPwUvWoY7Gt3a9fW+L9wFW1Ah/lWEFjnS+xY7U6zZ1A==
X-Received: by 2002:a5e:a710:: with SMTP id b16mr47449044iod.38.1563468231366;
        Thu, 18 Jul 2019 09:43:51 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p3sm30618089iom.7.2019.07.18.09.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 09:43:50 -0700 (PDT)
Subject: Re: [RFC PATCH] io_uring: add a memory barrier before atomic_read
From:   Jens Axboe <axboe@kernel.dk>
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-block@vger.kernel.org, liuyun01@kylinos.cn
References: <1563453840-19778-1-git-send-email-liuzhengyuan@kylinos.cn>
 <9b8f3de8-48c9-35e3-d985-00bad339b74d@kernel.dk>
Message-ID: <0c992e5e-e7f7-6b25-9347-04ec90e3e106@kernel.dk>
Date:   Thu, 18 Jul 2019 10:43:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9b8f3de8-48c9-35e3-d985-00bad339b74d@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/18/19 9:41 AM, Jens Axboe wrote:
> On 7/18/19 6:44 AM, Zhengyuan Liu wrote:
>> There is a hang issue while using fio to do some basic test. The issue can
>> been easily reproduced using bellow scripts:
>>
>>           while true
>>           do
>>                   fio  --ioengine=io_uring  -rw=write -bs=4k -numjobs=1 \
>>                        -size=1G -iodepth=64 -name=uring   --filename=/dev/zero
>>           done
>>
>> After serveral minutes, maybe more, fio would block at
>> io_uring_enter->io_cqring_wait in order to waiting for previously committed
>> sqes to be completed and cann't return to user anymore until we send a SIGTERM
>> to fio. After got SIGTERM, fio turns to hang at io_ring_ctx_wait_and_kill with
>> a backtrace like this:
>>
>>           [54133.243816] Call Trace:
>>           [54133.243842]  __schedule+0x3a0/0x790
>>           [54133.243868]  schedule+0x38/0xa0
>>           [54133.243880]  schedule_timeout+0x218/0x3b0
>>           [54133.243891]  ? sched_clock+0x9/0x10
>>           [54133.243903]  ? wait_for_completion+0xa3/0x130
>>           [54133.243916]  ? _raw_spin_unlock_irq+0x2c/0x40
>>           [54133.243930]  ? trace_hardirqs_on+0x3f/0xe0
>>           [54133.243951]  wait_for_completion+0xab/0x130
>>           [54133.243962]  ? wake_up_q+0x70/0x70
>>           [54133.243984]  io_ring_ctx_wait_and_kill+0xa0/0x1d0
>>           [54133.243998]  io_uring_release+0x20/0x30
>>           [54133.244008]  __fput+0xcf/0x270
>>           [54133.244029]  ____fput+0xe/0x10
>>           [54133.244040]  task_work_run+0x7f/0xa0
>>           [54133.244056]  do_exit+0x305/0xc40
>>           [54133.244067]  ? get_signal+0x13b/0xbd0
>>           [54133.244088]  do_group_exit+0x50/0xd0
>>           [54133.244103]  get_signal+0x18d/0xbd0
>>           [54133.244112]  ? _raw_spin_unlock_irqrestore+0x36/0x60
>>           [54133.244142]  do_signal+0x34/0x720
>>           [54133.244171]  ? exit_to_usermode_loop+0x7e/0x130
>>           [54133.244190]  exit_to_usermode_loop+0xc0/0x130
>>           [54133.244209]  do_syscall_64+0x16b/0x1d0
>>           [54133.244221]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> The reason is that we had added a req to ctx->pending_async at the very end, but
>> it got no chance to be processed anymore. How could this be happened?
>>
>>           fio#cpu0                                        wq#cpu1
>>
>>           io_add_to_prev_work                    io_sq_wq_submit_work
>>
>>             atomic_read() <<< 1
>>
>>                                                     atomic_dec_return() << 1->0
>>                                                     list_empty();    <<< true;
>>
>>             list_add_tail()
>>             atomic_read() << 0 or 1?
>>
>> As was said in atomic_ops.rst, atomic_read does not guarantee that the runtime
>> initialization by any other thread is visible yet, so we must take care of that
>> with a proper implicit or explicit memory barrier;
> 
> Thanks for looking at this and finding this issue, it does looks like a problem.
> But I'm not sure about the fix. Shouldn't we just need an smp_mb__after_atomic()
> on the atomic_dec_return() side of things? Like the below.
> 
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 5ec06e5ba0be..3c2a6f88a6b0 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1881,6 +1881,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>   	 */
>   	if (async_list) {
>   		ret = atomic_dec_return(&async_list->cnt);
> +		smp_mb__after_atomic();
>   		while (!ret && !list_empty(&async_list->list)) {
>   			spin_lock(&async_list->lock);
>   			atomic_inc(&async_list->cnt);
> @@ -1894,6 +1895,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>   				goto restart;
>   			}
>   			ret = atomic_dec_return(&async_list->cnt);
> +			smp_mb__after_atomic();
>   		}
>   	}
>   
> 

I don't think this is enough, I actually think your fix is the most
appropriate. I will apply it, thank you!

-- 
Jens Axboe

