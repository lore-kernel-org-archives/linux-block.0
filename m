Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1ABC433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721B560FDC
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhJNPrp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJNPro (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 11:47:44 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C33C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:45:39 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id x1so3988773ilv.4
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nzUAxpbzpFLx2T9iGWk9VTaKLPNY65CW5UI1LTXY7l4=;
        b=WgvK1gjcwHE7SNPc4Rcr6NG5cKJ5CPjvHNBcF7Jag38hxlAIrGeC/Ofuy1wN0kft2D
         nHgCQxHasHHTBRVh9ZGLoSqpG/4sUFtpTwG0wcyEVCnk2qyVRgrexTC3wSjEJwf6h83U
         gcGxODhmk8SMeeFzDWu1O5xO9v2jo8i4RnBkOYBlTh7HX/mF2wRY7eMVajePIR4NuB2Q
         L+HnZBWyS0MGld7wSDVHx85re5UBrpVsBQ00xrDJpZjl6eOlT4iM5DuBTXTK7+H2kLI6
         J4boUJXmJRTS6HMt/Kg1PVBMHRr73t9N07Ijc8YyrJXkbmBSpRGaH/VOTbxmZZWKPgPZ
         zJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nzUAxpbzpFLx2T9iGWk9VTaKLPNY65CW5UI1LTXY7l4=;
        b=HzV/76dPX9fjjV5vskezcyEplZUKRBJRTPiz7UBJo+GHCcxGFBmiwvbjk54qNaQjbA
         S57iwCP0HMoWiZGJCBoE1ltmUXmP5lIzCum1aIkusPaV8VqU7YF3BTU4MDrQn0POoiHS
         0FXRObMUesgHlZ4/xDOWqlX7NrHMVyfotWjsXU6rN84AhGRpZgB6we8gAd53emFgiYft
         ymi5uf8DM6jVITtswdALXSJ9v7ITTx7tzd2XoYBbq2gkbsd8+Y8ciicKmvqwxiwEajt5
         g37cjZebYBv6qFHkm10nAvC9Moh7HKMosyJ+tLZ5R1pN7oYVsfBVF0F42t3NJMrzU3dG
         TiGw==
X-Gm-Message-State: AOAM5312YKqjPs4tAYneqGxe4ol9yW49eF2rogz5hZYEKMaArSDzBjDY
        K4y4+JbKAbc4Yv1208pSblD2YxX74YU6Og==
X-Google-Smtp-Source: ABdhPJxBmPI/SvCPjU/HDkmaCnbhyq+ZU0yw2CCHXqU2P0OWxucNqwiXLi9OEJDiP64vjDkHCNlx2A==
X-Received: by 2002:a05:6e02:1e02:: with SMTP id g2mr3002807ila.89.1634226338880;
        Thu, 14 Oct 2021 08:45:38 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i18sm1644974ila.32.2021.10.14.08.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:45:38 -0700 (PDT)
Subject: Re: [PATCH 8/9] io_uring: utilize the io_batch infrastructure for
 more efficient polled IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-9-axboe@kernel.dk> <YWfkVtB+pMpaG2T3@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ed66f47-6f5a-39b2-7cd8-df7cf0952743@kernel.dk>
Date:   Thu, 14 Oct 2021 09:45:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWfkVtB+pMpaG2T3@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 2:03 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 10:54:15AM -0600, Jens Axboe wrote:
>> @@ -2404,6 +2406,11 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
>>  		struct kiocb *kiocb = &req->rw.kiocb;
>>  		int ret;
>>  
>> +		if (!file)
>> +			file = kiocb->ki_filp;
>> +		else if (file != kiocb->ki_filp)
>> +			break;
>> +
> 
> Can you explain why we now can only poll for a single file (independent
> of the fact that batching is used)?

Different file may be on a different backend, it's just playing it
safe and splitting it up. In practice it should not matter.

>> +	if (!pos && !iob.req_list)
>>  		return 0;
>> +	if (iob.req_list)
>> +		iob.complete(&iob);
> 
> Why not:
> 
> 	if (iob.req_list)
> 		iob.complete(&iob);
> 	else if (!pos)
> 		return 0;

That is cleaner, will adapt. Thanks!

-- 
Jens Axboe

