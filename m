Return-Path: <SRS0=PH3O=VQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A794C7618F
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 00:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D582173B
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 00:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfGSAof convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:44:35 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:41254 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfGSAof (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 20:44:35 -0400
X-QQ-mid: bizesmtp20t1563497067txkf3law
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 19 Jul 2019 08:44:27 +0800 (CST)
X-QQ-SSF: 00400000002000Q0WP70000A0000000
X-QQ-FEAT: 3jlOKZxptE5LPSE/amu2+KmpbpefOI9Q2kwmWJVGsrejvt10kKAvrVg6l0ClB
        xxDAN7XhSMuaNhuyvg2KCEFKM1+0b6u5yrPmfl7Ykm2e+O9eM/8iBnnBOe8s49u/z1uP3U7
        BOGgHE529mQ0TncFqdzp0fpYEmDhgIArYGX5tXucoD5BODso3KQPtY+mWjHx+NkoFD8EFB2
        suCMapaIB23Ixq17KrrF97lYaUr2ncy0OYTj52wll1XlgVFSUlvAaIoVwZ4ALYCIE0E6HJX
        nr1i3SCvns9XSI69rsYtVAva2hLCkKqeixQi1DSNd0oaP132SoY/OWfNHbEsow7exnpdCEI
        bkZTrd6Fy65cFlxaYQ=
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH] io_uring: add a memory barrier before atomic_read
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <0c992e5e-e7f7-6b25-9347-04ec90e3e106@kernel.dk>
Date:   Fri, 19 Jul 2019 08:44:27 +0800
Cc:     =?gb2312?B?wfXV/dSq?= <liuzhengyuan@kylinos.cn>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1C57FBBB-1753-4C7C-8230-B569A98CF31D@kylinos.cn>
References: <1563453840-19778-1-git-send-email-liuzhengyuan@kylinos.cn>
 <9b8f3de8-48c9-35e3-d985-00bad339b74d@kernel.dk>
 <0c992e5e-e7f7-6b25-9347-04ec90e3e106@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> 在 2019年7月19日，00:43，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 7/18/19 9:41 AM, Jens Axboe wrote:
>> On 7/18/19 6:44 AM, Zhengyuan Liu wrote:
>>> There is a hang issue while using fio to do some basic test. The issue can
>>> been easily reproduced using bellow scripts:
>>> 
>>>          while true
>>>          do
>>>                  fio  --ioengine=io_uring  -rw=write -bs=4k -numjobs=1 \
>>>                       -size=1G -iodepth=64 -name=uring   --filename=/dev/zero
>>>          done
>>> 
>>> After serveral minutes, maybe more, fio would block at
>>> io_uring_enter->io_cqring_wait in order to waiting for previously committed
>>> sqes to be completed and cann't return to user anymore until we send a SIGTERM
>>> to fio. After got SIGTERM, fio turns to hang at io_ring_ctx_wait_and_kill with
>>> a backtrace like this:
>>> 
>>>          [54133.243816] Call Trace:
>>>          [54133.243842]  __schedule+0x3a0/0x790
>>>          [54133.243868]  schedule+0x38/0xa0
>>>          [54133.243880]  schedule_timeout+0x218/0x3b0
>>>          [54133.243891]  ? sched_clock+0x9/0x10
>>>          [54133.243903]  ? wait_for_completion+0xa3/0x130
>>>          [54133.243916]  ? _raw_spin_unlock_irq+0x2c/0x40
>>>          [54133.243930]  ? trace_hardirqs_on+0x3f/0xe0
>>>          [54133.243951]  wait_for_completion+0xab/0x130
>>>          [54133.243962]  ? wake_up_q+0x70/0x70
>>>          [54133.243984]  io_ring_ctx_wait_and_kill+0xa0/0x1d0
>>>          [54133.243998]  io_uring_release+0x20/0x30
>>>          [54133.244008]  __fput+0xcf/0x270
>>>          [54133.244029]  ____fput+0xe/0x10
>>>          [54133.244040]  task_work_run+0x7f/0xa0
>>>          [54133.244056]  do_exit+0x305/0xc40
>>>          [54133.244067]  ? get_signal+0x13b/0xbd0
>>>          [54133.244088]  do_group_exit+0x50/0xd0
>>>          [54133.244103]  get_signal+0x18d/0xbd0
>>>          [54133.244112]  ? _raw_spin_unlock_irqrestore+0x36/0x60
>>>          [54133.244142]  do_signal+0x34/0x720
>>>          [54133.244171]  ? exit_to_usermode_loop+0x7e/0x130
>>>          [54133.244190]  exit_to_usermode_loop+0xc0/0x130
>>>          [54133.244209]  do_syscall_64+0x16b/0x1d0
>>>          [54133.244221]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>> 
>>> The reason is that we had added a req to ctx->pending_async at the very end, but
>>> it got no chance to be processed anymore. How could this be happened?
>>> 
>>>          fio#cpu0                                        wq#cpu1
>>> 
>>>          io_add_to_prev_work                    io_sq_wq_submit_work
>>> 
>>>            atomic_read() <<< 1
>>> 
>>>                                                    atomic_dec_return() << 1->0
>>>                                                    list_empty();    <<< true;
>>> 
>>>            list_add_tail()
>>>            atomic_read() << 0 or 1?
>>> 
>>> As was said in atomic_ops.rst, atomic_read does not guarantee that the runtime
>>> initialization by any other thread is visible yet, so we must take care of that
>>> with a proper implicit or explicit memory barrier;
>> 
>> Thanks for looking at this and finding this issue, it does looks like a problem.
>> But I'm not sure about the fix. Shouldn't we just need an smp_mb__after_atomic()
>> on the atomic_dec_return() side of things? Like the below.
>> 
>> 
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 5ec06e5ba0be..3c2a6f88a6b0 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -1881,6 +1881,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>>  	 */
>>  	if (async_list) {
>>  		ret = atomic_dec_return(&async_list->cnt);
>> +		smp_mb__after_atomic();
>>  		while (!ret && !list_empty(&async_list->list)) {
>>  			spin_lock(&async_list->lock);
>>  			atomic_inc(&async_list->cnt);
>> @@ -1894,6 +1895,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>>  				goto restart;
>>  			}
>>  			ret = atomic_dec_return(&async_list->cnt);
>> +			smp_mb__after_atomic();
>>  		}
>>  	}
>> 
>> 
> 
> I don't think this is enough, I actually think your fix is the most
> appropriate. I will apply it, thank you!
> 

Actually, although we can passed test use smp_mb(), but in the end we still do not
understand where the race conditions are, could you explain it. If it is said as 
Zhengyuan, because of atomic_read, I think we should only need smp_rmb. but failed.
smp_rmb can't help us pass the test. At the same time, we have tried smp_wmb, failed too.
it seems that only smp_mb works correctly.

Is it because list_add_tail requires smp_wmb and atomic_read requires smp_rmb? 

--
Jackie Liu




