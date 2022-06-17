Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0DEC43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 18:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiFQSZq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 14:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiFQSZp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 14:25:45 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ABA3192D
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 11:25:45 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d5so4527482plo.12
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 11:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TpfDZIJDTOYGLVeEunX3azo5Zy9nVDPKvXJO3qdUTS4=;
        b=S4U1xYUt96Ge9J+5m4O1ynwZ6MDW5p11EIUzlr/DjP5w+/lrIP5RZS0RWeMFGzJ2/o
         WRq3QE5hPqQQ1Lvcq+op3Xl4k4Hkl8w4mEnmwm3Bfn2fiH3xroedWuynudnGf1xp7w8K
         VF+QBmOfvHI9/caia57oXX7BgTkFf+JTId24Rl2e4FekTrANEmYZ0bVUDYaab9dap4v5
         x1NYeOGXQfdTNXz5HlSMu5UsL9mvlyDgGGLvmNkmko/t01QeLtXEiPMyBP/FF51tXT5S
         VpqpYNS12w4E51LHDx6k7iEsHiWr93wFc/jh85cj7MI2NQOmRXNdjjtryN9s9Gki9+Mq
         aMlA==
X-Gm-Message-State: AJIora8dctHO0CCmDnPlT5l8sRc5s1lGKtmTskdjTO+GiW7tHRppIYn6
        9mAmDQl5sxRD8XwKWvypfyI=
X-Google-Smtp-Source: AGRyM1vTy2dvYxcxqJcO/NwDkJd6K99I08Vit65OFHAjdofI1kKAiEe0n+koFDtrKiUAfZ9mCMMvtQ==
X-Received: by 2002:a17:90b:4a90:b0:1e8:626c:e1b2 with SMTP id lp16-20020a17090b4a9000b001e8626ce1b2mr11840790pjb.141.1655490344461;
        Fri, 17 Jun 2022 11:25:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d24:3188:b21f:5671? ([2620:15c:211:201:5d24:3188:b21f:5671])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902d58700b0016403cae7desm3880863plh.276.2022.06.17.11.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 11:25:43 -0700 (PDT)
Message-ID: <d510cb62-4b19-9ae0-cad4-1ca6756cc3fd@acm.org>
Date:   Fri, 17 Jun 2022 11:25:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/3] block: Specify the operation type when calling
 blk_mq_map_queue()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20220614175725.612878-1-bvanassche@acm.org>
 <20220614175725.612878-4-bvanassche@acm.org> <YqkoWUjOPgpqzn4E@T590>
 <20220615060851.GE22115@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220615060851.GE22115@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 23:08, Christoph Hellwig wrote:
> On Wed, Jun 15, 2022 at 08:31:21AM +0800, Ming Lei wrote:
>>> -	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, 0, ctx);
>>> +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, REQ_OP_WRITE, ctx);
>>
>> The change itself doesn't make a difference, since both results in choosing
>> HCTX_TYPE_DEFAULT, but passing REQ_OP_WRITE is a bit misleading.
> 
> Well, the argument is an operationm so we better pass in a correct
> operation (at some point we should look into a __bitwise annotation
> or similar to make it clean).  And as 0 is REQ_OP_READ, we will end
> up with the HCTX_TYPE_READ hctx IFF someone configures read queues
> and uses an sq only schedule.  Which is a completely stupid but
> possible setup.

Hi Christoph,

I looked into adding a __bitwise annotation for request flags by 
introducing a new type that is called blk_mq_opf_t. Introducing such a 
type without modifying a lot of code seems difficult to me. This is what 
I ran into:
* If the type of the operation type constants (REQ_OP_READ etc.) is 
modified into blk_mq_opf_t then their type changes from 'enum req_opf' 
into type blk_mq_opf_t and sparse complains when passing e.g. 
REQ_OP_READ to a function that accepts an argument with type enum req_opf.
* If the type of the operation type constants is not modified then 
sparse complains about bitwise or-ing the operation type and a request 
flag, e.g. REQ_OP_WRITE | REQ_FUA.

I'm not sure how to solve this other than by modifying the functions 
that accept an 'opf' argument into accepting an additional argument 
(enum req_opf op + blk_mq_opf_t op_flags).

Thanks,

Bart.
