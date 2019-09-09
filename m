Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71915C433EF
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 11:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A7221920
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 11:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OwL0Twp+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NgsW2NOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfIILJf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:09:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40422 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbfIILJf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 07:09:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8E4EE6085C; Mon,  9 Sep 2019 11:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568027373;
        bh=m3siA6JilszddF3fgPt0elZMM0OUpjUCyOtl93+G9Hw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OwL0Twp+0hF+79kksWQwQQi9svFiuFA1VECSfhgqSzRBQFaR+q/V6+V1fvd8SIXPh
         i8IxzmBxoxXcWXVcpzqeOlVT+VaZv/I4uQhnQRqBSdFoJNWUX9ePBtJ3PsimW+CBoR
         fAMQ2DtjBbVxhEy1tg1TPS+ugKvWH1Wu5D6fenxo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 845DD6063A;
        Mon,  9 Sep 2019 11:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568027372;
        bh=m3siA6JilszddF3fgPt0elZMM0OUpjUCyOtl93+G9Hw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NgsW2NOweeZDIxorAFIKUbhZfXYb3wU88sMndMPNXEEXFI7m60vk5/6Dbe+1c0q90
         QyF0Q38sy79lSRnS3VXgU5cxFKKeGlWkCkFHxEP6FvtKF3SuIiQsGtp5kOqg5tU8aG
         1kX7d/8SJCdnmWcT5cqoxhvhP0Io7sdpP6t2lDmc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Sep 2019 16:39:32 +0530
From:   ppvk@codeaurora.org
To:     paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: APPS Crash - Page fault Execute error: PC =
 bfqg_stats_update_idle_time+0x14/0x50 LR = bfq_dispatch_request+0x398/0x948
In-Reply-To: <ade528d81fda9fe1d85b71ffb41c1aeb@codeaurora.org>
References: <ade528d81fda9fe1d85b71ffb41c1aeb@codeaurora.org>
Message-ID: <11509fcad34d67f5a87dd2bd21db6813@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Paolo,

Did you get a chance to take a look on this issue ?

Regards,
Pradeep

On 2019-09-06 21:09, ppvk@codeaurora.org wrote:
> Hi Paolo,
> 
> Good Evening!!
> 
> We started using BFQ IO Sched. from last 3 Months. it was awesome !!
> 
> Its been running great, but we just hit a "free-after-use" crash.
> We are running stability test (includes heavy IO, video playbacks etc)
> for 48~72hrs. We encountered below error. This crash is seen 2 to 3
> times during our stability testing.
> 
>    120.444910:   <6> binder: undelivered transaction 163882, process 
> died.
>    120.470254:   <6> binder: undelivered transaction 163953, process 
> died.
>    120.474841:   <6> Unable to handle kernel paging request at virtual
> address 006b6b6b6b6b7773
>    120.484651:   <6> Mem abort info:
>    120.487534:   <6>   ESR = 0x96000004
>    120.490680:   <6>   Exception class = DABT (current EL), IL = 32 
> bits
>    120.496760:   <6>   SET = 0, FnV = 0
>    120.499906:   <6>   EA = 0, S1PTW = 0
>    120.503145:   <6> Data abort info:
>    120.506111:   <6>   ISV = 0, ISS = 0x00000004
>    120.510056:   <6>   CM = 0, WnR = 0
>    120.513106:   <6> [006b6b6b6b6b7773] address between user and
> kernel address ranges
>    120.520437:   <6> Internal error: Oops: 96000004 [#1] PREEMPT SMP
>    120.522998:   <6> binder_alloc: 12672: binder_alloc_buf, no vma
>    120.526162:   <6> Modules linked in: wlan(O) machine_dlkm(O)
> wcd938x_slave_dlkm(O) wcd938x_dlkm(O) wcd9xxx_dlkm(O) mbhc_dlkm(O)
> tx_macro_dlkm(O) rx_macro_dlkm(O) va_macro_dlkm(O) wsa_macro_dlkm(O)
> swr_ctrl_dlkm(O) bolero_cdc_dlkm(O) wsa881x_dlkm(O) wcd_core_dlkm(O)
> stub_dlkm(O) hdmi_dlkm(O) swr_dlkm(O) pinctrl_lpi_dlkm(O) usf_dlkm(O)
> native_dlkm(O) platform_dlkm(O) q6_dlkm(O) adsp_loader_dlkm(O)
> apr_dlkm(O) snd_event_dlkm(O) q6_notifier_dlkm(O) q6_pdr_dlkm(O)
>    120.537723:   <6> binder: 1280:9939 transaction failed 29189/-3,
> size 80-0 line 3277
>    120.572951:   <6> Process kworker/4:1H (pid: 310, stack limit =
> 0xffffff8010670000)
>    120.572958:   <6> CPU: 4 PID: 310 Comm: kworker/4:1H Tainted: G S
>    W  O      4.19.66+ #1
>    120.572961:   <6> Hardware name: Qualcomm Technologies, Inc. Lito 
> MTP (DT)
>    120.572973:   <6> Workqueue: kblockd blk_mq_run_work_fn
>    120.572980:   <2> pstate: a0c00085 (NzCv daIf +PAN +UAO)
>    120.572988:   <2> pc : bfqg_stats_update_idle_time+0x14/0x50
>    120.572992:   <2> lr : bfq_dispatch_request+0x398/0x948
>    120.572995:   <2> sp : ffffff8010673bb0
>    120.572998:   <2> x29: ffffff8010673bc0 x28: 0000000000000001
>    120.573004:   <2> x27: 0000001c0c5e468f x26: fffffff6aa182a80
>    120.573011:   <2> x25: 0000000000000000 x24: fffffff6aa197a80
>    120.573018:   <2> x23: fffffff63feb4008 x22: 0000000000000001
>    120.573024:   <2> x21: fffffff6ab1eee08 x20: fffffff63feb4008
>    120.573030:   <2> x19: 6b6b6b6b6b6b6ad3 x18: 0000000000000004
>    120.573037:   <2> x17: 000000000000775f x16: 0000000000004e20
>    120.573043:   <2> x15: fffffff5dcd83d40 x14: 2faa9e9b959219ea
>    120.573049:   <2> x13: 0000000000000004 x12: 0000000089c9fa08
>    120.573056:   <2> x11: 2a768cc68edc0700 x10: 0000000000000000
>    120.573062:   <2> x9 : 0000000000000001 x8 : 6b6b6b6b6b6b6b6b
>    120.573069:   <2> x7 : ffffff943cfb1678 x6 : 0000000000000000
>    120.573075:   <2> x5 : 0000000000000080 x4 : 0000000000000001
>    120.573081:   <2> x3 : 0000000000000000 x2 : 0000000000000000
>    120.573087:   <2> x1 : 0000000000000000 x0 : 6b6b6b6b6b6b6ad3
>    120.573098:   <6>
>    :
>    :
>    121.185250:   <2> Call trace:
>    121.187772:   <2>  bfqg_stats_update_idle_time+0x14/0x50
>    121.192701:   <2>  bfq_dispatch_request+0x398/0x948
>    121.197188:   <2>  blk_mq_do_dispatch_sched+0x84/0x118
>    121.198271:   <6> CPU7: update max cpu_capacity 1024
>    121.206504:   <2>  blk_mq_sched_dispatch_requests+0x130/0x190
>    121.211874:   <2>  __blk_mq_run_hw_queue+0xcc/0x148
>    121.216359:   <2>  blk_mq_run_work_fn+0x24/0x30
>    121.220490:   <2>  process_one_work+0x328/0x6b0
>    121.224620:   <2>  worker_thread+0x330/0x4d0
>    121.228476:   <2>  kthread+0x128/0x138
>    121.231806:   <2>  ret_from_fork+0x10/0x1c
>    121.235484:   <6> Code: a9017bfd 910043fd aa0003f3 d503201f 
> (39728268)
>    121.241751:   <6> ---[ end trace 83177e232bbbf1f0 ]---
>    121.246514:   <6> Kernel panic - not syncing: Fatal exception
>    121.251896:   <6> SMP: stopping secondary CPUs
>    121.255938:   <6> CPU1: stopping
> 
> After doing code walk on bfq-iosched, i could see that in fn.
> bfq_dispatch_request()
> 
> in_serv_queue is assigned with bfqd->in_service_queue.
> 
> and after this, we are getting the request using 
> __bfq_dispatch_request() fn.
> 
> 
> In __bfq_dispatch_request() fn., we see that bfqd->in_service_queue is
> being updated via. __bfq_dispatch_request --> bfq_select_queue -->
> bfq_set_in_service_queue -->  __bfq_set_in_service_queue.
> I presumed that the in service queue time/budget got expired and it
> selected a new queue from a different service group.
> (If there are no more queues to be served, it could pick the new queue
> from it's next group of service tree.) during this updation, we are
> not updating the variable "in_serv_queue", we are passing same it to
> bfq_update_dispatch_stats() fn. and resulting in above crash while
> updating bfqg idle time stats.
> 
> 
> I also seen the comments written just above 
> bfgq_stats_update_idle_time() fn. as
> " Since the idle timer has been disabled, in_serv_queue contained some
> request when __bfq_dispatch_request
> was invoked above, which implies that rq was picked exactly from
> in_serv_queue. Thus in_serv_queue == bfqq,
> and is therefore guaranteed to exist because of the above arguments."
> 
> if it is so, can we suppose to use "bfqq" instead of "in_serv_queue"
> as bfqq is extracted from request "rq" and the "rq" is updated
> properly by __bfq_dispatch_request() fn. ?
> 
> Please correct me if my understanding was wrong.
> 
> Many thanks in advance !!
> 
> Best Regards,
> Pradeep
