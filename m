Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826B1C4332F
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 22:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiERWlK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 18:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiERWk6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 18:40:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513642FFD2
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:40:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so7011048pjr.1
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6CjLHJv2KA3UYpol8fjDDq5hkiBotVVzrhywge1qyNU=;
        b=wrJMFTIQ7Yp9Uql3VLw0P3eZsDs+b1JV9KcU/0cWmfEKtzb2nHz9qQOWcknqiv3wB6
         Qe/tgV7Wd1ZHgM0PLCX4x70ixWK4nzzI8BoHFoJI7M5IVH+dxrvEfNoN7lwgKCD2f3s1
         SssvyCbsFzUf3QgcSJFKnLglCQxAspEBBcIEcsJDQCshhG6gmosFUSSFrwSOE+2aeTrU
         2lNPrBXDbYcs5PXq5jKYOuXIF1vCRi6YBouhmgTOE0bqz//uobUJex8BrlGWvPJWaR5i
         sNQ5I6zJ8fIjyybnFPYO1nhn+R5wcXeiyVTVwrufjzrTk7Hnrt7K/zVniZVpM1tdT3X9
         TXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6CjLHJv2KA3UYpol8fjDDq5hkiBotVVzrhywge1qyNU=;
        b=OrdcXnJYDIQJLJYyUIFQJvXXXqjgttEBuT90YXBF2EDhvjvPPp6XS04R1+z5N6R0qT
         ycn9CgNWEGOQze4/XYf7CER4kOarRvjDwgnH4Xq909lKG03ue8kn2SHSH+C0gwnixqpw
         WdnQBx/Ud49NX7yyCWmgzKBwkLfX39Lc5nPGCc9Dw18ohyYqO/V/SNFia9qp/DLqmkx5
         A9O+Ce+0j3QCXxaURLjw2I+Zk7bRiyaGQrmplC/t2zpyq1Jn8Jbm/iUy98eB7efiz3kB
         pTBeldrhUpJMy0SffZ386bGPixu3dX8M7B7sOTFtVX5d5XEOdq2L3B82mWzFbDvDhGhB
         Lf4w==
X-Gm-Message-State: AOAM531ZJAPn6ju8PaPC9vfesMpZneVe8ic9fyOT0Y9V+JGEpL1oN/rM
        MC0AQ1pue3LRYW9t3Yoy1OvGbA==
X-Google-Smtp-Source: ABdhPJzs5D3xiswFdU/ktExKQiuNvoDQe4ombx0sc+ixFqOYLAZByoojFMvCFdJR/wrJj7TUPZJQmg==
X-Received: by 2002:a17:90a:940d:b0:1df:359b:2f9e with SMTP id r13-20020a17090a940d00b001df359b2f9emr2261914pjo.235.1652913656802;
        Wed, 18 May 2022 15:40:56 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0015e8d4eb277sm2151000pln.193.2022.05.18.15.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:40:56 -0700 (PDT)
Message-ID: <28682d9a-ac58-ea19-6d51-73fbd87bfb5e@kernel.dk>
Date:   Wed, 18 May 2022 16:40:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: cleanup blk_execute_rq*
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20220517064901.3059255-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220517064901.3059255-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/22 12:48 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the blk_execute_rq* helpers.  It simplifies the
> plugging mess a bit, fixes the sparse __bitwise warnings and simplifies
> the blk_execute_rq_nowait API a bit.

Looks good to me, but let's do this series post flushing out the
initial bits. It ends up depending on the passthrough changes,
yet also conflicts with the nvme changes on the driver side.

-- 
Jens Axboe

