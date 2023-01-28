Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8496AC38142
	for <linux-block@archiver.kernel.org>; Sat, 28 Jan 2023 02:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjA1CtC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 21:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA1CtB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 21:49:01 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B06C14EA0
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 18:49:00 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id 144so4472588pfv.11
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 18:49:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALv3IajnYqBwEbZwMHxRLgVmK0t3Zs8Bgo9cdHJGQtw=;
        b=pxXif0V7D3NN3mpsvV1oh8SZjgPvYAzvp+qCSWe3+bDTl0wPof3rz8JriG4Jkz8asz
         e+pTr6YSLUEWQwHwkjKt1wSfa+R2bxgI1Aq8FRYCYNkxeCZaghy/G5XM0j+bKUc8RrmY
         ONqgRxlGjB+UzLKImpOBuwz9eMz3FDaA9R9Q1Blhsuu43q0ivJAUDRJKRNsw5oEBsAaK
         5Dvsm/iNfRshxXq0dm2gkisCvOeEKVPpXFB7e6ChXt+16BVADY9VW0b9SiaZ3M3gPfRe
         UVLw0gDwTlrY7hcKxU1xpAite4ovtaTEnVIQOecabqaXiWn7ONYSAVmaAoBui/O71Fhk
         wz1A==
X-Gm-Message-State: AO0yUKXwawWp3oACr7vFGGHpH9Pv97HHjRxeHwTDmHEyL2rX2N9Wy4i6
        2E+28FRi47hojO+jIOqFnNE=
X-Google-Smtp-Source: AK7set+px1sIqkTJasasSDzGyMZZ/ikvww7waBMsy24x3kr17Qz4dMslX4rvxNUFcAMCxILHwnjndQ==
X-Received: by 2002:a62:64cb:0:b0:590:1bfe:cf63 with SMTP id y194-20020a6264cb000000b005901bfecf63mr11809492pfb.24.1674874138928;
        Fri, 27 Jan 2023 18:48:58 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b3-20020aa78103000000b00582388bd80csm308418pfi.83.2023.01.27.18.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 18:48:57 -0800 (PST)
Message-ID: <beafab98-df34-8f1c-1108-7e61080a7e21@acm.org>
Date:   Fri, 27 Jan 2023 18:48:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] null_blk: Support configuring the maximum segment size
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20230128005926.79336-1-bvanassche@acm.org>
 <ff478889-7a02-135f-57b6-f56d386d7065@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ff478889-7a02-135f-57b6-f56d386d7065@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/23 17:18, Damien Le Moal wrote:
> On 1/28/23 09:59, Bart Van Assche wrote:
>> +	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
>> +		  dev->max_segment_size);
> 
> Shouldn't this be an EIO return as this is not supposed to happen ?

Hmm ... the above WARN_ONCE() statement is intended as a precondition 
check. This statement is intended as a help for developers to check that 
the code below works fine. I'm not sure how returning EIO here would help?

Thanks

Bart.
