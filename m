Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3052BC433FE
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 15:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJFPRa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJFPR2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 11:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6507A59A6
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665069446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LaNanz1TbIo0L9kCY4HbAhnT0dLLrBmpJdnr9yzBj4w=;
        b=U2WQLXHsN2wyJi95xYNmT3DnvTADRqi5epC7ZObTJP3CPW4R0VwVGwXoBLfrtMmW7holD1
        jez42EsWYokUBGZK6hsvFGwYGuoaxRueJdtScp+Ltd6gIvhu7UFNi7Wd6GSgCyMoJYQ+tN
        xYGhQftQCdbcnVTkWsScgkUSKmy9KJw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-503-ArCh5ojcNs-3TxEjMiq5pQ-1; Thu, 06 Oct 2022 11:17:25 -0400
X-MC-Unique: ArCh5ojcNs-3TxEjMiq5pQ-1
Received: by mail-wr1-f71.google.com with SMTP id k30-20020adfb35e000000b0022e04708c18so646704wrd.22
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2022 08:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LaNanz1TbIo0L9kCY4HbAhnT0dLLrBmpJdnr9yzBj4w=;
        b=gXtpEMzcoQF3ka5VRc2dvkLOiZVmFXXTcqAY2gEM+h7H4NrhDvtCCmh3/wUBKpy+dk
         pOID9vda18Tsk2CC5qXGkk9stbX2yvtTGItO8wwwNGo10BE+TVg1DmJg/3BWg89/Gztm
         QKBMnsjeA/10ovuModpyxQWEzMuhD5xHlQed3bAtqlIKLNxcGICRptxb3mb+GZzQKfVn
         R8bliRczgdE37PUSI4sbOWI4T7mHEPT5lXmEaN5I9r3TeZl3XsiZiQU/JtWHRaB3TzHA
         m2We8wMJLRCNJLbH1MMTpkd82frHuNCfDvQzjHfVPs97Kskauefb6qbfS+bVR9O5i3P/
         /v3g==
X-Gm-Message-State: ACrzQf0d1NnvWq2ug/QJtJDUt5tQNOk4Mtwat6FFkHJu7Qfyqxa58OXp
        nyRZVdaeZyjx4fJYdOF1cuVPDAqWJUjIub2eIcOuQclt0/oFDlpnqHNwvvrf52ngZsDOxLUbkUV
        06KxKKcD4zebiPelYZrvcpm8=
X-Received: by 2002:a05:600c:4254:b0:3bd:c9c9:92cc with SMTP id r20-20020a05600c425400b003bdc9c992ccmr7609142wmm.151.1665069443636;
        Thu, 06 Oct 2022 08:17:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5xBGuQWsrC6rFfTPmTdLaQ20XGGEkPMobtqTJ6wfL4EKokOUZjDvFcpkEkxoCTA0HgUj6O1Q==
X-Received: by 2002:a05:600c:4254:b0:3bd:c9c9:92cc with SMTP id r20-20020a05600c425400b003bdc9c992ccmr7609126wmm.151.1665069443377;
        Thu, 06 Oct 2022 08:17:23 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d4e03000000b002238ea5750csm21354407wrt.72.2022.10.06.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:17:22 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH bitmap-for-next 4/4] blk_mq: Fix cpumask_check()
 warning in blk_mq_hctx_next_cpu()
In-Reply-To: <Yz7dC4zxby1CZphE@yury-laptop>
References: <20221006122112.663119-1-vschneid@redhat.com>
 <20221006122112.663119-5-vschneid@redhat.com>
 <Yz7dC4zxby1CZphE@yury-laptop>
Date:   Thu, 06 Oct 2022 16:17:21 +0100
Message-ID: <xhsmhy1ttf0ce.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/10/22 06:50, Yury Norov wrote:
> On Thu, Oct 06, 2022 at 01:21:12PM +0100, Valentin Schneider wrote:
>> blk_mq_hctx_next_cpu() implements a form of cpumask_next_and_wrap() using
>> cpumask_next_and_cpu() and blk_mq_first_mapped_cpu():
>>
>> [    5.398453] WARNING: CPU: 3 PID: 162 at include/linux/cpumask.h:110 __blk_mq_delay_run_hw_queue+0x16b/0x180
>> [    5.399317] Modules linked in:
>> [    5.399646] CPU: 3 PID: 162 Comm: ssh-keygen Tainted: G                 N 6.0.0-rc4-00004-g93003cb24006 #55
>> [    5.400135] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>> [    5.405430] Call Trace:
>> [    5.406152]  <TASK>
>> [    5.406452]  blk_mq_sched_insert_requests+0x67/0x150
>> [    5.406759]  blk_mq_flush_plug_list+0xd0/0x280
>> [    5.406987]  ? bit_wait+0x60/0x60
>> [    5.407317]  __blk_flush_plug+0xdb/0x120
>> [    5.407561]  ? bit_wait+0x60/0x60
>> [    5.407765]  io_schedule_prepare+0x38/0x40
>> [...]
>>
>> This triggers a warning when next_cpu == nr_cpu_ids - 1, so rewrite it
>> using cpumask_next_and_wrap() directly. The backwards-going goto can be
>> removed, as the cpumask_next*() operation already ANDs hctx->cpumask and
>> cpu_online_mask, which implies checking for an online CPU.
>>
>> No change in behaviour intended.
>>
>> Suggested-by: Yury Norov <yury.norov@gmail.com>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  block/blk-mq.c | 39 +++++++++++++--------------------------
>>  1 file changed, 13 insertions(+), 26 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index c96c8c4f751b..1520794dd9ea 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2038,42 +2038,29 @@ static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
>>   */
>>  static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>>  {
>> -	bool tried = false;
>>      int next_cpu = hctx->next_cpu;
>>
>>      if (hctx->queue->nr_hw_queues == 1)
>>              return WORK_CPU_UNBOUND;
>>
>> -	if (--hctx->next_cpu_batch <= 0) {
>> -select_cpu:
>> -		next_cpu = cpumask_next_and(next_cpu, hctx->cpumask,
>> -				cpu_online_mask);
>> -		if (next_cpu >= nr_cpu_ids)
>> -			next_cpu = blk_mq_first_mapped_cpu(hctx);
>> +	if (--hctx->next_cpu_batch > 0 && cpu_online(next_cpu))
>> +		return next_cpu;
>> +
>> +	next_cpu = cpumask_next_and_wrap(next_cpu, hctx->cpumask, cpu_online_mask, next_cpu, false);
>
> Last two parameters are simply useless. In fact, in many cases they
> are useless for cpumask_next_wrap(). I'm working on simplifying the
> cpumask_next_wrap() so that it would take just 2 parameters - pivot
> point and cpumask.
>
> Regarding 'next' version - we already have find_next_and_bit_wrap(),
> and I think cpumask_next_and_wrap() should use it.
>

Oh, I had missed those, that makes more sense indeed.

> For the context: those last parameters are needed to exclude part of
> cpumask from traversing, and to implement for-loop. Now that we have
> for_each_cpu_wrap() based on for_each_set_bit_wrap(), it's possible
> to remove them. I'm working on it.

Sounds good.

