Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F04C4332F
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A988D60EE9
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhJRMlK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhJRMlE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 08:41:04 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF5C06176D
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:38:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id k3so14712526ilu.2
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BcvXSYMKkxOdDPvUtRzou8KqQzfYeQv0RToRcKEVNAg=;
        b=btv+qo0CHuKzzErInGsQ65G06PcsWmsYaNtpYrofOdTvjw7QV8IRQV5i5mSRvG54Mi
         APy/xWafBG+suitucirc09YUL3kLNJ+JPmgiZzsigcDf+B2aoVILRnhCZ6IAsILxi9vt
         eSShdO+ySnGSmn4a/AI5t2cdbRFBDB0pS641bmqPOmXD7VkgfB3d9opYzoBEEsl4oEg8
         LOTevcB3g3WlIbNqgmd2HdnsSXvN2JGvW79DBY+ErDphGsI+zADy5alEKkZRCdgwR4uq
         cxPmusTS3/Z70gytou6JjktWz1dWNk96uVZvKj70V073broLkNBgW3zLo/trd7ZS7Oid
         nnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BcvXSYMKkxOdDPvUtRzou8KqQzfYeQv0RToRcKEVNAg=;
        b=iOniFZLe3EvkAFs3L/UINnKeWxREG31l8fJCdd9PndbAQWnsGIixzN+0iaUHKX88rl
         AC6U8hcgMC72o5c6+uAQKIxs2EVEXodT/1siAAwzzbV3qICTAUZoGsqmcFl9NzFfEU8I
         wWMgikyxa9XXWZN2Gzix8KzpUVQaqwhlE7TxEnM2vuya50X2It4/i9kqkI0QtBMD8HBe
         zK9wTGSTCdWHT1GDjHcjjp2WN37n5qyKGXHegT0LgQfHsHzszAafH5WunwyBlrazrxeR
         xoduieeubzbtyFDEyUIYoXIgvQXbdQPjWapueyL1htFm9Rz6FAwV73iQnlXq6SyyZ5Ce
         HD0w==
X-Gm-Message-State: AOAM533wRaihOSR/HO/LiCEsqnxhamoY+Kohmp78vJmQyHHaMU9BbguY
        tUxgx/itoKPRn+54X1ZKbSHsdQ==
X-Google-Smtp-Source: ABdhPJyuTjdqdlTi1vGe3/gXFjBQ2qMMfEdb1Nmoo0MdFvLDvYbM17wlnmNOHqUXJjZQvwv9pPvX0A==
X-Received: by 2002:a05:6e02:20c3:: with SMTP id 3mr13115359ilq.206.1634560733032;
        Mon, 18 Oct 2021 05:38:53 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u12sm6742945ioc.33.2021.10.18.05.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 05:38:52 -0700 (PDT)
Subject: Re: [PATCH] nvme: don't memset() the normal read/write command
To:     Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
References: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk>
 <20211013045822.GA24761@lst.de>
 <843b8695-9af7-ec33-da83-e711850223b1@kernel.dk>
 <20211018123750.GA17785@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a5715e6-af4a-341c-906a-e5b5aa4e9d9a@kernel.dk>
Date:   Mon, 18 Oct 2021 06:38:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211018123750.GA17785@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 6:37 AM, Christoph Hellwig wrote:
> On Mon, Oct 18, 2021 at 06:33:51AM -0600, Jens Axboe wrote:
>>>>  	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
>>>> +	cmnd->rw.rsvd2 = 0;
>>>
>>> There should be no need to clear this reserved space.
>>
>> Actually wasn't sure, sometimes hardware specs required reserved fields
>> to get cleared. nvme does not? I'd be happy to drop it if not the case.
> 
> It only requires bits in otherwise unused fields to be the zeroed.
> 
> That being said, yes we're probably on the safe side by clearing
> everything.

I'll keep the reserved clearing.

-- 
Jens Axboe

