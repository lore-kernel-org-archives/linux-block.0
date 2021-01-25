Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3597DC433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 04:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9A82085B
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 04:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbhAYE0U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 23:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbhAYE0T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 23:26:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39380C061573
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:25:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b8so6788233plh.12
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lA7TVMM1qEXKPlpnw5pY6Qs5gLDneWRq6rWhbNC1CaQ=;
        b=OQkH6QE9pSAoVQuUzeHlJDBKKRQZnq8wEOHlee+HgcMMm3Fv/Y7DgTeYlTLVPbGZWI
         x7TQplfRlzmKusMHpYnR4/FK5LE+IPiKsDoPtDRFQh7QXfdPWQQnIjGaq73Cy+GQSaRn
         SB7aMtOpGcVzXRXlcS3zARuEcsmgMeENtURFYoG6IyL2Q78+iXrqxPdxGV9QjekeCOUc
         5OlBPBjBTMAn6yWpJ2EcCpwvvmfnn9tFksT8lPh+/mRWH4Av0yKM9ouA/k9FOwwnvvFO
         5QGg+Shk8NdVTkLMJ+nyTVUcYL/7Sbad6mf4K30wLAeiTqhCQTwFmfeedhUy3YSJ6ZRA
         ePRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lA7TVMM1qEXKPlpnw5pY6Qs5gLDneWRq6rWhbNC1CaQ=;
        b=LtOEowflPsGvzEyZHgmN3zjdCvH28D3C5t94UkCI1DTuy3ZDmuAzt/gWqCRUWPvKpT
         ZP3gMbOEAk9HKswVaNgSNSaSck89Dmi/SXaL2Xds9CuiMuYb1N2gUYj3wdaRuJYLYvfY
         /lc6Jez7w3MIihQGQI+TDCcqkCSvP9leXLKlF0J784aTpyrW2Ljr6v60tB785lhsR4dQ
         nw+FqKu1blkxNrAAWNCiYyZMhEZbIvFCKJlKw/lT4ARPQ8Ycv+QH+8rFAFNifrllE029
         2GtNp1aSrGlViyqC4Aa7h53ZAF+6D/K5fDNCK8/WBSz5oRDmxTWBzEU5VPJZ1CnGhgmK
         CkDQ==
X-Gm-Message-State: AOAM5314VwiMfqX6B1pu+BYDTNlAu8/enKGKysVPXGh9glXDxk8LG0Bp
        dzbpkzvsE7i2iWWk3YtvGOKZAA==
X-Google-Smtp-Source: ABdhPJyrspS2mAHP9F1IdnWzMqSLWuNY/me9goHdfLtnAkjVGH/Ll+rJDJWjtgFzViBkNC8hJVs04w==
X-Received: by 2002:a17:902:9b95:b029:df:d859:42bb with SMTP id y21-20020a1709029b95b02900dfd85942bbmr2552640plp.2.1611548738677;
        Sun, 24 Jan 2021 20:25:38 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id t206sm14773216pgb.84.2021.01.24.20.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:25:38 -0800 (PST)
Subject: Re: [PATCH] blk-mq: test QUEUE_FLAG_HCTX_ACTIVE for sbitmap_shared in
 hctx_may_queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
References: <20201227113458.3289082-1-ming.lei@redhat.com>
 <20210125022915.GC984849@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <161afb46-6cb9-0b49-8e31-ed9e201b1c7b@kernel.dk>
Date:   Sun, 24 Jan 2021 21:25:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125022915.GC984849@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/21 7:29 PM, Ming Lei wrote:
> On Sun, Dec 27, 2020 at 07:34:58PM +0800, Ming Lei wrote:
>> In case of blk_mq_is_sbitmap_shared(), we should test QUEUE_FLAG_HCTX_ACTIVE against
>> q->queue_flags instead of BLK_MQ_S_TAG_ACTIVE.
>>
>> So fix it.
>>
>> Cc: John Garry <john.garry@huawei.com>
>> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
>> Fixes: f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for when using shared sbitmap")
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Hello Jens,
> 
> This one fixes one v5.11 issue, can you queue it?

Queued up, thanks.

-- 
Jens Axboe

