Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB5AC433B4
	for <linux-block@archiver.kernel.org>; Sat,  3 Apr 2021 03:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7FA61179
	for <linux-block@archiver.kernel.org>; Sat,  3 Apr 2021 03:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhDCD0G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 23:26:06 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:44698 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhDCD0G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 23:26:06 -0400
Received: by mail-pj1-f53.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso3333122pjb.3
        for <linux-block@vger.kernel.org>; Fri, 02 Apr 2021 20:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fmR/LTTTLSkHmR8jC4tWevl/iPqL4yZguGoI6CqHiiU=;
        b=DJCq8KvfxilwbPkAy+jgjnzL1u6e2SpovGdh9gaokmdh04lWf0vG/8kfIQ5RYnB35i
         VqGrO4Dmz7OhtvESmK/AhmJRHYk2HQdpsC8EpYpQMT3TgsyFknDaTcbp8wXExCunJ+rG
         Rvo+OP8Az4vfhzofbZvKplb7CYXLaq9cChmwwM69QiqovuXup3Js0rtoOXfnzfHwAuGO
         pXn/g2t4UrrKY3EGpoRtMMK94s3BFHIxpFAziroGBaI7NQlBE4HqQnRN6HMiSnaCpVYr
         6CdhS/dHllRIj0pH86wdkl6JZBkfCqPrlD4fbfAdMcQOS2xgW6djIVJi1/zr6uD5wgkT
         R8cw==
X-Gm-Message-State: AOAM531mBBX9UNprA2dqgAg+YNzeI9LViCUMJeDc9GM/2xNcCqCqND3L
        DG4WPNKajz4SpM+B2qKzTxdt0ffPxkE=
X-Google-Smtp-Source: ABdhPJz2DmVowxVz8jO7f4vr3t/efz6uTHwwwc9aoHq+xI5MOQa5klM0jX5iGGm+LPrMVs2RUULSjg==
X-Received: by 2002:a17:90b:3107:: with SMTP id gc7mr1242481pjb.12.1617420362368;
        Fri, 02 Apr 2021 20:26:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6389:cb68:6af4:3922? ([2601:647:4000:d7:6389:cb68:6af4:3922])
        by smtp.gmail.com with ESMTPSA id q95sm9302592pjq.20.2021.04.02.20.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 20:26:01 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20210329020028.18241-1-bvanassche@acm.org>
 <20210329020028.18241-4-bvanassche@acm.org>
 <CACGdZYJb8saxEkkmenPDK=o9r0Av3PNJsGitAgpiXHd4D13TYg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <229d08ec-7ae9-31f2-9f7c-ae340e372c56@acm.org>
Date:   Fri, 2 Apr 2021 20:25:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACGdZYJb8saxEkkmenPDK=o9r0Av3PNJsGitAgpiXHd4D13TYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/2/21 4:59 PM, Khazhy Kumykov wrote:
> On Sun, Mar 28, 2021 at 7:00 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> @@ -209,7 +209,12 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>
>>         if (!reserved)
>>                 bitnr += tags->nr_reserved_tags;
>> -       rq = tags->rqs[bitnr];
>> +       /*
>> +        * See also the percpu_ref_tryget() and blk_queue_exit() calls in
>> +        * blk_mq_queue_tag_busy_iter().
>> +        */
>> +       rq = rcu_dereference_check(tags->rqs[bitnr],
>> +                       !percpu_ref_is_zero(&hctx->queue->q_usage_counter));
> 
> do we need to worry about rq->q != hctx->queue here? i.e., could we
> run into use-after-free on rq->q == hctx->queue check below, since
> rq->q->q_usage_counter might not be raised? Once we verify rq->q ==
> hctx->queue, i agree q_usage_counter is sufficient then

That's a great question. I will change the second
rcu_dereference_check() argument into 'true' and elaborate the comment
above rcu_dereference_check().

>> -static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>> +static bool __bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr,
>> +                          void *data)
>>  {
>>         struct bt_tags_iter_data *iter_data = data;
>>         struct blk_mq_tags *tags = iter_data->tags;
>> @@ -275,7 +286,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>         if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
>>                 rq = tags->static_rqs[bitnr];
>>         else
>> -               rq = tags->rqs[bitnr];
>> +               rq = rcu_dereference_check(tags->rqs[bitnr], true);
>
> lockdep_is_held(&tags->iter_rwsem) ?

I will change the second rcu_dereference_check() argument into the
following:

rcu_read_lock_held() || lockdep_is_held(&tags->iter_rwsem)

>> +               /*
>> +                * Freeing tags happens with the request queue frozen so the
>> +                * srcu dereference below is protected by the request queue
>
> s/srcu/rcu

Thanks, will fix.

Bart.
