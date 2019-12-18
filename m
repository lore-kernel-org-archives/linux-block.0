Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A33C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 01:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A50B2176D
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 01:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j9CJEujl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfLRBO5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:14:57 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40964 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfLRBO5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 20:14:57 -0500
Received: by mail-il1-f193.google.com with SMTP id f10so216070ils.8
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 17:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jHMze2R5sGSN2eUdrzOAy+Dv9T36Z4u2RHOSw0IjoPs=;
        b=j9CJEujl7GBep7gWNlxkSWRlqg9cEAXc1Ps8yzqaNh3zrQxtEgeDCoHgRbqd858d9X
         e+2/HyXai9ryx418L8y1grzEapgz9fvmcTx/Lof6SFswoAu2grLZQx07GN8qXC4sbvYy
         4Ophz/6DnJfFBq57ykO9xQM/fb31nxLjjU/QxaH66P2dW9gUlkVJt/TtiggiRvnmuIv3
         nykt1meNSZBJPXcESJw06JjZCk/4/2M/ZD7X0Xu8kXgagHA8uPHE9Q+O7OzvxlrBz9WM
         6JhADVQxenhGebcVdoFg52vEhnqV2Scy4KLw4KR7kXWNDhgw38CSsCfZSobHJA/Jajxk
         GXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jHMze2R5sGSN2eUdrzOAy+Dv9T36Z4u2RHOSw0IjoPs=;
        b=Ia5kznI3ohd3AaR92C6wCRVoLgzYV/KpLIJaK8RT0ENuBOALqSiABQqfD5tSD4rTXI
         /lRLWZ+TeUHPL2QeMQ2LQ9AaWYMk/FvU8hZ5ZScnc5A1vympnQglDjzxUv9E6W0EU5eE
         slRUXDuUG33xfCDJu09y4dooV+ofoACjnq54eWRDk3Tn/50YRrOy5ekON8L2nKuuKB9l
         6TlExtnVnBaJ4yLXcA82SkwN9JMe7GMqY/F3medKbqtLWr+cckItVTzgZEhmLMcTAXRJ
         WjBrZNxhYRShatHvkuXXS8Y6fXnCq0g3wszaB1qTStYzEofb+ZO+a4wXXoueenLc0nfl
         DUoQ==
X-Gm-Message-State: APjAAAUQb1qV25AM+gSu7F3CIu0yvyNSAm2m7axt1cd4VH83tPHPAzJs
        z0c82W8BmHP0v8FiilnlOCoBwmawiCNTWQ==
X-Google-Smtp-Source: APXvYqxgHwvHkt/Pxljix1ugco+k46cBNYiRMc6k+hX67AkZWCAS0Op1TQHIUsKKP/yrG+w8bp7Euw==
X-Received: by 2002:a92:3f0f:: with SMTP id m15mr335669ila.164.1576631696830;
        Tue, 17 Dec 2019 17:14:56 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t17sm147701ilb.29.2019.12.17.17.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 17:14:56 -0800 (PST)
Subject: Re: [PATCH] sbitmap: only queue kyber's wait callback if not already
 active
To:     David Jeffery <djeffery@redhat.com>, linux-block@vger.kernel.org
Cc:     John Pittman <jpittman@redhat.com>,
        Omar Sandoval <osandov@osandov.com>
References: <20191217160024.GA23066@redhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <647af756-3a8a-d895-cbf8-ed3583732817@kernel.dk>
Date:   Tue, 17 Dec 2019 18:14:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217160024.GA23066@redhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/19 9:00 AM, David Jeffery wrote:
> Under heavy loads where the kyber I/O scheduler hits the token limits for
> its scheduling domains, kyber can become stuck.  When active requests
> complete, kyber may not be woken up leaving the I/O requests in kyber
> stuck.
> 
> This stuck state is due to a race condition with kyber and the sbitmap
> functions it uses to run a callback when enough requests have completed.
> The running of a sbt_wait callback can race with the attempt to insert the
> sbt_wait.  Since sbitmap_del_wait_queue removes the sbt_wait from the list
> first then sets the sbq field to NULL, kyber can see the item as not on a
> list but the call to sbitmap_add_wait_queue will see sbq as non-NULL. This
> results in the sbt_wait being inserted onto the wait list but ws_active
> doesn't get incremented.  So the sbitmap queue does not know there is a
> waiter on a wait list.
> 
> Since sbitmap doesn't think there is a waiter, kyber may never be
> informed that there are domain tokens available and the I/O never advances.
> With the sbt_wait on a wait list, kyber believes it has an active waiter
> so cannot insert a new waiter when reaching the domain's full state.
> 
> This race can be fixed by only adding the sbt_wait to the queue if the
> sbq field is NULL.  If sbq is not NULL, there is already an action active
> which will trigger the re-running of kyber.  Let it run and add the
> sbt_wait to the wait list if still needing to wait.
> 
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Reported-by: John Pittman <jpittman@redhat.com>
> Tested-by: John Pittman <jpittman@redhat.com>
> ---
> 
> This bug was reliably being triggered on several test systems.  With the
> fix, the tests no longer fail.
> 
>  sbitmap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 33feec8989f1..af88d1346dd7 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -650,8 +650,8 @@ void sbitmap_add_wait_queue(struct sbitmap_queue *sbq,
>  	if (!sbq_wait->sbq) {
>  		sbq_wait->sbq = sbq;
>  		atomic_inc(&sbq->ws_active);
> +		add_wait_queue(&ws->wait, &sbq_wait->wait);
>  	}
> -	add_wait_queue(&ws->wait, &sbq_wait->wait);
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_add_wait_queue);

This looks good to me, waiting for Omar to take a look (CC'ed).

-- 
Jens Axboe

