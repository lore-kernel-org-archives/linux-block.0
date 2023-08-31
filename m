Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2D7C83F2F
	for <linux-block@archiver.kernel.org>; Thu, 31 Aug 2023 17:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346991AbjHaR7s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbjHaR7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2023 13:59:48 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB0A12F
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 10:59:45 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34cb4b85bacso1182315ab.0
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693504784; x=1694109584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFF9uTHTuDa0r1dXUNDiH3Poy6F8RGhGYJBri72Rgzw=;
        b=ObezdKPU1BnGsjlaNw4Nf9kwC78BfAUpCH5BMjcrurT2L3VdkH2SCFOo6PaJYhG0n3
         tthT3OvakUp5Hbxgo46A0mMVR6dAxCe4O1o0sH3w/HCxQ3Q/RY7osg2taYKg0y9GTAY2
         w3gtZJaaOiPE7LdJfAW1U1DHvlZNMvh+5E0fwWQVFR+D8Hys4flGgeeEdE2oYkbBftmv
         qtnwDPE7zpsv9D/Bu857dH4RTRUfcqzQBRsMo6IiPd2d+/YH66U8iv6wz7EzE31cJ36+
         n39fbNtWBH1/mszkFECF+hG0nau/6ZOfgIeua7pJQFmuWbJG1jGbaELSak9825EJ9sjC
         tzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693504784; x=1694109584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFF9uTHTuDa0r1dXUNDiH3Poy6F8RGhGYJBri72Rgzw=;
        b=UKVHyVY3HLDpk5LE/ZX7CtnUgU6jsWe1a3YGPmEjlALcMYqe818yMD/ZOwl3xxUSoF
         Gcclip8uhBZ8vDmHya3RmG2xv/2A8GJHwCaVEVXUC1g0hdkwWC0v/cIRqHgzoawnPz4H
         OrhTUhz9B+KytjmJf56VEemZRmipf64qm8zjUbWHNGOB0Q4OXVfwhY1lDNbpc4r6VCaJ
         FjQ4kdfXxxTeqza0iXRnLecEsn3xSZC8XDX4wZr+0aXYtwl5YFvrz2Z3cFocM1qYqd8L
         VHovyYGQ5J7Uy1CoAfe3S/GeBq3ZabEF22w12jImvVdZ+4tHrWB7JYjBnu9cpqFRsXz/
         8Q9w==
X-Gm-Message-State: AOJu0Yxu5O1jZG31+vcgXj8VK4F7Y3RNym4PfByiBIGRZDw6t43kwVA1
        fSG67NmLxWD5zoiA3glJMm+A3Q==
X-Google-Smtp-Source: AGHT+IEiZowoVhxQhK8DNw0f+Jm4pkkGh4zqEOaobgtLp9nIVqaN/mQq2Qzd+ofZlDp1LSPOyRSukQ==
X-Received: by 2002:a92:d785:0:b0:349:385e:287e with SMTP id d5-20020a92d785000000b00349385e287emr223341iln.1.1693504784601;
        Thu, 31 Aug 2023 10:59:44 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y8-20020a02c008000000b004300eca209csm502485jai.112.2023.08.31.10.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 10:59:43 -0700 (PDT)
Message-ID: <9353345b-bf34-4ee9-a81f-3c58e7e0e68c@kernel.dk>
Date:   Thu, 31 Aug 2023 11:59:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: fix IO hang in io_wq_put_and_exit from
 do_exit()
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20230831074221.2309565-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230831074221.2309565-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/31/23 1:42 AM, Ming Lei wrote:
> @@ -3313,11 +3323,12 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
>  	atomic_inc(&tctx->in_cancel);
>  	do {
>  		bool loop = false;
> +		bool wq_cancelled;

Minor nit, but io_uring generally uses US spelling, so this should be
wq_canceled.

>  
>  		io_uring_drop_tctx_refs(current);
>  		/* read completions before cancelations */
>  		inflight = tctx_inflight(tctx, !cancel_all);
> -		if (!inflight)
> +		if (!inflight && !tctx->io_wq)
>  			break;

Not sure I follow this one, is it just for checking of io_wq was ever
setup? How could it not be?

> -		if (loop) {
> +		if (!wq_cancelled || (inflight && loop)) {
>  			cond_resched();
>  			continue;
>  		}

And this one is a bit puzzling to me too - if we didn't cancel anything
but don't have anything inflight, why are we looping? Should it be
something ala:

if (inflight && (!wq_cancelled || loop)) {

?

-- 
Jens Axboe

