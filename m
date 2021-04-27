Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C585DC433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 14:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FE6613DD
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 14:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbhD0Ox5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 10:53:57 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:44580 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhD0Ox4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 10:53:56 -0400
Received: by mail-pg1-f178.google.com with SMTP id y32so42494189pga.11
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 07:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rrMGqRkXlKTde4vfnnDwZ1geedRg0DPkvUF5DXLWZW8=;
        b=h2wd4lPUpG3s0cpoluxUv8QoRzIBjDRuCsfEk1Mx6+LhNEDHok/yoWCjkDDEYth0tU
         XMKzkYn2XwYxHKymvej4SFkSvXO2QIK9tfQi/8xfUDIjvK0T8r7wTIS9VAdBp7w1+ZXo
         3CwDU5vbLD0KJKZWzyzddpo/AVI1vyKbViotx+u17wcTEEgZe2UEyuAcoq65RTLREy6x
         9DwfLcsKrBZOqNQzsGOjO5pDjHhGOxZS7wA7cnL6BC3vioJgrmBmnMfkOah06OWRsQBi
         r3S34MYsXCTP/PeqdLXYZG/abJFug3Owm6wCzGs4b9m3wFcVJbsznERqBKizcMzDi21C
         Ab/A==
X-Gm-Message-State: AOAM5322h2URGhYjzOSeCcZYXexMBAocLn1UPaQYEQwkzjTUUSPYWfbC
        Sq+Cec5t/Q8HhR+mX6EFjNs=
X-Google-Smtp-Source: ABdhPJxuPHlT+j5r++u81HUM1U++LPPBzQMAdltWAvi0HkdbOlFwDeupC+b4F2WQYxmQSJcV6oLNMA==
X-Received: by 2002:a05:6a00:150d:b029:27a:ce95:bb0e with SMTP id q13-20020a056a00150db029027ace95bb0emr3039022pfu.64.1619535192453;
        Tue, 27 Apr 2021 07:53:12 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id c129sm2911412pfb.141.2021.04.27.07.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 07:53:11 -0700 (PDT)
Subject: Re: [PATCH V2 2/3] blk-mq: complete request locally if the completion
 is from tagset iterator
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210427014540.2747282-1-ming.lei@redhat.com>
 <20210427014540.2747282-3-ming.lei@redhat.com>
 <c122e2bc-2e03-3890-bc7a-be1470bee1d5@acm.org> <YIe4CzfUDX4yCCNO@T590>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <023a5045-bc1d-ecf4-784d-6de9adda85ba@acm.org>
Date:   Tue, 27 Apr 2021 07:53:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIe4CzfUDX4yCCNO@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/21 12:06 AM, Ming Lei wrote:
> On Mon, Apr 26, 2021 at 07:30:51PM -0700, Bart Van Assche wrote:
>> On 4/26/21 6:45 PM, Ming Lei wrote:
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index 100fa44d52a6..773aea4db90c 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -284,8 +284,11 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>>  	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
>>>  	    !blk_mq_request_started(rq))
>>>  		ret = true;
>>> -	else
>>> +	else {
>>> +		rq->rq_flags |= RQF_ITERATING;
>>>  		ret = iter_data->fn(rq, iter_data->data, reserved);
>>> +		rq->rq_flags &= ~RQF_ITERATING;
>>> +	}
>>>  	if (!iter_static_rqs)
>>>  		blk_mq_put_rq_ref(rq);
>>>  	return ret;
>>
>> All existing rq->rq_flags modifications are serialized. The above change
>> adds code that may change rq_flags concurrently with regular request
>> processing. I think that counts as a race condition.
> 
> Good catch, but we still can change .rq_flags via atomic op, such as:
> 
> 	do {
> 		old = rq->rq_flags;
> 		new = old | RQF_ITERATING;
> 	} while (cmpxchg(&rq->rq_flags, old, new) != old);

That's not sufficient because the above would not work correctly in
combination with statements like the following:

	rq->rq_flags &= ~RQF_MQ_INFLIGHT;
	req->rq_flags |= RQF_TIMED_OUT;

How about setting a flag in 'current', just like the memalloc_noio_*()
functions set or clear PF_MEMALLOC_NOIO to indicate whether or not
GFP_NOIO should be used? That should work fine in thread context and
also in interrupt context.

>> Additionally, the
>> RQF_ITERATING flag won't be set correctly in the (unlikely) case that
>> two concurrent bt_tags_iter() calls examine the same request at the same
>> time.
> 
> If the driver completes request from two concurrent bt_tags_iter(), there has
> been big trouble of double completion, so I'd rather not to consider this case.

bt_tags_iter() may be used for other purposes than completing requests.
Here is an example of a blk_mq_tagset_busy_iter() call (from debugfs)
that may run concurrently with other calls of that function:

static int hctx_busy_show(void *data, struct seq_file *m)
{
	struct blk_mq_hw_ctx *hctx = data;
	struct show_busy_params params = { .m = m, .hctx = hctx };

	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
				&params);

	return 0;
}

Bart.
