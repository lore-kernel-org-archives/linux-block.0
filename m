Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF3CC43334
	for <linux-block@archiver.kernel.org>; Wed, 13 Jul 2022 23:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiGMXqh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jul 2022 19:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiGMXqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jul 2022 19:46:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6D6419BF
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 16:46:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so607195pjl.4
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=goY5s09yDjamY/zMU5kBbCD+EHX29aLygMcuT7F3v0c=;
        b=C2qLSZl8ptTZ42zHdHCxk2BOy9WdHv80VIgEhOva6Wl6xohe3GYNyjEp0ABlzOqOPb
         2n0TI1esjW0E/mjTX1bXdvHPK1FMPyToxYwblhrJ4UG87MUSH/MgQhx9RDfZmor1WRlK
         BpvLYoj44+0u53zAeccpa4OYasWpehzTRdFJyaxomBJ9QNUkVnQURO1WCkB8QIoLkpAo
         7g6oQNxWhEQ45rQonxsKPOBZQh5SAJEToJfTMaOF0HJwowUMPzb6lYWDr+gqF5sNzhYJ
         wh0ccoZEn2uKAcF+nfwbs1Orl2chaMZEAMJJHEgxR8hxc4Rc5lo8fPxCuRcd023ervJv
         7TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=goY5s09yDjamY/zMU5kBbCD+EHX29aLygMcuT7F3v0c=;
        b=AQmoge6z0A3zeYf5PrK7sdv8eivxTjz/6A26ibxtYAJd7QljZH69A8GNrzBp1Xjbeh
         t9WvOcSXk2erFjv77igJc1ByRK6ZzjABZvaw/avqZEjJpNNUddVcZNfsUrztRTkQ6qzR
         YBf5D9VtpUoqw/9bWI2B4FLPgfLDSYNZgqjXFiIxL5rbNeDKFh+v5BeAYnnpLR97Qo+n
         o4qUNcAACpi3LMD7lM5A1E0EEZXbuoVMB7R3Xxzwpd83+7N4dHjJ/lh2NTL5yFDPCyWR
         ACLXmn0zaQf173lV/hjNZyaUggD8m1nCxxEt9kVtVQKcWluImM6lAyqUnKda6Wxhe0xe
         q67g==
X-Gm-Message-State: AJIora9wqgL5aCDsOd0k8toAgMhSPjyYdEiE7uYGw3JG18vJfgxs8ql7
        yE77uLyDkbA45jFvl4Hv8CA5YA==
X-Google-Smtp-Source: AGRyM1s+e0Sys0LuGyWP0xkZpSFlrftoz+VqgKP2/XtxSADN2j6AUd5sbSqWzTIneLlO/yMEXjYSJg==
X-Received: by 2002:a17:902:c992:b0:16b:d8b9:1c5f with SMTP id g18-20020a170902c99200b0016bd8b91c5fmr5364819plc.93.1657755995336;
        Wed, 13 Jul 2022 16:46:35 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79ae9000000b0052ab8525893sm106545pfp.142.2022.07.13.16.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 16:46:34 -0700 (PDT)
Message-ID: <ee65aa8a-2e74-9a7a-f8e6-11266744a326@kernel.dk>
Date:   Wed, 13 Jul 2022 17:46:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 00/63] Improve static type checking for request flags
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <d1a88d4f-9f03-a1d6-cf4a-fcdb8070399c@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d1a88d4f-9f03-a1d6-cf4a-fcdb8070399c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/13/22 3:48 PM, Bart Van Assche wrote:
> On 6/29/22 16:30, Bart Van Assche wrote:
>> A source of confusion in the block layer is that can be nontrivial to determine
>> which type of flags a u32 function argument accepts. This patch series clears
>> up that confusion for request flags by introducing a new __bitwise type, namely
>> blk_opf_t. Additionally, the type 'int' is change into 'enum req_op' where used
>> to hold a request operation.
>>
>> Analysis of the sparse warnings introduced by this conversion resulted in one
>> bug fix ("blktrace: Trace remap operations correctly").
>>
>> Although the number of patches in this series is significant, the risk of this
>> patch series is low since most patches involve changing one integer type (int
>> or u32) into another integer type of the same size (enum req_op or blk_opf_t).
>>
>> Please consider this patch series for kernel v5.20.
> 
> (replying to my own email)
> 
> Hi Jens,
> 
> I think that everyone who is interested in reviewing this patch series
> has had sufficient time to review the patches in this patch series. Do
> you prefer to queue this patch series for kernel v5.20 or kernel
> v5.21?

I've been pondering the same. I'm fine with going for 5.20 as this will
be a pain to maintain, but the first patch doesn't even apply to my
for-5.20/block branch...

-- 
Jens Axboe

