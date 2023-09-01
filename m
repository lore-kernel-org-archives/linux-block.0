Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B84CA0FE2
	for <linux-block@archiver.kernel.org>; Fri,  1 Sep 2023 02:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348132AbjIACR5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Aug 2023 22:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbjIACR5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2023 22:17:57 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A343AE6F
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 19:17:31 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-48d0ceedda1so574007e0c.3
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 19:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693534650; x=1694139450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJKYt94JdvO0pZ7fwwTOPf0qYRDlnD5VJs9iA54kUak=;
        b=a3kDFdu/PngKcxRT+TeKVg067EAHm+dTbO9I+3/jDO1Cn2scbfsuRg1hnwrAE7g8+D
         YZ5iZZKj1bzaPuT66JH+sPYCgh+QLbvHExocQgvsQH4lr//lbreofvan+Z9+D4+4GHYd
         ScEupctEij/yTMMeqYAmu353M6GL452mrDWNT9oShxk/9cNCKgnXReTNVcxmMtpbfPP2
         czDq5X4KdyiQonkqqICFUGYFxxHF/Vn91dL38EMyU1UUatYlMWMyp5MB39uzZAAGKOL0
         mhFHFg7pVbCi2Dl6eSLZQQ5vh0ngAh4K1xaaUON5xgE2OxQsAaV3yTD5+R+4tnOxVlhQ
         r3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693534650; x=1694139450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJKYt94JdvO0pZ7fwwTOPf0qYRDlnD5VJs9iA54kUak=;
        b=VJaGsltLZUbJwjH/huj5RlZu53H9IHFV9qJpq4CxMT0jwujV2xfEgxCUdR3J36OKZI
         Mp8eRreX3GwaH93q1IjQZ4mbHMaKvhN1RlXtP3vggiieKZKf95/P1mPzDFjJQr28xv8w
         6ZjW667Svr6PzrT74nD9x8ycFsX7L4PuLoCQfWL05H25dgR07Ic8mbocC1wprOENCSqU
         l+lKLvYmFaicjGO1gzMZYH8l10bGtQBOvttP1NE2kftjrwkmMgloDt9c4Sc+wqoUl2IB
         vDvJH0SjnSjgzKkJ2sknG+7u/7wu+9nBeCrg2POBh9Scht3kLrO6K0kU/8iAvnI+DYtt
         G/tA==
X-Gm-Message-State: AOJu0YzKCTaCNUAfiXIfdeOkPoh1P515Z304FrTzxk/yN6jK46i3j8gL
        wkPjeO/GtSm6D+Bbttz9E8PqMg==
X-Google-Smtp-Source: AGHT+IFpiAloiSx/uSnFsZHLgtWdf0wCS/tjAy7eTOinbvRKjhs9n/f8XPHixvnhIES9xBO5svMe7w==
X-Received: by 2002:a1f:c9c3:0:b0:490:a0eb:1b9f with SMTP id z186-20020a1fc9c3000000b00490a0eb1b9fmr1244627vkf.10.1693534650658;
        Thu, 31 Aug 2023 19:17:30 -0700 (PDT)
Received: from [10.4.182.70] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id u191-20020a6379c8000000b0056368adf5e2sm1884113pgc.87.2023.08.31.19.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 19:17:30 -0700 (PDT)
Message-ID: <22bde4fc-6dd8-e9de-5b28-96de14f51323@bytedance.com>
Date:   Fri, 1 Sep 2023 10:17:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] io_uring: fix IO hang in io_wq_put_and_exit from
 do_exit()
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, David Howells <dhowells@redhat.com>
References: <20230831074221.2309565-1-ming.lei@redhat.com>
 <7a083b4e-f9f3-552b-0e6c-32bf44982d8f@bytedance.com>
 <ZPFH1RArR07g+ldL@fedora>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <ZPFH1RArR07g+ldL@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/9/1 10:09, Ming Lei wrote:
> On Fri, Sep 01, 2023 at 09:50:02AM +0800, Chengming Zhou wrote:
>> On 2023/8/31 15:42, Ming Lei wrote:
>>> io_wq_put_and_exit() is called from do_exit(), but all requests in io_wq
>>> aren't cancelled in io_uring_cancel_generic() called from do_exit().
>>> Meantime io_wq IO code path may share resource with normal iopoll code
>>> path.
>>>
>>> So if any HIPRI request is pending in io_wq_submit_work(), this request
>>> may not get resouce for moving on, given iopoll isn't possible in
>>> io_wq_put_and_exit().
>>>
>>> The issue can be triggered when terminating 't/io_uring -n4 /dev/nullb0'
>>> with default null_blk parameters.
>>>
>>> Fix it by always cancelling all requests in io_wq from io_uring_cancel_generic(),
>>> and this way is reasonable because io_wq destroying follows cancelling
>>> requests immediately. Based on one patch from Chengming.
>>
>> Thanks much for this work, I'm still learning these code, so maybe some
>> silly questions below.
>>
>>>
>>> Closes: https://lore.kernel.org/linux-block/3893581.1691785261@warthog.procyon.org.uk/
>>> Reported-by: David Howells <dhowells@redhat.com>
>>> Cc: Chengming Zhou <zhouchengming@bytedance.com>,
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  io_uring/io_uring.c | 40 ++++++++++++++++++++++++++++------------
>>>  1 file changed, 28 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>>> index e7675355048d..18d5ab969c29 100644
>>> --- a/io_uring/io_uring.c
>>> +++ b/io_uring/io_uring.c
>>> @@ -144,7 +144,7 @@ struct io_defer_entry {
>>>  
>>>  static bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
>>>  					 struct task_struct *task,
>>> -					 bool cancel_all);
>>> +					 bool cancel_all, bool *wq_cancelled);
>>>  
>>>  static void io_queue_sqe(struct io_kiocb *req);
>>>  
>>> @@ -3049,7 +3049,7 @@ static __cold void io_ring_exit_work(struct work_struct *work)
>>>  		if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
>>>  			io_move_task_work_from_local(ctx);
>>>  
>>> -		while (io_uring_try_cancel_requests(ctx, NULL, true))
>>> +		while (io_uring_try_cancel_requests(ctx, NULL, true, NULL))
>>>  			cond_resched();
>>>  
>>>  		if (ctx->sq_data) {
>>> @@ -3231,12 +3231,13 @@ static __cold bool io_uring_try_cancel_iowq(struct io_ring_ctx *ctx)
>>>  
>>>  static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
>>>  						struct task_struct *task,
>>> -						bool cancel_all)
>>> +						bool cancel_all, bool *wq_cancelled)
>>>  {
>>> -	struct io_task_cancel cancel = { .task = task, .all = cancel_all, };
>>> +	struct io_task_cancel cancel = { .task = task, .all = true, };
>>>  	struct io_uring_task *tctx = task ? task->io_uring : NULL;
>>>  	enum io_wq_cancel cret;
>>>  	bool ret = false;
>>> +	bool wq_active = false;
>>>  
>>>  	/* set it so io_req_local_work_add() would wake us up */
>>>  	if (ctx->flags & IORING_SETUP_DEFER_TASKRUN) {
>>> @@ -3249,7 +3250,7 @@ static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
>>>  		return false;
>>>  
>>>  	if (!task) {
>>> -		ret |= io_uring_try_cancel_iowq(ctx);
>>> +		wq_active = io_uring_try_cancel_iowq(ctx);
>>>  	} else if (tctx && tctx->io_wq) {
>>>  		/*
>>>  		 * Cancels requests of all rings, not only @ctx, but
>>> @@ -3257,11 +3258,20 @@ static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
>>>  		 */
>>>  		cret = io_wq_cancel_cb(tctx->io_wq, io_cancel_task_cb,
>>>  				       &cancel, true);
>>> -		ret |= (cret != IO_WQ_CANCEL_NOTFOUND);
>>> +		wq_active = (cret != IO_WQ_CANCEL_NOTFOUND);
>>>  	}
>>> +	ret |= wq_active;
>>> +	if (wq_cancelled)
>>> +		*wq_cancelled = !wq_active;
>>
>> Here it seems "wq_cancelled" means no any pending or running work anymore.
> 
> wq_cancelled means all requests in io_wq are canceled.
> 
>>
>> Why not just use the return value "loop", instead of using this new "wq_cancelled"?
>>
>> If return value "loop" is true, we know there is still any request need to cancel,
>> so we will loop the cancel process until there is no any request.
>>
>> Ah, I guess you may want to cover one case: !wq_active && loop == true
> 
> If we just reply on 'loop', things could be like passing 'cancel_all' as
> true, that might be over-kill. And I am still not sure why not canceling
> all requests(cancel_all is true) in do_exit()?
> 

Yes, I'm also confused by this. Could we just remove the "cancel_all"?

If we always cancel all requests, these code would be much simpler,
and we can free task_ctx here, instead of in the last reference put
of task_struct.

> But here it is enough to cancel all requests in io_wq only for solving
> this IO hang issue.

Ok, get it.

> 
>>
>>>  
>>> -	/* SQPOLL thread does its own polling */
>>> -	if ((!(ctx->flags & IORING_SETUP_SQPOLL) && cancel_all) ||
>>> +	/*
>>> +	 * SQPOLL thread does its own polling
>>> +	 *
>>> +	 * io_wq may share IO resources(such as requests) with iopoll, so
>>> +	 * iopoll requests have to be reapped for providing forward
>>> +	 * progress to io_wq cancelling
>>> +	 */
>>> +	if (!(ctx->flags & IORING_SETUP_SQPOLL) ||
>>>  	    (ctx->sq_data && ctx->sq_data->thread == current)) {
>>>  		while (!wq_list_empty(&ctx->iopoll_list)) {
>>>  			io_iopoll_try_reap_events(ctx);
>>> @@ -3313,11 +3323,12 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
>>>  	atomic_inc(&tctx->in_cancel);
>>>  	do {
>>>  		bool loop = false;
>>> +		bool wq_cancelled;
>>>  
>>>  		io_uring_drop_tctx_refs(current);
>>>  		/* read completions before cancelations */
>>>  		inflight = tctx_inflight(tctx, !cancel_all);
>>> -		if (!inflight)
>>> +		if (!inflight && !tctx->io_wq)
>>>  			break;
>>>  
>>
>> I think this inflight check should put after the cancel loop, because the
>> cancel loop make sure there is no any request need to cancel, then we can
>> loop inflight checking to make sure all inflight requests to complete.
> 
> But it is fine to break immediately in case that (!inflight && !tctx->io_wq) is true.
> 

This inflight will used after cancel, maybe some requests become inflight during cancel process?
So we use a stale inflight value? I'm not sure.

Thanks.
