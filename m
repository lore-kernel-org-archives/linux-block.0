Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6C2C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3C720735
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 16:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391034AbhAZQTn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392378AbhAZQSj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 11:18:39 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A100EC061797
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 08:17:57 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m6so10717484pfk.1
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 08:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=epgYCzdc72kBsoz5/bU1Ciqhlsremw0jcEwfc6vQq00=;
        b=buKxZXNp5UJibZh3nqNGwDHf3vzgy8HQqITHVHIP8ptalwP+WFPqWHplJ+ssAzYibz
         s0Z/Bn+EcuBbwJ5mxpTlbFnUjNFS+OrVHV83Xt03WmpI3B8811kASQXjlI0+xMQkGLKI
         Vw3e2kfOsTThCoPNgAqMCdjTfjlcuWguu8xPidiIargUNrEA0KFJ5P2A4GdBMKPLbXyB
         L+RBnTA0ITU5/w67h/91KqZg602FKiYNTpMg8sz53BTpM7xYT835NPMcmWRfDnD+covK
         0utH7WDNIODvHxfVHRKHUVtWhn+aLevkJkcmuEU9l4opE9a63Qefhgp5EF+bsUicN4eu
         bl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=epgYCzdc72kBsoz5/bU1Ciqhlsremw0jcEwfc6vQq00=;
        b=BU7sEVV4mlU2yiSXxI95x398fOvne6Mx+/LqRPXyEQ0CURluJX7DXGWyMc52KImFEr
         5QULOn2QUrQua2HpuEZ3lbSsx8tFJyI2rg3FrIVaP0QiYMmwoaRycH/K4XtvUr4O2fV5
         luqz0fkaEVdBJl9XyFpws7vdy3rHjwkU0QP77S0m+P7R6Vpq7viPHmtj1adDNeoZ9ro3
         wauLOKMcPzjgDt81KC2hLZfGS8nOFQrGknet9Dx0xRglg1KlGh1Svzz3F4/8Gg63mb8f
         D594K1DHZzTkaYx90DnW22N39ZmvYwWNs8uJnjz1LLBUqCvXiuIVi7m+do2fDm5puSP4
         U+mA==
X-Gm-Message-State: AOAM533Bdyk/moRSgcOVtyqPeWanOi4/TAxnmV5EIHrGeMVKlQpwbW74
        Wj0FPam14eKrYQixRhKprKseSg==
X-Google-Smtp-Source: ABdhPJzayUmLqyp84K+wfgc4GWyTILacj8dMzGotGEXVhIXyu2CQpO/Go5PZbRnMpxoOHjQZaYTcTg==
X-Received: by 2002:a65:52cc:: with SMTP id z12mr6261716pgp.116.1611677877191;
        Tue, 26 Jan 2021 08:17:57 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a2sm19528814pgi.8.2021.01.26.08.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 08:17:56 -0800 (PST)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 1/6] block, bfq: always inject I/O of
 queues blocked by wakers
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
 <20210126105102.53102-2-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23cc8281-a869-b260-ba0c-22127db2019b@kernel.dk>
Date:   Tue, 26 Jan 2021 09:17:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126105102.53102-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/21 3:50 AM, Paolo Valente wrote:
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 445cef9c0bb9..a83149407336 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4487,9 +4487,15 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
>  			bfq_bfqq_busy(bfqq->bic->bfqq[0]) &&
>  			bfqq->bic->bfqq[0]->next_rq ?
>  			bfqq->bic->bfqq[0] : NULL;
> +		struct bfq_queue *blocked_bfqq =
> +			!hlist_empty(&bfqq->woken_list) ?
> +			container_of(bfqq->woken_list.first,
> +				     struct bfq_queue,
> +				     woken_list_node)
> +			: NULL;

hlist_first_entry_or_null?

-- 
Jens Axboe

