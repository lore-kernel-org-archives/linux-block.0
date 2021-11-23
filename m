Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0F9C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhKWTCO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhKWTCI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 14:02:08 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2428DC061714
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:58:59 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id c3so29369166iob.6
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tGfp1w1ytjxMcyCYD3ngzFiXT+Qt5vEq4RSm91bnKKQ=;
        b=H33/0yUwyXbCqQWlfsnX1XtbN5sy4EOD0ghnd87/BiQuQuddYtt5iDTl3D6PQuZlHU
         d/lqdg723/YGh5RsAZeuhP3rnDSc9kh7AtGHWl6RH9kmMAZCbj4LexMe1MN6p7pwh1A1
         bkLi+28pBruxUtISJz2AMlFDXTXsQiyGlElnREJqVBYLh+PhV3iR5XzUIsi8SVzd2CsE
         MTVhF53p3guJwT16RwArb9r0PvLdBmcz/gltW/daKmgltiDORuqUvcMdRA6wXDhjOahS
         q9F4zr/xj4KuuuVBhuC0D8GUFiRJQN7H+6Czz03bsZWmPSM9jXs2oNJ/tTWP12CPPi2z
         xO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tGfp1w1ytjxMcyCYD3ngzFiXT+Qt5vEq4RSm91bnKKQ=;
        b=YXqqlPxCO5an1HIbAXMlhkeTALY1fXQxdtLWAltyXCw3ZL6c+7BaszxDbt1cfSqSxk
         Eyeh0J+18sMoxrv1l4rt9piumQBEeJ4VfFYqfUcLz78JHRJVvMX0vQuTezkQIrBNPW4l
         GPez8u4Psi2Fi8lX/7j/CLSvtnOGSuw2zeGPXCSrh/MKx3O/bEXKSbCNJQMHAogUDUmN
         SSs+pldoczmYInEZnS2Ikv3PyoEq3IiFfWF2uc/A5CpsgUTuCFXWVMNP1xGmBM9RiS4B
         3ftNK/KWOa4ty9FT6NE4jp38uMRUW2kQTcXSMwjq5ZGNpXCxcOgDZbfeXNvFL9xo7oeq
         BGdQ==
X-Gm-Message-State: AOAM5333yHyOPQEeG8lAUEpIkUiY0HWpSjRTpHEr0NLDj0E0n854U78m
        6Q7ui6P8dVoY17J4NhZ4mHxaxzEP3DgjvyC6
X-Google-Smtp-Source: ABdhPJzUEjZs4d1R5g837deOQFul8mBqGqCn/WFFjk4vxCs+lNs/EXrrAJ82VfL0W4XL9HoeOzQDSA==
X-Received: by 2002:a05:6602:1224:: with SMTP id z4mr8553307iot.43.1637693937799;
        Tue, 23 Nov 2021 10:58:57 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b8sm6004627ilj.0.2021.11.23.10.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 10:58:57 -0800 (PST)
Subject: Re: [PATCH 1/3] block: move io_context creation into where it's
 needed
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211123171058.346084-1-axboe@kernel.dk>
 <20211123171058.346084-2-axboe@kernel.dk> <YZ03AMGXFVAGoiUo@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cab90aaa-96e4-1e77-2a9d-133f01535c55@kernel.dk>
Date:   Tue, 23 Nov 2021 11:58:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZ03AMGXFVAGoiUo@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 11:46 AM, Christoph Hellwig wrote:
> On Tue, Nov 23, 2021 at 10:10:56AM -0700, Jens Axboe wrote:
>> --- a/block/blk-ioc.c
>> +++ b/block/blk-ioc.c
>> @@ -286,6 +286,7 @@ int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, int node)
>>  
>>  	return ret;
>>  }
>> +EXPORT_SYMBOL_GPL(create_task_io_context);
> 
> No need to export this now.

Indeed, killed.

-- 
Jens Axboe

