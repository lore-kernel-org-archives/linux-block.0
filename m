Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E119EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 23 Jun 2023 20:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjFWUIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jun 2023 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjFWUIj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2023 16:08:39 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053911FC2
        for <linux-block@vger.kernel.org>; Fri, 23 Jun 2023 13:08:39 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b512309c86so7917035ad.1
        for <linux-block@vger.kernel.org>; Fri, 23 Jun 2023 13:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687550917; x=1690142917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ek0/4Ziuu+Jca9bMLVh+okjyQvrjuaP1VZAPdLMRpg=;
        b=icIF4orcjojiZZnDUnR1lUp+cc1gL8UhHF/ApTQ0WtJ/KZQWQwgPux961eQkpuZSYv
         BZ/aLLmNNbELPbmkWK1Y6Z3AQpMllM+t5Zezp5a3pkxmXiC2hVSp89VhZnWjANDOrtic
         kGjg1UjaHumDW7A97S60G6Yc/SQmQFWQehjv2VAg8mnh8gyAfm1rA/pbOwsJ3noaBtGr
         fLx2MyyyxC1+WUi4Jj77VQ1qE5Xclkfim1RwkDGNsS2LRL1cfzZqf+FUGNacmjbf0ATJ
         fzs4B5uOKGuiaP6ltdOPGSj5FbzKRMMzDXqv43DPCSNCdasRzJBZQlWrKBoulAU6GGxs
         07hg==
X-Gm-Message-State: AC+VfDz0yCDSrbcTcXxEswRZ4ir+5pFiQsFr4alccEBbB2s6cVjxxR3P
        vpOUVMG5Y/D5Z6BSYYbJvNE=
X-Google-Smtp-Source: ACHHUZ7GhUP/9Avkcuo7Ngxb+v8tbS8GnKm8zrZw4trzNnPvxNVOR2DUME7hBjECyiN4TRudqfCq+g==
X-Received: by 2002:a17:902:da84:b0:1a2:a904:c42e with SMTP id j4-20020a170902da8400b001a2a904c42emr140379plx.24.1687550917083;
        Fri, 23 Jun 2023 13:08:37 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f2:1321:dd41:5ef? ([2620:15c:211:201:8f2:1321:dd41:5ef])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001b6740207dbsm7514767plb.214.2023.06.23.13.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 13:08:36 -0700 (PDT)
Message-ID: <6e57f158-a98c-0355-25a4-2d12f3ec0b23@acm.org>
Date:   Fri, 23 Jun 2023 13:08:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/7] block: Preserve the order of requeued requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
 <20230621201237.796902-6-bvanassche@acm.org> <20230623055053.GE9085@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230623055053.GE9085@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/23 22:50, Christoph Hellwig wrote:
>> +	blk_mq_process_requeue_list(hctx);
> 
> Should this do list_empty_careful checks on ->requeue_list and
> ->flush_list so that we can avoid taking the requeue lock when
> these conditions aren't met before calling into
> blk_mq_process_requeue_list?

Hi Christoph,

I agree that checks whether or not requeue_list and flush_list are empty 
should be added.

Does it matter in this context whether list_empty_careful() or 
list_empty() is used? If blk_mq_process_requeue_list() is called 
concurrently with code that adds an element to one of these two lists it 
is guaranteed that the queue will be run again. This is why I think that 
it is fine that the list checks in blk_mq_process_requeue_list() race 
with concurrent list additions.

Thanks,

Bart.
