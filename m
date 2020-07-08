Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F62CC433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CF8206F6
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hr0vTbH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgGHWhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHWhY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 18:37:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5525DC061A0B
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 15:37:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so26732pge.12
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 15:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q3UqSSyfIBC1rMGV9nALdXLQBVwoBmKfCFkzwkHahg8=;
        b=hr0vTbH1eQaQ1QoG8hJBW0VhUzgNK9r1JU5JPnbDRf7spnrKmRRaTpXgkfCXRgGT4e
         ttHdOXPDA7oT50viySeZXBWYZlf5vQXnoRWq6G7T3YreUxQQcwmYrXoNxo3TT51uMiV4
         2nnNWi7fxP2lbgQPd38h6FV3S7Ne+QtXv1WMORY++W0EhXFk0wNtaV5w9nP+rAqoggiZ
         gwX+RJBFBMEYzYW9vq+VU8asY5SAl0TOc4gndrjF5Mn6O5f1L5tJ2TYlPuai0iDT2Kdw
         Y1zGB/0UTFfXk1ZPoG97VKxJWFLHLb0Asuavx/6GM1V1AwwYWUF69q+DDRXVVxyhx84U
         9OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q3UqSSyfIBC1rMGV9nALdXLQBVwoBmKfCFkzwkHahg8=;
        b=WGMBK9D03+t8RG3jIQ5IvHjXD5CyGWb2BC6gcqCEXiCcniVMc/fsfbiBHwz3YF1qLb
         Ie2CXfU3j/ibORspd9UcIDJgA4k9VMp1fVi0rnSN8HkMBcnIvM4B/OUu8N3KVOnvFFjg
         FvQvcHEQg08zZvQGHYHzOu3a/H1Tp7DxlFP+VLn0UJx3/ACkG3wqoRJDGYGKZp5O7MCa
         09A/Sv1DW+LcpsfPFUdjcj2hd8JxhwRcV8sxA4hIZrQPx/526gaeq7CmL6SGWxADfSSI
         1qjkPwY9dJQwpL5tzLlgaG4rOBqYYB77LBJxBA7QlaGE22rRVE+iWVttduJodjqe5R3m
         nhAQ==
X-Gm-Message-State: AOAM5317BpON1M4BMRWjB7RMIOzGgITxhIjDRWSmtMGzMLz8SVzU4fgT
        aiWaVBI+/uhkhK/TklZGIPBfvQ==
X-Google-Smtp-Source: ABdhPJyKN5K8/iz33QUVfw+r+Vu8IJVeHNQDzaI5DOkexKvPwmp1jilnyQIzwi64s/K7n4mQx72hWA==
X-Received: by 2002:a63:380d:: with SMTP id f13mr49658491pga.16.1594247843851;
        Wed, 08 Jul 2020 15:37:23 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k2sm742530pgm.11.2020.07.08.15.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 15:37:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] fs: Abstract calling the kiocb completion function
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <20200708222637.23046-1-willy@infradead.org>
 <20200708222637.23046-2-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <983baa4b-55c6-0988-9e43-6860937957b4@kernel.dk>
Date:   Wed, 8 Jul 2020 16:37:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708222637.23046-2-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/20 4:26 PM, Matthew Wilcox (Oracle) wrote:
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index b1cd3535c525..590dbbcd0e9f 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -1045,7 +1045,7 @@ void af_alg_async_cb(struct crypto_async_request *_req, int err)
>  	af_alg_free_resources(areq);
>  	sock_put(sk);
>  
> -	iocb->ki_complete(iocb, err ? err : (int)resultlen, 0);
> +	complete_kiocb(iocb, err ? err : (int)resultlen, 0);

I'd prefer having it called kiocb_complete(), seems more in line with
what you'd expect in terms of naming for an exported interface.

-- 
Jens Axboe

