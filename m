Return-Path: <SRS0=NP29=XY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E49C4360C
	for <linux-block@archiver.kernel.org>; Sun, 29 Sep 2019 02:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083B0214AE
	for <linux-block@archiver.kernel.org>; Sun, 29 Sep 2019 02:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Sn+dGoQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfI2Ch3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Sep 2019 22:37:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42329 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfI2Ch3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Sep 2019 22:37:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id z12so5410044pgp.9
        for <linux-block@vger.kernel.org>; Sat, 28 Sep 2019 19:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CA9JaUWRSgJjfD0gLr/xIGL/54fEj/ARJBR32HsLi+g=;
        b=Sn+dGoQsTRBE5GlqgynGrEJ+EJkTF7BKEsWYIiIX8eTxmhjVGuGtj31r+XQTY7nWYC
         xyYH3t4iN7gLUbcqSPNDlMjHwTBLpFdJ9qN84SzmcGNrqGj0NiiMmDPdTiE0sem5eZ7M
         BclXjb+ZWaMBlYBFV8S28WYIVLWbySP2UqBdWxo/LBLI9yLgvNzhU/BNvRBgUdZ3Q1fb
         IB0M2tmO5cS4xKHXfTKg3aXrnYEWdGbsXa3uCNqtwKGjmrFN1pFD2sY65pB0820CNWLF
         kBUxvRhmOz1o0MxQqqeJ3/W09Epog+BsqsSkkYQf0BaPfgbALYxJWCDB7MX8qDdJNg4h
         QtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CA9JaUWRSgJjfD0gLr/xIGL/54fEj/ARJBR32HsLi+g=;
        b=X+A6KHu90iZIXtmrrIPU7NWel0Vt3/uucfkoYYVjGjuayeusDtGzyGWCOTmfHjg38j
         0PxGJqqGZfaTIIpqzQ2SbQTnRviu4LjvuJ8E3rXT5v4wKwUtO9RtFJBId0UFA3LAs5jq
         9KGV0//KjbKQVXeeAQtiejCcE2WUHwTqEVCKETDek1xEZpjK+8ecAISags9m/8A+CtM/
         plttbl6bi5IAx2FvLeodABRBdX1eNInAi1+/RHTZ1zHJowUteNNjP+zgGfGM1ttt3ueF
         KaI6av4ar0L33NWLdaIoogGbJwc7cgmeVRu57qMTEgGuGqs+8Sq0STkaSPGafKO9WW9l
         zwow==
X-Gm-Message-State: APjAAAWdVxSh+JODKE9a4I2UZ4SVPk5D0zp9Vgrgg5Yv0rISSMRo1kYo
        FiN3wFhzIz/ggr0rAInMmah6G0Q8/92WHtjt
X-Google-Smtp-Source: APXvYqzMzhkDUYtDVV6CpUsjmO8zUkhZBbnrsWfu0P8/6vHk5PYUgPPyygs3VDtFyDUMiRo6MY63DQ==
X-Received: by 2002:a65:404b:: with SMTP id h11mr17507028pgp.237.1569724647653;
        Sat, 28 Sep 2019 19:37:27 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id u11sm11272955pgb.75.2019.09.28.19.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Sep 2019 19:37:26 -0700 (PDT)
Subject: Re: [PATCH] io_uring: run dependent links inline if possible
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e736649e-8360-ad69-8151-3cf3cf78b50f@kernel.dk>
 <793C733D-D492-43BF-A32A-39C1C5CB76A6@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6dd391ac-0d3d-ac3c-f12c-5611dccd13f5@kernel.dk>
Date:   Sat, 28 Sep 2019 20:37:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <793C733D-D492-43BF-A32A-39C1C5CB76A6@kylinos.cn>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/29/19 3:47 AM, Jackie Liu wrote:
> 
> 
>> 在 2019年9月29日，07:23，Jens Axboe <axboe@kernel.dk> 写道：
>>
>> Currently any dependent link is executed from a new workqueue context,
>> which means that we'll be doing a context switch per link in the chain.
>> If we are running the completion of the current request from our async
>> workqueue and find that the next request is a link, then run it directly
>> from the workqueue context instead of forcing another switch.
>>
>> This improves the performance of linked SQEs, and reduces the CPU
>> overhead.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> 2-3x speedup doing read-write links, where the read often ends up
>> blocking. Tested with examples/link-cp.c
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index aa8ac557493c..742d95563a54 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -667,7 +667,7 @@ static void __io_free_req(struct io_kiocb *req)
>> 	kmem_cache_free(req_cachep, req);
>> }
>>
>> -static void io_req_link_next(struct io_kiocb *req)
>> +struct io_kiocb *io_req_link_next(struct io_kiocb *req)
>> {
>> 	struct io_kiocb *nxt;
>>
>> @@ -686,9 +686,19 @@ static void io_req_link_next(struct io_kiocb *req)
>> 		}
>>
>> 		nxt->flags |= REQ_F_LINK_DONE;
>> +		/*
>> +		 * If we're in async work, we can continue processing this,
>> +		 * we can continue processing the chain in this context instead
>> +		 * of having to queue up new async work.
>> +		 */
>> +		if (current_work())
>> +			return nxt;
>> 		INIT_WORK(&nxt->work, io_sq_wq_submit_work);
>> 		io_queue_async_work(req->ctx, nxt);
>> +		nxt = NULL;
>> 	}
>> +
>> +	return nxt;
>> }
>>
>> /*
>> @@ -707,8 +717,10 @@ static void io_fail_links(struct io_kiocb *req)
>> 	}
>> }
>>
>> -static void io_free_req(struct io_kiocb *req)
>> +static struct io_kiocb *io_free_req(struct io_kiocb *req)
>> {
>> +	struct io_kiocb *nxt = NULL;
>> +
>> 	/*
>> 	 * If LINK is set, we have dependent requests in this chain. If we
>> 	 * didn't fail this request, queue the first one up, moving any other
>> @@ -719,16 +731,30 @@ static void io_free_req(struct io_kiocb *req)
>> 		if (req->flags & REQ_F_FAIL_LINK)
>> 			io_fail_links(req);
>> 		else
>> -			io_req_link_next(req);
>> +			nxt = io_req_link_next(req);
>> 	}
>>
>> 	__io_free_req(req);
>> +	return nxt;
>> }
>>
> 
> LGTM, Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>
> 
> The function io_free_req has been used not only for free req, but also for the task
> of finding the next link entry. I think it is possible to change a name to avoid
> confusion, of course, only personal opinion.

That's a good point. I also changed how we handle the return of that, so there's
no confusion as to a caller getting a nxt request returned and not handling it.
See here:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring&id=778fd7a24868b329ff8da2784fd8ced5e35af78c

I'll send out a v2 that's the above, and your naming suggestion.

-- 
Jens Axboe

