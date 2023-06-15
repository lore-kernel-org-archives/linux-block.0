Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82409EB64DB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 02:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbjFOCBY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFOCBX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 22:01:23 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D811720
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 19:01:23 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-652328c18d5so5582647b3a.1
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 19:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686794482; x=1689386482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+np2jJ+fgXlMo6P7rVifpv08sdWoKw4zO8u5LsV/zo=;
        b=GJxxDiOlbT2+JHe4lGHd1k1DeYFP4f+2JOKMHlG6SM0m8nigBesy4KGReM9WKt9JgM
         tHnWCSWNMLF3mQ92lIBJfJH/LFZs1kg8HtkDb+V/PvaB/XP4SWixSPH2h7rv6ts/uTF6
         xFBsI1JJ2UVhn0oNsLHuPQ2F0Q7T4mYcsRK63eOpUhJL6KnSK9YwySsOG2FVb5WjKhcq
         iPA/jkNzr+wokMBVseAkCQUhcGYAzhFIYL60mMI+MVFHyqjEhunKr5S0oCyE+iSRKfiQ
         DKWVkr/L87J+CVJXJK0dokX8Vmljr7KnwD8iG1AanUsW/8/cC6a2KkqyF5wugk8jm7mI
         JixQ==
X-Gm-Message-State: AC+VfDwlCqHxX3h0VzF+eGTDSabwTwXsrhheY5PCx2Ru/TpQxOgJM5K9
        9V4Rb2nyVF8M74yiBmai53A3kpliwGA=
X-Google-Smtp-Source: ACHHUZ5qvZWhmYyHuWZQEfoAm1c7YfOhuIJN7PvZrIbTcDP2rq5NwHq5wZ/R5pmC9GGCkaZB8l56Vg==
X-Received: by 2002:a05:6a21:6da4:b0:10b:8bc7:e112 with SMTP id wl36-20020a056a216da400b0010b8bc7e112mr3046599pzb.10.1686794482297;
        Wed, 14 Jun 2023 19:01:22 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001ae7fad1598sm7518007plk.29.2023.06.14.19.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 19:01:21 -0700 (PDT)
Message-ID: <d583c3d8-a574-7e76-2b28-42870e104979@acm.org>
Date:   Wed, 14 Jun 2023 19:01:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/8] Support limits below the page size
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>
References: <20230612203314.17820-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230612203314.17820-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/12/23 13:33, Bart Van Assche wrote:
> We want to improve Android performance by increasing the page size from 4 KiB
> to 16 KiB. However, some of the storage controllers we care about do not support
> DMA segments larger than 4 KiB. Hence the need support for DMA segments that are
> smaller than the size of one virtual memory page. This patch series implements
> that support. Please consider this patch series for the next merge window.

(replying to my own email)

Hi Jens,

Can you please take a look at this patch series? I think it is ready to 
be merged.

Thanks,

Bart.

