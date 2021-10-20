Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28239C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1214560ED5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJTMZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJTMZT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 08:25:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E5FC061746
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:23:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso9788111wms.4
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EcuqnnQYFj7gLtjloOJOgw3afh/ffUsiaju5o8Agzog=;
        b=B3anBNgXJT78uXajt9UqkYj24+mFi00u/7vW48UUyOVrXMknpVwFVTR4YrwT4lEe1E
         LFo3+EaK2xVSMtV5LIcBHrskHUs90+GaLEPBXL578Uie4eb0No+VGrcnaJmSbHVlBhoP
         BbQnk1y+MJ8USLy127uukRIKV/kf6+x1SDWY03hI8GFKX/KorKb2edrfWj4gGFrG6oO+
         INKq7EsjYV1tRDQrxamMRAX9n02Hc5IUanja3cqnS1h5xJ89SdwQno5gIRoP4a0vOtQp
         OQm2/gm3Y4Qa+Riv+V6jgX4z0k7SA4jiiGJMSEzzZ2R9csVtYyj3FIBG0nAR/jEpDT+K
         rJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EcuqnnQYFj7gLtjloOJOgw3afh/ffUsiaju5o8Agzog=;
        b=Fo0VW4Ay9E41eXXFW0lCyfTyTdJPxI49D7oF1WN7dDvUGcW3cD6VPLDD8F44ItSJuz
         gRk1y6s0OZEwDtTfMrnPcThGfRKzxs/29wx4bReyeSmRLZoMxehBW1fYq7GO7FT6P5yb
         cSWtw9g3XfuV4SXs2HJoH6tvI+64ui8qWv1+cFkZ8nAIoFSdzmhmv045PRK88L35A/w2
         /tiC4kQn8oW1gH7bV9Mbym4cl+lGkTZ1riKYk8aVGierexpQFQFA/mN1vWz5+U6ykROh
         K6sVTUE4wAH+vvm+OuYjL2erZGgk42exqofWOnDclp0SsBYE9cb3ZFrjksGUZrfrNgvr
         wv5g==
X-Gm-Message-State: AOAM532VfPlY5JMRO98kEVAhSgZ6hlMKMk/22/ZNsyztRAmKfWl7e51s
        YKa++s3lwaFJgzdXbB0rzls=
X-Google-Smtp-Source: ABdhPJxhRfFdXI2Ekazn+5mkHqnlJZ2emW2FIdl0CHtLdfhnDnupmVm2KT60dZjcA14ecSSz19hnNg==
X-Received: by 2002:adf:b748:: with SMTP id n8mr51482526wre.133.1634732583841;
        Wed, 20 Oct 2021 05:23:03 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id z1sm1785638wrt.94.2021.10.20.05.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:23:03 -0700 (PDT)
Message-ID: <366c2f9b-c255-7140-a2e0-d93856017bf2@gmail.com>
Date:   Wed, 20 Oct 2021 13:23:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 07/16] blocK: move plug flush functions to blk-mq.c
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <bb6fe6de2fe6bd69ccf9bc8af049ffedcf52bda0.1634676157.git.asml.silence@gmail.com>
 <YW+0h4nARoKeonn2@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YW+0h4nARoKeonn2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 07:17, Christoph Hellwig wrote:
> Spelling error in the subject.
> 
> On Tue, Oct 19, 2021 at 10:24:16PM +0100, Pavel Begunkov wrote:
>> Flushing is tightly coupled with blk-mq and almost all
>> blk_flush_plug_list() callees are in blk-mq.c. So move the whole thing
>> there, so the compiler is able to apply more optimisations and inline.
> 
> No, it isn't.  The whole callback handling is all about bio based
> drivers.

How about leaving flush_plug_callbacks() in blk-core.c but moving
everything else?

-- 
Pavel Begunkov
