Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BDEC4360C
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 02:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A97820B7C
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 02:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oO+Uy4Dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfJKCfX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 22:35:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45743 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfJKCfX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 22:35:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so5118778pfb.12
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2019 19:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BsIXGOyjs4/q3i7VrDm+v5tb1LeXeggKX5ZTnwaBFhg=;
        b=oO+Uy4Ddrcssw/cp8bzEDWJTFkz2mwvZDb0NEGcEq8fv1GgmoMMxyfv8UeAAU0HTFF
         uV/CBEGweqV2/3OVh/L1iBQb43bgZu31O2Tb2FQ+pE8ZPmQihGGNuEmUts/zJREEVuAk
         MZtzwCn1MZB3jeIJquD5BlGEF5rhlVvuotJ0ISdr8hlhSL2ssvpso4wRxlCpUELqrw1B
         6ZlPxIAU+PLIWBWCFovA8iNLMJ6ad4z1y8NUL+d73ALXAQv4C0fGpg0AE1uMDw32e691
         8wjNe/4aoSYgvrKe7QotDLtuMP6Rbiu5bOmIGKk7+0BkKO2SACAj8JQejARnoGNEQHBW
         cuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BsIXGOyjs4/q3i7VrDm+v5tb1LeXeggKX5ZTnwaBFhg=;
        b=B3KHRUw6FMuo5Ih033wKaqfTG7oU0n8iJdR/vcKZUmuUVk4ZQeFc4/tC6rVACOOY5y
         h7vhSTj5HUe7A9p+01viOPJvwZpUh9pCgajmmS9LipXkZTeKlHrScrs1HSS8TgNWjxEB
         Ox91CJOKprhtZU7VMOKgZHhzLNv/njpbr0rRoOiHquP8MAZ3J6w6Zhh5YjnnCgmBDkrR
         +iQsC35DLeZwT8uVpWeHJKblFzr24ESTCS+fepyddR1KfdOh3Y0/EHcb9xHwxUMMhdqw
         Vc5AOlO3wIqIFOnCmpLIDPC9acsPufkgBMVKUfzFmigJE0Tx3ZVPnacirdTKXljJcSie
         JiVg==
X-Gm-Message-State: APjAAAUe6jes8rttecrXq8FG5pwebjXbE0xKxkdI4blWUQNL+FcXliQ/
        ffF3RIjj2B5pXu778g6Z0c2xxGqbrUWY5g==
X-Google-Smtp-Source: APXvYqx66ZVeRAQY7tyf4d8w09VXxl/ON+YEbrvVtsG6eKEQckUHzIEVMVh+F+HXVO7nPa1dbEoY7Q==
X-Received: by 2002:a17:90a:cb88:: with SMTP id a8mr15000981pju.85.1570761320995;
        Thu, 10 Oct 2019 19:35:20 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id k8sm5225473pgm.14.2019.10.10.19.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 19:35:20 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: make the logic clearer for
 io_sequence_defer
To:     yangerkun <yangerkun@huawei.com>, Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
 <7af32ce6-dc8f-6683-2b99-95eefb598bff@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <597dc8a4-b9db-f0b7-21b5-12050f07e766@kernel.dk>
Date:   Thu, 10 Oct 2019 20:35:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7af32ce6-dc8f-6683-2b99-95eefb598bff@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/19 8:24 PM, yangerkun wrote:
> 
> 
> On 2019/10/9 9:19, Jackie Liu wrote:
>> __io_get_deferred_req is used to get all defer lists, including defer_list
>> and timeout_list, but io_sequence_defer should be only cares about the sequence.
>>
>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>> ---
>>    fs/io_uring.c | 13 +++++--------
>>    1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 8a0381f1a43b..8ec2443eb019 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -418,9 +418,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>>    static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
>>    				     struct io_kiocb *req)
>>    {
>> -	/* timeout requests always honor sequence */
>> -	if (!(req->flags & REQ_F_TIMEOUT) &&
>> -	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>> +	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>    		return false;
>>    
>>    	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>> @@ -435,12 +433,11 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>    		return NULL;
>>    
>>    	req = list_first_entry(list, struct io_kiocb, list);
>> -	if (!io_sequence_defer(ctx, req)) {
>> -		list_del_init(&req->list);
>> -		return req;
>> -	}
>> +	if (!(req->flags & REQ_F_TIMEOUT) && io_sequence_defer(ctx, req))
>> +		return NULL;
> Hi,
> 
> For timeout req, we should also compare the sequence to determine to
> return NULL or the req. But now we will return req directly. Actually,
> no need to compare req->flags with REQ_F_TIMEOUT.

Yes, not sure how I missed this, the patch is broken as-is. I will kill
it, cleanup can be done differently.

> Another problem, before this change, a timeout req can also drain the
> sqe(io_queue_sqe->io_req_defer and add to refer list), i am not sure is
> it a right or wrong logic, but your patch fix that.

We should factor the cq_timeouts into that.

-- 
Jens Axboe

