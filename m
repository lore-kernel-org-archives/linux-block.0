Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE56C433FE
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 12:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJEMT1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 08:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJEMTZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 08:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E824153D32
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664972364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0IP2Q/SFyk+E5joRy/Gl92dMItD+kKxqDH/MwB9IYM=;
        b=Pxti1PtjtO/83ZO9UWEg/iXyt92LpUCnIN/cvdqsEOCgzWphcB3DlAI+H/z17b4FxVPcei
        KNj8/pV3+bxbxsdL7btvVvnF2kWDxyIlVaIhpNdgolGPwzTwgurmc0Xa0zqYbeY/RphL/y
        2bZhsC+JsXr7DxgfDHIsQLAW0aOQXwk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-U-SgOxvYPBuVlx-SfBxGKg-1; Wed, 05 Oct 2022 08:19:22 -0400
X-MC-Unique: U-SgOxvYPBuVlx-SfBxGKg-1
Received: by mail-wm1-f69.google.com with SMTP id z14-20020a05600c220e00b003be0a6b3b13so312226wml.8
        for <linux-block@vger.kernel.org>; Wed, 05 Oct 2022 05:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0IP2Q/SFyk+E5joRy/Gl92dMItD+kKxqDH/MwB9IYM=;
        b=mNkWTzEdr0b82T7BkTLQkgKSidWCsUJQip27Zfr1lE3cchlXyd8vyT9m+ofFi8PXk0
         hW9DGusI/X2as81Nx1uydzpbe8RPCvo+T6Bh91LnWuv87bgf16gfmn8Z2mfwPFyzMP4R
         jfJYM01PsfhrsgEXSDoWQ8/4bKEAW9SA5Kuiw8mk6Cy2UocUaDDffsv6fa5y0Z7AUUCN
         d5HtZCgnkbdS1ftOZaL78extuceZm97TSJyJpAg0FEEAYvt7MHCI1VLa9B5mVnO+MB/0
         KcgenBZh6PdfHNe9ok5E/gtYON1LgUrTvo3Fskwo4vYeYienNVbJibQTEMW669eAewey
         5MEg==
X-Gm-Message-State: ACrzQf1gddoMyRCFI7Wxv6OxkOgpQIh2WlqP0ZHxoOv12z4OV/xje2En
        wtv4jxbPzznmV/hV68iSeMRjzy9AfvRpzwAtfkjfA54n1IQIiJ+EMwCfw7ezq2Ah/H8GBEXAodY
        MKVSalFauTeeKmWbbKL34DWI=
X-Received: by 2002:a05:600c:3b8c:b0:3b4:8ad1:d894 with SMTP id n12-20020a05600c3b8c00b003b48ad1d894mr3140335wms.113.1664972361812;
        Wed, 05 Oct 2022 05:19:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM66bVwTHS3ezLO9XJqEXHFj4hjLkIIwdQIbGvhgdXuFEVfqrQZOAb1/bfpx9fSGV5jtlxazSA==
X-Received: by 2002:a05:600c:3b8c:b0:3b4:8ad1:d894 with SMTP id n12-20020a05600c3b8c00b003b48ad1d894mr3140317wms.113.1664972361616;
        Wed, 05 Oct 2022 05:19:21 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003b477532e66sm9478522wms.2.2022.10.05.05.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 05:19:20 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH bitmap-for-next 1/5] blk_mq: Fix cpumask_check() warning
 in blk_mq_hctx_next_cpu()
In-Reply-To: <Yzshzw6hKhbtdxSd@yury-laptop>
References: <20221003153420.285896-1-vschneid@redhat.com>
 <20221003153420.285896-2-vschneid@redhat.com>
 <Yzshzw6hKhbtdxSd@yury-laptop>
Date:   Wed, 05 Oct 2022 13:19:20 +0100
Message-ID: <xhsmha66a31kn.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/10/22 10:54, Yury Norov wrote:
> On Mon, Oct 03, 2022 at 04:34:16PM +0100, Valentin Schneider wrote:
>> A recent commit made cpumask_next*() trigger a warning when passed
>> n = nr_cpu_ids - 1. This means extra care must be taken when feeding CPU
>> numbers back into cpumask_next*().
>>
>> The warning occurs nearly every boot on QEMU:
>
> [...]
>
>> Fixes: 78e5a3399421 ("cpumask: fix checking valid cpu range")
>
> No! It fixes blk-mq bug, which has been revealed after 78e5a3399421.
>
>> Suggested-by: Yury Norov <yury.norov@gmail.com>
>
> OK, maybe I suggested something like this. But after looking into the code
> of blk_mq_hctx_next_cpu() code for more, I have a feeling that this should
> be overridden deeper.
>
> Can you check - did this warning raise because hctx->next_cpu, or
> because cpumask_next_and() was called twice after jumping on
> select_cpu label?
>

It seems to always happen when hctx->next_cpu == nr_cpu_ids-1 at the start
of the function - no jumping involved.

>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  block/blk-mq.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index c96c8c4f751b..30ae51eda95e 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2046,8 +2046,13 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>>
>>      if (--hctx->next_cpu_batch <= 0) {
>>  select_cpu:
>
> Because we have backward looking goto, I have a strong feeling that the
> code should be reorganized.
>
>> -		next_cpu = cpumask_next_and(next_cpu, hctx->cpumask,
>> -				cpu_online_mask);
>> +		if (next_cpu == nr_cpu_ids - 1)
>> +			next_cpu = nr_cpu_ids;
>> +		else
>> +			next_cpu = cpumask_next_and(next_cpu,
>> +						    hctx->cpumask,
>> +						    cpu_online_mask);
>> +
>>              if (next_cpu >= nr_cpu_ids)
>>                      next_cpu = blk_mq_first_mapped_cpu(hctx);
>
> This simply means 'let's start from the beginning', and should be
> replaced with cpumask_next_and_wrap().

I hadn't looked in depth there, but that's a strange behaviour.
If we get to the end of the cpumask, blk_mq_first_mapped_cpu() does:

        int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);

        if (cpu >= nr_cpu_ids)
                cpu = cpumask_first(hctx->cpumask);
        return cpu;

That if branch means the returned CPU is offline, which then triggers:

        if (!cpu_online(next_cpu)) {
                if (!tried) {
                        tried = true;
                        goto select_cpu;
                }

but going back to select_cpu doesn't make much sense, we've already checked
that hctx->cpumask and cpu_online_mask were disjoint.

>
>>              hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
>
>
> Maybe something like this would work?
>
>         if (--hctx->next_cpu_batch > 0 && cpu_online(next_cpu)) {
>                 hctx->next_cpu = next_cpu;
>                 return next_cpu;
>         }
>
>         next_cpu = cpumask_next_and_wrap(next_cpu, hctx->cpumask, cpu_online_mask)
>         if (next_cpu < nr_cpu_ids) {
>                 hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
>                 hctx->next_cpu = next_cpu;
>                 return next_cpu;
>         }
>
>         /*
>          * Make sure to re-select CPU next time once after CPUs
>          * in hctx->cpumask become online again.
>          */
>         hctx->next_cpu = next_cpu;
>         hctx->next_cpu_batch = 1;
>         return WORK_CPU_UNBOUND;
>
> I didn't test it and likely screwed some corner case. I'm just
> trying to say that picking next cpu should be an easier thing.
>

Agreed, your suggestion looks sane, let me play with that a bit.

> Thanks,
> Yury

