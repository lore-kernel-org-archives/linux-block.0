Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310AFEB64D8
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 17:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjFVRX7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFVRX4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 13:23:56 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD26D1FF6
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 10:23:52 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2553663f71eso3704665a91.3
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 10:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454632; x=1690046632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1cIWatiJb15S4YPjXyuCPTSA8kG2aIcuZC8GEmD03k=;
        b=bMMxOY9Y62OafrcBAAp2aJV9mSVEIZxB8ZMRuSh4hZY3EP0Ls6w+OdP4o6QmzhaTCL
         3YU8y8ZyTsxzOlgZ901/dCBXjuiyOz7NbvflELzg0Zl9i7rR3bSikFaIeYKYWyNDgIim
         L4McN2ASN0azGuM+CpCOUQZZrVqrXVZ7fI5sd88ft9TNsWjMdr17s11j/oCuapsbY+Oi
         ShoF/PQmFCluhvoiN7UwiOS4vwvevXbHRYSK+1CtRxIAtwXsgXEbpYMyEh5MRG+xnGSK
         xp1k0yQ1ViXMjpOsD46I12khUP/8dl9gzx2E8B5N6x9Z9e3A6SLMC+NitqSFkokhWCV8
         AyLg==
X-Gm-Message-State: AC+VfDyqLTjK+Nh7wfF3zXhdSvUI6fvUR2dYRJvjjw4FV3M+xAQkEFq1
        PyFF+0+PUbitln3MxD4JufA=
X-Google-Smtp-Source: ACHHUZ7h23g8fsnaUp2SUms4C0Aoq0NMCflNXjW2Q5ObCkUde93VULzkYoBgbl3COTL8a7Rb9jtN2Q==
X-Received: by 2002:a17:90a:19d:b0:25e:8f0f:a131 with SMTP id 29-20020a17090a019d00b0025e8f0fa131mr12515637pjc.13.1687454631908;
        Thu, 22 Jun 2023 10:23:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b6a3:63a2:146b:3f29? ([2620:15c:211:201:b6a3:63a2:146b:3f29])
        by smtp.gmail.com with ESMTPSA id z92-20020a17090a6d6500b0025efaf7a0d3sm26451pjj.14.2023.06.22.10.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 10:23:51 -0700 (PDT)
Message-ID: <32a2617a-0c41-fb6c-3cfe-7c832487a6b4@acm.org>
Date:   Thu, 22 Jun 2023 10:23:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/7] block: Send requeued requests to the I/O scheduler
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
 <20230621201237.796902-4-bvanassche@acm.org>
 <989f9473-c17e-e85d-ab10-313182f7ac3b@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <989f9473-c17e-e85d-ab10-313182f7ac3b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/23 18:19, Damien Le Moal wrote:
> Why ? I still do not understand the need for this. There is always only a single
> in-flight write per sequential zone. Requeuing that in-flight write directly to
> the dispatch list will not reorder writes and it will be better for the command
> latency.
Hi Damien,

After having taken a closer look I see that blk_req_zone_write_unlock() 
is called from inside dd_insert_request() when requeuing a request. 
Hence, there is no reordering risk when requeuing a zoned write. I will 
drop this patch.

Do you agree with having one requeue list per hctx instead of per 
request queue? This change enables eliminating 
blk_mq_kick_requeue_list(). I think that's an interesting simplification 
of the block layer API.

Thanks,

Bart.
