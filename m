Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE77C433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 20:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0668D65208
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 20:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCHT7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:59:50 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:39180 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhCHT70 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Mar 2021 14:59:26 -0500
Received: by mail-pg1-f172.google.com with SMTP id x29so7119878pgk.6;
        Mon, 08 Mar 2021 11:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OEgorovdQsjkjU9qNekIDia6GRBVJARi8Jz71Iix888=;
        b=H5Y+/i7ruuKh0UvHGT3wk64OF2eHFJfohAb8v8hjXR28zLK8ThA+nPofQdqE0t5P+Y
         9B0BmKmx230WtzzHU18lJCPy+sCC7mYT2iOYjB64CxpdKmnSZhQVLNCblxiwuyr3ZOVG
         YrK1G4vg0XqF8SlJ5UiQNcZl9eNB9d/QmSmTksoUPW69HEbkTHL9RIRJatchkC62yjtl
         +zg++LoN0J7MzUAEZnzlGSGj+YxUiz7WbY03Lie1hJ3TLqDqFGK7dW4D9bn40ohUNgn7
         Xh8aSr9OzO9LWls7wdUSO14Etj2AWEUFyTXQdl7xtXKAHopAAmES5q7rhGT+Er3T6goU
         4owg==
X-Gm-Message-State: AOAM531cuzY77w+BekSKLrBilpOyOfkpcJxm0PZiAylQH61fGNupHXad
        1422U7mHiBLfAvH9dw0GF40=
X-Google-Smtp-Source: ABdhPJzQyZ82aCuUVMiC4SsPlaY0Ixw9qU7ADHahR5G9nnjByuE2qAnpH+xAJlgki0Zs+Ik3cO/guw==
X-Received: by 2002:aa7:881a:0:b029:1f1:6148:15c3 with SMTP id c26-20020aa7881a0000b02901f1614815c3mr14667561pfo.30.1615233565986;
        Mon, 08 Mar 2021 11:59:25 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id y29sm6529501pfp.206.2021.03.08.11.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 11:59:25 -0800 (PST)
Subject: Re: [RFC PATCH v3 3/3] blk-mq: Lockout tagset iterator when exiting
 elevator
To:     John Garry <john.garry@huawei.com>, hare@suse.de,
        ming.lei@redhat.com, axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pragalla@codeaurora.org, kashyap.desai@broadcom.com,
        yuyufen@huawei.com
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-4-git-send-email-john.garry@huawei.com>
 <48a3cf78-3f6d-c13c-bca2-1f8277817b45@acm.org>
 <9c9360bf-7ca9-5c8f-c61d-441044f9c78f@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <784a3686-cb54-561d-740c-30e0b3f46df8@acm.org>
Date:   Mon, 8 Mar 2021 11:59:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <9c9360bf-7ca9-5c8f-c61d-441044f9c78f@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/21 3:17 AM, John Garry wrote:
> On 06/03/2021 04:43, Bart Van Assche wrote:
>> On 3/5/21 7:14 AM, John Garry wrote:
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index 7ff1b20d58e7..5950fee490e8 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -358,11 +358,16 @@ void blk_mq_tagset_busy_iter(struct 
>>> blk_mq_tag_set *tagset,
>>>   {
>>>       int i;
>>> +    if (!atomic_inc_not_zero(&tagset->iter_usage_counter))
>>> +        return;
>>> +
>>>       for (i = 0; i < tagset->nr_hw_queues; i++) {
>>>           if (tagset->tags && tagset->tags[i])
>>>               __blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>>>                             BT_TAG_ITER_STARTED);
>>>       }
>>> +
>>> +    atomic_dec(&tagset->iter_usage_counter);
>>>   }
>>>   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
> 
> Hi Bart,
> 
>> This changes the behavior of blk_mq_tagset_busy_iter(). What will e.g.
>> happen if the mtip driver calls blk_mq_tagset_busy_iter(&dd->tags,
>> mtip_abort_cmd, dd) concurrently with another blk_mq_tagset_busy_iter()
>> call and if that causes all mtip_abort_cmd() calls to be skipped?
> 
> I'm not sure that I understand this problem you describe. So if 
> blk_mq_tagset_busy_iter(&dd->tags, mtip_abort_cmd, dd) is called, either 
> can happen:
> a. normal operation, iter_usage_counter initially holds >= 1, and then 
> iter_usage_counter is incremented in blk_mq_tagset_busy_iter() and we 
> iter the busy tags. Any parallel call to blk_mq_tagset_busy_iter() will 
> also increase iter_usage_counter.
> b. we're switching IO scheduler. In this scenario, first we quiesce all 
> queues. After that, there should be no active requests. At that point, 
> we ensure any calls to blk_mq_tagset_busy_iter() are finished and block 
> (or discard may be a better term) any more calls. Blocking any more 
> calls should be safe as there are no requests to iter. atomic_cmpxchg() 
> is used to set iter_usage_counter to 0, blocking any more calls.


Hi John,

My concern is about the insertion of the early return statement in 
blk_mq_tagset_busy_iter(). Although most blk_mq_tagset_busy_iter() 
callers can handle skipping certain blk_mq_tagset_busy_iter() calls 
(e.g. when gathering statistics), I'm not sure this is safe for all 
blk_mq_tagset_busy_iter() callers. The example I cited is an example of 
a blk_mq_tagset_busy_iter() call with side effects.

The mtip driver allocates one tag set per request queue so quiescing 
queues should be sufficient to address my concern for the mtip driver.

The NVMe core and SCSI core however share a single tag set across 
multiple namespaces / LUNs. In the error path of nvme_rdma_setup_ctrl() 
I found a call to nvme_cancel_tagset(). nvme_cancel_tagset() calls 
blk_mq_tagset_busy_iter(ctrl->tagset, nvme_cancel_request, ctrl). I'm 
not sure it is safe to skip the nvme_cancel_request() calls if the I/O 
scheduler for another NVMe namespace is being modified.

Thanks,

Bart.
