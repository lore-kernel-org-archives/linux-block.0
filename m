Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8482EC433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 12:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiCJMsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 07:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiCJMsH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 07:48:07 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9146A148910
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 04:47:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so5135233pju.2
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 04:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eUMVRHTpelVyqGOzGhRePfmdKILQxJ4a4eucCew4+K0=;
        b=a8jIx3UnGkc32da8Qm3ZD2r+sVcqAMA1vbYxehBvVFQyUu8xB+Mlap/amm6hKrNsvA
         XSY+KaejViPzOKb0YXfs5E6sUkIHryA/r6uFioqVz+xsO6zqnYdRvxXJ3Y8s5hb+r9LG
         LCxVWAMoR2vdwN2nfCjF4C3MjK6wpQWMl6ZPUwdsoLVG2nPZHE2qJ9vhZxbGJsCgAU5U
         w64IzIDhTv5ZDxacuOGm90z5ie4RW0msfDH7K8diJrvoAORdMF6XECEN57sydgqqoD+6
         pgmiG9vEzk9NaLQsDlvQZX2+9IUCung7sBNblE/cbxz33lfDK74w5iv/h4AlxnxVFLN8
         fefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eUMVRHTpelVyqGOzGhRePfmdKILQxJ4a4eucCew4+K0=;
        b=vPue0c3BYaEeDCgwAYWpukD9tMMEgNEVcz6QVdDbgZgUFq8gWL+9t/UAYe79ovEHeh
         TWZpcP4K2e0us96TaOJzw+QF2nF+iHNglKbfOeYrfpyvLdlbi9X96CrZbjLnJ79Z70dP
         kn5x42BdcbGiI8J1sffnRMPWJIS0dgNcG5trd9IdIgn3Qc/PolnZd5BU2Sii7A3YLLwI
         9V35/Ukm1HzZHLGSzV+2oAnv3+3+bo7YYnrIVHfgPboqlcTfz2mCtojLm9Q3PPg5ZSs0
         KtTM377JWhkOvCwj6jxU157EAw24oyf5yg3C/xV2Patl04owc0zq0bGMsl1gZaPrcO+T
         LNdg==
X-Gm-Message-State: AOAM5302WFSMnFTw/c7a0wTFWm1OgWjl38RLvw8qnaWVS3daJKrxR81+
        sPmgFSe/4FmKUol4+EFrVjrtrD+pBbjbpPsA
X-Google-Smtp-Source: ABdhPJwmyVOglkWnPpjBfOe3y6DkGftXjGEAqlf3L7FQuC33uhW5DeE0ODXo4knTogUD7CBGJZIQrA==
X-Received: by 2002:a17:902:7b8d:b0:14f:f1c2:9ff4 with SMTP id w13-20020a1709027b8d00b0014ff1c29ff4mr4733551pll.54.1646916425914;
        Thu, 10 Mar 2022 04:47:05 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x14-20020a17090ab00e00b001bf2d30ee9dsm9670433pjq.3.2022.03.10.04.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:47:05 -0800 (PST)
Message-ID: <a6d6b858-4bee-10da-884c-20b16e4ad0de@kernel.dk>
Date:   Thu, 10 Mar 2022 05:47:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20220310091649.zypaem5lkyfadymg@shindev> <YinMWPiuUluinom8@T590>
 <20220310124023.tkax52chul265bus@shindev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220310124023.tkax52chul265bus@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/22 5:40 AM, Shinichiro Kawasaki wrote:
> On Mar 10, 2022 / 18:00, Ming Lei wrote:
>> On Thu, Mar 10, 2022 at 09:16:50AM +0000, Shinichiro Kawasaki wrote:
>>> This issue does not look critical, but let me share it to ask comments for fix.
>>>
>>> When fio command with 40 jobs [1] is run for a null_blk device with memory
>>> backing and mq-deadline scheduler, kernel reports a BUG message [2]. The
>>> workqueue watchdog reports that kblockd blk_mq_run_work_fn keeps on running
>>> more than 30 seconds and other work can not run. The 40 fio jobs keep on
>>> creating many read requests to a single null_blk device, then the every time
>>> the mq_run task calls __blk_mq_do_dispatch_sched(), it returns ret == 1 which
>>> means more than one request was dispatched. Hence, the while loop in
>>> blk_mq_do_dispatch_sched() does not break.
>>>
>>> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>>> {
>>>         int ret;
>>>
>>>         do {
>>>                ret = __blk_mq_do_dispatch_sched(hctx);
>>>         } while (ret == 1);
>>>
>>>         return ret;
>>> }
>>>
>>> The BUG message was observed when I ran blktests block/005 with various
>>> conditions on a system with 40 CPUs. It was observed with kernel version
>>> v5.16-rc1 through v5.17-rc7. The trigger commit was 0a593fbbc245 ("null_blk:
>>> poll queue support"). This commit added blk_mq_ops.map_queues callback. I
>>> guess it changed dispatch behavior for null_blk devices and triggered the
>>> BUG message.
>>
>> It is one blk-mq soft lockup issue in dispatch side, and shouldn't be related
>> with 0a593fbbc245.
>>
>> If queueing requests is faster than dispatching, the issue will be triggered
>> sooner or later, especially easy to trigger in SQ device. I am sure it can
>> be triggered on scsi debug, even saw such report on ahci.
> 
> Thank you for the comments. Then this is the real problem.
> 
>>
>>>
>>> I'm not so sure if we really need to fix this issue. It does not seem the real
>>> world problem since it is observed only with null_blk. The real block devices
>>> have slower IO operation then the dispatch should stop sooner when the hardware
>>> queue gets full. Also the 40 jobs for single device is not realistic workload.
>>>
>>> Having said that, it does not feel right that other works are pended during
>>> dispatch for null_blk devices. To avoid the BUG message, I can think of two
>>> fix approaches. First one is to break the while loop in blk_mq_do_dispatch_sched
>>> using a loop counter [3] (or jiffies timeout check).
>>
>> This way could work, but the queue need to be re-run after breaking
>> caused by max dispatch number. cond_resched() might be the simplest way,
>> but it can't be used here because of rcu/srcu read lock.
> 
> As far as I understand, blk_mq_run_work_fn() should return after the loop break
> to yield the worker to other works. How about to call
> blk_mq_delay_run_hw_queue() at the loop break? Does this re-run the dispatch?
> 
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 55488ba978232..faa29448a72a0 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -178,13 +178,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  	return !!dispatched;
>  }
>  
> +#define MQ_DISPATCH_MAX 0x10000
> +
>  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  {
>  	int ret;
> +	unsigned int count = MQ_DISPATCH_MAX;
>  
>  	do {
>  		ret = __blk_mq_do_dispatch_sched(hctx);
> -	} while (ret == 1);
> +	} while (ret == 1 && count--);
> +
> +	if (ret == 1 && !count)
> +		blk_mq_delay_run_hw_queue(hctx, 0);
>  
>  	return ret;
>  }

Why not just gate it on needing to reschedule, rather than some random
value?

static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
{
	int ret;

	do {
		ret = __blk_mq_do_dispatch_sched(hctx);
	} while (ret == 1 && !need_resched());

	if (ret == 1 && need_resched())
		blk_mq_delay_run_hw_queue(hctx, 0);

	return ret;
}

or something like that.


-- 
Jens Axboe

