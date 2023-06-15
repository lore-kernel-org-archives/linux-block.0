Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55C1EB64D8
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 02:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbjFOCWg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbjFOCWf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 22:22:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EE4268C
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 19:22:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-656bc570a05so1716631b3a.0
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 19:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686795753; x=1689387753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6+OtGQ2U+RZAIcscS2go2xf62JKef1IHh4L17JllKOY=;
        b=P+60U1KmK3vxLi6XhvFRbuCoFSKs2SXKamBCuvwoLyumGocZ5pS2ehUh9KTegWxst5
         LiWNZon1uQlkjV8QPcEZDNmexE9NeumBIOGksqYwD0Nx9a4imOOBbAVkQKtizeAppYiv
         A3kCQNW8ezLu5oQSwEaoiDW8JT774Iv3x8S+coUBnAcNv9bEpuyojRigimm7YhN/wOO9
         AYbDnKd8AHfykwl3sN1ynlovSjowHoZQ3fF7UAc2iYvZwd0SX8EIgaHiQ/p+P47FITsi
         caa0mvesS5eZ0cnXEvm5zCFdRt9guChrq26iUdKPAwUnC+8+9IwR2CNtPddpSEBbrPiP
         KLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686795753; x=1689387753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+OtGQ2U+RZAIcscS2go2xf62JKef1IHh4L17JllKOY=;
        b=DvdPC7/FXra/c8rr7Nur61bHsAIDewo4ajNQ0QjGKTS1AVqeGrfUCqlhAdff8qoDBV
         0+yYR3FmIU9gDZshpoSbZQ+UCuhYyEfM+IoN+XmAm9tm99/cUus40cE4bEJ9mh+KrvYx
         UPErXasw/M+ntqf5ix3PzyANs3virVGBin9xbkiz6GDsnfKlclYCKgp+Kl32Gu91JA9C
         6ZWbJIy9VMZCJweT9Xjoq406AbpStBel0kbwhxfKCXkkTs5VCFtR3inqugOLrbD0VjSh
         Yzb+J/M4tRPqaESb4bjZmxdHaFdVuWUriv67/zLyR97V1E8BCeDgNF6w9yVuAW4Agrxy
         2gGQ==
X-Gm-Message-State: AC+VfDy2ny8Qh2Sj0Zt6eW4VcgY/B32t4m2g1K1xGI2EReR81aknZ/B0
        //iHYcNpI+eh6kwAberZXybCgA==
X-Google-Smtp-Source: ACHHUZ4w60/za3x3+f3zN+/SvlWwue/H+HEY3+BGoHy45Vxh0dd1Gnpnyiq97D5jk2mf22OAJzpdVQ==
X-Received: by 2002:a05:6a20:3d28:b0:117:2125:559d with SMTP id y40-20020a056a203d2800b001172125559dmr21359267pzi.4.1686795753253;
        Wed, 14 Jun 2023 19:22:33 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b0064cb0845c77sm10933821pfn.122.2023.06.14.19.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 19:22:32 -0700 (PDT)
Message-ID: <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk>
Date:   Wed, 14 Jun 2023 20:22:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/8] Support limits below the page size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>
References: <20230612203314.17820-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230612203314.17820-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/12/23 2:33?PM, Bart Van Assche wrote:
> Hi Jens,
> 
> We want to improve Android performance by increasing the page size
> from 4 KiB to 16 KiB. However, some of the storage controllers we care
> about do not support DMA segments larger than 4 KiB. Hence the need
> support for DMA segments that are smaller than the size of one virtual
> memory page. This patch series implements that support. Please
> consider this patch series for the next merge window.

I'm usually a fan of putting code in the core so we don't have to in
drivers, that's how most of the block layer is designed. But this seems
niche enough that perhaps it's worth considering just remapping these in
the driver? It's peppering changes all over delicate parts of the core
for cases that 99.9% don't need to worry about or should worry about.
I will say that I do think the patches do look better than they did in
earlier versions, however.

Maybe we've already discussed this before, but let's please have the
discussion again. Because I'd really love to avoid this code, if at all
possible.

-- 
Jens Axboe

