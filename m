Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B5C4360C
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 03:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817B32067B
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 03:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tqTVWe9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfJKDRY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:17:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44557 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJKDRX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 23:17:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id e10so935931pgd.11
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2019 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Aqz4nekBE465eQXPB0yOaK19jNjs0/oVEbgRjBsrhm8=;
        b=tqTVWe9IkObTQzASoKSdMjdpV8bvZrBldc/J7xR3dUZmc7lktXaHdFIfcIe/2vN7bV
         9lsvysNJ/TlTHZFP0IaojJaqAHQ3fkKvqNb6BF9gPhud72PkWTGzs7KlB1nCt0yRq/5u
         Esy5rAW/CLBoi7UI+82nAZlrGnUEu0A7xAC8CQ2igEnkVhOSD5wpPVKiTDJB2+fhcOUg
         +g7eV3q+OXqVLBxgciVvQlA2KcrDNAkA2qlWNsXkNzsrmhE0bkxAnuxk0nMjL/3PNYfP
         UgMiPTZkjL4I0Y91SWXCx8AgdrLU51hEDfEjqwyhnxOTO3wC5ilUkqTPV1/W7YE7cT2Z
         ip6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aqz4nekBE465eQXPB0yOaK19jNjs0/oVEbgRjBsrhm8=;
        b=CfJJLMPw3V2s5z2SyZNcWBMDQ6QoaGobAZKeOiBn7kPGXEsGvF/Dwg/GUewbEdnxYf
         sRUAaQjudorNXeSULfJkQ6ZuknlUts+yHc84J/RIvDGrEZD1Sfm6oiL5nROuPjsBW5kw
         vYBEKzzjYnOc43cRk/DunSQ8exG0USHKkeTffvtVC/CZGGvfBxYH7MzLuoRanD704xit
         HJovib2Ts1+Yz8z5hFl3hO7NyUXnLtj7hCEv5M+70cizo1xR6W9QHcB6SwnluYfbF4BN
         FKnBldLZnaev52KveWUEY0wgshvvQKL+/LO9wQKAZeirhIHAbaB5NA827kGd1EGj1R3E
         imeQ==
X-Gm-Message-State: APjAAAWkGo9H1u1gt9UV0IKpIjsyAss1WdIH36yLHTsKC3A59n9SDefZ
        R6tYN9fBFlgUEVltaSxDv59rPkmQxkl7Bw==
X-Google-Smtp-Source: APXvYqyHZ4CxK83kKaxWDonfQ5q0LbveJN++KViWdv6892uBG6T1UQ078Z2tOQtkvs+wzV9MmyRE2g==
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr6697040pjp.74.1570763840981;
        Thu, 10 Oct 2019 20:17:20 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id u13sm744325pgk.88.2019.10.10.20.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 20:17:19 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: make the logic clearer for
 io_sequence_defer
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
 <7af32ce6-dc8f-6683-2b99-95eefb598bff@huawei.com>
 <597dc8a4-b9db-f0b7-21b5-12050f07e766@kernel.dk>
 <544E51DB-7774-4DDF-A897-7A957AE2CDEB@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e1c1450-4317-7acf-dfa0-40977de4b8ea@kernel.dk>
Date:   Thu, 10 Oct 2019 21:17:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <544E51DB-7774-4DDF-A897-7A957AE2CDEB@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/19 9:06 PM, Jackie Liu wrote:
> 
> 
>> 2019年10月11日 10:35，Jens Axboe <axboe@kernel.dk> 写道：
>>
>> On 10/10/19 8:24 PM, yangerkun wrote:
>>>
>>>
>>> On 2019/10/9 9:19, Jackie Liu wrote:
>>>> __io_get_deferred_req is used to get all defer lists, including defer_list
>>>> and timeout_list, but io_sequence_defer should be only cares about the sequence.
>>>>
>>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>>> ---
>>>>    fs/io_uring.c | 13 +++++--------
>>>>    1 file changed, 5 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>> index 8a0381f1a43b..8ec2443eb019 100644
>>>> --- a/fs/io_uring.c
>>>> +++ b/fs/io_uring.c
>>>> @@ -418,9 +418,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>>>>    static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
>>>>    				     struct io_kiocb *req)
>>>>    {
>>>> -	/* timeout requests always honor sequence */
>>>> -	if (!(req->flags & REQ_F_TIMEOUT) &&
>>>> -	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>> +	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>>    		return false;
>>>>
>>>>    	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>>>> @@ -435,12 +433,11 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>>>    		return NULL;
>>>>
>>>>    	req = list_first_entry(list, struct io_kiocb, list);
>>>> -	if (!io_sequence_defer(ctx, req)) {
>>>> -		list_del_init(&req->list);
>>>> -		return req;
>>>> -	}
>>>> +	if (!(req->flags & REQ_F_TIMEOUT) && io_sequence_defer(ctx, req))
>>>> +		return NULL;
>>> Hi,
>>>
>>> For timeout req, we should also compare the sequence to determine to
>>> return NULL or the req. But now we will return req directly. Actually,
>>> no need to compare req->flags with REQ_F_TIMEOUT.
>>
>> Yes, not sure how I missed this, the patch is broken as-is. I will kill
>> it, cleanup can be done differently.
> 
> Sorry for miss it, I don't wanna change the logic, it's not my
> original meaning.

No worries, mistakes happen.

> Personal opinion, timeout list should not be mixed with defer_list,
> which makes the code more complicated and difficult to understand.

Not sure why you feel they are mixed? They are in separate lists, but
they share using the sequence logic. In that respet they are really not
that different, the sequence will trigger either one of them. Either as
a timeout, or as a "can now be issued". Hence the code handling them is
both shared and identical.

I do agree that the check could be cleaner, which is probably how the
mistake in this patch happened in the first place.

-- 
Jens Axboe

