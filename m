Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD70C433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 01:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E05C613FF
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 01:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhD1Bi2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 21:38:28 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:34434 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhD1Bi2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 21:38:28 -0400
Received: by mail-pg1-f176.google.com with SMTP id z16so2704713pga.1
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 18:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6z3qwcQ0NEfjyKdSApbzD2fvzYI1B145Cwho43bmi4U=;
        b=GswM1Dp6Ynr+oA7P/9qG1mfD8+BLrU9aT8wlRpWekTGXlR/12s+Qm7dYj/MjJMorCl
         F5PLqz4voPg81S4Mrui0Hde4tkC2gD56ypr6/YFJGLw7bJikZgAHwDOSEeBTAZxeQgqS
         J2HWa4RSo1sqJ4kzmqaqW19GlO/cwbOOv0TGz/3C8FfJAeTbAU344RmKQxuDOeOqFeTZ
         45PaH2KLh9mSAJyzETha3kSJuUZjCpyNVSpk5fYyMHpVpRtUoojS3KzuNv/9aUGUvjIe
         GLAX94zzE+wC7lbn+kH1QScHPxYIlTRp+k/SO3R0iB1MPqIT4zXNANA1Ry9YYAqDgs/g
         Xy5g==
X-Gm-Message-State: AOAM532pnvNLOBJDAOLi0RRbR4NOOHgvNNbkWnUBe0VLJ0Y6mBCotNEl
        Yu6SqY3PL1jHuH/ceX38uhk=
X-Google-Smtp-Source: ABdhPJwC3voZ8FywET5RIEnErT6eweq5cPgxX2dH8jU2rgmiXkwNCi9RdJR89C9Y+pVSfZuV4WHQOA==
X-Received: by 2002:a65:6414:: with SMTP id a20mr24102042pgv.96.1619573863896;
        Tue, 27 Apr 2021 18:37:43 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id i123sm3863827pfc.53.2021.04.27.18.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 18:37:43 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] blk-mq: grab rq->refcount before calling ->fn in
 blk_mq_tagset_busy_iter
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210427151058.2833168-1-ming.lei@redhat.com>
 <20210427151058.2833168-3-ming.lei@redhat.com>
 <ce2f315d-ffa8-8327-0633-01c06a2c23fe@acm.org> <YIinU8pb2RzzNxLi@T590>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0151a8f4-37d2-69c2-cc3f-ff05e0c2b8d5@acm.org>
Date:   Tue, 27 Apr 2021 18:37:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIinU8pb2RzzNxLi@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/21 5:07 PM, Ming Lei wrote:
> On Tue, Apr 27, 2021 at 01:17:06PM -0700, Bart Van Assche wrote:
>> On 4/27/21 8:10 AM, Ming Lei wrote:
>>> +void blk_mq_put_rq_ref(struct request *rq)
>>> +{
>>> +	if (is_flush_rq(rq, rq->mq_hctx))
>>> +		rq->end_io(rq, 0);
>>> +	else if (refcount_dec_and_test(&rq->ref))
>>> +		__blk_mq_free_request(rq);
>>> +}
>>
>> The above function needs more work. blk_mq_put_rq_ref() may be called from
>> multiple CPUs concurrently and hence must handle concurrent calls safely.
>> The flush .end_io callbacks have not been designed to handle concurrent
>> calls.
> 
> static void flush_end_io(struct request *flush_rq, blk_status_t error)
> {
>         struct request_queue *q = flush_rq->q;
>         struct list_head *running;
>         struct request *rq, *n;
>         unsigned long flags = 0;
>         struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
> 
>         /* release the tag's ownership to the req cloned from */
>         spin_lock_irqsave(&fq->mq_flush_lock, flags);
> 
>         if (!refcount_dec_and_test(&flush_rq->ref)) {
>                 fq->rq_status = error;
>                 spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
>                 return;
>         }
> 		...
> 		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
> }
> 
> Both spin lock and refcount_dec_and_test() are called at the beginning of
> flush_end_io(), so it is absolutely reliable in case of concurrent
> calls.
> 
> Otherwise, it is simply one issue between normal completion and timeout
> since the pattern in this patch is same with timeout.
> 
> Or do I miss something?

The following code from blk_flush_restore_request() modifies the end_io
pointer:

	rq->end_io = rq->flush.saved_end_io;

If blk_mq_put_rq_ref() is called from two different contexts then one of
the two rq->end_io(rq, 0) calls in blk_mq_put_rq_ref() races with the
end_io assignment in blk_flush_restore_request().

Bart.
