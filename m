Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC519ECAAA1
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 00:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKAAGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 20:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKAAGh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 20:06:37 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E4412ADA
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 17:06:36 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r18so12021467pgr.12
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYaYQAD+Z2EUCfUF4uFCjRBL3iae+JniaaRAdcvsmHM=;
        b=Hc4J4fj66+3IqS1gZu8cXqiENtKVH114NCZOrwFKI1vOiakow0GGsW+Ux1oAWg0DPb
         d8z/TK/Siss03TapfZAr2u9X3DfrQ1R4BnjSrTIPWJFA/k+rtufz9yVYx024ksyZtnkz
         ZXCH2IGMovlZV8Yxe23RirkTJ8kYE+y3m+043a/AZEj1ZBiM+WgZFTfyJNh21RslBDDl
         7kpyL0EQIAMmYXjVYOwTRO5i+GC2lP/DF1yzSXrj/sl+I254oMYY73iWRJR9W2UVt1c6
         UmQvuT1DquLJTxqHh0ENa+gK/A5lLVX+h3YY2wjZLcIIhGPtCktW6JJFJvdAQwbEfvFM
         pzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYaYQAD+Z2EUCfUF4uFCjRBL3iae+JniaaRAdcvsmHM=;
        b=dfpfLWxYmhyqMrVXzCUgMcfJ6ajHUyrMgQALqGVHOJzA3/LwSAdtaeTCovmiSgNo5W
         TMadQglglbUB8tq8/R1YjTXtIPfQljNYn1Urt6cpqfNL+uvL6X7EU9nJeSKqcwpucOqf
         bNwiRc79GIeAe3uWKw6cm/mCXcjjjQEamjgcI3zESSfziRdM97gX2D9E2xSYiKEIlfT5
         GbnhimrcTSsGc2IJmw1h/lAJNp9lBuXb8nbYKkVUA0W8hNDB1bboCfp07/H7/+pJzf/w
         mlkAvc+4War9UZ9UIQLFJCaDI3ltwziEgKAmtmSwhBg5j46D5H7Lqd7tMhtHzZ3YqbZQ
         NPAQ==
X-Gm-Message-State: ACrzQf1QBmtDeJ53y0RTKy9hs/jhMEN6gEah8TOOX8b64EMdI/cX9JBU
        PG+/s/CB8ZiyPm2e94HelAH+ofSDHJl1lOdQ
X-Google-Smtp-Source: AMsMyM6f7SpAI2f2f+lpPPQoVJqzexCj0Uk9CujJHqZUaksJbX6cbZmgwsNW4h2XoAWsC0ez0AxvJQ==
X-Received: by 2002:a05:6a00:8d6:b0:56d:67d8:10a with SMTP id s22-20020a056a0008d600b0056d67d8010amr8639787pfu.28.1667261195566;
        Mon, 31 Oct 2022 17:06:35 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m18-20020a656a12000000b0046f59bef0c5sm4731658pgu.89.2022.10.31.17.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 17:06:35 -0700 (PDT)
Message-ID: <67fa977f-a490-4201-f56b-1e20d37c3863@kernel.dk>
Date:   Mon, 31 Oct 2022 18:06:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: UAF in blk_add_rq_to_plug()?
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org
References: <Y2BIad98er4QsbZY@ZenIV>
 <1a46585b-878b-a3b7-3090-36bddba86dbd@kernel.dk> <Y2BbvIdYGM/4L66H@ZenIV>
 <8ae6352c-7880-b51c-004c-06835858a349@kernel.dk>
In-Reply-To: <8ae6352c-7880-b51c-004c-06835858a349@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/22 6:03 PM, Jens Axboe wrote:
> On 10/31/22 5:35 PM, Al Viro wrote:
>> On Mon, Oct 31, 2022 at 04:42:11PM -0600, Jens Axboe wrote:
>>> On 10/31/22 4:12 PM, Al Viro wrote:
>>>> static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>>>> {
>>>>         struct request *last = rq_list_peek(&plug->mq_list);
>>>>
>>>> Suppose it's not NULL...
>>>>
>>>>         if (!plug->rq_count) {
>>>>                 trace_block_plug(rq->q);
>>>>         } else if (plug->rq_count >= blk_plug_max_rq_count(plug) ||
>>>>                    (!blk_queue_nomerges(rq->q) &&
>>>>                     blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
>>>> ... and we went here:
>>>>                 blk_mq_flush_plug_list(plug, false);
>>>> All requests, including the one last points to, might get fed ->queue_rq()
>>>> here.  At which point there seems to be nothing to prevent them getting
>>>> completed and freed on another CPU, possibly before we return here.
>>>>
>>>>                 trace_block_plug(rq->q);
>>>>         }
>>>>
>>>>         if (!plug->multiple_queues && last && last->q != rq->q)
>>>> ... and here we dereference last.
>>>>
>>>> Shouldn't we reset last to NULL after the call of blk_mq_flush_plug_list()
>>>> above?
>>>
>>> There's no UAF here as the requests aren't freed. We could clear 'last'
>>> to make the code more explicit, and that would avoid any potential
>>> suboptimal behavior with ->multiple_queues being wrong.
>>
>> Umm...
>> Suppose ->has_elevator is false and so's ->multiple_queues.
>> No ->queue_rqs(), so blk_mq_flush_plug_list() grabs rcu_read_lock() and
>> hit blk_mq_plug_issue_direct().
>> blk_mq_plug_issue_direct() picks the first request off the list
>> and passes it to blk_mq_request_issue_directly(), which passes it
>> to __blk_mq_request_issue_directly().  There we grab a tag and
>> proceed to __blk_mq_issue_directly(), which feeds request to ->queue_rq().
>>
>> What's to stop e.g. worker on another CPU from picking that sucker,
>> completing it and calling blk_mq_end_request() which completes all
>> bio involved and calls blk_mq_free_request()?
>>
>> If all of that manages to happen before blk_mq_flush_plug_list()
>> returns to caller...  Sure, you probably won't hit in on bare
>> metal, but if you are in a KVM and this virtual CPU happens to
>> lose the host timeslice... I've seen considerably more narrow
>> race windows getting hit on such setups.
>>
>> Am I missing something subtle here?  It's been a long time since
>> I've read through that area - as the matter of fact, I'm trying
>> to refresh my memories of the bio_submit()-related code paths
>> at the moment...
> 
> With blk-mq, which all drivers are these days, the request memory is
> statically allocated when the driver is setup. I'm not denying that you
> could very well have issued AND completed the request which 'last'
> points to by the time we dereference it, but that won't be a UAF unless
> the device has also been quiesced and removed in between. Which I guess
> could indeed be a possibility since it is by definition on a different
> queue (->multiple_queues would be true, however, but that's also what
> would be required to reach that far into that statement).
> 
> This is different from the older days of a request being literally freed
> when it completes, which is what I initially reacted to.
> 
> As mentioned in the original reply, I do think we should just clear
> 'last' as you suggest. But it's not something we've seen on the FB fleet
> of servers, even with the majority of hosts running this code (and on
> VMs).

Forgot to ask - do you want to send a patch for that, or do you just
want me to cook one up with a reported-by for you?

-- 
Jens Axboe


