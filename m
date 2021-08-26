Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CEEC432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 18:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F3E60F4A
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 18:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243217AbhHZSK0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:10:26 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:39675 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243092AbhHZSK0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 14:10:26 -0400
Received: by mail-pj1-f51.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so7151541pjb.4;
        Thu, 26 Aug 2021 11:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j0mt7AWcGZvt97QcESxgo4rDmKH0RfGdg9W8LlCYkLQ=;
        b=BVArMxorTUNQfUowQX36xKsqXt29xYa8KHRwvYfCYrPmJm+X7tg2wcPecmSBGcvKqc
         tREEZTQAX+JuVaKzOv+LVVVJjRoPcU708CTyWGpFYFHw+ptNL5QM/Al/0h55UaKbsN8k
         H0M6AaNk1x0IAnK0TZiOoYf9JoaEig/ZV9/hyXdUOY/+LreSbvlbL+PLhk9v4kj31Z2b
         2ZocViT66GH56sPxNF8VxyVpHe/WlIXE492qvu0vvcD1XZfFqyyvC3shWC7ipkA85Ymk
         cS1OzMHz3kHrW8NhS+P+ADvl222kdWyFdFLbxqD2RH/IE5amEdGPUGGvgmhtCwlzhiaR
         HImA==
X-Gm-Message-State: AOAM531MkX6v0GO/W63YTNzcYd8UHnJOjK6TzK1iPD6/TmFhE34okBES
        ySBXgAZgVFR0QrsuQEAiLmE=
X-Google-Smtp-Source: ABdhPJwsw62jBWgm4+d4gnDL12k+csfjNX1WJnG8wU7slFky9TJwv1DrkqwtpnkUvjQTbJH7GVhFeg==
X-Received: by 2002:a17:90a:a404:: with SMTP id y4mr5929010pjp.52.1630001378136;
        Thu, 26 Aug 2021 11:09:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:22e3:6079:e5ce:5e45? ([2601:647:4000:d7:22e3:6079:e5ce:5e45])
        by smtp.gmail.com with ESMTPSA id nk17sm3539792pjb.18.2021.08.26.11.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:09:37 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
Date:   Thu, 26 Aug 2021 11:09:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826144039.2143-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/21 7:40 AM, Zhen Lei wrote:
> lock protection needs to be added only in
> dd_finish_request(), which is unlikely to cause significant performance
> side effects.

Not sure the above is correct. Every new atomic instruction has a measurable
performance overhead. But I guess in this case that overhead is smaller than
the time needed to sum 128 per-CPU variables.

> Tested on my 128-core board with two ssd disks.
> fio bs=4k rw=read iodepth=128 cpus_allowed=0-95 <others>
> Before:
> [183K/0/0 iops]
> [172K/0/0 iops]
> 
> After:
> [258K/0/0 iops]
> [258K/0/0 iops]

Nice work!

> Fixes: fb926032b320 ("block/mq-deadline: Prioritize high-priority requests")

Shouldn't the Fixes: tag be used only for patches that modify functionality?
I'm not sure it is appropriate to use this tag for performance improvements.

>  struct deadline_data {
> @@ -277,9 +278,9 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  }
>  
>  /* Number of requests queued for a given priority level. */
> -static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> +static __always_inline u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>  {
> -	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
> +	return dd->per_prio[prio].nr_queued;
>  }

Please leave out "__always_inline". Modern compilers are smart enough to
inline this function without using the "inline" keyword.

> @@ -711,6 +712,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	prio = ioprio_class_to_prio[ioprio_class];
>  	dd_count(dd, inserted, prio);
> +	per_prio = &dd->per_prio[prio];
> +	per_prio->nr_queued++;
>  
>  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>  		blk_mq_free_requests(&free);

I think the above is wrong - nr_queued should not be incremented if the
request is merged into another request. Please move the code that increments
nr_queued past the above if-statement.

Thanks,

Bart.
