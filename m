Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CB4C7EE25
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 21:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjEMVPl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 17:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjEMVPk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 17:15:40 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF706199A
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 14:15:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a69e101070so21623695ad.1
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684012536; x=1686604536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hzp0Qb4mDjpD9Mou4KpzPLwzl2YJnM4HCnwQameMVSA=;
        b=u+UIGW/roPHFNYjPZUnKJd/1sa6U0JXTsngOmVp+K/nS33JPdGdV3WbT813Z/FkHfA
         JBMcpMYbO0sQOwpv443zxUMTIhB7i2tCfnBQpTJ/i2MGPJMPKr2xhCr8mL9d2Vtb6Vx7
         3Sf98c6PcfzTu39+AehjlHwXdSiiXH5Bwbx1JZcaUSkg4pn2NClGifNxazyBhPRvY5lV
         2Dw9y8bv55T3PXCBING/VbL6ZhBhyNTP91cmX6x7ClsdsTkmcJRFdPCFJ4YFv0MgyJKi
         vRPj9VCkLJ6BV/WLjevo6TO6I5x3IJKXQRFwp/SmGixv/g8/8ihdNoqvG7nu8FNXN6IS
         pzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684012536; x=1686604536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hzp0Qb4mDjpD9Mou4KpzPLwzl2YJnM4HCnwQameMVSA=;
        b=FWxBLnXJhuA9IQ60I6WKa/fEKXk9eABzprXGEBAtBAew1ck83SnFJJXdu2RnHMM7bb
         QC5OZKHCFu/pjmzBKGHJWoWXYjMmfs2VDD8ZDMY7K2iLBLqq+TTxHgztXUcHvt9f6s+O
         +c+uaYeh5yPcr9UgEzo+5omk6k//bZmSsLol9nBmzJ2kbJi6yBlywKjnkbfmvoYwXk3L
         ZNMhHT6+so9Meh4t851+Sebf0v4CuVFts8+fO+xRkBqQ8lVpl8njwV0DoKTgA3lpqo/S
         ebUR2IBgPe1CpXdZBTeqogPnvZE+KV9UW6UvaNEQvTdrDqQoWU7N+/w/PZd7urDpcqWT
         OWWQ==
X-Gm-Message-State: AC+VfDy6524KkFNkDhxVRbkMdWDL+EolDCcplzNC2UzcHbNgvB0PSJA/
        KgP/AZNf4Qp/XYsLsXUQZO2vfQ==
X-Google-Smtp-Source: ACHHUZ4BC4ek84IpPhjvOy57FgGhRfINtnLd1MrDEoLu0t6EYcK6DS+tm2JSEf9Pcva+q8iA2FmgTA==
X-Received: by 2002:a17:902:d4c4:b0:1ac:40f7:8b5a with SMTP id o4-20020a170902d4c400b001ac40f78b5amr33972856plg.3.1684012536347;
        Sat, 13 May 2023 14:15:36 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001ab13f1fa82sm10260662pll.85.2023.05.13.14.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 14:15:35 -0700 (PDT)
Message-ID: <892f5292-884b-42ef-fe24-05cfac56e527@kernel.dk>
Date:   Sat, 13 May 2023 15:15:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>, Tian Lan <tilan7663@gmail.com>
Cc:     lkp@intel.com, linux-block@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, tian.lan@twosigma.com
References: <202305140021.WvuGBjaZ-lkp@intel.com>
 <20230513190534.331274-1-tilan7663@gmail.com> <ZF/4/k+u3h2fXgHU@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZF/4/k+u3h2fXgHU@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/23 2:54?PM, Simon Horman wrote:
> On Sat, May 13, 2023 at 03:05:34PM -0400, Tian Lan wrote:
>> From: Tian Lan <tian.lan@twosigma.com>
>>
>> The nr_active counter continues to increase over time which causes the
>> blk_mq_get_tag to hang until the thread is rescheduled to a different
>> core despite there are still tags available.
>>
>> kernel-stack
>>
>>   INFO: task inboundIOReacto:3014879 blocked for more than 2 seconds
>>   Not tainted 6.1.15-amd64 #1 Debian 6.1.15~debian11
>>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>   task:inboundIOReacto state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
>>     Call Trace:
>>     <TASK>
>>     __schedule+0x351/0xa20
>>     scheduler+0x5d/0xe0
>>     io_schedule+0x42/0x70
>>     blk_mq_get_tag+0x11a/0x2a0
>>     ? dequeue_task_stop+0x70/0x70
>>     __blk_mq_alloc_requests+0x191/0x2e0
>>
>> kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
>> __blk_mq_free_request being called.
>>
>>   320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0 in-flight 1
>>          b'__blk_mq_free_request+0x1 [kernel]'
>>          b'bt_iter+0x50 [kernel]'
>>          b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
>>          b'blk_mq_timeout_work+0x7c [kernel]'
>>          b'process_one_work+0x1c4 [kernel]'
>>          b'worker_thread+0x4d [kernel]'
>>          b'kthread+0xe6 [kernel]'
>>          b'ret_from_fork+0x1f [kernel]'
>>
>> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
>> ---
>>  block/blk-mq.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 9c8dc70020bc..732a39d88cd6 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -716,6 +716,10 @@ static void __blk_mq_free_request(struct request *rq)
>>  	blk_crypto_free_request(rq);
>>  	blk_pm_mark_last_busy(rq);
>>  	rq->mq_hctx = NULL;
>> +
>> +	if (rq->rq_flags & RQF_MQ_INFLIGHT)
>> +		__blk_mq_dec_active_requests(hctx);
>> +
>>  	if (rq->tag != BLK_MQ_NO_TAG)
>>  		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
>>  	if (sched_tag != BLK_MQ_NO_TAG)
>> @@ -733,9 +737,6 @@ void blk_mq_free_request(struct request *rq)
>>  	    q->elevator->type->ops.finish_request)
>>  		q->elevator->type->ops.finish_request(rq);
>>  
>> -	if (rq->rq_flags & RQF_MQ_INFLIGHT)
>> -		__blk_mq_dec_active_requests(hctx);
>> -
> 
> Unless I am mistaken, hctx is now unused in this function.

Indeed. Tian, first one didn't compile and this one will most certainly
spew a warning. That's 2 for 2 so far. I realize that you tested this
one a different kernel in prod, but don't seen stuff you haven't even
compiled.

-- 
Jens Axboe

