Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042CCC47404
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 03:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4BD21A4A
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 03:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1w5ffyRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfJKDrJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:47:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42452 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfJKDrI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 23:47:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so5221474pff.9
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2019 20:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dENKdnONoM+0Eii3w9tgreWyAvZZOHAhWd+yQDpQrNQ=;
        b=1w5ffyRWL7qvX8ii/HFcoeLAYXcrKgpgKvEUnCIs7rSp6cSUa8HE+/9Y8mCcwtA5fz
         i6UQtfUICKNMOKEB7zZ1zgGl4bO5mvqWPutUWUS7fCaquaS3Xcz1BiW/LVRbZW6u8Vnn
         2nCuQExJXLPAxym//73/2WQVGDUtSsrk7pDBx4hZmpLylMfJSzu71xOIlPW63VI5CL18
         RdtwElmRzKE7gSWlTGpNd4IEUwVoDrHelU4/Y3NSu6VccFp/OqXJMalkQ7l5NRMQYznj
         FtREJMiXr48ZCx3KkRISvnZxTvdBAjwYGjZax4dnqBrsRVHnUkmCDr3MQv8EmpirkJjj
         4yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dENKdnONoM+0Eii3w9tgreWyAvZZOHAhWd+yQDpQrNQ=;
        b=VNrorlgeN4tST4Z0o5cetJqayrnWyCgyOmQ+eW/ssuWmC6Q9Pj3k8tmorNnN+iV89a
         zm3LIPxEi7v+wQZWAVEmw8YmYJxlHml73ydR6m6PHV7QWD6ttu4fnhoyVaeSRsQeYLwE
         O32p6KwJwNeLEuxtnD1UoRPWy7OgtpatrnEVUHyM6q7qZcvDhRFJ37Hb+IjkV0MnvHZK
         AXsXBiNIr0pvY4QLsF9tp/spDdC/9SZNDxnlSNWiE19uiOle2Ui/3IjgHu8eS0WYlIu9
         mICPwN9SJw7vH8FlK98pbVme1wZ/xaMf5eszu/tYhliG3RbGso/ccJEf91CeB0NobOWE
         G+Rg==
X-Gm-Message-State: APjAAAUB9yOf5W3P31Mz66bl4dBFSm7ocHEFX0F8ViAAroYhohjS7saQ
        TcZN0Pzh1xp0rdSQDBkf1hSJQS6d6ASNLQ==
X-Google-Smtp-Source: APXvYqzGZo8fXrLg1HjJx5MHwTN4O9mc7dQ94HgIcQr1zUWuatKepy+4QyMcQpPeLvmApFNZ0ME5qQ==
X-Received: by 2002:aa7:8691:: with SMTP id d17mr14035417pfo.218.1570765627402;
        Thu, 10 Oct 2019 20:47:07 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id h14sm6756001pfo.15.2019.10.10.20.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 20:47:06 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: make the logic clearer for
 io_sequence_defer
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
 <7af32ce6-dc8f-6683-2b99-95eefb598bff@huawei.com>
 <597dc8a4-b9db-f0b7-21b5-12050f07e766@kernel.dk>
 <544E51DB-7774-4DDF-A897-7A957AE2CDEB@kylinos.cn>
 <6e1c1450-4317-7acf-dfa0-40977de4b8ea@kernel.dk>
 <543C3771-8956-40C4-B477-6B0F2FF477F5@kylinos.cn>
 <ccdcd63c-e811-fbcb-3329-2e779e69fe76@kernel.dk>
 <9C395F47-FE38-4E42-9DB0-3CCC427DE857@kylinos.cn>
 <dc9a36c6-0427-212f-efc9-4658663498c7@kernel.dk>
 <71C4794E-2B1F-4A29-93E9-D578E71DECED@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <617f81c3-4633-e1b2-f51b-ae63fb071237@kernel.dk>
Date:   Thu, 10 Oct 2019 21:47:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <71C4794E-2B1F-4A29-93E9-D578E71DECED@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/19 9:43 PM, Jackie Liu wrote:
> 
> 
>> 2019年10月11日 11:42，Jens Axboe <axboe@kernel.dk> 写道：
>>
>> On 10/10/19 9:41 PM, Jackie Liu wrote:
>>>
>>>
>>>> 2019年10月11日 11:34，Jens Axboe <axboe@kernel.dk> 写道：
>>>>
>>>> On 10/10/19 9:27 PM, Jackie Liu wrote:
>>>>>
>>>>>
>>>>>> 2019年10月11日 11:17，Jens Axboe <axboe@kernel.dk> 写道：
>>>>>>
>>>>>> On 10/10/19 9:06 PM, Jackie Liu wrote:
>>>>>>>
>>>>>>>
>>>>>>>> 2019年10月11日 10:35，Jens Axboe <axboe@kernel.dk> 写道：
>>>>>>>>
>>>>>>>> On 10/10/19 8:24 PM, yangerkun wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2019/10/9 9:19, Jackie Liu wrote:
>>>>>>>>>> __io_get_deferred_req is used to get all defer lists, including defer_list
>>>>>>>>>> and timeout_list, but io_sequence_defer should be only cares about the sequence.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>>>>>>>>> ---
>>>>>>>>>>    fs/io_uring.c | 13 +++++--------
>>>>>>>>>>    1 file changed, 5 insertions(+), 8 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>>>>>>>> index 8a0381f1a43b..8ec2443eb019 100644
>>>>>>>>>> --- a/fs/io_uring.c
>>>>>>>>>> +++ b/fs/io_uring.c
>>>>>>>>>> @@ -418,9 +418,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>>>>>>>>>>    static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
>>>>>>>>>>    				     struct io_kiocb *req)
>>>>>>>>>>    {
>>>>>>>>>> -	/* timeout requests always honor sequence */
>>>>>>>>>> -	if (!(req->flags & REQ_F_TIMEOUT) &&
>>>>>>>>>> -	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>>>>>>>> +	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>>>>>>>>    		return false;
>>>>>>>>>>
>>>>>>>>>>    	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>>>>>>>>>> @@ -435,12 +433,11 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>>>>>>>>>    		return NULL;
>>>>>>>>>>
>>>>>>>>>>    	req = list_first_entry(list, struct io_kiocb, list);
>>>>>>>>>> -	if (!io_sequence_defer(ctx, req)) {
>>>>>>>>>> -		list_del_init(&req->list);
>>>>>>>>>> -		return req;
>>>>>>>>>> -	}
>>>>>>>>>> +	if (!(req->flags & REQ_F_TIMEOUT) && io_sequence_defer(ctx, req))
>>>>>>>>>> +		return NULL;
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> For timeout req, we should also compare the sequence to determine to
>>>>>>>>> return NULL or the req. But now we will return req directly. Actually,
>>>>>>>>> no need to compare req->flags with REQ_F_TIMEOUT.
>>>>>>>>
>>>>>>>> Yes, not sure how I missed this, the patch is broken as-is. I will kill
>>>>>>>> it, cleanup can be done differently.
>>>>>>>
>>>>>>> Sorry for miss it, I don't wanna change the logic, it's not my
>>>>>>> original meaning.
>>>>>>
>>>>>> No worries, mistakes happen.
>>>>>>
>>>>>>> Personal opinion, timeout list should not be mixed with defer_list,
>>>>>>> which makes the code more complicated and difficult to understand.
>>>>>>
>>>>>> Not sure why you feel they are mixed? They are in separate lists, but
>>>>>> they share using the sequence logic. In that respet they are really not
>>>>>> that different, the sequence will trigger either one of them. Either as
>>>>>> a timeout, or as a "can now be issued". Hence the code handling them is
>>>>>> both shared and identical.
>>>>>
>>>>> I not sure, I think I need reread the code of timeout command.
>>>>>
>>>>>>
>>>>>> I do agree that the check could be cleaner, which is probably how the
>>>>>> mistake in this patch happened in the first place.
>>>>>>
>>>>>
>>>>> Yes, I agree with you. io_sequence_defer should be only cares about
>>>>> the sequence.  Thanks for point out this mistake.
>>>>
>>>> How about something like this? More cleanly separates them to avoid
>>>> mixing flags. The regular defer code will honor the flags, the timeout
>>>> code will just bypass those.
>>>>
>>>>
>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>> index c92cb09cc262..4a2bb81cb1f1 100644
>>>> --- a/fs/io_uring.c
>>>> +++ b/fs/io_uring.c
>>>> @@ -416,26 +416,29 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>>>> 	return ctx;
>>>> }
>>>>
>>>> +static inline bool __io_sequence_defer(struct io_ring_ctx *ctx,
>>>> +				       struct io_kiocb *req)
>>>> +{
>>>> +	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>>>> +}
>>>> +
>>>> static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
>>>> 				     struct io_kiocb *req)
>>>> {
>>>> -	/* timeout requests always honor sequence */
>>>> -	if (!(req->flags & REQ_F_TIMEOUT) &&
>>>> -	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>> +	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>> 		return false;
>>>>
>>>> -	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>>>> +	return __io_sequence_defer(ctx, req);
>>>> }
>>>>
>>>> -static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>>> -					      struct list_head *list)
>>>> +static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
>>>> {
>>>> 	struct io_kiocb *req;
>>>>
>>>> -	if (list_empty(list))
>>>> +	if (list_empty(&ctx->defer_list))
>>>> 		return NULL;
>>>>
>>>> -	req = list_first_entry(list, struct io_kiocb, list);
>>>> +	req = list_first_entry(&ctx->defer_list, struct io_kiocb, list);
>>>> 	if (!io_sequence_defer(ctx, req)) {
>>>> 		list_del_init(&req->list);
>>>> 		return req;
>>>> @@ -444,14 +447,20 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>>> 	return NULL;
>>>> }
>>>>
>>>> -static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
>>>> -{
>>>> -	return __io_get_deferred_req(ctx, &ctx->defer_list);
>>>> -}
>>>> -
>>>> static struct io_kiocb *io_get_timeout_req(struct io_ring_ctx *ctx)
>>>> {
>>>> -	return __io_get_deferred_req(ctx, &ctx->timeout_list);
>>>> +	struct io_kiocb *req;
>>>> +
>>>> +	if (list_empty(&ctx->timeout_list))
>>>> +		return NULL;
>>>> +
>>>> +	req = list_first_entry(&ctx->timeout_list, struct io_kiocb, list);
>>>> +	if (!__io_sequence_defer(ctx, req)) {
>>>> +		list_del_init(&req->list);
>>>> +		return req;
>>>> +	}
>>>> +
>>>> +	return NULL;
>>>> }
>>>>
>>>> static void __io_commit_cqring(struct io_ring_ctx *ctx)
>>>>
>>>
>>> Much better, clearly and easy understand.
>>
>> Agree, this is easier to read as well, and harder to inadvertently
>> break. Can I add your reviewed-by to this one?
>>
>>
> 
> Yes, please, Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>

Great thanks, now queued up.

-- 
Jens Axboe

